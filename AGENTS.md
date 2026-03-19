# AGENTS.md

## Project overview
Agora Flutter SDK is a Flutter plugin that wraps the Agora native RTC SDKs for multiple platforms. The repository appears to contain:

- Dart-facing plugin API
- Platform implementations for Android, iOS, macOS, and Windows
- Example app(s)
- Tests, sharded tests, and supporting scripts/tools

Primary goals for contributors and AI agents:

- Preserve cross-platform behavior and API consistency
- Keep Dart and native platform code aligned
- Prefer minimal, targeted changes over broad refactors
- Validate changes through analysis, formatting, and tests where possible

## Tech stack and key dependencies
Core technologies inferred from the repo layout:

- **Dart / Flutter** — plugin interface and example app
- **Native Agora SDKs** — underlying RTC implementation
- **Android** — Gradle / Kotlin or Java integration
- **iOS / macOS** — Xcode / CocoaPods integration
- **Windows** — native desktop plugin layer
- **CI tooling** — repository includes CI configuration
- **Static analysis** — `analysis_options.yaml`
- **Package publishing** — `pubspec.yaml`, pub.dev package

Likely important files:

- `pubspec.yaml`
- `analysis_options.yaml`
- `README.md`
- `CONTRIBUTING.md`
- `CHANGELOG.md`
- `build.yaml`

## Code structure and conventions
Use the existing repo layout as the source of truth. Expected top-level areas:

- `lib/` — public Dart API and plugin-facing code
- `android/` — Android plugin implementation
- `ios/`, `macos/` — Apple platform implementations
- `windows/` — Windows implementation
- `example/` — sample app and usage validation
- `test/` — automated tests
- `test_shard/` — split/sharded test coverage
- `shared/` — common utilities or shared code
- `tool/`, `scripts/` — automation, generation, maintenance scripts

Conventions to follow:

- Keep public API changes deliberate and documented
- Maintain naming/style consistent with nearby code
- Prefer small diffs in platform-specific files
- Do not move directories or rename public symbols unless necessary
- Update docs/examples when changing user-visible behavior
- Check `CONTRIBUTING.md` before altering workflows

## Build and test commands
Run from the repository root. Use the commands that already succeed in the project environment.

### Setup
```bash
flutter pub get
```

### Static analysis
```bash
flutter analyze
```

### Formatting
```bash
dart format .
```

### Tests
```bash
flutter test
```

If the repo uses sharded or custom test runners, inspect `test_shard/`, `tool/`, and `scripts/` for the canonical commands.

### Example app
```bash
cd example
flutter pub get
flutter run
```

### Platform-specific verification
Use native toolchains only when touching platform code:

- Android: Gradle/Android Studio build
- iOS/macOS: Xcode/CocoaPods build
- Windows: Visual Studio/CMake toolchain as configured by Flutter

## Important patterns to follow
When making changes, especially as an AI assistant:

1. **Preserve plugin contract**
   - Keep Dart API and native method/event channel behavior synchronized.
   - Avoid breaking existing method signatures or event payload shapes.

2. **Respect cross-platform parity**
   - If adding or changing a feature, check whether the same behavior must exist on Android, iOS, macOS, and Windows.
   - If parity is not possible, document the limitation clearly.

3. **Minimize native drift**
   - Platform wrappers should stay thin where possible.
   - Avoid introducing platform-only behavior unless required by the underlying SDK.

4. **Update supporting artifacts**
   - User-visible changes should usually update:
     - `README.md`
     - `CHANGELOG.md`
     - `example/`
     - tests

5. **Prefer existing tooling**
   - Reuse scripts in `tool/` and `scripts/` instead of creating ad hoc workflows.
   - Follow lints and analyzer guidance from `analysis_options.yaml`.

6. **Be careful with large/deeply nested areas**
   - The repo has some deep nesting and at least one large file; make surgical edits and avoid unnecessary churn.

## Recommended workflow for AI agents
Before editing:

1. Read `README.md` and `CONTRIBUTING.md`
2. Inspect `pubspec.yaml` and `analysis_options.yaml`
3. Identify whether the change affects:
   - Dart API only
   - Native platform code
   - Example/docs/tests
4. Make the smallest viable change
5. Run:
   - `dart format .`
   - `flutter analyze`
   - `flutter test`

If touching public API or behavior, also update documentation and changelog.