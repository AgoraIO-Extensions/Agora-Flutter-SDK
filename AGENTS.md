# AGENTS.md

## Project overview
- **Repository:** `AgoraIO-Extensions/Agora-Flutter-SDK`
- **Purpose:** Flutter plugin wrapping the Agora RTC SDK for cross-platform real-time audio/video features.
- **Primary surfaces:** Dart plugin API, platform channel/native bindings, example app, tests, and release/tooling scripts.
- **Supported targets:** Flutter with platform-specific implementations under `android/`, `ios/`, `macos/`, and `windows/`.

## Tech stack and key dependencies
- **Languages:** Dart, Flutter, platform-native code (Android/iOS/macOS/Windows)
- **Core tooling:** Flutter SDK, Dart SDK, `pub`, CI workflows, static analysis via `analysis_options.yaml`
- **Package metadata:** `pubspec.yaml`
- **Build/config files likely relevant:** `build.yaml`, platform build files, example app config
- **External dependency focus:** Agora native RTC SDK integrations and Flutter plugin interfaces

## Code structure
Typical important paths:
- `lib/` — public Dart API and plugin-facing logic
- `android/`, `ios/`, `macos/`, `windows/` — platform implementations
- `example/` — runnable sample app; use this to understand intended API usage
- `test/` — unit/integration-style Dart tests
- `test_shard/` — split test execution support
- `shared/` — shared helpers/utilities used across tooling or codegen
- `tool/`, `scripts/` — maintenance, generation, and automation scripts
- `README.md` — user-facing setup and usage
- `CONTRIBUTING.md` — contributor workflow expectations
- `CHANGELOG.md` — release history and breaking changes

## Conventions and working style
- Prefer following existing patterns in nearby files over introducing new abstractions.
- Treat `example/` as the reference for expected plugin usage and API ergonomics.
- Keep public Dart APIs stable and explicit; plugin changes often require synchronized Dart + platform updates.
- When modifying platform behavior, check whether corresponding changes are needed across multiple targets.
- Respect analyzer/linter rules from `analysis_options.yaml`.
- Keep edits focused; avoid broad refactors unless required.

## Build, analyze, and test
Run from repo root unless a subpackage requires otherwise:

```bash
flutter pub get
flutter analyze
dart format . --set-exit-if-changed
flutter test
```

Useful additional checks:
```bash
flutter test test_shard
flutter run -d <device> example
```

If platform changes are involved, also validate native builds where relevant:
```bash
flutter build apk
flutter build ios --no-codesign
flutter build macos
flutter build windows
```

## Important patterns to follow
- **Mirror API changes across layers:** If a Dart API changes, verify platform channels/native handlers remain aligned.
- **Use the example app for validation:** Add or update example usage when changing public behavior.
- **Prefer additive changes:** Avoid breaking public API unless clearly intentional and documented in `CHANGELOG.md`.
- **Keep platform parity in mind:** A feature exposed in Dart should have well-defined behavior per supported platform.
- **Add tests with fixes:** For bug fixes or feature work, update `test/` and/or example coverage where feasible.
- **Minimize deep navigation cost:** The repo already has deep nesting; place new files in the most local, predictable module.
- **Be cautious with large files:** If touching a very large file, prefer small, well-scoped edits and preserve existing structure.

## Suggested AI-assistant workflow
1. Read `README.md` and `CONTRIBUTING.md`.
2. Inspect `pubspec.yaml`, `analysis_options.yaml`, and `build.yaml`.
3. Use `example/` to understand intended API flows.
4. Trace affected code through `lib/` first, then platform directories.
5. Run formatter, analyzer, and the smallest relevant test set before proposing broader changes.

## When making changes
- Update docs if public setup or usage changes.
- Update `CHANGELOG.md` for user-visible changes.
- Avoid introducing repo-wide style churn.
- Prefer concise PRs with clear scope and validation steps.