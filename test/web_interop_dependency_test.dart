import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('web interop dependencies', () {
    test('use dart:js_interop without direct js dependency', () {
      final bindingsFile =
          File('lib/src/impl/platform/web/iris_web_rtc_bindings_js.dart');
      final bindingsContent = bindingsFile.readAsStringSync();
      expect(bindingsContent, contains("import 'dart:js_interop';"));
      expect(bindingsContent, contains("import 'dart:js_interop_unsafe';"));
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

    test('keep web delegate compatible with current iris_method_channel API', () {
      final delegateFile =
          File('lib/src/impl/platform/web/js_iris_api_engine_binding_delegate.dart');
      final delegateContent = delegateFile.readAsStringSync();

      expect(delegateContent, isNot(contains("import 'dart:js_util';")));
      expect(delegateContent, isNot(contains('promiseToFuture(')));
    });

    test('avoid invalid external js interop signatures for iris web rtc', () {
      final bindingsFile =
          File('lib/src/impl/platform/web/iris_web_rtc_bindings_js.dart');
      final bindingsContent = bindingsFile.readAsStringSync();

      expect(bindingsContent, isNot(contains('external void initIrisRtc(')));
      expect(bindingsContent, contains("globalContext['IrisWebRtc']"));
      expect(
        bindingsContent,
        contains("callMethodVarArgs<JSAny?>('initIrisRtc'.toJS"),
      );
    });

    test('use modern flutter web bootstrap in example index', () {
      final indexFile = File('example/web/index.html');
      final indexContent = indexFile.readAsStringSync();

      expect(indexContent, contains('flutter_bootstrap.js'));
      expect(indexContent, isNot(contains('{{flutter_service_worker_version}}')));
      expect(indexContent, isNot(contains('loadMainDartJs')));
    });
  });
}
