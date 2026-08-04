# Apple SPM Dependency Updater Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add tested update rules that let the existing dependency-update GitHub Action generate the iOS/macOS `Package.swift` changes, without manually editing either manifest on the rules branch.

**Architecture:** A dependency-free Node CLI parses platform-scoped SPM fields from the workflow's original `dependencies_content`, validates a complete Native/Iris set, transforms both manifests in memory, and writes only after all transformations succeed. The existing external action remains responsible for Maven/CocoaPods/CDN parsing; the local SPM updater is tested and invoked separately before the workflow creates a PR.

**Tech Stack:** Node.js 22 built-ins (`node:test`, `fs/promises`), Swift Package Manager, Bash, GitHub Actions, Flutter 3.44.8.

---

## File Map

- Create `ci/update_spm_deps.mjs`: parse raw SPM input, validate it, and atomically update two caller-selected manifests.
- Create `ci/update_spm_deps.test.mjs`: exercise the CLI against temporary copies so repository manifests never change during tests.
- Modify `.github/workflows/run_update_deps.yml`: install Node 22, run tests, invoke the updater with raw input, and validate generated manifests.
- Modify `/Users/zhugaopeng/Downloads/flutter-special-sdk-release-request/flutter-SKILL_副本.md`: require platform-scoped SPM artifact metadata in release requests.
- Do not modify `ios/agora_rtc_engine/Package.swift` or `macos/agora_rtc_engine/Package.swift` on `codex/spm-support-main`.

### Task 1: Lock the parser and transformation behavior with failing tests

**Files:**
- Create: `ci/update_spm_deps.test.mjs`
- Test fixtures: temporary copies of `ios/agora_rtc_engine/Package.swift` and `macos/agora_rtc_engine/Package.swift`

- [ ] **Step 1: Write a test helper that invokes the not-yet-created CLI**

```js
async function runUpdater(content, iosManifest, macosManifest) {
  return execFileAsync('node', [
    'ci/update_spm_deps.mjs',
    '--dependencies-content', content,
    '--ios-manifest', iosManifest,
    '--macos-manifest', macosManifest,
  ], { cwd: repoRoot });
}
```

- [ ] **Step 2: Add the successful two-platform update case**

Assert that temporary manifests contain:

```swift
.package(name: "FlutterFramework", path: "../FlutterFramework")
.package(url: "https://github.com/AgoraIO/AgoraRtcEngine_iOS.git", exact: "4.6.2")
.product(name: "FlutterFramework", package: "FlutterFramework")
.product(name: "RtcBasic", package: "AgoraRtcEngine_iOS")
```

Also assert the exact Iris URLs/checksums from PR #2633 and package-level `cxxLanguageStandard: .cxx14` on macOS.

- [ ] **Step 3: Add failure and compatibility cases**

Cover incomplete platform metadata, duplicate platform blocks, invalid checksum, SSH GitHub URL normalization, input field reordering, multiple/future products, no SPM blocks, and preservation of unrelated manifest settings.

- [ ] **Step 4: Prove the tests fail before implementation**

Run: `node --test ci/update_spm_deps.test.mjs`

Expected: FAIL because `ci/update_spm_deps.mjs` does not exist.

### Task 2: Implement the SPM updater

**Files:**
- Create: `ci/update_spm_deps.mjs`
- Test: `ci/update_spm_deps.test.mjs`

- [ ] **Step 1: Parse command arguments and platform blocks**

Accept the same labels as these complete platform blocks:

```text
platform:iOS github:https://github.com/AgoraIO/AgoraRtcEngine_iOS.git tag:4.6.2 products:RtcBasic iris-url:https://download.agora.io/sdk/release/AgoraIrisRTC_iOS2-4.6.2-build.1.zip iris-checksum:eba8f9fc5b3d93d9d083d0c3f16e6c98fcd993e49989fb851e6df2941ca29825
platform:macOS github:https://github.com/AgoraIO/AgoraRtcEngine_macOS.git tag:4.6.2 products:RtcBasic iris-url:https://download.agora.io/sdk/release/AgoraIrisRTC_macOS2-4.6.2-build.1.zip iris-checksum:dbfe2db86b0cb2c1012202212248bd6588173020c357dc13fc5a6dcf0a7b97cf
```

Treat `version:` as an alias for `tag:` and normalize `git@github.com:Owner/Repo.git` to `https://github.com/Owner/Repo.git`.

- [ ] **Step 2: Validate before any file writes**

Reject a block unless all six values are present and valid. Reject duplicate platform blocks. When neither platform block exists, print `SPM dependencies unchanged` and exit successfully.

- [ ] **Step 3: Transform both manifests in memory**

For each selected platform:

```swift
dependencies: [
    .package(name: "FlutterFramework", path: "../FlutterFramework"),
    .package(url: "\(dependency.packageUrl)", exact: "\(dependency.version)"),
]
```

Add the official Flutter 3.44.8 product dependency, replace only Native product lines for that package, update `AgoraRtcWrapper` URL/checksum, preserve linker settings, and migrate the macOS C++ flag to `cxxLanguageStandard: .cxx14`.

- [ ] **Step 4: Write only after every transformation succeeds**

Write sibling temporary files and rename them after both results have been produced. On parse or transform failure, leave both original manifests byte-for-byte unchanged.

