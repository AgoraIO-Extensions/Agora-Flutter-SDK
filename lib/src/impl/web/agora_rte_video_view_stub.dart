import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:flutter/widgets.dart';

/// Stub for non-web platforms. Never called at runtime because
/// [AgoraRteVideoView] checks [kIsWeb] before invoking this.
Widget buildWebVideoView({
  required AgoraRteCanvas? canvas,
  required AgoraRtePlayer? player,
  required VoidCallback? onViewCreated,
  required Function(String)? onLog,
}) {
  return const SizedBox.shrink();
}
