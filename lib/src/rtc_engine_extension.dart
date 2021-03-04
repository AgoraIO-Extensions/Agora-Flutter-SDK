import 'rtc_engine.dart';

/// Extension for RtcEngine
extension RtcEngineExtension on RtcEngine {
  /// Get the actual absolute path of the asset through the relative path of the asset
  ///
  /// - [assetPath] The resource path configured in the `flutter` -> `assets` field of pubspec.yaml, for example: assets/Sound_Horizon.mp3
  /// - Returns the actual absolute path of the asset
  static Future<String?> getAssetAbsolutePath(String assetPath) {
    return RtcEngine.methodChannel
        .invokeMethod('getAssetAbsolutePath', assetPath);
  }
}
