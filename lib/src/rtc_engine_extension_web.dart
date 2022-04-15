import 'package:flutter/services.dart';

import 'enums.dart';
import 'rtc_engine.dart';

/// Extension for RtcEngine
extension RtcEngineExtension on RtcEngine {
  /// Get the actual absolute path of the asset through the relative path of the asset
  ///
  /// - [assetPath] The resource path configured in the `flutter` -> `assets` field of pubspec.yaml, for example: assets/Sound_Horizon.mp3
  /// - Returns the actual absolute path of the asset
  Future<String?> getAssetAbsolutePath(String assetPath) {
    throw PlatformException(code: ErrorCode.NotSupported.toString());
  }

  /// @nodoc
  List<dynamic> enumerateDisplays() {
    throw PlatformException(code: ErrorCode.NotSupported.toString());
  }

  /// @nodoc
  List<dynamic> enumerateWindows() {
    throw PlatformException(code: ErrorCode.NotSupported.toString());
  }
}
