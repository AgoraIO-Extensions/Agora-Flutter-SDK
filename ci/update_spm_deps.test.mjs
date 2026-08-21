import assert from 'node:assert/strict';
import { execFile } from 'node:child_process';
import { createHash } from 'node:crypto';
import {
  mkdir,
  mkdtemp,
  readFile,
  readdir,
  rename,
  rm,
  writeFile,
} from 'node:fs/promises';
import { createServer } from 'node:http';
import os from 'node:os';
import path from 'node:path';
import test from 'node:test';
import { fileURLToPath } from 'node:url';
import { promisify } from 'node:util';

import * as spmUpdater from './update_spm_deps.mjs';

const { commitUpdates } = spmUpdater;

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

const sectionedNativeDependenciesContent = [
  '【Maven】',
  "implementation 'io.agora.rtc:agora-special-full:4.5.2.211.FAV'",
  '【Cocoapods】',
  "pod 'AgoraRtcEngine_Special_iOS', '4.5.2.211.FAV'",
  '【swiftPM】',
  'github:git@github.com:AgoraIO/AgoraRtcEngine_iOS.git | tag:4.5.2.211',
].join('\n');

const compactAudioDependenciesContent =
  "github:https://github.com/AgoraIO/AgoraAudio_iOS.git tag:4.5.3-a1 products:RtcBasic implementation 'io.agora.rtc:agora-special-voice:4.5.3.1.BASIC1'";

const irisBuildResultWithoutFailures = [
  'Iris SDK Build Result',
  'Build version:4.7.0-dev.2',
  'Iris macOS:',
  'CDN:',
  'https://download.agora.io/sdk/release/iris_4.7.0-dev.2_DCG_Mac_Video_Standalone_20260805_0512_32933.zip',
  'Cocoapods:',
  "pod 'AgoraIrisRTC_macOS', '4.7.0-dev.2'",
  'Iris iOS:',
  'CDN:',
  'https://download.agora.io/sdk/release/iris_4.7.0-dev.2_DCG_iOS_Video_Standalone_20260805_0512_33960.zip',
  'Cocoapods:',
  "pod 'AgoraIrisRTC_iOS', '4.7.0-dev.2'",
  'Iris Android:',
  'Maven:',
  "api 'io.agora.rtc:iris-rtc:4.7.0-dev.2'",
].join('\n');

async function createTemporaryManifests() {
  const tempRoot = await mkdtemp(path.join(os.tmpdir(), 'agora-spm-deps-'));
  const iosManifest = path.join(tempRoot, 'ios-Package.swift');
  const macosManifest = path.join(tempRoot, 'macos-Package.swift');

  await writeFile(iosManifest, await readFile(sourceIosManifest, 'utf8'), 'utf8');
  await writeFile(macosManifest, await readFile(sourceMacosManifest, 'utf8'), 'utf8');

  return { iosManifest, macosManifest };
}

