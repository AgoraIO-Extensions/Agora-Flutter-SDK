import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

// ignore_for_file: public_member_api_docs

class GlobalMethodChannel {
  static const MethodChannel _engineMethodChannel =
      MethodChannel('agora_rtc_ng');

  static Future<String?> getIrisLogAbsolutePath() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      final externalFilesDir =
          await _engineMethodChannel.invokeMethod('getExternalFilesDir');
      return '$externalFilesDir/agorasdk.log';
    }

    return null;
  }
}
