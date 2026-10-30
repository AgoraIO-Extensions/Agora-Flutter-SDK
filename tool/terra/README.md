# Flutter binding generation

Run `bash scripts/code_gen.sh rtc_<version>` from the SDK root. CI installs
LLVM 15 on macos-15 with Xcode 16.4; local macOS generation also needs
`llvm@15` and a compatible C SDK. Xcode 26 C SDK headers are not supported by
libclang 15. `build.sh` selects a
matching compiler and C SDK headers for both Terra parser passes. Parser errors
or a nonzero generator exit stop before serializers/test fixtures.

`stage_headers.py` copies the shared SDK snapshot into ignored `.binding_headers/`.
The original snapshot is never changed. The copy makes headers independently
parseable and normalizes platform alternatives which Terra otherwise flattens
into invalid C++: one binding-only constructor for each screen struct, a single
logging enum spelling, and a RefCountInterface include for audio devices.
Screen-audio fields remain nullable, so omitted values use real SDK defaults.
Generic Optional/RefPtr implementation headers remain available to includes,
but are not standalone parser entry points in either pass.

These inputs are metadata only and are never used to build or publish Native
binaries. The call renderer decodes JSON arrays of structs through each element's
`fromJson` factory. Do not patch generated Dart bindings directly.

Regression checks from the SDK root:

```sh
python3 -m unittest discover -s tool/terra/tests -p 'test_*.py'
flutter test test/loopback_recording_sources_test.dart
```
