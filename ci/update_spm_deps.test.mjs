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

test('accepts quoted reordered fields, SSH GitHub URLs, and future products', async () => {
  const manifests = await createTemporaryManifests();
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const input = [
    'platform = iOS',
    `iris-checksum = '${iosIrisChecksum}'`,
    'products = RtcBasic, SomeFutureProduct',
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
    /\.product\(name: "SomeFutureProduct", package: "AgoraRtcEngine_iOS"\)/,
  );
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
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
    /Incomplete SPM metadata for iOS/,
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

test('dependency update workflow tests, runs, and validates the SPM updater before PR creation', async () => {
  const workflow = await readFile(updateDepsWorkflow, 'utf8');
  const setupNodeIndex = workflow.indexOf('uses: actions/setup-node@v4');
  const testUpdaterIndex = workflow.indexOf('node --test ci/update_spm_deps.test.mjs');
  const updateSpmIndex = workflow.indexOf(
    'node ci/update_spm_deps.mjs --dependencies-content "$DEPENDENCIES_CONTENT"',
  );
  const validateSpmIndex = workflow.indexOf('swift package dump-package');
  const createPrIndex = workflow.indexOf('name: Commit and create pull request');

  assert.ok(setupNodeIndex >= 0, 'workflow must set up Node');
  assert.match(workflow, /node-version: ['"]?22['"]?/);
  assert.match(workflow, /platform:iOS github:/);
  assert.match(workflow, /platform:macOS github:/);
  assert.ok(testUpdaterIndex > setupNodeIndex, 'workflow must run updater tests after setup');
  assert.match(workflow, /DEPENDENCIES_CONTENT: \$\{\{ inputs\.dependencies_content \}\}/);
  assert.ok(updateSpmIndex > testUpdaterIndex, 'workflow must update manifests after tests');
  assert.ok(validateSpmIndex > updateSpmIndex, 'workflow must validate generated manifests');
  assert.ok(createPrIndex > validateSpmIndex, 'workflow must validate manifests before PR creation');
});
