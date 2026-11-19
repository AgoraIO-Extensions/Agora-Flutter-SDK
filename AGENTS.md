# AGENTS.md

## Project overview
Agora Flutter SDK is a Flutter plugin that wraps the Agora native RTC/RTM capabilities for use in Flutter apps. This repository appears to contain:

- The Flutter/Dart public API surface
- Platform-specific plugin implementations for Android, iOS, macOS, and Windows
- Example applications
- Tests, scripts, and tooling used for validation and release workflows

When contributing, treat this repo as a cross-platform plugin: changes in Dart APIs often require coordinated updates in native layers, examples, and tests.

## Tech stack and key dependencies
Core technologies likely used in this repository:

- **Dart / Flutter** for the plugin API, example app, and tests
- **Platform channels / plugin bindings** to bridge Flutter and native Agora SDKs
- **Android**: Kotlin/Java + Gradle
- **iOS / macOS**: Swift/Objective-C + Xcode/CocoaPods
- **Windows**: C++/Windows plugin code
- **YAML tooling**: `pubspec.yaml`, CI workflows, analysis config, build config

Key repo-level files likely relevant to changes:

- `pubspec.yaml`
- `analysis_options.yaml`
- `build.yaml`
- `README.md`
- `CONTRIBUTING.md`
- `CHANGELOG.md`

## Code structure and conventions
Based on the repository layout, expect these top-level areas:

- `lib/` — public Dart API and Flutter-facing plugin code
- `android/`, `ios/`, `macos/`, `windows/` — native platform implementations
- `example/` — sample app demonstrating intended usage
- `test/`, `test_shard/` — automated tests
- `shared/` — shared assets, codegen artifacts, or common definitions
- `tool/`, `scripts/` — developer utilities, code generation, validation, or release scripts

### Conventions to follow
- Keep **public Dart API changes** deliberate and backward-aware.
- Maintain **cross-platform parity** when adding or changing features.
- Prefer updating the **example app** when behavior or API usage changes.
- Keep changes **localized**; avoid mixing refactors with feature work.
- Follow existing naming/style patterns from nearby files rather than inventing new abstractions.
- Respect `analysis_options.yaml` and existing lints/formatting.

## Build and test commands
Run commands from the repository root unless project docs specify otherwise.

### Flutter / Dart
- Install dependencies:
  ```bash
  flutter pub get
  ```
- Format code:
  ```bash
  dart format .
  ```
- Static analysis:
  ```bash
  flutter analyze
  ```
- Run tests:
  ```bash
  flutter test
  ```

### Example app
If validating runtime behavior:
```bash
cd example
flutter pub get
flutter run
```

### Platform-specific validation
Use only when your change touches native code:

- Android: build via Flutter or Android Studio/Gradle
- iOS/macOS: build via Flutter or Xcode/CocoaPods
- Windows: build via Flutter on Windows

If scripts exist under `scripts/` or `tool/`, prefer those for repeatable workflows.

## Important patterns to follow
- **Preserve API compatibility** unless the change is explicitly breaking and documented.
- **Update all impacted layers**: Dart API, native bindings, example usage, and tests.
- **Test behavior, not just compilation**: add or adjust tests where practical.
- **Document user-facing changes** in `README.md` and/or `CHANGELOG.md` when appropriate.
- **Avoid platform drift**: if a feature is unsupported on a platform, document it clearly rather than silently diverging.
- **Use the example as the contract** for intended plugin usage.
- **Be careful with generated or shared code**: inspect `shared/`, `tool/`, and `scripts/` before editing manually.

## Guidance for AI coding assistants
Before making edits:

1. Read `README.md`, `CONTRIBUTING.md`, and `pubspec.yaml`
2. Inspect `lib/` and the matching platform folders for the feature area
3. Check `example/` for canonical usage
4. Search `test/` and `test_shard/` for existing coverage patterns
5. Look for helper scripts in `tool/` or `scripts/` before introducing new build logic

When proposing changes, prefer small PR-sized edits with explicit notes about:
- affected platforms
- API surface changes
- example/test updates
- any follow-up work needed