#!/usr/bin/env node

import { execFile } from 'node:child_process';
import { randomUUID } from 'node:crypto';
import { createWriteStream } from 'node:fs';
import { mkdtemp, readFile, rename, rm, writeFile } from 'node:fs/promises';
import os from 'node:os';
import path from 'node:path';
import { Readable, Transform } from 'node:stream';
import { pipeline } from 'node:stream/promises';
import { fileURLToPath } from 'node:url';
import { promisify } from 'node:util';

const modulePath = fileURLToPath(import.meta.url);
const ciDir = path.dirname(modulePath);
const repoRoot = path.resolve(ciDir, '..');
const execFileAsync = promisify(execFile);
const defaultFileOperations = { writeFile, rename, rm };
const defaultArtifactMaxBytes = 512 * 1024 * 1024;

function readPositiveIntegerEnv(name, fallback) {
  const value = process.env[name];
  if (value === undefined) {
    return fallback;
  }
  if (!/^[1-9][0-9]*$/.test(value) || !Number.isSafeInteger(Number(value))) {
    throw new Error(`${name} must be a positive integer`);
  }
  return Number(value);
}

const artifactMaxBytes = readPositiveIntegerEnv(
  'AGORA_SPM_ARTIFACT_MAX_BYTES',
  defaultArtifactMaxBytes,
);
const artifactTimeoutMs = readPositiveIntegerEnv(
  'AGORA_SPM_ARTIFACT_TIMEOUT_MS',
  120_000,
);