async function runUpdater(
  dependenciesContent,
  manifests,
  { env = {}, timeout } = {},
) {
  return execFileAsync(
    process.execPath,
    [
      updaterPath,
      '--dependencies-content',
      dependenciesContent,
      '--ios-manifest',
      manifests.iosManifest,
      '--macos-manifest',
      manifests.macosManifest,
    ],
    { env: { ...process.env, ...env }, timeout },
  );
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

async function withArtifactServer(
  fileName,
  bytes,
  callback,
  statusOrOptions = 200,
) {
  const options =
    typeof statusOrOptions === 'number'
      ? { statusCode: statusOrOptions }
      : statusOrOptions;
  const { statusCode = 200, stall = false } = options;
  const server = createServer((_request, response) => {
    if (stall) {
      return;
    }
    response.writeHead(statusCode, { 'content-type': 'application/zip' });
    response.end(bytes);
  });

  await new Promise((resolve, reject) => {
    server.once('error', reject);
    server.listen(0, '127.0.0.1', resolve);
  });

  const address = server.address();
  assert.ok(address && typeof address === 'object');
  try {
    return await callback(`http://127.0.0.1:${address.port}/${fileName}`);
  } finally {
    await new Promise((resolve, reject) => {
      server.close((error) => (error ? reject(error) : resolve()));
    });
  }
}

async function createArtifactZip(rootDirectory = 'AgoraRtcWrapper.xcframework') {
  const tempRoot = await mkdtemp(path.join(os.tmpdir(), 'agora-spm-artifact-'));
  const contentsRoot = path.join(tempRoot, 'contents');
  const artifactPath = path.join(tempRoot, 'artifact.zip');
  await mkdir(path.join(contentsRoot, rootDirectory), { recursive: true });
  await writeFile(
    path.join(contentsRoot, rootDirectory, 'Info.plist'),
    'SwiftPM artifact fixture',
    'utf8',
  );

  try {
    await execFileAsync('zip', ['-qry', artifactPath, rootDirectory], {
      cwd: contentsRoot,
    });
    return await readFile(artifactPath);
  } finally {
    await rm(tempRoot, { recursive: true, force: true });
  }
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

function extractWorkflowStep(workflow, stepName) {
  const stepMarker = `      - name: ${stepName}\n`;
  const stepStart = workflow.indexOf(stepMarker);
  assert.ok(stepStart >= 0, `workflow step not found: ${stepName}`);
  const remaining = workflow.slice(stepStart + stepMarker.length);
  const nextStep = remaining.indexOf('\n      - name:');
  return nextStep >= 0 ? remaining.slice(0, nextStep) : remaining;
}

test('updates both Apple manifests from complete platform-scoped input', async () => {
  const manifests = await createTemporaryManifests();

  await runUpdater(completeDependenciesContent, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.doesNotMatch(ios, /FlutterFramework/);
  assert.doesNotMatch(ios, /agora-spm-updater:/);
  assert.match(
    ios,
    /\.package\(url: "https:\/\/github\.com\/AgoraIO\/AgoraRtcEngine_iOS\.git", exact: "4\.6\.2"\)/,
  );
  assert.match(ios, /\.product\(name: "RtcBasic", package: "AgoraRtcEngine_iOS"\)/);
  assert.match(ios, new RegExp(`url: "${iosIrisUrl.replaceAll('.', '\\.')}"`));
  assert.match(ios, new RegExp(`checksum: "${iosIrisChecksum}"`));

  const macos = await readFile(manifests.macosManifest, 'utf8');
  assert.doesNotMatch(macos, /FlutterFramework/);
  assert.doesNotMatch(macos, /agora-spm-updater:/);
  assert.match(
    macos,
    /\.package\(url: "https:\/\/github\.com\/AgoraIO\/AgoraRtcEngine_macOS\.git", exact: "4\.6\.2"\)/,
  );
  assert.match(
    macos,
    /\.product\(name: "RtcBasic", package: "AgoraRtcEngine_macOS"\)/,
  );
  assert.match(macos, new RegExp(`url: "${macosIrisUrl.replaceAll('.', '\\.')}"`));
  assert.match(macos, new RegExp(`checksum: "${macosIrisChecksum}"`));
  assert.match(macos, /\.unsafeFlags\(\["-std=c\+\+14"\]\)/);
  assert.doesNotMatch(macos, /cxxLanguageStandard/);
});

test('accepts real sectioned Native SPM input without platform or omitted fields', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const wrapperBefore = iosBefore.match(
    /name: "AgoraRtcWrapper",\n            url: "([^"]+)",\n            checksum: "([^"]+)"/,
  );
  assert.ok(wrapperBefore);

  await runUpdater(sectionedNativeDependenciesContent, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(
    ios,
    /\.package\(url: "https:\/\/github\.com\/AgoraIO\/AgoraRtcEngine_iOS\.git", exact: "4\.5\.2\.211"\)/,
  );
  assert.match(ios, /\.product\(name: "RtcBasic", package: "AgoraRtcEngine_iOS"\)/);
  assert.match(ios, new RegExp(`url: "${wrapperBefore[1].replaceAll('.', '\\.')}"`));
  assert.match(ios, new RegExp(`checksum: "${wrapperBefore[2]}"`));
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);

  const legacy = await printLegacyContent(sectionedNativeDependenciesContent);
  assert.match(legacy.stdout, /implementation 'io\.agora\.rtc:agora-special-full:/);
  assert.match(legacy.stdout, /pod 'AgoraRtcEngine_Special_iOS'/);
  assert.doesNotMatch(legacy.stdout, /github:|\btag:/i);
  assert.doesNotMatch(legacy.stdout, /^\s*\|/m);
});

test('reads RtcBasic before trailing Maven content in compact unscoped input', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  await writeFile(
    manifests.iosManifest,
    iosBefore.replace(
      '                .product(name: "RtcBasic", package: "AgoraRtcEngine_iOS"),',
      [
        '                .product(name: "RtcBasic", package: "AgoraRtcEngine_iOS"),',
        '                .product(name: "AINS", package: "AgoraRtcEngine_iOS"),',
      ].join('\n'),
    ),
    'utf8',
  );

  await runUpdater(compactAudioDependenciesContent, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(
    ios,
    /\.package\(url: "https:\/\/github\.com\/AgoraIO\/AgoraAudio_iOS\.git", exact: "4\.5\.3-a1"\)/,
  );
  assert.match(ios, /\.product\(name: "RtcBasic", package: "AgoraAudio_iOS"\)/);
  assert.doesNotMatch(ios, /\.product\(name: "AINS"/);

  const legacy = await printLegacyContent(compactAudioDependenciesContent);
  assert.match(
    legacy.stdout,
    /implementation 'io\.agora\.rtc:agora-special-voice:4\.5\.3\.1\.BASIC1'/,
  );
  assert.doesNotMatch(legacy.stdout, /github:|\btag:|products:/i);
});

test('reports whether products came from input or the target Package.swift', async () => {
  const explicitManifests = await createTemporaryManifests();
  const explicitResult = await runUpdater(
    compactAudioDependenciesContent,
    explicitManifests,
  );
  assert.match(explicitResult.stdout, /products: RtcBasic \(input\)/);

  const preservedManifests = await createTemporaryManifests();
  const preservedIos = await readFile(preservedManifests.iosManifest, 'utf8');
  const preservedProducts = [...preservedIos.matchAll(
    /\.product\(name: "([A-Za-z0-9_]+)", package: "AgoraRtcEngine_iOS"\)/g,
  )].map(([, product]) => product).join(',');
  const preservedResult = await runUpdater(
    sectionedNativeDependenciesContent,
    preservedManifests,
  );
  assert.match(
    preservedResult.stdout,
    new RegExp(
      `products: ${preservedProducts} \\(preserved from Package\\.swift\\)`,
    ),
  );
});

test('parses Native products and derives Iris URLs from a real mixed build result', () => {
  assert.equal(typeof spmUpdater.parsePlatformDependencies, 'function');

  const dependencies = spmUpdater.parsePlatformDependencies(
    [
      irisBuildResultWithoutFailures,
      '【swiftPM】',
      'github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git tag:4.6.2 products:RtcBasic,AINS',
      'github:https://github.com/AgoraIO/AgoraRtcEngine_macOS.git tag:4.6.2 products:RtcBasic',
    ].join('\n'),
  );

  assert.deepEqual(dependencies.get('iOS')?.products, ['RtcBasic', 'AINS']);
  assert.equal(
    dependencies.get('iOS')?.irisUrl,
    'https://download.agora.io/sdk/release/AgoraIrisRTC_iOS-4.7.0-dev.2.zip',
  );
  assert.equal(
    dependencies.get('iOS')?.irisUrlSource,
    "derived from pod 'AgoraIrisRTC_iOS', '4.7.0-dev.2'",
  );
  assert.equal(
    dependencies.get('macOS')?.irisUrl,
    'https://download.agora.io/sdk/release/AgoraIrisRTC_macOS-4.7.0-dev.2.zip',
  );
  assert.deepEqual(dependencies.get('macOS')?.products, ['RtcBasic']);
});

test('ignores a compact build result version while parsing Iris CocoaPods metadata', () => {
  const compactBuildResult = [
    'Iris SDK Build Result',
    'Build version:4.7.0-dev.15',
    'Iris macOS:',
    "Cocoapods:pod 'AgoraIrisRTC_macOS', '4.7.0-dev.15'",
    'Iris iOS:',
    "Cocoapods:pod 'AgoraIrisRTC_iOS', '4.7.0-dev.15'",
  ].join('');

  const dependencies = spmUpdater.parsePlatformDependencies(compactBuildResult);
  assert.equal(
    dependencies.get('iOS')?.irisUrl,
    'https://download.agora.io/sdk/release/AgoraIrisRTC_iOS-4.7.0-dev.15.zip',
  );
  assert.equal(
    dependencies.get('macOS')?.irisUrl,
    'https://download.agora.io/sdk/release/AgoraIrisRTC_macOS-4.7.0-dev.15.zip',
  );
});

test('rejects Iris SPM derivation from an Apple build section marked failed', () => {
  const failedBuildResult = irisBuildResultWithoutFailures.replace(
    'Iris Android:',
    'Failure found on above jobs\nIris Android:',
  );

  assert.throws(
    () => spmUpdater.parsePlatformDependencies(failedBuildResult),
    /Iris iOS build result is marked failed/,
  );
});

test('rejects a failed Apple build section without a CocoaPods result', () => {
  const failedBuildResult = [
    'Iris iOS:',
    'CDN:',
    'https://download.agora.io/sdk/release/iris_4.7.0-dev.2_DCG_iOS_Video_Standalone.zip',
    'Failure found on above jobs',
    'Iris Android:',
    "api 'io.agora.rtc:iris-rtc:4.7.0-dev.2'",
    '【swiftPM】',
    'github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git tag:4.7.0 products:RtcBasic',
  ].join('\n');

  assert.throws(
    () => spmUpdater.parsePlatformDependencies(failedBuildResult),
    /Iris iOS build result is marked failed/,
  );
});

test('rejects an explicit Iris SPM URL inside a failed Apple build section', () => {
  const failedBuildResult = [
    'Iris iOS:',
    'url:https://download.agora.io/sdk/release/AgoraIrisRTC_iOS2-4.7.0-dev.2.zip',
    'Failure found on above jobs',
    'Iris Android:',
    "api 'io.agora.rtc:iris-rtc:4.7.0-dev.2'",
  ].join('\n');

  assert.throws(
    () => spmUpdater.parsePlatformDependencies(failedBuildResult),
    /Iris iOS build result is marked failed/,
  );
});

test('computes a missing checksum for unscoped iOS and macOS Iris URLs', async () => {
  const artifact = await createArtifactZip();
  const expectedChecksum = createHash('sha256').update(artifact).digest('hex');

  for (const platform of ['iOS', 'macOS']) {
    const manifests = await createTemporaryManifests();
    const targetManifest = platform === 'iOS' ? manifests.iosManifest : manifests.macosManifest;
    const otherManifest = platform === 'iOS' ? manifests.macosManifest : manifests.iosManifest;
    const otherBefore = await readFile(otherManifest, 'utf8');

    await withArtifactServer(
      `AgoraIrisRTC_${platform}2-4.6.3-build.1.zip`,
      artifact,
      async (artifactUrl) => {
        await runUpdater(`【swiftPM】\nurl: "${artifactUrl}"`, manifests);

        const manifest = await readFile(targetManifest, 'utf8');
        assert.match(manifest, new RegExp(`url: "${artifactUrl.replaceAll('.', '\\.')}"`));
        assert.match(manifest, new RegExp(`checksum: "${expectedChecksum}"`));

        const legacy = await printLegacyContent(`【swiftPM】\nurl: "${artifactUrl}"`);
        assert.doesNotMatch(legacy.stdout, /AgoraIrisRTC_|\burl:/i);
      },
    );

    assert.equal(await readFile(otherManifest, 'utf8'), otherBefore);
  }
});

test('accepts a Swift binary target snippet with an explicitly supplied checksum', async () => {
  const manifests = await createTemporaryManifests();
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const input = [
    '【swiftPM】',
    `url: "${iosIrisUrl}",`,
    `checksum: "${iosIrisChecksum}"`,
  ].join('\n');

  await runUpdater(input, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.ok(ios.includes(`url: "${iosIrisUrl}"`));
  assert.match(ios, new RegExp(`checksum: "${iosIrisChecksum}"`));
  assert.match(ios, /AgoraRtcEngine_iOS\.git/);
  assert.match(ios, /\.product\(name: "RtcBasic", package: "AgoraRtcEngine_iOS"\)/);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('accepts an explicit Iris URL when it matches the CocoaPods-derived URL', async () => {
  const manifests = await createTemporaryManifests();
  const input = [
    "pod 'AgoraIrisRTC_iOS2', '4.6.2-build.1'",
    completeDependenciesContent.split('\n')[0],
  ].join('\n');

  await runUpdater(input, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.ok(ios.includes(`url: "${iosIrisUrl}"`));
  assert.match(ios, new RegExp(`checksum: "${iosIrisChecksum}"`));
});

test('rejects an explicit Iris URL that conflicts with its CocoaPods identity', async () => {
  const manifests = await createTemporaryManifests();
  const input = [
    "pod 'AgoraIrisRTC_iOS2', '4.6.2-build.1'",
    completeDependenciesContent
      .split('\n')[0]
      .replace('AgoraIrisRTC_iOS2-', 'AgoraIrisRTC_iOS-'),
  ].join('\n');

  await assert.rejects(
    runUpdater(input, manifests),
    /Iris SPM URL conflict for iOS.*does not match.*AgoraIrisRTC_iOS2/,
  );
});

test('splits iOS and macOS records inside one unscoped SwiftPM section', async () => {
  const manifests = await createTemporaryManifests();
  const input = [
    '【swiftPM】',
    'github:git@github.com:AgoraIO/AgoraRtcEngine_iOS.git tag:4.6.2 products:RtcBasic,AINS',
    `url: "${iosIrisUrl}",`,
    `checksum: "${iosIrisChecksum}"`,
    'github:https://github.com/AgoraIO/AgoraRtcEngine_macOS.git tag:4.6.2 products:RtcBasic',
    `url: "${macosIrisUrl}",`,
    `checksum: "${macosIrisChecksum}"`,
  ].join('\n');

  await runUpdater(input, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(ios, /AgoraRtcEngine_iOS\.git", exact: "4\.6\.2"/);
  assert.match(ios, /\.product\(name: "AINS", package: "AgoraRtcEngine_iOS"\)/);
  assert.ok(ios.includes(`url: "${iosIrisUrl}"`));
  assert.match(ios, new RegExp(`checksum: "${iosIrisChecksum}"`));

  const macos = await readFile(manifests.macosManifest, 'utf8');
  assert.match(macos, /AgoraRtcEngine_macOS\.git", exact: "4\.6\.2"/);
  assert.doesNotMatch(macos, /\.product\(name: "AINS"/);
  assert.ok(macos.includes(`url: "${macosIrisUrl}"`));
  assert.match(macos, new RegExp(`checksum: "${macosIrisChecksum}"`));

  const legacy = await printLegacyContent(input);
  assert.equal(legacy.stdout, '\n');
});

test('requires explicit products when changing the Native package repository', async () => {
  const manifests = await createTemporaryManifests();

  await assert.rejects(
    runUpdater(
      'github:https://github.com/AgoraIO/AgoraAudio_iOS.git tag:4.5.3-a1',
      manifests,
    ),
    /Native package changed for iOS.*products must be provided/,
  );
});

test('does not write either manifest when an Iris artifact download fails', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');

  await withArtifactServer(
    'AgoraIrisRTC_macOS2-4.6.3-build.1.zip',
    Buffer.from('not found'),
    async (artifactUrl) => {
      const input = [
        'github:https://github.com/AgoraIO/AgoraAudio_iOS.git tag:4.5.3-a1 products:RtcBasic',
        `url: "${artifactUrl}"`,
      ].join('\n');

      await assert.rejects(
        runUpdater(input, manifests),
        /Failed to download Iris SPM artifact.*404/,
      );
    },
    404,
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('rolls back both manifests when the second commit rename fails', async () => {
  const tempRoot = await mkdtemp(path.join(os.tmpdir(), 'agora-spm-commit-'));
  const iosManifest = path.join(tempRoot, 'ios-Package.swift');
  const macosManifest = path.join(tempRoot, 'macos-Package.swift');
  const iosBefore = 'original iOS manifest';
  const macosBefore = 'original macOS manifest';
  await writeFile(iosManifest, iosBefore, 'utf8');
  await writeFile(macosManifest, macosBefore, 'utf8');

  let markIosInstalled;
  const iosInstalled = new Promise((resolve) => {
    markIosInstalled = resolve;
  });
  const fileOperations = {
    writeFile,
    rename: async (source, destination) => {
      if (source.startsWith(`${iosManifest}.tmp-`) && destination === iosManifest) {
        await rename(source, destination);
        markIosInstalled();
        return;
      }
      if (
        source.startsWith(`${macosManifest}.tmp-`) &&
        destination === macosManifest
      ) {
        await iosInstalled;
        throw new Error('injected second manifest rename failure');
      }
      await rename(source, destination);
    },
    rm,
  };

  try {
    await assert.rejects(
      commitUpdates(
        [
          { filePath: iosManifest, content: 'updated iOS manifest' },
          { filePath: macosManifest, content: 'updated macOS manifest' },
        ],
        fileOperations,
      ),
      /injected second manifest rename failure/,
    );

    assert.equal(await readFile(iosManifest, 'utf8'), iosBefore);
    assert.equal(await readFile(macosManifest, 'utf8'), macosBefore);
    assert.deepEqual(
      (await readdir(tempRoot)).sort(),
      ['ios-Package.swift', 'macos-Package.swift'],
    );
  } finally {
    await rm(tempRoot, { recursive: true, force: true });
  }
});

test('waits for all temporary writes before cleaning up a failed preparation', async () => {
  const tempRoot = await mkdtemp(path.join(os.tmpdir(), 'agora-spm-prepare-'));
  const iosManifest = path.join(tempRoot, 'ios-Package.swift');
  const macosManifest = path.join(tempRoot, 'macos-Package.swift');
  await writeFile(iosManifest, 'original iOS manifest', 'utf8');
  await writeFile(macosManifest, 'original macOS manifest', 'utf8');
  const fileOperations = {
    writeFile: async (filePath, content, encoding) => {
      if (filePath.startsWith(`${iosManifest}.tmp-`)) {
        await new Promise((resolve) => setTimeout(resolve, 50));
        await writeFile(filePath, content, encoding);
        return;
      }
      if (filePath.startsWith(`${macosManifest}.tmp-`)) {
        throw new Error('injected temporary write failure');
      }
      await writeFile(filePath, content, encoding);
    },
    rename,
    rm,
  };

  try {
    await assert.rejects(
      commitUpdates(
        [
          { filePath: iosManifest, content: 'updated iOS manifest' },
          { filePath: macosManifest, content: 'updated macOS manifest' },
        ],
        fileOperations,
      ),
      /injected temporary write failure/,
    );
    await new Promise((resolve) => setTimeout(resolve, 75));

    assert.deepEqual(
      (await readdir(tempRoot)).sort(),
      ['ios-Package.swift', 'macos-Package.swift'],
    );
  } finally {
    await rm(tempRoot, { recursive: true, force: true });
  }
});

test('reports temporary cleanup failures after preparation fails', async () => {
  const fileOperations = {
    writeFile: async () => {
      throw new Error('injected preparation failure');
    },
    rename,
    rm: async () => {
      throw new Error('injected preparation cleanup failure');
    },
  };

  await assert.rejects(
    commitUpdates(
      [{ filePath: '/unused/Package.swift', content: 'updated manifest' }],
      fileOperations,
    ),
    (error) => {
      assert.ok(error instanceof AggregateError);
      assert.match(error.message, /prepare SPM manifests and clean up 1 temporary file/);
      assert.deepEqual(
        error.errors.map((nestedError) => nestedError.message),
        ['injected preparation failure', 'injected preparation cleanup failure'],
      );
      return true;
    },
  );
});

test('reports every temporary write failure during preparation', async () => {
  const fileOperations = {
    writeFile: async (filePath) => {
      if (filePath.includes('ios-Package.swift')) {
        throw new Error('injected iOS preparation failure');
      }
      throw new Error('injected macOS preparation failure');
    },
    rename,
    rm: async () => {},
  };

  await assert.rejects(
    commitUpdates(
      [
        { filePath: '/unused/ios-Package.swift', content: 'updated iOS manifest' },
        {
          filePath: '/unused/macos-Package.swift',
          content: 'updated macOS manifest',
        },
      ],
      fileOperations,
    ),
    (error) => {
      assert.ok(error instanceof AggregateError);
      assert.match(error.message, /2 temporary writes failed/);
      assert.deepEqual(
        error.errors.map((nestedError) => nestedError.message),
        ['injected iOS preparation failure', 'injected macOS preparation failure'],
      );
      return true;
    },
  );
});

test('reports temporary cleanup failures after commit fails', async () => {
  const fileOperations = {
    writeFile: async () => {},
    rename: async () => {
      throw new Error('injected commit failure');
    },
    rm: async () => {
      throw new Error('injected commit cleanup failure');
    },
  };

  await assert.rejects(
    commitUpdates(
      [{ filePath: '/unused/Package.swift', content: 'updated manifest' }],
      fileOperations,
    ),
    (error) => {
      assert.ok(error instanceof AggregateError);
      assert.match(error.message, /commit SPM manifests and clean up 1 temporary file/);
      assert.deepEqual(
        error.errors.map((nestedError) => nestedError.message),
        ['injected commit failure', 'injected commit cleanup failure'],
      );
      return true;
    },
  );
});

test('reports every backup cleanup failure after a successful commit', async () => {
  const fileOperations = {
    writeFile: async () => {},
    rename: async () => {},
    rm: async (filePath) => {
      if (filePath.includes('ios-Package.swift')) {
        throw new Error('injected iOS backup cleanup failure');
      }
      throw new Error('injected macOS backup cleanup failure');
    },
  };

  await assert.rejects(
    commitUpdates(
      [
        { filePath: '/unused/ios-Package.swift', content: 'updated iOS manifest' },
        {
          filePath: '/unused/macos-Package.swift',
          content: 'updated macOS manifest',
        },
      ],
      fileOperations,
    ),
    (error) => {
      assert.ok(error instanceof AggregateError);
      assert.match(error.message, /clean up 2 SPM manifest backup file/);
      assert.deepEqual(
        error.errors.map((nestedError) => nestedError.message),
        [
          'injected iOS backup cleanup failure',
          'injected macOS backup cleanup failure',
        ],
      );
      return true;
    },
  );
});

test('rejects a downloaded Iris artifact that is not a valid zip', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');

  await withArtifactServer(
    'AgoraIrisRTC_iOS2-invalid.zip',
    Buffer.from('not a zip archive'),
    async (artifactUrl) => {
      await assert.rejects(
        runUpdater(`url:"${artifactUrl}"`, manifests),
        /Invalid Iris SPM artifact.*valid zip/,
      );
    },
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('rejects an Iris zip without AgoraRtcWrapper.xcframework at its root', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const artifact = await createArtifactZip('Other.xcframework');

  await withArtifactServer(
    'AgoraIrisRTC_iOS2-wrong-root.zip',
    artifact,
    async (artifactUrl) => {
      await assert.rejects(
        runUpdater(`url:"${artifactUrl}"`, manifests),
        /must contain AgoraRtcWrapper\.xcframework at archive root/,
      );
    },
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('rejects an Iris artifact that exceeds the download size limit', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const artifact = await createArtifactZip();

  await withArtifactServer(
    'AgoraIrisRTC_iOS2-too-large.zip',
    artifact,
    async (artifactUrl) => {
      await assert.rejects(
        runUpdater(`url:"${artifactUrl}"`, manifests, {
          env: { AGORA_SPM_ARTIFACT_MAX_BYTES: '8' },
        }),
        /exceeds maximum size of 8 bytes/,
      );
    },
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('times out a stalled Iris artifact download before writing manifests', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');

  await withArtifactServer(
    'AgoraIrisRTC_iOS2-stalled.zip',
    Buffer.alloc(0),
    async (artifactUrl) => {
      await assert.rejects(
        runUpdater(`url:"${artifactUrl}"`, manifests, {
          env: { AGORA_SPM_ARTIFACT_TIMEOUT_MS: '50' },
          timeout: 1000,
        }),
        /download timed out after 50 ms/,
      );
    },
    { stall: true },
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('does not add FlutterFramework or updater markers', async () => {
  const manifests = await createTemporaryManifests();

  await runUpdater(completeDependenciesContent, manifests);

  for (const manifestPath of [manifests.iosManifest, manifests.macosManifest]) {
    const manifest = await readFile(manifestPath, 'utf8');
    assert.doesNotMatch(manifest, /FlutterFramework/);
    assert.doesNotMatch(manifest, /agora-spm-updater:/);
  }
});

test('preserves an existing FlutterFramework dependency without managing it', async () => {
  const manifests = await createTemporaryManifests();

  for (const manifestPath of [manifests.iosManifest, manifests.macosManifest]) {
    const source = (await readFile(manifestPath, 'utf8'))
      .replace(
        '    dependencies: [\n',
        [
          '    dependencies: [',
          '        .package(name: "FlutterFramework", path: "../FlutterFramework"),',
          '',
        ].join('\n'),
      )
      .replace(
        '            dependencies: [\n',
        [
          '            dependencies: [',
          '                .product(name: "FlutterFramework", package: "FlutterFramework"),',
          '',
        ].join('\n'),
      );
    await writeFile(manifestPath, source, 'utf8');
  }

  await runUpdater(completeDependenciesContent, manifests);

  for (const manifestPath of [manifests.iosManifest, manifests.macosManifest]) {
    const manifest = await readFile(manifestPath, 'utf8');
    assert.equal(
      manifest.match(/\.package\(name: "FlutterFramework"/g)?.length,
      1,
    );
    assert.equal(
      manifest.match(/\.product\(name: "FlutterFramework"/g)?.length,
      1,
    );
    assert.doesNotMatch(manifest, /agora-spm-updater:/);
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

test('does not attach an unscoped SwiftPM section to a preceding legacy platform record', async () => {
  const manifests = await createTemporaryManifests();
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const input = [
    "platform:Android implementation 'io.agora.rtc:agora-special-full:4.6.2'",
    '【swiftPM】',
    'github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git tag:4.6.2',
  ].join('\n');

  await runUpdater(input, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(ios, /AgoraRtcEngine_iOS\.git", exact: "4\.6\.2"/);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('accepts a legacy-only block after SPM metadata for the same platform', async () => {
  const manifests = await createTemporaryManifests();
  const input = [
    completeDependenciesContent.split('\n')[0],
    "platform:iOS cocoapods: pod 'AgoraVideo_Special_iOS', '4.6.2.70'",
  ].join('\n');

  await runUpdater(input, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(ios, /\.product\(name: "RtcBasic", package: "AgoraRtcEngine_iOS"\)/);
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

test('removes a SwiftPM section after a legacy platform record from legacy content', async () => {
  const input = [
    "platform:Android implementation 'io.agora.rtc:agora-special-full:4.6.2'",
    '【swiftPM】',
    'github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git tag:4.6.2',
  ].join('\n');

  const result = await printLegacyContent(input);

  assert.match(result.stdout, /platform:Android implementation/);
  assert.doesNotMatch(result.stdout, /swiftpm|github|tag:/i);
});

test('preserves version and tag fields in non-Apple legacy records', async () => {
  const input = [
    "platform:Android native maven: implementation 'io.agora.rtc:full-sdk:4.6.2' version:4.6.2 tag:android-preview",
    completeDependenciesContent.split('\n')[0],
    'platform:Windows native cdn: https://download.agora.io/example.zip version:4.6.2.70 tag:windows-preview',
  ].join('\n');

  const result = await printLegacyContent(input);

  assert.match(result.stdout, /platform:Android.*version:4\.6\.2 tag:android-preview/);
  assert.match(result.stdout, /platform:Windows.*version:4\.6\.2\.70 tag:windows-preview/);
  assert.match(result.stdout, /tag:android-preview\nplatform:iOS\nplatform:Windows/);
  assert.doesNotMatch(result.stdout, /AgoraRtcEngine_iOS|products:|iris-url:|iris-checksum:/i);
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

test('rejects a Native GitHub URL without a tag before writing either manifest', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const incompleteInput =
    'platform:macOS github:https://github.com/AgoraIO/AgoraRtcEngine_macOS.git';

  await assert.rejects(
    runUpdater(incompleteInput, manifests),
    /Incomplete Native SPM metadata for macOS/,
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('rejects an empty GitHub field before writing either manifest', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');

  await assert.rejects(
    runUpdater('platform:iOS github:', manifests),
    /Invalid SPM metadata for iOS: github/,
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('rejects an empty tag field before writing either manifest', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const input =
    'platform:iOS github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git tag:';

  await assert.rejects(
    runUpdater(input, manifests),
    /Invalid SPM metadata for iOS: tag\/version/,
  );

  assert.equal(await readFile(manifests.iosManifest, 'utf8'), iosBefore);
  assert.equal(await readFile(manifests.macosManifest, 'utf8'), macosBefore);
});

test('rejects an empty checksum field before writing either manifest', async () => {
  const manifests = await createTemporaryManifests();
  const iosBefore = await readFile(manifests.iosManifest, 'utf8');
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');

  await withArtifactServer(
    'AgoraIrisRTC_iOS2-empty-checksum.zip',
    Buffer.from('unused artifact'),
    async (artifactUrl) => {
      const input = `platform:iOS url:"${artifactUrl}" checksum:`;
      await assert.rejects(
        runUpdater(input, manifests),
        /Invalid SPM metadata for iOS: iris-checksum/,
      );
    },
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

test('derives Iris SPM URLs while preserving repeated Apple blocks for legacy parsing', async () => {
  const legacyInput = [
    "platform:iOS cocoapods: pod 'AgoraVideo_Special_iOS', '4.6.2.70'",
    "platform:iOS iris cocoapods: pod 'AgoraIrisRTC_iOS2', '4.6.2-build.1'",
    "platform:macOS cocoapods: pod 'AgoraVideo_Special_macOS', '4.6.2.70'",
    "platform:macOS iris cocoapods: pod 'AgoraIrisRTC_macOS2', '4.6.2-build.1'",
  ].join('\n');

  const dependencies = spmUpdater.parsePlatformDependencies(legacyInput);
  assert.equal(dependencies.get('iOS')?.irisUrl, iosIrisUrl);
  assert.equal(dependencies.get('macOS')?.irisUrl, macosIrisUrl);

  const legacy = await printLegacyContent(legacyInput);
  assert.equal(legacy.stdout.trim(), legacyInput);
});

test('infers the platform when SPM metadata omits the platform field', async () => {
  const manifests = await createTemporaryManifests();
  const macosBefore = await readFile(manifests.macosManifest, 'utf8');
  const missingPlatform = completeDependenciesContent
    .split('\n')[0]
    .replace('platform:iOS ', '');

  await runUpdater(missingPlatform, manifests);

  const ios = await readFile(manifests.iosManifest, 'utf8');
  assert.match(
    ios,
    /\.package\(url: "https:\/\/github\.com\/AgoraIO\/AgoraRtcEngine_iOS\.git", exact: "4\.6\.2"\)/,
  );
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
  const parseLegacyIndex = workflow.indexOf('name: Parse dependencies content');
  const updateSpmIndex = workflow.indexOf('name: Update Apple SPM dependencies');
  const validateSpmIndex = workflow.indexOf('name: Validate Apple SPM manifests');
  const createPrIndex = workflow.indexOf('name: Commit and create pull request');
  const legacyStep = extractWorkflowStep(workflow, 'Parse dependencies content');
  const spmStep = extractWorkflowStep(workflow, 'Update Apple SPM dependencies');

  assert.ok(setupNodeIndex >= 0, 'workflow must set up Node');
  assert.ok(testUpdaterIndex > setupNodeIndex, 'workflow must run updater tests after setup');
  assert.ok(parseLegacyIndex > testUpdaterIndex, 'workflow must parse legacy input after tests');
  assert.match(legacyStep, /uses: AgoraIO-Extensions\/actions\/\.github\/actions\/dep@[^\s]+/);
  assert.match(legacyStep, /dependencies-content:\s*\$\{\{\s*inputs\.dependencies_content\s*\}\}/);
  assert.doesNotMatch(legacyStep, /update_spm_deps\.mjs/);
  assert.match(spmStep, /DEPENDENCIES_CONTENT:\s*\$\{\{\s*inputs\.dependencies_content\s*\}\}/);
  assert.match(spmStep, /update_spm_deps\.mjs/);
  assert.ok(updateSpmIndex > testUpdaterIndex, 'workflow must update manifests after tests');
  assert.ok(validateSpmIndex > updateSpmIndex, 'workflow must validate generated manifests');
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

  const spmInputs = [
    'tag:4.6.2',
    `checksum:${iosIrisChecksum}`,
    "pod 'AgoraIrisRTC_iOS', '4.7.0-dev.2'",
    'github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git tag:4.6.2',
    `【swiftPM】\nurl: "${iosIrisUrl}"`,
    `url: "${macosIrisUrl}"`,
  ];
  for (const dependenciesContent of spmInputs) {
    let spmError;
    try {
      await execFileAsync('bash', ['-c', script], {
        cwd: oldTarget,
        env: { ...process.env, DEPENDENCIES_CONTENT: dependenciesContent },
      });
    } catch (error) {
      spmError = error;
    }
    assert.ok(spmError, `SPM input must fail without updater: ${dependenciesContent}`);
    assert.match(spmError.stdout, /Target ref does not contain the Apple SPM dependency updater/);
  }
});
