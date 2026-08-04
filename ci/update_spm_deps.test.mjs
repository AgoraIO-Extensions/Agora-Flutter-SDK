import assert from 'node:assert/strict';
import { execFile } from 'node:child_process';
import { mkdtemp, readFile, writeFile } from 'node:fs/promises';
import os from 'node:os';
import path from 'node:path';
import test from 'node:test';
import { fileURLToPath } from 'node:url';
import { promisify } from 'node:util';

const execFileAsync = promisify(execFile);
const ciDir = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(ciDir, '..');
const updaterPath = path.join(ciDir, 'update_spm_deps.mjs');
const sourceIosManifest = path.join(repoRoot, 'ios/agora_rtc_engine/Package.swift');
const sourceMacosManifest = path.join(repoRoot, 'macos/agora_rtc_engine/Package.swift');
const updateDepsWorkflow = path.join(repoRoot, '.github/workflows/run_update_deps.yml');

const iosIrisUrl =
  'https://download.agora.io/sdk/release/AgoraIrisRTC_iOS2-4.6.2-build.1.zip';
const iosIrisChecksum =
  'eba8f9fc5b3d93d9d083d0c3f16e6c98fcd993e49989fb851e6df2941ca29825';
const macosIrisUrl =
  'https://download.agora.io/sdk/release/AgoraIrisRTC_macOS2-4.6.2-build.1.zip';
const macosIrisChecksum =
  'dbfe2db86b0cb2c1012202212248bd6588173020c357dc13fc5a6dcf0a7b97cf';

const completeDependenciesContent = [
  `platform:iOS github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git tag:4.6.2 products:RtcBasic iris-url:${iosIrisUrl} iris-checksum:${iosIrisChecksum}`,
  `platform:macOS github:https://github.com/AgoraIO/AgoraRtcEngine_macOS.git tag:4.6.2 products:RtcBasic iris-url:${macosIrisUrl} iris-checksum:${macosIrisChecksum}`,
].join('\n');

async function createTemporaryManifests() {
  const tempRoot = await mkdtemp(path.join(os.tmpdir(), 'agora-spm-deps-'));
  const iosManifest = path.join(tempRoot, 'ios-Package.swift');
  const macosManifest = path.join(tempRoot, 'macos-Package.swift');

  await writeFile(iosManifest, await readFile(sourceIosManifest, 'utf8'), 'utf8');
  await writeFile(macosManifest, await readFile(sourceMacosManifest, 'utf8'), 'utf8');

  return { iosManifest, macosManifest };
}

async function runUpdater(dependenciesContent, manifests) {
  return execFileAsync(process.execPath, [
    updaterPath,
    '--dependencies-content',
    dependenciesContent,
    '--ios-manifest',
    manifests.iosManifest,
    '--macos-manifest',
    manifests.macosManifest,
  ]);
}

async function printLegacyContent(dependenciesContent) {
  const manifests = await createTemporaryManifests();
  return execFileAsync(process.execPath, [
    updaterPath,
    '--dependencies-content',
    dependenciesContent,
    '--print-legacy-content',
    '--ios-manifest',
    manifests.iosManifest,
    '--macos-manifest',
    manifests.macosManifest,
  ]);
}

function extractWorkflowRunScript(workflow, stepName) {
  const stepMarker = `      - name: ${stepName}\n`;
  const stepStart = workflow.indexOf(stepMarker);
  assert.ok(stepStart >= 0, `workflow step not found: ${stepName}`);
  const remaining = workflow.slice(stepStart + stepMarker.length);
  const nextStep = remaining.indexOf('\n      - name:');
  const step = nextStep >= 0 ? remaining.slice(0, nextStep) : remaining;
  const runMarker = '        run: |\n';
  const runStart = step.indexOf(runMarker);
  assert.ok(runStart >= 0, `workflow run script not found: ${stepName}`);
  return step
    .slice(runStart + runMarker.length)
    .split('\n')
    .map((line) => line.replace(/^          /, ''))
    .join('\n');
}

