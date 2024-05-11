import 'dart:convert';

import 'package:agora_rtc_engine/src/impl/json_converters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('readIntPtr', () {
    test('can parse int ptr from key pattern <key>_str', () async {
      const json = '''
{
  "key": 18446744073709551615,
  "key_str": "18446744073709551615"
}
''';
      final res = readIntPtr(jsonDecode(json), 'key');
      // 18446744073709551615 is -1 in c++
      expect(res, -1);
    });

    test('can parse int ptr if no key pattern <key>_str', () async {
      const json = '''
{
  "key": 18446744073709551615
}
''';
      final res = readIntPtr(jsonDecode(json), 'key');
      // Shoud return 0
      expect(res, 0);
    });

    test(
        'throw assertion error if value of key pattern <key>_str is not type of String',
        () async {
      const json = '''
{
  "key": 18446744073709551615,
  "key_str": 18446744073709551615
}
''';
      expect(() => readIntPtr(jsonDecode(json), 'key'), throwsAssertionError);
    });
  });

  group('readIntPtrList', () {
    test('can parse int ptr list from key pattern <key>_str', () async {
      const json = '''
{
  "key": [18446744073709551615, 18446744073709551615],
  "key_str": ["18446744073709551615", "18446744073709551615"]
}
''';
      final res = readIntPtrList(jsonDecode(json), 'key');
      // 18446744073709551615 is -1 in c++
      expect(res, const [-1, -1]);
    });

    test('can parse int ptr list if no key pattern <key>_str', () async {
      const json = '''
{
  "key": [18446744073709551615, 18446744073709551615]
}
''';
      final res = readIntPtrList(jsonDecode(json), 'key');
      // Shoud return []
      expect(res, []);
    });

    test(
        'throw assertion error if value of key pattern <key>_str is not type of List',
        () async {
      const json = '''
{
  "key": [18446744073709551615, 18446744073709551615],
  "key_str": 18446744073709551615
}
''';
      expect(
          () => readIntPtrList(jsonDecode(json), 'key'), throwsAssertionError);
    });
  });
}
