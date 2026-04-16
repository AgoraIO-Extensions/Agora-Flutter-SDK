import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('web interop dependencies', () {
    test('use dart:js_interop without direct js dependency', () {
      final bindingsFile =
          File('lib/src/impl/platform/web/iris_web_rtc_bindings_js.dart');
      final bindingsContent = bindingsFile.readAsStringSync();
      expect(bindingsContent, contains("import 'dart:js_interop';"));
      expect(bindingsContent, isNot(contains("import 'package:js/js.dart';")));

      final pubspecFile = File('pubspec.yaml');
      final pubspecContent = pubspecFile.readAsStringSync();
      final dependenciesSection = RegExp(
        r'^dependencies:\n(?:(?:  .*\n)+)',
        multiLine: true,
      ).firstMatch(pubspecContent)?.group(0);

      expect(dependenciesSection, isNotNull);
      expect(
        RegExp(r'^  js:\s', multiLine: true).hasMatch(dependenciesSection!),
        isFalse,
        reason:
            'The plugin should use dart:js_interop directly and must not '
            'declare js as a direct dependency.',
      );
    });
  });
}