test('updates both Apple manifests from complete platform-scoped input', async () => {
  const manifests = await createTemporaryManifests();

  await runUpdater(completeDependenciesContent, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(
    ios,
    /\.package\(name: "FlutterFramework", path: "\.\.\/FlutterFramework"\)/,
  );
  assert.match(
    ios,
    /\.package\(url: "https:\/\/github\.com\/AgoraIO\/AgoraRtcEngine_iOS\.git", exact: "4\.6\.2"\)/,
  );
  assert.match(
    ios,
    /\.product\(name: "FlutterFramework", package: "FlutterFramework"\)/,
  );
  assert.match(ios, /\.product\(name: "RtcBasic", package: "AgoraRtcEngine_iOS"\)/);
  assert.match(ios, new RegExp(`url: "${iosIrisUrl.replaceAll('.', '\\.')}"`));
  assert.match(ios, new RegExp(`checksum: "${iosIrisChecksum}"`));

  const macos = await readFile(manifests.macosManifest, 'utf8');
  assert.match(
    macos,
    /\.package\(name: "FlutterFramework", path: "\.\.\/FlutterFramework"\)/,
  );
  assert.match(
    macos,
    /\.package\(url: "https:\/\/github\.com\/AgoraIO\/AgoraRtcEngine_macOS\.git", exact: "4\.6\.2"\)/,
  );
  assert.match(
    macos,
    /\.product\(name: "FlutterFramework", package: "FlutterFramework"\)/,
  );
  assert.match(
    macos,
    /\.product\(name: "RtcBasic", package: "AgoraRtcEngine_macOS"\)/,
  );
  assert.match(macos, new RegExp(`url: "${macosIrisUrl.replaceAll('.', '\\.')}"`));
  assert.match(macos, new RegExp(`checksum: "${macosIrisChecksum}"`));
  assert.doesNotMatch(macos, /unsafeFlags/);
  assert.match(macos, /cxxLanguageStandard: \.cxx14/);
});

test('keeps FlutterFramework outside Native updater marker regions', async () => {
  const manifests = await createTemporaryManifests();

  await runUpdater(completeDependenciesContent, manifests);

  for (const manifestPath of [manifests.iosManifest, manifests.macosManifest]) {
    const manifest = await readFile(manifestPath, 'utf8');
    const packageRegion = manifest.match(
      /\/\/ agora-spm-updater:managed-packages-start([\s\S]*?)\/\/ agora-spm-updater:managed-packages-end/,
    );
    const productRegion = manifest.match(
      /\/\/ agora-spm-updater:managed-products-start([\s\S]*?)\/\/ agora-spm-updater:managed-products-end/,
    );

    assert.ok(packageRegion, 'Native package marker region must exist');
    assert.ok(productRegion, 'Native product marker region must exist');
    assert.doesNotMatch(packageRegion[1], /FlutterFramework/);
    assert.doesNotMatch(productRegion[1], /FlutterFramework/);
    assert.match(
      manifest,
      /\.package\(name: "FlutterFramework", path: "\.\.\/FlutterFramework"\)/,
    );
    assert.match(
      manifest,
      /\.product\(name: "FlutterFramework", package: "FlutterFramework"\)/,
    );
  }
});

test('accepts GitHub workflow input with literal escaped newlines', async () => {
  const manifests = await createTemporaryManifests();
  const escapedInput = completeDependenciesContent.replaceAll('\n', String.raw`\n`);

  await runUpdater(escapedInput, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  const macos = await readFile(manifests.macosManifest, 'utf8');
  assert.match(ios, /AgoraRtcEngine_iOS\.git", exact: "4\.6\.2"/);
  assert.match(macos, /AgoraRtcEngine_macOS\.git", exact: "4\.6\.2"/);
});

test('accepts mixed legacy content and multiline reordered SPM platform blocks', async () => {
  const manifests = await createTemporaryManifests();
  const mixedInput = [
    "platform:Android native maven: implementation 'io.agora.rtc:full-sdk:4.6.2' version:4.6.2",
    "platform:iOS cocoapods: pod 'AgoraVideo_Special_iOS', '4.6.2.70'",
    'products = "RtcBasic, AINS"',
    `iris-checksum = '${iosIrisChecksum}'`,
    'github = git@github.com:AgoraIO/AgoraRtcEngine_iOS.git',
    'version = 4.6.2',
    `iris-url = "${iosIrisUrl}"`,
    "platform:macOS cocoapods: pod 'AgoraVideo_Special_macOS', '4.6.2.70'",
    `iris-url = '${macosIrisUrl}'`,
    'tag = 4.6.2',
    'products = RtcBasic',
    'github = https://github.com/AgoraIO/AgoraRtcEngine_macOS.git',
    `iris-checksum = ${macosIrisChecksum}`,
    'platform:Windows native cdn: https://download.agora.io/example.zip version:4.6.2',
  ].join('\n');

  await runUpdater(mixedInput, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(ios, /\.product\(name: "RtcBasic", package: "AgoraRtcEngine_iOS"\)/);
  assert.match(ios, /\.product\(name: "AINS", package: "AgoraRtcEngine_iOS"\)/);
  assert.match(ios, new RegExp(`url: "${iosIrisUrl.replaceAll('.', '\\.')}"`));

  const macos = await readFile(manifests.macosManifest, 'utf8');
  assert.match(
    macos,
    /\.product\(name: "RtcBasic", package: "AgoraRtcEngine_macOS"\)/,
  );
  assert.doesNotMatch(macos, /\.product\(name: "AINS"/);
  assert.match(macos, new RegExp(`url: "${macosIrisUrl.replaceAll('.', '\\.')}"`));
});

test('prints legacy dependency content without SPM-only fields', async () => {
  const mixedInput = [
    "platform:Android native maven: implementation 'io.agora.rtc:full-sdk:4.6.2'",
    "platform:iOS cocoapods: pod 'AgoraVideo_Special_iOS', '4.6.2.70'",
    'products = "RtcBasic, AINS"',
    `iris-checksum = '${iosIrisChecksum}'`,
    'github = git@github.com:AgoraIO/AgoraRtcEngine_iOS.git',
    'version = 4.6.2',
    `iris-url = "${iosIrisUrl}"`,
  ].join('\n');

  const result = await printLegacyContent(mixedInput);

  assert.match(result.stdout, /platform:Android native maven:/);
  assert.match(result.stdout, /platform:iOS cocoapods:/);
  assert.doesNotMatch(result.stdout, /products|iris-checksum|github|iris-url|version/i);
  assert.doesNotMatch(result.stdout, /"/);
});

test('preserves unrelated package and target dependencies', async () => {
  const manifests = await createTemporaryManifests();
  const iosWithUnrelatedDependencies = (await readFile(manifests.iosManifest, 'utf8'))
    .replace(
      '    dependencies: [\n',
      [
        '    dependencies: [',
        '        .package(url: "https://github.com/example/Other.git", exact: "1.0.0"),',
        '',
      ].join('\n'),
    )
    .replace(
      '            dependencies: [\n',
      [
        '            dependencies: [',
        '                .product(name: "OtherProduct", package: "Other"),',
        '',
      ].join('\n'),
    );
  await writeFile(manifests.iosManifest, iosWithUnrelatedDependencies, 'utf8');

  await runUpdater(completeDependenciesContent.split('\n')[0], manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(
    ios,
    /\.package\(url: "https:\/\/github\.com\/example\/Other\.git", exact: "1\.0\.0"\)/,
  );
  assert.match(
    ios,
    /\.product\(name: "OtherProduct", package: "Other"\)/,
  );
});

test('rejects duplicate platform blocks before writing either manifest', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const duplicateInput = `${completeDependenciesContent}\n${completeDependenciesContent.split('\n')[0]}`;

  await assert.rejects(
    runUpdater(duplicateInput, manifests),
    /Duplicate SPM metadata for iOS/,
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('rejects incomplete metadata before writing either manifest', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const incompleteInput = completeDependenciesContent.replace(
    ` iris-checksum:${macosIrisChecksum}`,
    '',
  );

  await assert.rejects(
    runUpdater(incompleteInput, manifests),
    /Incomplete SPM metadata for macOS/,
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('leaves manifests unchanged when old input contains no SPM blocks', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');

  const result = await runUpdater(
    "pod 'AgoraVideo_Special_iOS', '4.6.2.70' implementation 'io.agora.rtc:agora-full:4.6.2'",
    manifests,
  );

  assert.match(result.stdout, /SPM dependencies unchanged/);
  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('leaves legacy platform-scoped input unchanged when it has no SPM fields', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');

  const result = await runUpdater(
    "platform:iOS cocoapods:pod 'AgoraVideo_Special_iOS', '4.6.2.70'",
    manifests,
  );

  assert.match(result.stdout, /SPM dependencies unchanged/);
  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('rejects SPM metadata that omits the platform field', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const missingPlatform = completeDependenciesContent
    .split('\n')[0]
    .replace('platform:iOS ', '');

  await assert.rejects(
    runUpdater(missingPlatform, manifests),
    /SPM metadata requires an explicit platform field/,
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('rejects a standalone SPM tag instead of treating it as legacy input', async () => {
  for (const input of ['platform:iOS tag:4.6.2', 'tag:4.6.2']) {
    const manifests = await createTemporaryManifests();
    await assert.rejects(runUpdater(input, manifests), /SPM metadata|Incomplete SPM/);
  }
});

test('accepts quoted reordered fields, SSH GitHub URLs, and iOS-only AINS product', async () => {
  const manifests = await createTemporaryManifests();
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const input = [
    'platform = iOS',
    `iris-checksum = '${iosIrisChecksum}'`,
    'products = RtcBasic, AINS',
    `iris-url = "${iosIrisUrl}"`,
    'version = 4.6.2',
    'github = git@github.com:AgoraIO/AgoraRtcEngine_iOS.git',
  ].join(' | ');

  await runUpdater(input, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(
    ios,
    /\.package\(url: "https:\/\/github\.com\/AgoraIO\/AgoraRtcEngine_iOS\.git", exact: "4\.6\.2"\)/,
  );
  assert.match(
    ios,
    /\.product\(name: "AINS", package: "AgoraRtcEngine_iOS"\)/,
  );
  const macos = await readFile(manifests.macosManifest, 'utf8');
  assert.equal(macos, macosBefore);
  assert.doesNotMatch(macos, /\.product\(name: "AINS"/);
});

test('uses the explicitly labeled GitHub URL instead of an earlier URL', async () => {
  const manifests = await createTemporaryManifests();
  const input = completeDependenciesContent
    .split('\n')[0]
    .replace('platform:iOS ', 'platform:iOS notes:https://github.com/example/Wrong.git ');

  await runUpdater(input, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(
    ios,
    /\.package\(url: "https:\/\/github\.com\/AgoraIO\/AgoraRtcEngine_iOS\.git", exact: "4\.6\.2"\)/,
  );
  assert.doesNotMatch(ios, /example\/Wrong/);
});

test('rejects trailing characters instead of truncating SPM field values', async () => {
  const validInput = completeDependenciesContent.split('\n')[0];
  const malformedInputs = [
    validInput.replace('AgoraRtcEngine_iOS.git', 'AgoraRtcEngine_iOS.git/extra'),
    validInput.replace('tag:4.6.2', 'tag:4.6.2???'),
    validInput.replace('products:RtcBasic', 'products:RtcBasic extra'),
    validInput.replace('products:RtcBasic', 'products:"RtcBasic'),
    validInput.replace(iosIrisChecksum, `${iosIrisChecksum}a`),
  ];

  for (const input of malformedInputs) {
    const manifests = await createTemporaryManifests();
    await assert.rejects(runUpdater(input, manifests), /Invalid SPM metadata for iOS/);
  }
});

test('rejects duplicate fields within one SPM platform record', async () => {
  const validInput = completeDependenciesContent.split('\n')[0];
  const duplicateInputs = [
    `${validInput} github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git`,
    `${validInput} version:4.6.2`,
    `${validInput} products:RtcBasic`,
    `${validInput} iris-url:${iosIrisUrl}`,
    `${validInput} iris-checksum:${iosIrisChecksum}`,
    `${validInput} platform:iOS`,
  ];

  for (const input of duplicateInputs) {
    const manifests = await createTemporaryManifests();
    await assert.rejects(runUpdater(input, manifests), /Duplicate SPM fields for iOS/);
  }
});

test('does not harvest a product name from a URL', async () => {
  const manifests = await createTemporaryManifests();
  const malformedProducts = [
    'platform:iOS',
    'products:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git',
    'github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git',
    'tag:4.6.2',
    `iris-url:${iosIrisUrl}`,
    `iris-checksum:${iosIrisChecksum}`,
  ].join(' ');

  await assert.rejects(
    runUpdater(malformedProducts, manifests),
    /Invalid SPM metadata for iOS: products/,
  );
});

test('is idempotent when the same dependency input is applied twice', async () => {
  const manifests = await createTemporaryManifests();

  await runUpdater(completeDependenciesContent, manifests);
  const iosAfterFirstRun = await readFile(manifests.iosManifest, 'utf8');
  const macosAfterFirstRun = await readFile(manifests.macosManifest, 'utf8');

  await runUpdater(completeDependenciesContent, manifests);

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosAfterFirstRun);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosAfterFirstRun);
});

test('can switch the managed Native package repository from Audio to Video', async () => {
  const manifests = await createTemporaryManifests();
  const iosInput = completeDependenciesContent.split('\n')[0];
  const audioInput = iosInput.replace(
    'AgoraIO/AgoraRtcEngine_iOS.git',
    'example/AgoraRtcEngine_iOS_Audio.git',
  );
  const videoInput = iosInput
    .replace(
      'AgoraIO/AgoraRtcEngine_iOS.git',
      'example/AgoraRtcEngine_iOS_Video.git',
    )
    .replace('products:RtcBasic', 'products:RtcBasic,AINS');

  await runUpdater(audioInput, manifests);
  const audioManifest = await readFile(manifests.iosManifest, 'utf8');
  assert.match(audioManifest, /github\.com\/example\/AgoraRtcEngine_iOS_Audio\.git/);
  assert.match(audioManifest, /package: "AgoraRtcEngine_iOS_Audio"/);
  assert.doesNotMatch(audioManifest, /\.product\(name: "AINS"/);

  await runUpdater(videoInput, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(ios, /github\.com\/example\/AgoraRtcEngine_iOS_Video\.git/);
  assert.match(ios, /package: "AgoraRtcEngine_iOS_Video"/);
  assert.match(ios, /\.product\(name: "AINS", package: "AgoraRtcEngine_iOS_Video"\)/);
  assert.doesNotMatch(ios, /AgoraRtcEngine_iOS_Audio/);
});

test('dependency update workflow tests, runs, and validates the SPM updater before PR creation', async () => {
  const workflow = await readFile(updateDepsWorkflow, 'utf8');
  const setupNodeIndex = workflow.indexOf('uses: actions/setup-node@v4');
  const testUpdaterIndex = workflow.indexOf('node --test ci/update_spm_deps.test.mjs');
  const prepareLegacyIndex = workflow.indexOf('name: Prepare legacy dependency content');
  const parseLegacyIndex = workflow.indexOf('name: Parse dependencies content');
  const updateSpmIndex = workflow.indexOf(
    'node ci/update_spm_deps.mjs --dependencies-content "$DEPENDENCIES_CONTENT"',
  );
  const validateSpmIndex = workflow.indexOf('swift package dump-package');
  const createPrIndex = workflow.indexOf('name: Commit and create pull request');

  assert.ok(setupNodeIndex >= 0, 'workflow must set up Node');
  assert.match(workflow, /node-version: ['"]?22['"]?/);
  assert.match(workflow, /platform:iOS[\s\S]*github:/);
  assert.match(workflow, /platform:macOS[\s\S]*github:/);
  assert.match(workflow, /Each platform field starts an Apple SPM block/);
  assert.match(workflow, /Fields may stay on that line or continue on following lines/);
  assert.ok(testUpdaterIndex > setupNodeIndex, 'workflow must run updater tests after setup');
  assert.ok(prepareLegacyIndex > testUpdaterIndex, 'workflow must sanitize legacy input after tests');
  assert.ok(parseLegacyIndex > prepareLegacyIndex, 'workflow must parse sanitized legacy input');
  assert.match(workflow, /--print-legacy-content/);
  assert.match(
    workflow,
    /dependencies-content: \$\{\{ steps\.prepare_legacy_dependencies\.outputs\.content \}\}/,
  );
  assert.match(workflow, /if \[\[ -f ci\/update_spm_deps\.test\.mjs \]\]/);
  assert.match(workflow, /DEPENDENCIES_CONTENT: \$\{\{ inputs\.dependencies_content \}\}/);
  assert.match(workflow, /if \[\[ -f ci\/update_spm_deps\.mjs \]\]/);
  assert.match(workflow, /Target ref does not contain the Apple SPM dependency updater/);
  assert.ok(updateSpmIndex > testUpdaterIndex, 'workflow must update manifests after tests');
  assert.match(workflow, /SPM manifest validation skipped for target ref/);
  assert.ok(validateSpmIndex > updateSpmIndex, 'workflow must validate generated manifests');
  assert.match(workflow, /uses: peter-evans\/create-pull-request@v8/);
  assert.ok(createPrIndex > validateSpmIndex, 'workflow must validate manifests before PR creation');
});

test('workflow old-ref guard preserves legacy input and rejects SPM intent', async () => {
  const workflow = await readFile(updateDepsWorkflow, 'utf8');
  const script = extractWorkflowRunScript(workflow, 'Update Apple SPM dependencies');
  const oldTarget = await mkdtemp(path.join(os.tmpdir(), 'agora-old-target-'));

  const legacyResult = await execFileAsync('bash', ['-c', script], {
    cwd: oldTarget,
    env: {
      ...process.env,
      DEPENDENCIES_CONTENT:
        "platform:iOS cocoapods:pod 'AgoraVideo_Special_iOS', '4.6.2.70'",
    },
  });
  assert.match(legacyResult.stdout, /SPM dependencies unchanged/);

  let spmError;
  try {
    await execFileAsync('bash', ['-c', script], {
      cwd: oldTarget,
      env: { ...process.env, DEPENDENCIES_CONTENT: 'tag:4.6.2' },
    });
  } catch (error) {
    spmError = error;
  }
  assert.ok(spmError, 'SPM input must fail when the target ref has no updater');
  assert.match(spmError.stdout, /Target ref does not contain the Apple SPM dependency updater/);
});
