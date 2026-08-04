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
  const fieldMatch = line.match(
    /(?:^|[\s|])products?\s*[:=]\s*/i,
  );
  if (!fieldMatch) {
    return null;
  }

  const valueStart = fieldMatch.index + fieldMatch[0].length;
  const nextFieldPattern =
    /(?:^|[\s|])(?:platform|github|tag|version|products?|iris-url|iris-checksum)\s*[:=]/gi;
  nextFieldPattern.lastIndex = valueStart;
  const nextField = nextFieldPattern.exec(line);
  const valueEnd = nextField?.index ?? line.length;
  let value = line.slice(valueStart, valueEnd).trim().replace(/\|\s*$/, '').trim();

  if (value.startsWith('"') || value.startsWith("'")) {
    const quote = value[0];
    if (value.length < 2 || !value.endsWith(quote)) {
      return null;
    }
    value = value.slice(1, -1);
  } else if (value.includes('"') || value.includes("'")) {
    return null;
  }

  if (!/^[A-Za-z0-9_]+(?:\s*,\s*[A-Za-z0-9_]+)*$/.test(value)) {
    return null;
  }
  return value.split(',').map((product) => product.trim());
}

function parseLabeledValues(line, labelPattern) {
  const fieldPattern = new RegExp(
    `(?:^|[\\s|])(?:${labelPattern})\\s*[:=]\\s*(?:"([^"]*)"|'([^']*)'|([^\\s|]+))(?=$|[\\s|])`,
    'gi',
  );
  return [...line.matchAll(fieldPattern)].map(
    (match) => match[1] ?? match[2] ?? match[3],
  );
}

function countLabeledFields(line, labelPattern) {
  const fieldPattern = new RegExp(
    `(?:^|[\\s|])(?:${labelPattern})\\s*[:=]`,
    'gi',
  );
  return [...line.matchAll(fieldPattern)].length;
}