function parseArgs(argv) {
  const args = {
    dependenciesContent: '',
    iosManifest: path.join(repoRoot, 'ios/agora_rtc_engine/Package.swift'),
    macosManifest: path.join(repoRoot, 'macos/agora_rtc_engine/Package.swift'),
    printLegacyContent: false,
  };

  for (let index = 0; index < argv.length; index += 1) {
    const arg = argv[index];
    const value = argv[index + 1] ?? '';

    if (arg === '--print-legacy-content') {
      args.printLegacyContent = true;
    } else if (arg === '--dependencies-content') {
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

function isProductBoundary(value) {
  return /^(?:\s*$|\s*\||\s*\r?\n|\s+(?:(?:platform|github|tag|version|products?|iris-url|iris-checksum|url|checksum)\s*[:=]|implementation\b|pod\b|【))/i.test(
    value,
  );
}

function parseProducts(record) {
  const fieldMatch = record.match(
    /(?:^|[\s|])products?\s*[:=]\s*/i,
  );
  if (!fieldMatch) {
    return null;
  }

  const valueStart = fieldMatch.index + fieldMatch[0].length;
  const remaining = record.slice(valueStart);
  let value;
  let valueEnd;

  if (remaining.startsWith('"') || remaining.startsWith("'")) {
    const quote = remaining[0];
    const closingQuote = remaining.indexOf(quote, 1);
    if (closingQuote < 0) {
      return null;
    }
    value = remaining.slice(1, closingQuote);
    valueEnd = closingQuote + 1;
  } else {
    const valueMatch = remaining.match(
      /^[A-Za-z0-9_]+(?:\s*,\s*[A-Za-z0-9_]+)*/,
    );
    if (!valueMatch) {
      return null;
    }
    value = valueMatch[0];
    valueEnd = value.length;
  }

  if (
    !/^[A-Za-z0-9_]+(?:\s*,\s*[A-Za-z0-9_]+)*$/.test(value) ||
    !isProductBoundary(remaining.slice(valueEnd))
  ) {
    return null;
  }
  return value.split(',').map((product) => product.trim());
}

function parseLabeledValues(line, labelPattern) {
  const fieldPattern = new RegExp(
    `(?:^|[\\s|])(?:${labelPattern})\\s*[:=]\\s*(?:"([^"]*)"|'([^']*)'|([^\\s|,]+))(?:\\s*,)?(?=$|[\\s|])`,
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

function normalizeDependenciesContent(content) {
  return content
    .replaceAll(String.raw`\r\n`, '\n')
    .replaceAll(String.raw`\n`, '\n')
    .replaceAll(String.raw`\r`, '\n');
}

function findFailedIrisApplePlatforms(content) {
  const failedPlatforms = new Set();
  const sectionPattern = /^Iris\s+(iOS|macOS|Android|Windows):\s*$/gim;
  const sections = [...content.matchAll(sectionPattern)];

  for (const [index, section] of sections.entries()) {
    const bodyStart = section.index + section[0].length;
    const bodyEnd = sections[index + 1]?.index ?? content.length;
    if (!/Failure found on above jobs/i.test(content.slice(bodyStart, bodyEnd))) {
      continue;
    }
    const platformName = section[1].toLowerCase();
    if (platformName === 'ios') {
      failedPlatforms.add('iOS');
    } else if (platformName === 'macos') {
      failedPlatforms.add('macOS');
    }
  }

  return failedPlatforms;
}

function parseIrisCocoaPodsDependencies(content) {
  const dependencies = new Map();
  const failedPlatforms = findFailedIrisApplePlatforms(content);
  const failedPlatform = failedPlatforms.values().next().value;
  if (failedPlatform) {
    throw new Error(`Iris ${failedPlatform} build result is marked failed`);
  }
  const irisPodPattern =
    /\bpod\s+(['"])(AgoraIrisRTC_(iOS|macOS)[A-Za-z0-9_-]*)\1\s*,\s*(['"])([A-Za-z0-9_.+-]+)\4/gi;

  for (const match of content.matchAll(irisPodPattern)) {
    const [, , podName, platformName, , version] = match;
    const platform = platformName.toLowerCase() === 'ios' ? 'iOS' : 'macOS';
    if (dependencies.has(platform)) {
      throw new Error(`Duplicate Iris CocoaPods metadata for ${platform}`);
    }
    dependencies.set(platform, {
      irisUrl: `https://download.agora.io/sdk/release/${podName}-${version}.zip`,
      irisUrlSource: `derived from pod '${podName}', '${version}'`,
      irisPodName: podName,
      irisPodVersion: version,
    });
  }

  return dependencies;
}

function inferPlatformFromPackageUrl(packageUrl) {
  const packageName = path.basename(packageUrl, '.git');
  if (/(?:^|[_-])ios(?:$|[_-])/i.test(packageName)) {
    return 'iOS';
  }
  if (/(?:^|[_-])macos(?:$|[_-])/i.test(packageName)) {
    return 'macOS';
  }
  return null;
}

function inferPlatformFromIrisUrl(irisUrl) {
  const match = irisUrl.match(/AgoraIrisRTC[_-]?(iOS|macOS)/i);
  if (!match) {
    return null;
  }
  return match[1].toLowerCase() === 'ios' ? 'iOS' : 'macOS';
}

function parseIrisUrlValues(record) {
  const explicitValues = parseLabeledValues(record, 'iris-url');
  const genericValues = parseLabeledValues(record, 'url').filter((value) =>
    inferPlatformFromIrisUrl(value),
  );
  return [...explicitValues, ...genericValues];
}

function stripSpmFields(record, stripGenericIrisFields = false) {
  const scalarSpmField =
    /(^|[\s|])\s*(?:github|tag|version|iris-url|iris-checksum)\s*[:=]\s*(?:"[^"]*"|'[^']*'|[^\s|,]+)(?:\s*,)?(?=$|[\s|])/gi;
  const productsField =
    /(^|[\s|])\s*products?\s*[:=]\s*(?:"[^"]*"|'[^']*'|[A-Za-z0-9_]+(?:\s*,\s*[A-Za-z0-9_]+)*)/gi;
  const genericUrlField =
    /(^|[\s|])\s*url\s*[:=]\s*(?:"([^"]*)"|'([^']*)'|([^\s|,]+))(?:\s*,)?(?=$|[\s|])/gi;
  const genericChecksumField =
    /(^|[\s|])\s*checksum\s*[:=]\s*(?:"[^"]*"|'[^']*'|[^\s|,]+)(?:\s*,)?(?=$|[\s|])/gi;
  const preserveSeparator = (_match, separator) =>
    separator === '|' ? ' ' : separator;
  const containsAppleIrisUrl = parseIrisUrlValues(record).some((value) =>
    inferPlatformFromIrisUrl(value),
  );

  return record
    .split(/\r?\n/)
    .map((line) => {
      let sanitized = line
        .replace(productsField, preserveSeparator)
        .replace(scalarSpmField, preserveSeparator)
        .replace(genericUrlField, (match, separator, doubleQuoted, singleQuoted, bare) => {
          const value = doubleQuoted ?? singleQuoted ?? bare;
          return inferPlatformFromIrisUrl(value)
            ? preserveSeparator(match, separator)
            : match;
        });
      if (stripGenericIrisFields || containsAppleIrisUrl) {
        sanitized = sanitized.replace(genericChecksumField, preserveSeparator);
      }
      return sanitized.trim();
    })
    .filter(Boolean)
    .join('\n');
}

function hasAppleGithubUrl(record) {
  return parseLabeledValues(record, 'github').some((value) => {
    try {
      return inferPlatformFromPackageUrl(normalizeGithubUrl(value));
    } catch {
      return false;
    }
  });
}

function hasUnscopedSpmIntent(record) {
  if (/^\s*Build\s+version\s*:/i.test(record)) {
    return false;
  }
  const fieldCounts = countSpmFields(record);
  return (
    hasStrongSpmMetadata(fieldCounts) ||
    fieldCounts['tag/version'] > 0 ||
    hasAppleGithubUrl(record)
  );
}

function inferPlatformsFromRecord(record) {
  const platforms = new Set();
  for (const value of parseLabeledValues(record, 'github')) {
    try {
      const platform = inferPlatformFromPackageUrl(normalizeGithubUrl(value));
      if (platform) {
        platforms.add(platform);
      }
    } catch {
      // Invalid URLs remain in the record for strict validation later.
    }
  }
  for (const value of parseIrisUrlValues(record)) {
    const platform = inferPlatformFromIrisUrl(value);
    if (platform) {
      platforms.add(platform);
    }
  }
  return platforms;
}

function splitUnscopedSpmSection(body) {
  const records = [];
  let currentLines = [];
  let currentPlatform = null;

  const finishCurrentRecord = () => {
    const record = currentLines.join('\n').trim();
    if (record) {
      records.push(record);
    }
    currentLines = [];
    currentPlatform = null;
  };

  for (const line of body.split(/\r?\n/)) {
    if (!line.trim()) {
      continue;
    }
    const linePlatforms = inferPlatformsFromRecord(line);
    const linePlatform = linePlatforms.size === 1 ? [...linePlatforms][0] : null;

    if (linePlatforms.size > 1) {
      finishCurrentRecord();
      records.push(line.trim());
      continue;
    }
    if (linePlatform && currentPlatform && linePlatform !== currentPlatform) {
      finishCurrentRecord();
    }

    currentLines.push(line);
    currentPlatform ??= linePlatform;
  }
  finishCurrentRecord();
  return records;
}

function processUnscopedContent(content, transformSpmRecord) {
  const sectionPattern = /【\s*([^】]+?)\s*】/g;
  const sections = [...content.matchAll(sectionPattern)];
  const processOutsideSections = (outside) =>
    outside
      .split(/\r?\n/)
      .map((line) =>
        hasUnscopedSpmIntent(line) ? transformSpmRecord(line, false) : line,
      )
      .join('\n');

  if (sections.length === 0) {
    return processOutsideSections(content);
  }

  const chunks = [processOutsideSections(content.slice(0, sections[0].index))];
  for (const [index, section] of sections.entries()) {
    const bodyStart = section.index + section[0].length;
    const bodyEnd = sections[index + 1]?.index ?? content.length;
    const body = content.slice(bodyStart, bodyEnd);
    const isSwiftPm = section[1].replaceAll(/\s/g, '').toLowerCase() === 'swiftpm';
    if (isSwiftPm) {
      chunks.push(
        splitUnscopedSpmSection(body)
          .map((record) => transformSpmRecord(record, true))
          .join('\n'),
      );
    } else {
      chunks.push(section[0], body);
    }
  }
  return chunks.join('');
}

function splitExplicitPlatformContent(content) {
  const platformPattern =
    /(?:^|[\s|])platform\s*[:=]\s*(?:"[^"]*"|'[^']*'|[^\s|]+)(?=$|[\s|])/gi;
  const matches = [...content.matchAll(platformPattern)];
  return {
    preamble: content.slice(0, matches[0]?.index ?? content.length),
    records: matches.map((match, index) => {
      const nextStart = matches[index + 1]?.index ?? content.length;
      return content.slice(match.index, nextStart);
    }),
  };
}

function extractSectionedSpmRecords(content) {
  const sectionPattern = /【\s*([^】]+?)\s*】/g;
  const sections = [...content.matchAll(sectionPattern)];
  if (sections.length === 0) {
    return { contentWithoutSwiftPmSections: content, records: [] };
  }

  const records = [];
  const chunks = [content.slice(0, sections[0].index)];
  for (const [index, section] of sections.entries()) {
    const bodyStart = section.index + section[0].length;
    const bodyEnd = sections[index + 1]?.index ?? content.length;
    const body = content.slice(bodyStart, bodyEnd);
    const isSwiftPm = section[1].replaceAll(/\s/g, '').toLowerCase() === 'swiftpm';
    if (!isSwiftPm) {
      chunks.push(section[0], body);
      continue;
    }

    const { preamble, records: platformRecords } = splitExplicitPlatformContent(body);
    const sectionRecords = [
      ...splitUnscopedSpmSection(preamble),
      ...platformRecords,
    ];
    records.push(...sectionRecords);
    chunks.push(
      sectionRecords
        .map((record) => stripSpmFields(record, true))
        .filter(Boolean)
        .join('\n'),
      '\n',
    );
  }

  return {
    contentWithoutSwiftPmSections: chunks.join(''),
    records,
  };
}

function createLegacyDependenciesContent(content) {
  const normalizedContent = normalizeDependenciesContent(content);
  const { contentWithoutSwiftPmSections } =
    extractSectionedSpmRecords(normalizedContent);
  const { preamble, records } = splitExplicitPlatformContent(
    contentWithoutSwiftPmSections,
  );
  const chunks = [
    processUnscopedContent(
      preamble,
      (record, isSwiftPmSection) => stripSpmFields(record, isSwiftPmSection),
    ),
  ];

  for (const record of records) {
    const platformValue = parseLabeledValues(record, 'platform')[0] ?? '';
    const isApplePlatform = /^(?:iOS|macOS)$/i.test(platformValue);
    const fieldCounts = countSpmFields(record);
    const hasSpmMetadata =
      hasStrongSpmMetadata(fieldCounts) ||
      (isApplePlatform && fieldCounts['tag/version'] > 0);

    chunks.push(
      isApplePlatform && hasSpmMetadata ? stripSpmFields(record, true) : record,
    );
  }

  return chunks
    .join('\n')
    .split(/\r?\n/)
    .map((line) => line.trim())
    .filter(Boolean)
    .join('\n');
}

function countSpmFields(record) {
  const tagCount = countLabeledFields(record, 'tag');
  const versionCount = countLabeledFields(record, 'version');
  return {
    platform: countLabeledFields(record, 'platform'),
    github: countLabeledFields(record, 'github'),
    'tag/version': tagCount + versionCount,
    products: countLabeledFields(record, 'products?'),
    'iris-url': parseIrisUrlValues(record).length,
    'iris-checksum': countLabeledFields(record, '(?:iris-)?checksum'),
  };
}

function hasStrongSpmMetadata(fieldCounts) {
  return (
    fieldCounts.github > 0 ||
    fieldCounts.products > 0 ||
    fieldCounts['iris-url'] > 0 ||
    fieldCounts['iris-checksum'] > 0
  );
}

function collectUnscopedSpmRecords(content) {
  const records = [];
  processUnscopedContent(content, (record) => {
    if (record.trim()) {
      records.push(record);
    }
    return record;
  });
  return records;
}

function mergeDependency(dependencies, platform, dependency) {
  const existing = dependencies.get(platform) ?? {};
  if (
    dependency.irisUrl &&
    existing.irisUrlSource?.startsWith('derived from pod ') &&
    existing.irisUrl !== dependency.irisUrl
  ) {
    throw new Error(
      `Iris SPM URL conflict for ${platform}: input URL ${dependency.irisUrl} does not match CocoaPods-derived URL ${existing.irisUrl} from ${existing.irisPodName}`,
    );
  }
  const duplicateFields = Object.keys(dependency).filter((field) => {
    if (existing[field] === undefined) {
      return false;
    }
    return !(
      field === 'irisUrl' &&
      existing.irisUrlSource?.startsWith('derived from pod ') &&
      existing.irisUrl === dependency.irisUrl
    );
  });
  if (duplicateFields.length > 0) {
    throw new Error(
      `Duplicate SPM metadata for ${platform}: ${duplicateFields.join(', ')}`,
    );
  }
  dependencies.set(platform, { ...existing, ...dependency });
}

function parsePlatformDependencies(content) {
  const normalizedContent = normalizeDependenciesContent(content);
  const dependencies = parseIrisCocoaPodsDependencies(normalizedContent);
  const { contentWithoutSwiftPmSections, records: sectionRecords } =
    extractSectionedSpmRecords(normalizedContent);
  const { preamble, records: platformRecords } =
    splitExplicitPlatformContent(contentWithoutSwiftPmSections);
  const records = [
    ...collectUnscopedSpmRecords(preamble),
    ...platformRecords,
    ...sectionRecords,
  ];

  for (const record of records) {
    const fieldCounts = countSpmFields(record);
    const platformValues = parseLabeledValues(record, 'platform');
    const platformValue = platformValues[0] ?? null;
    const isExplicitApplePlatform = /^(?:iOS|macOS)$/i.test(platformValue ?? '');
    const hasSpmMetadata =
      hasStrongSpmMetadata(fieldCounts) ||
      (isExplicitApplePlatform && fieldCounts['tag/version'] > 0) ||
      (!platformValue && countLabeledFields(record, 'tag') > 0);
    if (!hasSpmMetadata) {
      continue;
    }
    if (platformValue && !isExplicitApplePlatform) {
      throw new Error(`Unsupported SPM platform: ${platformValue}`);
    }
    const duplicateFields = Object.entries(fieldCounts)
      .filter(([_field, count]) => count > 1)
      .map(([field]) => field);
    const explicitPlatform = isExplicitApplePlatform
      ? (platformValue.toLowerCase() === 'ios' ? 'iOS' : 'macOS')
      : null;
    const githubValue = parseLabeledValues(record, 'github')[0] ?? null;
    const versionValue = parseLabeledValues(record, 'tag|version')[0] ?? null;
    const products = fieldCounts.products > 0 ? parseProducts(record) : undefined;
    const irisUrlValue = parseIrisUrlValues(record)[0] ?? null;
    const checksumValue =
      parseLabeledValues(record, '(?:iris-)?checksum')[0] ?? null;

    let packageUrl;
    if (githubValue) {
      try {
        packageUrl = normalizeGithubUrl(githubValue);
      } catch {
        packageUrl = null;
      }
    }
    const packagePlatform = packageUrl
      ? inferPlatformFromPackageUrl(packageUrl)
      : null;
    const irisPlatform = irisUrlValue
      ? inferPlatformFromIrisUrl(irisUrlValue)
      : null;
    const inferredPlatforms = new Set(
      [explicitPlatform, packagePlatform, irisPlatform].filter(Boolean),
    );
    if (inferredPlatforms.size !== 1) {
      throw new Error(
        inferredPlatforms.size === 0
          ? 'SPM metadata requires an inferable Apple platform'
          : `Conflicting SPM platforms: ${[...inferredPlatforms].join(', ')}`,
      );
    }
    const platform = [...inferredPlatforms][0];

    if (duplicateFields.length > 0) {
      throw new Error(`Duplicate SPM fields for ${platform}: ${duplicateFields.join(', ')}`);
    }

    const invalidFields = [];
    if (fieldCounts.github > 0 && (!githubValue || !packageUrl || !packagePlatform)) {
      invalidFields.push('github');
    }
    if (
      fieldCounts['tag/version'] > 0 &&
      (!versionValue || !/^[A-Za-z0-9_.+-]+$/.test(versionValue))
    ) {
      invalidFields.push('tag/version');
    }
    if (fieldCounts.products > 0 && !products) {
      invalidFields.push('products');
    }
    if (
      irisUrlValue &&
      (!/^https?:\/\/[^\s|,'"]+$/.test(irisUrlValue) || !irisPlatform)
    ) {
      invalidFields.push('iris-url');
    }
    if (
      fieldCounts['iris-checksum'] > 0 &&
      (!checksumValue || !/^[a-f0-9]{64}$/i.test(checksumValue))
    ) {
      invalidFields.push('iris-checksum');
    }
    if (invalidFields.length > 0) {
      throw new Error(`Invalid SPM metadata for ${platform}: ${invalidFields.join(', ')}`);
    }

    if (Boolean(githubValue) !== Boolean(versionValue)) {
      throw new Error(
        `Incomplete Native SPM metadata for ${platform}: github and tag/version must be provided together`,
      );
    }
    if (checksumValue && !irisUrlValue) {
      throw new Error(
        `Incomplete Iris SPM metadata for ${platform}: checksum requires url`,
      );
    }

    const dependency = {};
    if (packageUrl) {
      dependency.packageUrl = packageUrl;
      dependency.version = versionValue;
    }
    if (products) {
      dependency.products = products;
    }
    if (irisUrlValue) {
      dependency.irisUrl = irisUrlValue;
      if (checksumValue) {
        dependency.irisChecksum = checksumValue.toLowerCase();
      }
    }
    mergeDependency(dependencies, platform, dependency);
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

function parsePackageDeclaration(line) {
  const match = line.match(
    /^\s*(\.package\(url:\s*"([^"]+)",\s*(?:exact:\s*"[^"]+"|\.upToNextMajor\(from:\s*"[^"]+"\))\),?)\s*$/,
  );
  if (!match) {
    return null;
  }

  let packageUrl;
  try {
    packageUrl = normalizeGithubUrl(match[2]);
  } catch {
    return null;
  }

  return {
    declaration: `${match[1].replace(/,$/, '')},`,
    packageUrl,
    packageName: path.basename(packageUrl, '.git'),
  };
}

function parseManifestDependency(source, platform) {
  const packageSection = source.match(
    /    dependencies: \[\n([\s\S]*?)\n    \],\n    targets: \[/,
  );
  if (!packageSection) {
    throw new Error('Unable to locate package dependencies in Package.swift');
  }

  const packageLines = packageSection[1].split('\n');
  const packageCandidates = packageLines
    .map((line) => parsePackageDeclaration(line))
    .filter(
      (parsed) => parsed && inferPlatformFromPackageUrl(parsed.packageUrl) === platform,
    );
  if (packageCandidates.length !== 1) {
    throw new Error('Unable to locate Native package dependency in Package.swift');
  }
  const nativePackage = packageCandidates[0];

  const targetSection = source.match(
    /            dependencies: \[\n([\s\S]*?)\n            \],\n            cSettings:/,
  );
  if (!targetSection) {
    throw new Error('Unable to locate plugin target dependencies in Package.swift');
  }

  const targetLines = targetSection[1].split('\n');
  const products = targetLines
    .map((line, index) => {
      const match = line.match(
        /\.product\(name:\s*"([A-Za-z0-9_]+)",\s*package:\s*"([^"]+)"\)/,
      );
      return match ? { index, name: match[1], packageName: match[2] } : null;
    })
    .filter((product) => {
      if (!product || product.packageName === 'FlutterFramework') {
        return false;
      }
      return product.packageName === nativePackage.packageName;
    });
  if (
    products.length === 0 ||
    products.some((product) => product.packageName !== nativePackage.packageName)
  ) {
    throw new Error('Unable to locate Native product dependencies in Package.swift');
  }

  const binaryTargets = [
    ...source.matchAll(
      /\.binaryTarget\(\s*name:\s*"AgoraRtcWrapper",\s*url:\s*"([^"]+)",\s*checksum:\s*"([^"]+)"\s*\)/g,
    ),
  ];
  if (binaryTargets.length !== 1) {
    throw new Error('Unable to locate AgoraRtcWrapper binary target in Package.swift');
  }
  const [, irisUrl, irisChecksum] = binaryTargets[0];
  if (!/^https?:\/\/[^\s,'"]+$/.test(irisUrl) || !/^[a-f0-9]{64}$/i.test(irisChecksum)) {
    throw new Error('Invalid AgoraRtcWrapper binary target in Package.swift');
  }

  return {
    packageUrl: nativePackage.packageUrl,
    packageName: nativePackage.packageName,
    packageDeclaration: nativePackage.declaration,
    products: products.map((product) => product.name),
    irisUrl,
    irisChecksum: irisChecksum.toLowerCase(),
  };
}

async function computeIrisChecksum(artifactUrl) {
  const temporaryDirectory = await mkdtemp(
    path.join(os.tmpdir(), 'agora-iris-spm-checksum-'),
  );
  const artifactPath = path.join(temporaryDirectory, 'artifact.zip');

  try {
    let response;
    const downloadSignal = AbortSignal.timeout(artifactTimeoutMs);
    try {
      response = await fetch(artifactUrl, { signal: downloadSignal });
      if (!response.ok) {
        throw new Error(`HTTP ${response.status} ${response.statusText}`.trim());
      }
      if (!response.body) {
        throw new Error('response body is empty');
      }
      const contentLength = Number(response.headers.get('content-length'));
      if (Number.isFinite(contentLength) && contentLength > artifactMaxBytes) {
        throw new Error(
          `artifact exceeds maximum size of ${artifactMaxBytes} bytes`,
        );
      }

      let downloadedBytes = 0;
      const byteLimit = new Transform({
        transform(chunk, _encoding, callback) {
          downloadedBytes += chunk.length;
          if (downloadedBytes > artifactMaxBytes) {
            callback(
              new Error(
                `artifact exceeds maximum size of ${artifactMaxBytes} bytes`,
              ),
            );
            return;
          }
          callback(null, chunk);
        },
      });
      await pipeline(
        Readable.fromWeb(response.body),
        byteLimit,
        createWriteStream(artifactPath),
      );
    } catch (error) {
      const message = downloadSignal.aborted
        ? `download timed out after ${artifactTimeoutMs} ms`
        : error.message;
      throw new Error(
        `Failed to download Iris SPM artifact ${artifactUrl}: ${message}`,
      );
    }

    let archiveEntries;
    try {
      ({ stdout: archiveEntries } = await execFileAsync('unzip', ['-Z1', artifactPath], {
        maxBuffer: 1024 * 1024,
      }));
    } catch {
      throw new Error(
        `Invalid Iris SPM artifact ${artifactUrl}: archive is not a valid zip`,
      );
    }
    if (
      !archiveEntries
        .split(/\r?\n/)
        .some((entry) => entry.startsWith('AgoraRtcWrapper.xcframework/'))
    ) {
      throw new Error(
        `Invalid Iris SPM artifact ${artifactUrl}: archive must contain AgoraRtcWrapper.xcframework at archive root`,
      );
    }

    let stdout;
    try {
      ({ stdout } = await execFileAsync(
        'swift',
        ['package', 'compute-checksum', artifactPath],
        { maxBuffer: 1024 * 1024 },
      ));
    } catch (error) {
      throw new Error(
        `Failed to compute Iris SPM checksum for ${artifactUrl}: ${error.message}`,
      );
    }

    const checksum = stdout.trim();
    if (!/^[a-f0-9]{64}$/i.test(checksum)) {
      throw new Error(
        `Invalid Iris SPM checksum output for ${artifactUrl}: ${checksum}`,
      );
    }
    return checksum.toLowerCase();
  } finally {
    await rm(temporaryDirectory, { recursive: true, force: true });
  }
}

async function resolveManifestDependency(source, dependency, platform) {
  const current = parseManifestDependency(source, platform);
  const resolved = { ...current };
  const sources = {
    packageUrl: dependency.packageUrl ? 'input' : 'preserved from Package.swift',
    products: dependency.products ? 'input' : 'preserved from Package.swift',
    irisUrl: dependency.irisUrl
      ? (dependency.irisUrlSource ?? 'input')
      : 'preserved from Package.swift',
    irisChecksum: dependency.irisUrl
      ? (dependency.irisChecksum ? 'input' : 'computed')
      : 'preserved from Package.swift',
  };

  if (
    dependency.packageUrl &&
    dependency.packageUrl !== current.packageUrl &&
    !dependency.products
  ) {
    throw new Error(
      `Native package changed for ${platform}; products must be provided explicitly`,
    );
  }

  if (dependency.packageUrl) {
    resolved.packageUrl = dependency.packageUrl;
    resolved.packageName = path.basename(dependency.packageUrl, '.git');
    resolved.packageDeclaration =
      `.package(url: "${dependency.packageUrl}", exact: "${dependency.version}"),`;
  }
  if (dependency.products) {
    resolved.products = dependency.products;
  }
  if (dependency.irisUrl) {
    resolved.irisUrl = dependency.irisUrl;
    resolved.irisChecksum =
      dependency.irisChecksum ?? (await computeIrisChecksum(dependency.irisUrl));
  }

  return { current, resolved, sources };
}

function formatResolutionSummary(platform, dependency, sources) {
  return [
    `${platform} SPM resolution:`,
    `  Native package: ${dependency.packageUrl} (${sources.packageUrl})`,
    `  products: ${dependency.products.join(',')} (${sources.products})`,
    `  Iris URL: ${dependency.irisUrl} (${sources.irisUrl})`,
    `  Iris checksum: ${dependency.irisChecksum} (${sources.irisChecksum})`,
  ].join('\n');
}

function updateManifest(source, dependency, currentDependency) {
  let updated = replaceExactlyOnce(
    source,
    /(    dependencies: \[\n)([\s\S]*?)(\n    \],\n    targets: \[)/,
    (_match, prefix, body, suffix) => {
      const lines = body.split('\n');
      const managedIndexes = lines
        .map((line, index) => ({ index, parsed: parsePackageDeclaration(line) }))
        .filter(
          ({ parsed }) => parsed?.packageName === currentDependency.packageName,
        )
        .map(({ index }) => index);

      if (managedIndexes.length !== 1) {
        throw new Error('Unable to locate Native package dependency in Package.swift');
      }

      const insertionIndex = managedIndexes[0];
      const preservedLines = lines.filter((_line, index) => !managedIndexes.includes(index));
      preservedLines.splice(insertionIndex, 0, `        ${dependency.packageDeclaration}`);
      return `${prefix}${preservedLines.join('\n')}${suffix}`;
    },
    'package dependencies',
  );

  const targetDependencies = dependency.products.map(
    (product) =>
      `                .product(name: "${product}", package: "${dependency.packageName}"),`,
  );

  updated = replaceExactlyOnce(
    updated,
    /(            dependencies: \[\n)([\s\S]*?)(\n            \],\n            cSettings:)/,
    (_match, prefix, body, suffix) => {
      const lines = body.split('\n');
      const managedIndexes = lines
        .map((line, index) => {
          const productMatch = line.match(
            /\.product\(name: "[^"]+", package: "([^"]+)"\)/,
          );
          return productMatch?.[1] === currentDependency.packageName ? index : -1;
        })
        .filter((index) => index >= 0);

      if (managedIndexes.length === 0) {
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

  return updated;
}

async function commitUpdates(updates, fileOperations = defaultFileOperations) {
  const transactionId = `${process.pid}-${randomUUID()}`;
  const entries = updates.map(({ filePath, content }) => ({
    filePath,
    content,
    temporaryPath: `${filePath}.tmp-${transactionId}`,
    backupPath: `${filePath}.backup-${transactionId}`,
    originalMoved: false,
    updateInstalled: false,
  }));

  const preparationResults = await Promise.allSettled(
    entries.map(({ temporaryPath, content }) =>
      fileOperations.writeFile(temporaryPath, content, 'utf8'),
    ),
  );
  const preparationErrors = preparationResults
    .filter((result) => result.status === 'rejected')
    .map((result) => result.reason);
  if (preparationErrors.length > 0) {
    const cleanupResults = await Promise.allSettled(
      entries.map(({ temporaryPath }) =>
        fileOperations.rm(temporaryPath, { force: true }),
      ),
    );
    const cleanupErrors = cleanupResults
      .filter((result) => result.status === 'rejected')
      .map((result) => result.reason);
    if (preparationErrors.length > 1 || cleanupErrors.length > 0) {
      const preparationDetail =
        preparationErrors.length > 1
          ? ` (${preparationErrors.length} temporary writes failed)`
          : '';
      const cleanupDetail =
        cleanupErrors.length > 0
          ? ` and clean up ${cleanupErrors.length} temporary file(s)`
          : '';
      throw new AggregateError(
        [...preparationErrors, ...cleanupErrors],
        `Failed to prepare SPM manifests${preparationDetail}${cleanupDetail}`,
      );
    }
    throw preparationErrors[0];
  }

  try {
    for (const entry of entries) {
      await fileOperations.rename(entry.filePath, entry.backupPath);
      entry.originalMoved = true;
      await fileOperations.rename(entry.temporaryPath, entry.filePath);
      entry.updateInstalled = true;
    }
  } catch (error) {
    const rollbackErrors = [];
    for (const entry of [...entries].reverse()) {
      if (!entry.originalMoved) {
        continue;
      }
      try {
        if (entry.updateInstalled) {
          await fileOperations.rm(entry.filePath, { force: true });
        }
        await fileOperations.rename(entry.backupPath, entry.filePath);
        entry.originalMoved = false;
      } catch (rollbackError) {
        rollbackErrors.push(rollbackError);
      }
    }
    const cleanupResults = await Promise.allSettled(
      entries.map(({ temporaryPath }) =>
        fileOperations.rm(temporaryPath, { force: true }),
      ),
    );
    const cleanupErrors = cleanupResults
      .filter((result) => result.status === 'rejected')
      .map((result) => result.reason);
    if (rollbackErrors.length > 0 || cleanupErrors.length > 0) {
      const failedRecoveryActions = [];
      if (rollbackErrors.length > 0) {
        failedRecoveryActions.push(`roll back ${rollbackErrors.length} file(s)`);
      }
      if (cleanupErrors.length > 0) {
        failedRecoveryActions.push(
          `clean up ${cleanupErrors.length} temporary file(s)`,
        );
      }
      throw new AggregateError(
        [error, ...rollbackErrors, ...cleanupErrors],
        `Failed to commit SPM manifests and ${failedRecoveryActions.join(' and ')}`,
      );
    }
    throw error;
  }

  const backupCleanupResults = await Promise.allSettled(
    entries.map(({ backupPath }) =>
      fileOperations.rm(backupPath, { force: true }),
    ),
  );
  const backupCleanupErrors = backupCleanupResults
    .filter((result) => result.status === 'rejected')
    .map((result) => result.reason);
  if (backupCleanupErrors.length > 1) {
    throw new AggregateError(
      backupCleanupErrors,
      `Failed to clean up ${backupCleanupErrors.length} SPM manifest backup file(s)`,
    );
  }
  if (backupCleanupErrors.length === 1) {
    throw backupCleanupErrors[0];
  }
}

async function main(argv) {
  const args = parseArgs(argv);
  if (args.printLegacyContent) {
    console.log(createLegacyDependenciesContent(args.dependenciesContent));
    return;
  }

  const dependencies = parsePlatformDependencies(args.dependenciesContent);

  if (dependencies.size === 0) {
    console.log('SPM dependencies unchanged');
    return;
  }

  const requestedUpdates = [];
  if (dependencies.has('iOS')) {
    requestedUpdates.push({
      filePath: args.iosManifest,
      platform: 'iOS',
      dependency: dependencies.get('iOS'),
    });
  }
  if (dependencies.has('macOS')) {
    requestedUpdates.push({
      filePath: args.macosManifest,
      platform: 'macOS',
      dependency: dependencies.get('macOS'),
    });
  }

  const updates = await Promise.all(
    requestedUpdates.map(async ({ filePath, platform, dependency }) => {
      const source = await readFile(filePath, 'utf8');
      const { current, resolved, sources } = await resolveManifestDependency(
        source,
        dependency,
        platform,
      );
      return {
        filePath,
        content: updateManifest(source, resolved, current),
        summary: formatResolutionSummary(platform, resolved, sources),
      };
    }),
  );

  await commitUpdates(updates);
  for (const update of updates) {
    console.log(update.summary);
  }
  console.log(`Updated SPM dependencies for ${[...dependencies.keys()].join(', ')}`);
}

if (process.argv[1] && path.resolve(process.argv[1]) === modulePath) {
  await main(process.argv.slice(2));
}

export { commitUpdates, parsePlatformDependencies };
