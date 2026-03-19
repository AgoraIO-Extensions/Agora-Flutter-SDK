# AGENTS.md

## Project overview
Agora Flutter SDK is a Flutter plugin that wraps the Agora RTC/RTM native SDKs for use in Flutter apps across Android, iOS, macOS, and Windows. The repository contains:

- The Flutter-facing Dart API
- Platform-specific plugin implementations
- Example applications
- Tests, scripts, and tooling used to generate, validate, and publish the package

When making changes, preserve cross-platform behavior and keep the Dart API aligned with native platform bindings.

## Tech stack and key dependencies
- **Language:** Dart, Flutter
- **Native platforms:** Android, iOS, macOS, Windows
- **Plugin model:** Flutter federated/plugin-style platform integration
- **Tooling:** `flutter`, `dart`, repo scripts, CI workflows
- **Config files commonly relevant:**
  - `pubspec.yaml`
  - `analysis_options.yaml`
  - `build.yaml`
  - platform build files under `android/`, `ios/`, `macos/`, `windows/`

## Code structure
Top-level areas commonly used in this repo:

- `lib/` — public Dart API exposed to Flutter consumers
- `android/`, `ios/`, `macos/`, `windows/` — native plugin implementations
- `example/` — sample app for manual verification and integration testing
- `test/`, `test_shard/` — automated tests
- `shared/` — shared code/utilities used across repo components
- `tool/`, `scripts/` — generation, maintenance, and release helpers
- `README.md` — usage and setup documentation
- `CONTRIBUTING.md` — contribution workflow and expectations
- `CHANGELOG.md` — user-facing change history

## Conventions
- Follow existing patterns in `lib/` and platform folders before introducing new abstractions.
- Prefer minimal, targeted changes over large refactors.
- Keep Dart API naming and behavior consistent with existing SDK surface area.
- Update all affected platforms when changing a cross-platform feature or API contract.
- Avoid introducing platform-specific behavior into the public API unless already established by project conventions.
- Keep example code compiling if public APIs change.
- Add or update tests alongside behavior changes.

## Build and test commands
Use the standard Flutter workflow unless repo docs/scripts specify otherwise:

```bash
flutter pub get
flutter analyze
flutter test
```

Run the example app:

```bash
cd example
flutter pub get
flutter run
```

If code generation or maintenance scripts are involved, check `tool/`, `scripts/`, and `CONTRIBUTING.md` before editing generated files.

## Important patterns to follow
- **Cross-platform parity:** Changes in Dart APIs often require coordinated updates in native platform code.
- **Generated or mapped APIs:** If a file appears generated or mechanically maintained, find the source script/config before editing manually.
- **Backward compatibility:** This is an SDK package; avoid breaking public API behavior unless explicitly intended.
- **Validation through examples:** Use `example/` as the quickest sanity check for integration issues.
- **Small diffs, clear intent:** Prefer focused PRs with changelog/docs updates when user-visible behavior changes.
- **Respect repository tooling:** Keep formatting, linting, and CI expectations green before proposing changes.

## Recommended workflow for AI agents
1. Read `README.md` and `CONTRIBUTING.md`.
2. Inspect `lib/` first to understand the public surface.
3. Trace affected platform implementations in `android/`, `ios/`, `macos/`, and `windows/`.
4. Check `example/` and tests for expected usage patterns.
5. Run analyze/tests after edits and summarize any platform-specific limitations clearly.