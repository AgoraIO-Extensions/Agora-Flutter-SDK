#!/usr/bin/env node

import { readFile, rename, writeFile } from 'node:fs/promises';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const ciDir = path.dirname(fileURLToPath(import.meta.url));
const repoRoot = path.resolve(ciDir, '..');

function parseArgs(argv) {
  const args = {
    dependenciesContent: '',
    iosManifest: path.join(repoRoot, 'ios/agora_rtc_engine/Package.swift'),
    macosManifest: path.join(repoRoot, 'macos/agora_rtc_engine/Package.swift'),
  };

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];
    const value = argv[index + 1] ?? '';

    if (arg === '--dependencies-content') {
      args.dependenciesContent = value;
      index += 1;
    } else if (arg === '--ios-manifest') {
      args.iosManifest = path.resolve(value);
      index += 1;
    } else if (arg === '--macos-manifest') {
      args.macosManifest = path.resolve(value);
      index += 1;
    }
  }

  return args;
}

function normalizeGithubUrl(value) {
  const match = value.match(
    /github\.com[:/]([A-Za-z0-9_.-]+\/[A-Za-z0-9_.-]+?)(?:\.git)?$/i,
  );
  if (!match) {
    throw new Error(`Invalid GitHub package URL: ${value}`);
  }
  return `https://github.com/${match[1]}.git`;
}

function parseProducts(line) {
  const match = line.match(
    /\bproducts?\s*[:=]\s*["']?([^\s|'",]+(?:\s*,\s*[^\s|'",]+)*)["']?/i,
  );
  if (!match) {
    return null;
  }

  const products = match[1].split(',').map((product) => product.trim());
  return products.every((product) => /^[A-Za-z0-9_]+$/.test(product)) ? products : null;
}

function parsePlatformDependencies(content) {
  const dependencies = new Map();

  for (const line of content.split(/\r?\n/)) {
    const platformMatch = line.match(/\bplatform\s*[:=]\s*(iOS|macOS)\b/i);
    if (!platformMatch) {
      continue;
    }

    const platform = platformMatch[1].toLowerCase() === 'ios' ? 'iOS' : 'macOS';
    if (dependencies.has(platform)) {
      throw new Error(`Duplicate SPM metadata for ${platform}`);
    }
    const githubMatch = line.match(
      /(?:\bgithub\s*[:=]\s*["']?)?((?:https?:\/\/github\.com\/|git@github\.com:)[A-Za-z0-9_.-]+\/[A-Za-z0-9_.-]+(?:\.git)?)["']?/i,
    );
    const versionMatch = line.match(
      /\b(?:tag|version)\s*[:=]\s*["']?([A-Za-z0-9_.+-]+)["']?/i,
    );
    const products = parseProducts(line);
    const irisUrlMatch = line.match(
      /\biris-url\s*[:=]\s*["']?(https?:\/\/[^\s|,'"]+)["']?/i,
    );
    const checksumMatch = line.match(
      /\biris-checksum\s*[:=]\s*["']?([a-f0-9]{64})["']?/i,
    );

    if (!githubMatch || !versionMatch || !products || !irisUrlMatch || !checksumMatch) {
      throw new Error(`Incomplete SPM metadata for ${platform}`);
    }

    const packageUrl = normalizeGithubUrl(githubMatch[1]);
    dependencies.set(platform, {
      packageUrl,
      packageName: path.basename(packageUrl, '.git'),
      version: versionMatch[1],
      products,
      irisUrl: irisUrlMatch[1],
      irisChecksum: checksumMatch[1].toLowerCase(),
    });
  }

  return dependencies;
}

function replaceExactlyOnce(source, pattern, replacement, description) {
  const matches = source.match(pattern);
  if (!matches) {
    throw new Error(`Unable to locate ${description} in Package.swift`);
  }

  return source.replace(pattern, replacement);
}

function updateManifest(source, dependency, platform) {
  const packageDependencies = [
    '    dependencies: [',
    '        .package(name: "FlutterFramework", path: "../FlutterFramework"),',
    `        .package(url: "${dependency.packageUrl}", exact: "${dependency.version}"),`,
    '    ],',
    '    targets: [',
  ].join('\n');

  let updated = replaceExactlyOnce(
    source,
    /    dependencies: \[\n[\s\S]*?\n    \],\n    targets: \[/,
    packageDependencies,
    'package dependencies',
  );

  const targetDependencies = [
    '            dependencies: [',
    '                .product(name: "FlutterFramework", package: "FlutterFramework"),',
    ...dependency.products.map(
      (product) =>
        `                .product(name: "${product}", package: "${dependency.packageName}"),`,
    ),
    '                "AgoraRtcWrapper"',
    '            ],',
    '            cSettings:',
  ].join('\n');

  updated = replaceExactlyOnce(
    updated,
    /            dependencies: \[\n[\s\S]*?\n            \],\n            cSettings:/,
    targetDependencies,
    'plugin target dependencies',
  );

  updated = replaceExactlyOnce(
    updated,
    /(            name: "AgoraRtcWrapper",\n            url: )"[^"]+"(,\n            checksum: )"[^"]+"/,
    `$1"${dependency.irisUrl}"$2"${dependency.irisChecksum}"`,
    'AgoraRtcWrapper binary target',
  );

  if (platform === 'macOS') {
    const unsafeCxxSetting =
      /,\n            cxxSettings: \[\n                \.unsafeFlags\(\["-std=c\+\+14"\]\)\n            \]/;
    if (unsafeCxxSetting.test(updated)) {
      updated = updated.replace(unsafeCxxSetting, '');
    } else if (!updated.includes('cxxLanguageStandard: .cxx14')) {
      throw new Error('Unable to locate macOS C++ setting in Package.swift');
    }

    if (!updated.includes('cxxLanguageStandard: .cxx14')) {
      updated = replaceExactlyOnce(
        updated,
        /\n    \]\n\)\s*$/,
        '\n    ],\n    cxxLanguageStandard: .cxx14\n)\n',
        'macOS C++ language standard',
      );
    }
  }

  return updated;
}

async function writeAtomically(filePath, content) {
  const temporaryPath = `${filePath}.tmp-${process.pid}`;
  await writeFile(temporaryPath, content, 'utf8');
  await rename(temporaryPath, filePath);
}

const args = parseArgs(process.argv.slice(2));
const dependencies = parsePlatformDependencies(args.dependenciesContent);

if (dependencies.size === 0) {
  console.log('SPM dependencies unchanged');
  process.exit(0);
}

const updates = [];
if (dependencies.has('iOS')) {
  const source = await readFile(args.iosManifest, 'utf8');
  updates.push({
    filePath: args.iosManifest,
    content: updateManifest(source, dependencies.get('iOS'), 'iOS'),
  });
}
if (dependencies.has('macOS')) {
  const source = await readFile(args.macosManifest, 'utf8');
  updates.push({
    filePath: args.macosManifest,
    content: updateManifest(source, dependencies.get('macOS'), 'macOS'),
  });
}

await Promise.all(updates.map(({ filePath, content }) => writeAtomically(filePath, content)));
console.log(`Updated SPM dependencies for ${[...dependencies.keys()].join(', ')}`);
