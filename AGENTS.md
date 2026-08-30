# AGENTS.md

## Project overview

This repository contains the **Agora Flutter SDK plugin**, which exposes Agora Real-Time Engagement features to Flutter apps through Dart APIs backed by native platform implementations.

The repo includes:

- The Flutter plugin source
- Platform-specific implementations for supported targets
- Example app(s) showing SDK usage
- Tests, scripts, and tooling for validation and release workflows

Primary goals for contributors and AI agents:

- Preserve API compatibility where possible
- Keep Dart-facing APIs aligned with underlying Agora native SDK behavior
- Avoid breaking cross-platform behavior unintentionally
- Prefer small, targeted changes over broad refactors

---

## Tech stack and key dependencies

- **Flutter / Dart** for the public plugin API and example app
- **Platform channels / plugin bindings** to native Agora SDK integrations
- Native platform support likely includes:
  - **Android** (Gradle / Kotlin or Java)
  - **iOS / macOS** (CocoaPods / Swift or Objective-C)
  - **Windows**
- Repo tooling:
  - `analysis_options.yaml` for static analysis
  - CI workflows for validation
  - `build.yaml` and scripts/tooling for generation or packaging tasks

When making changes:

- Treat `pubspec.yaml`, platform build files, and generated/config files as authoritative
- Do not upgrade SDK/toolchain versions unless required by the task
- Keep platform API changes synchronized with Dart API updates

---

## Code structure

Common top-level areas in this repo:

- `lib/` — Dart plugin API exposed to Flutter users
- `android/`, `ios/`, `macos/`, `windows/` — platform-specific plugin implementations
- `example/` — sample Flutter app demonstrating usage
- `test/`, `test_shard/` — automated tests
- `shared/` — shared assets, definitions, or support code
- `tool/`, `scripts/` — maintenance, generation, and automation utilities
- `README.md` — user-facing usage/docs
- `CONTRIBUTING.md` — contributor workflow and policy
- `CHANGELOG.md` — release history and externally visible changes

---

## Conventions to follow

- Follow existing patterns in neighboring files before introducing new abstractions
- Keep public Dart API naming and documentation consistent with current SDK style
- Minimize churn in generated or platform glue code
- Prefer additive changes over renames/moves unless necessary
- Keep changes cross-platform-aware: if a Dart API changes, check all supported native targets
- Update docs/examples/tests when behavior or public APIs change
- Avoid editing unrelated files during focused fixes

### For Dart/Flutter code

- Respect `analysis_options.yaml`
- Use idiomatic Dart naming:
  - `UpperCamelCase` for types
  - `lowerCamelCase` for members
  - `snake_case` for file names where already used by the repo
- Keep null-safety and type annotations consistent with surrounding code
- Prefer small helper methods over deeply nested logic

### For platform code

- Match existing style and language choice in each platform directory
- Keep native method names, argument mapping, and event semantics aligned with the Dart layer
- Be careful with enum/value translation and callback/event propagation
- Do not remove backward-compatible shims without clear justification

---

## Build, analysis, and test commands

Run from the repository root unless the task requires otherwise.

### Flutter/Dart

```bash
flutter pub get
flutter analyze
flutter test
```

### Example app

```bash
cd example
flutter pub get
flutter run
```

### Platform validation

Use Flutter tooling first; only run platform-specific commands when needed for the task.

Examples:

```bash
flutter build apk
flutter build ios
flutter build macos
flutter build windows
```

### Repo scripts/tooling

If the task touches code generation, packaging, or validation helpers, inspect and use:

```bash
tool/
scripts/
```

and follow any documented workflow in:

- `README.md`
- `CONTRIBUTING.md`
- CI workflow files

---

## Important patterns for AI agents

1. **Read before editing**
   - Check `README.md`, `CONTRIBUTING.md`, and nearby source files first
   - Infer conventions from existing implementations rather than inventing new ones

2. **Preserve API contracts**
   - This is an SDK/plugin repo; public API changes have downstream impact
   - If changing signatures, events, enums, or defaults, update docs/examples/tests

3. **Think across layers**
   - Many changes require consistency between:
     - Dart API
     - platform channel/binding layer
     - native platform implementation
     - example usage
     - tests

4. **Be cautious with large files**
   - The repo likely contains some deep nesting and at least one large file
   - Make minimal, localized edits and avoid broad formatting-only diffs

5. **Testing expectations**
   - At minimum, run:
     ```bash
     flutter analyze
     flutter test
     ```
   - If behavior affects the example or platform integration, validate the example app build/run path where feasible

6. **Documentation hygiene**
   - Update `CHANGELOG.md` for user-visible changes if the repo’s contribution process expects it
   - Keep README/example snippets aligned with the implemented API

---

## Preferred change style

- Small PR-sized patches
- Backward-compatible fixes first
- Clear commit scope
- No speculative refactors
- No dependency upgrades unrelated to the task
- No generated-file edits unless the workflow explicitly requires regeneration

---

## Quick checklist before finishing

- [ ] Code follows local patterns and lint expectations
- [ ] Public API changes are reflected in docs/examples/tests
- [ ] Cross-platform implications were reviewed
- [ ] `flutter analyze` passes
- [ ] `flutter test` passes
- [ ] No unrelated file churn introduced
- [ ] Review and follow `RULES.md` before making changes
