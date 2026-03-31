import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Flutter web plugin registration entry point.
///
/// Required by Flutter's web plugin mechanism (declared in pubspec.yaml).
/// The actual RTE implementation uses dart:js_interop directly via
/// [createAgoraRte] → conditional import → AgoraRteWebImpl,
/// so this class is intentionally empty.
class AgoraRteEngineWeb {
  static void registerWith(Registrar registrar) {
    // No-op. RTE web uses direct JS interop, not MethodChannel.
  }
}