function parsePlatformDependencies(content) {
  const dependencies = new Map();

  for (const line of content.split(/\r?\n/)) {
    const tagCount = countLabeledFields(line, 'tag');
    const versionCount = countLabeledFields(line, 'version');
    const fieldCounts = {
      platform: countLabeledFields(line, 'platform'),
      github: countLabeledFields(line, 'github'),
      'tag/version': tagCount + versionCount,
      products: countLabeledFields(line, 'products?'),
      'iris-url': countLabeledFields(line, 'iris-url'),
      'iris-checksum': countLabeledFields(line, 'iris-checksum'),
    };
    const hasSpmMetadata =
      fieldCounts.github > 0 ||
      tagCount > 0 ||
      fieldCounts.products > 0 ||
      fieldCounts['iris-url'] > 0 ||
      fieldCounts['iris-checksum'] > 0;
    const platformValues = parseLabeledValues(line, 'platform');
    if (platformValues.length === 0) {
      if (hasSpmMetadata) {
        if (fieldCounts.platform === 0) {
          throw new Error('SPM metadata requires an explicit platform field');
        }
        throw new Error('Invalid SPM platform field');
      }
      continue;
    }
    if (!hasSpmMetadata) {
      continue;
    }

    const platformValue = platformValues[0];
    if (!/^(?:iOS|macOS)$/i.test(platformValue)) {
      throw new Error(`Unsupported SPM platform: ${platformValue}`);
    }
    const platform = platformValue.toLowerCase() === 'ios' ? 'iOS' : 'macOS';
    const duplicateFields = Object.entries(fieldCounts)
      .filter(([_field, count]) => count > 1)
      .map(([field]) => field);
    if (duplicateFields.length > 0) {
      throw new Error(`Duplicate SPM fields for ${platform}: ${duplicateFields.join(', ')}`);
    }
    if (dependencies.has(platform)) {
      throw new Error(`Duplicate SPM metadata for ${platform}`);
    }
    const githubValue = parseLabeledValues(line, 'github')[0] ?? null;
    const versionValue = parseLabeledValues(line, 'tag|version')[0] ?? null;
    const products = parseProducts(line);
    const irisUrlValue = parseLabeledValues(line, 'iris-url')[0] ?? null;
    const checksumValue = parseLabeledValues(line, 'iris-checksum')[0] ?? null;

    const missingFields = Object.entries(fieldCounts)
      .filter(([field, count]) => field !== 'platform' && count === 0)
      .map(([field]) => field);
    if (missingFields.length > 0) {
      throw new Error(`Incomplete SPM metadata for ${platform}: ${missingFields.join(', ')}`);
    }

    const invalidFields = [];
    let packageUrl;
    if (githubValue) {
      try {
        packageUrl = normalizeGithubUrl(githubValue);
      } catch {
        invalidFields.push('github');
      }
    } else {
      invalidFields.push('github');
    }
    if (!versionValue || !/^[A-Za-z0-9_.+-]+$/.test(versionValue)) {
      invalidFields.push('tag/version');
    }
    if (!products) {
      invalidFields.push('products');
    }
    if (!irisUrlValue || !/^https?:\/\/[^\s|,'"]+$/.test(irisUrlValue)) {
      invalidFields.push('iris-url');
    }
    if (!checksumValue || !/^[a-f0-9]{64}$/i.test(checksumValue)) {
      invalidFields.push('iris-checksum');
    }
    if (invalidFields.length > 0) {
      throw new Error(`Invalid SPM metadata for ${platform}: ${invalidFields.join(', ')}`);
    }

    dependencies.set(platform, {
      packageUrl,
      packageName: path.basename(packageUrl, '.git'),
      version: versionValue,
      products,
      irisUrl: irisUrlValue,
      irisChecksum: checksumValue.toLowerCase(),
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

function findManagedLineIndexes(lines, startMarker, endMarker, description) {
  const startIndexes = lines
    .map((line, index) => (line === startMarker ? index : -1))
    .filter((index) => index >= 0);
  const endIndexes = lines
    .map((line, index) => (line === endMarker ? index : -1))
    .filter((index) => index >= 0);

  if (startIndexes.length === 0 && endIndexes.length === 0) {
    return null;
  }
  if (
    startIndexes.length !== 1 ||
    endIndexes.length !== 1 ||
    startIndexes[0] >= endIndexes[0]
  ) {
    throw new Error(`Invalid ${description} markers in Package.swift`);
  }

  return Array.from(
    { length: endIndexes[0] - startIndexes[0] + 1 },
    (_value, offset) => startIndexes[0] + offset,
  );
}

function updateManifest(source, dependency, platform) {
  const existingPackageName =
    platform === 'iOS' ? 'AgoraRtcEngine_iOS' : 'AgoraRtcEngine_macOS';
  const managedPackageNames = new Set([existingPackageName, dependency.packageName]);
  const packageStartMarker = '        // agora-spm-updater:managed-packages-start';
  const packageEndMarker = '        // agora-spm-updater:managed-packages-end';
  const packageDependencies = [
    packageStartMarker,
    '        .package(name: "FlutterFramework", path: "../FlutterFramework"),',
    `        .package(url: "${dependency.packageUrl}", exact: "${dependency.version}"),`,
    packageEndMarker,
  ];

  let updated = replaceExactlyOnce(
    source,
    /(    dependencies: \[\n)([\s\S]*?)(\n    \],\n    targets: \[)/,
    (_match, prefix, body, suffix) => {
      const lines = body.split('\n');
      const managedIndexes = [];
      let nativePackageCount = 0;
      const markedIndexes = findManagedLineIndexes(
        lines,
        packageStartMarker,
        packageEndMarker,
        'managed package dependency',
      );

      if (markedIndexes) {
        managedIndexes.push(...markedIndexes);
        nativePackageCount = markedIndexes.filter((index) =>
          lines[index].includes('.package(url:'),
        ).length;
      } else {
        for (const [index, line] of lines.entries()) {
          if (line.includes('.package(name: "FlutterFramework"')) {
            managedIndexes.push(index);
            continue;
          }

          const packageMatch = line.match(/\.package\(url: "([^"]+)"/);
          if (!packageMatch) {
            continue;
          }

          try {
            const packageName = path.basename(
              normalizeGithubUrl(packageMatch[1]),
              '.git',
            );
            if (managedPackageNames.has(packageName)) {
              managedIndexes.push(index);
              nativePackageCount += 1;
            }
          } catch {
            // An unrelated non-GitHub package remains untouched.
          }
        }
      }

      if (nativePackageCount !== 1) {
        throw new Error('Unable to locate Native package dependency in Package.swift');
      }

      const insertionIndex = Math.min(...managedIndexes);
      const preservedLines = lines.filter((_line, index) => !managedIndexes.includes(index));
      preservedLines.splice(insertionIndex, 0, ...packageDependencies);
      return `${prefix}${preservedLines.join('\n')}${suffix}`;
    },
    'package dependencies',
  );

  const targetStartMarker = '                // agora-spm-updater:managed-products-start';
  const targetEndMarker = '                // agora-spm-updater:managed-products-end';
  const targetDependencies = [
    targetStartMarker,
    '                .product(name: "FlutterFramework", package: "FlutterFramework"),',
    ...dependency.products.map(
      (product) =>
        `                .product(name: "${product}", package: "${dependency.packageName}"),`,
    ),
    targetEndMarker,
  ];

  updated = replaceExactlyOnce(
    updated,
    /(            dependencies: \[\n)([\s\S]*?)(\n            \],\n            cSettings:)/,
    (_match, prefix, body, suffix) => {
      const lines = body.split('\n');
      const managedIndexes = [];
      let nativeProductCount = 0;
      const markedIndexes = findManagedLineIndexes(
        lines,
        targetStartMarker,
        targetEndMarker,
        'managed product dependency',
      );

      if (markedIndexes) {
        managedIndexes.push(...markedIndexes);
        nativeProductCount = markedIndexes.filter((index) => {
          const productMatch = lines[index].match(
            /\.product\(name: "[^"]+", package: "([^"]+)"\)/,
          );
          return productMatch && productMatch[1] !== 'FlutterFramework';
        }).length;
      } else {
        for (const [index, line] of lines.entries()) {
          const productMatch = line.match(
            /\.product\(name: "[^"]+", package: "([^"]+)"\)/,
          );
          if (!productMatch) {
            continue;
          }

          if (productMatch[1] === 'FlutterFramework') {
            managedIndexes.push(index);
          } else if (managedPackageNames.has(productMatch[1])) {
            managedIndexes.push(index);
            nativeProductCount += 1;
          }
        }
      }

      if (nativeProductCount === 0) {
        throw new Error('Unable to locate Native product dependencies in Package.swift');
      }

      const insertionIndex = Math.min(...managedIndexes);
      const preservedLines = lines.filter((_line, index) => !managedIndexes.includes(index));
      preservedLines.splice(insertionIndex, 0, ...targetDependencies);
      return `${prefix}${preservedLines.join('\n')}${suffix}`;
    },
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
