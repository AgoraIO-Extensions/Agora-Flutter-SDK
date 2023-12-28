import 'dart:convert';

import 'package:agora_rtc_engine/src/agora_media_base.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VideoFrame json serialization', () {
    test('can parse metaInfo', () async {
      const json = '''
{
  "metaInfo":{
    "KEY_FACE_CAPTURE":"my_meta_info_str"
  }
}
''';

      VideoFrame videoFrame = VideoFrame.fromJson(jsonDecode(json));
      expect(videoFrame.metaInfo, isNotNull);

      final info =
          await videoFrame.metaInfo!.getMetaInfoStr(MetaInfoKey.keyFaceCapture);
      expect(info, 'my_meta_info_str');
    });
  });
}
