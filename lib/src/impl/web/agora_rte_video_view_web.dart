import 'dart:ui_web' as ui_web;
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:flutter/widgets.dart';
// ignore: avoid_web_libraries_in_flutter
import 'package:web/web.dart' as web;
import 'agora_rte_web_view_registry.dart';

/// Called from [AgoraRteVideoView] on Web.
/// Creates an HTMLVideoElement, registers it in [AgoraRteWebViewRegistry],
/// then calls canvas.addView with the element's key.
Widget buildWebVideoView({
  required AgoraRteCanvas? canvas,
  required AgoraRtePlayer? player,
  required VoidCallback? onViewCreated,
  required Function(String)? onLog,
}) {
  if (canvas == null) {
    return const SizedBox.shrink();
  }

  // Use canvasId hashCode as the stable int key
  final int viewKey = canvas.canvasId.hashCode;
  final String viewType = 'agora-rte-video-$viewKey';

  // Register factory once — track registered types to avoid duplicate registration
  if (!_registeredViewTypes.contains(viewType)) {
    _registeredViewTypes.add(viewType);
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int id) {
      final video =
          web.document.createElement('video') as web.HTMLVideoElement;
      video.style.width = '100%';
      video.style.height = '100%';
      video.style.objectFit = 'contain';
      video.autoplay = true;

      // Store in registry so canvas impl can retrieve it
      AgoraRteWebViewRegistry.register(viewKey, video);

      // Bind to canvas after element is in registry
      canvas.addView(viewKey).then((_) {
        onLog?.call('Web video element bound to canvas');
        onViewCreated?.call();
      }).catchError((e) {
        onLog?.call('Web addView error: $e');
      });

      return video;
    });
  }

  return HtmlElementView(viewType: viewType);
}

final Set<String> _registeredViewTypes = {};
