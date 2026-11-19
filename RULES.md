# Repository Rules

- Prefer small, targeted changes over broad refactors.
- Preserve public API compatibility whenever possible.
- Keep Dart API, native platform code, examples, and tests in sync for user-visible changes.
- Follow existing patterns in neighboring files before introducing new abstractions.
- Avoid unrelated file churn and formatting-only diffs.
- Run `flutter analyze` and `flutter test` for code changes when feasible.
