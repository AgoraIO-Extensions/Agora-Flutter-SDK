import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Logger for texture rendering pipeline debugging.
///
/// Both native (ObjC/Java) and Flutter (Dart) sides write to the same
/// log file (`flutter_texture_render.log`) so entries are interleaved
/// in chronological order for easy correlation.
///
/// Disabled by default — zero overhead when off. Call [enable] with a
/// log directory to start logging. Intended for on-site debugging only.
class TextureRenderLogger {
  TextureRenderLogger._();

  static const MethodChannel _channel =
      MethodChannel('agora_rtc_ng/video_view_controller');

  static IOSink? _sink;
  static bool _enabled = false;

  /// Enable logging. Both native and Flutter logs will be written to
  /// `<logDir>/flutter_texture_render.log`.
  ///
  /// [logDir] should be the parent directory of the SDK log file path
  /// so all logs can be collected together.
  static Future<void> enable(String? logDir) async {
    await disable();
    try {
      if (logDir == null || logDir.isEmpty) {
        logDir = (await getApplicationDocumentsDirectory()).path;
      }
      // Enable native-side logger first (creates the file)
      await _channel.invokeMethod('enableTextureRenderLog', logDir);

      // Open the same file for Flutter-side writes
      final file = File(
          '$logDir${Platform.pathSeparator}flutter_texture_render.log');
      _sink = file.openWrite(mode: FileMode.append);
      _enabled = true;
    } catch (e) {
      // Silently fail — logging should never break the app
      _enabled = false;
    }
  }

  /// Disable logging and close the file.
  static Future<void> disable() async {
    _enabled = false;
    final sink = _sink;
    _sink = null;
    await sink?.flush();
    await sink?.close();
    try {
      await _channel.invokeMethod('disableTextureRenderLog');
    } catch (_) {}
  }

  /// Log a message. No-op when disabled.
  static void log(String tag, String message) {
    if (!_enabled) return;
    final now = DateTime.now().toIso8601String();
    _sink?.writeln('$now [Flutter][$tag] $message');
  }
}
