import 'package:flutter/services.dart';

import 'classes.dart';
import 'enums.dart';
import 'rtc_engine.dart';

/// @nodoc
class Display {
  /// @nodoc
  int id;

  /// @nodoc
  double scale;

  /// @nodoc
  Rectangle bounds;

  /// @nodoc
  Rectangle workArea;

  /// @nodoc
  int rotation;

  Display._(this.id, this.scale, this.bounds, this.workArea, this.rotation);
}

/// @nodoc
class Window {
  /// @nodoc
  int id;

  /// @nodoc
  String name;

  /// @nodoc
  String ownerName;

  /// @nodoc
  Rectangle bounds;

  /// @nodoc
  Rectangle workArea;

  Window._(this.id, this.name, this.ownerName, this.bounds, this.workArea);
}

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
  List<Display> enumerateDisplays() {
    throw PlatformException(code: ErrorCode.NotSupported.toString());
  }

  /// @nodoc
  List<Window> enumerateWindows() {
    throw PlatformException(code: ErrorCode.NotSupported.toString());
  }
}