- [ ] **Step 5: Run tests to green**

Run: `node --test ci/update_spm_deps.test.mjs`

Expected: all updater tests pass.

- [ ] **Step 6: Confirm repository manifests are untouched and commit**

Run:

```bash
git diff --exit-code -- ios/agora_rtc_engine/Package.swift macos/agora_rtc_engine/Package.swift
git add ci/update_spm_deps.mjs ci/update_spm_deps.test.mjs
git commit -m "feat: add Apple SPM dependency updater"
```

### Task 3: Integrate the updater into GitHub Actions

**Files:**
- Modify: `.github/workflows/run_update_deps.yml`
- Test: `ci/update_spm_deps.test.mjs`

- [ ] **Step 1: Add deterministic Node setup and updater tests**

Add `actions/setup-node@v4` with Node `22`, followed by:

```yaml
- name: Test SPM dependency updater
  run: node --test ci/update_spm_deps.test.mjs
```

- [ ] **Step 2: Pass the original workflow input to the updater**

After `ci/run_update_deps.sh`, add:

```yaml
- name: Update Apple SPM dependencies
  env:
    DEPENDENCIES_CONTENT: ${{ inputs.dependencies_content }}
  run: node ci/update_spm_deps.mjs --dependencies-content "$DEPENDENCIES_CONTENT"
```

Default manifest paths remain inside the CLI, while tests use explicit temporary paths.

- [ ] **Step 3: Validate the generated manifests before PR creation**

Run `swift package dump-package` for both package directories. This checks manifest syntax without resolving or building remote binaries.

- [ ] **Step 4: Validate YAML and local tests**

Run:

```bash
node --test ci/update_spm_deps.test.mjs
ruby -e 'require "yaml"; YAML.load_file(".github/workflows/run_update_deps.yml")'
git diff --check
```

Expected: tests and YAML parse pass; repository `Package.swift` files remain unchanged.

- [ ] **Step 5: Commit workflow integration**

```bash
git add .github/workflows/run_update_deps.yml
git commit -m "ci: update Apple SPM dependencies in release workflow"
```

### Task 4: Update the special-release skill rules

**Files:**
- Modify: `/Users/zhugaopeng/Downloads/flutter-special-sdk-release-request/flutter-SKILL_副本.md`

- [ ] **Step 1: Add SPM to related artifact inspection**

Require Native repository/tag/products and Iris binary URL/checksum for both iOS and macOS. Keep CocoaPods and SPM results separate.

- [ ] **Step 2: Add the exact `dependencies_content` format**

Document the two `platform:` lines used by the updater and require checksum/archive-shape verification before previewing an execution request.

- [ ] **Step 3: Add release blockers**

State that a CocoaPods-only Special version such as `4.6.2.70` does not imply a matching SPM tag, and that missing/mismatched SPM artifacts prevent an “Apple SPM ready” claim.

- [ ] **Step 4: Verify the focused diff**

Run `git diff --no-index` against a temporary pre-edit copy and inspect only SPM-related additions.

### Task 5: Push the rules branch and invoke the dependency update Action

**Files:**
- Remote branch: `codex/spm-support-main`
- Workflow: `.github/workflows/run_update_deps.yml`

- [ ] **Step 1: Prove rules branch has no manifest changes**

Run:

```bash
git diff origin/main...HEAD -- ios/agora_rtc_engine/Package.swift macos/agora_rtc_engine/Package.swift
git status --short
```

Expected: empty manifest diff and clean status.

- [ ] **Step 2: Push the test branch**

Run: `git push -u origin codex/spm-support-main`

- [ ] **Step 3: Dispatch the workflow against the test branch**

Use `run_gen_code=false` and input containing unchanged CocoaPods dependencies plus the two platform-scoped SPM lines. Do not use any release workflow or release label manually.

- [ ] **Step 4: Monitor to terminal state**

Resolve and watch the run with:

```bash
run_id=$(gh run list --workflow run_update_deps.yml --branch codex/spm-support-main --limit 1 --json databaseId --jq '.[0].databaseId')
gh run watch "$run_id" --exit-status
```

If it fails, inspect the first failing step and fix only the rule/workflow branch before retrying.

- [ ] **Step 5: Inspect the generated PR without merging it**

Verify the PR base is `codex/spm-support-main` and its file list contains the two manifests. Confirm Native exact `4.6.2`, Iris2 URLs/checksums, FlutterFramework dependency, and macOS C++ standard. Report any podspec or unrelated changes separately.

### Task 6: Final verification and review

**Files:**
- All committed rule/workflow files
- Generated Action PR manifests, read-only

- [ ] **Step 1: Run local regression tests**

Run `flutter test`, `node --test ci/update_spm_deps.test.mjs`, YAML parse, and `git diff --check`.

- [ ] **Step 2: Run focused code review**

Check parser ambiguity, shell/YAML quoting, atomic-write behavior, old input compatibility, GitHub token permissions, and whether the Action PR contains only intended generated changes.

- [ ] **Step 3: Report evidence**

Provide branch commit hashes, workflow run URL/status, generated PR URL, exact generated diff, test results, and the remaining limitation that Native SPM `4.6.2` is not binary-equivalent evidence for CocoaPods Special `4.6.2.70`.
