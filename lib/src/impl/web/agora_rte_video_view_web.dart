import 'dart:ui_web' as ui_web;
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/impl/web/agora_rte_web_view_registry.dart';
import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

/// Called from [AgoraRteVideoView] on Web.
/// Creates an HTMLVideoElement inside a constraining wrapper div,
/// registers it in [AgoraRteWebViewRegistry], then calls canvas.addView
/// so the JS SDK can use it for rendering.
Widget buildWebVideoView({
  required AgoraRteCanvas? canvas,
  required AgoraRtePlayer? player,
  required VoidCallback? onViewCreated,
  required Function(String)? onLog,
}) {
  if (canvas == null) {
    return const SizedBox.shrink();
  }

  final int viewKey = canvas.canvasId.hashCode;
  final String viewType = 'agora-rte-video-$viewKey';
  final String wrapperId = 'agora-rte-wrapper-$viewKey';
  final String videoElId = 'agora-rte-video-el-$viewKey';

  if (!_registeredViewTypes.contains(viewType)) {
    _registeredViewTypes.add(viewType);
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int id) {
      final wrapper = web.document.createElement('div') as web.HTMLDivElement;
      wrapper.id = wrapperId;
      wrapper.style.width = '100%';
      wrapper.style.height = '100%';
      wrapper.style.overflow = 'hidden';
      wrapper.style.position = 'relative';
      // Force GPU compositing layer to prevent scroll glitches on older browsers
      wrapper.style.setProperty('will-change', 'transform');
      wrapper.style.setProperty('transform', 'translateZ(0)');
      wrapper.style.setProperty('backface-visibility', 'hidden');
      wrapper.style.setProperty('contain', 'strict');

      // Scoped CSS that forces the video to fill the wrapper.
      // Uses !important to beat any inline styles the JS SDK may set.
      final style = web.document.createElement('style') as web.HTMLStyleElement;
      style.textContent = '''
        #$wrapperId > video {
          width: 100% !important;
          height: 100% !important;
          position: absolute !important;
          top: 0 !important;
          left: 0 !important;
          // object-fit: contain !important; // Cannot be set, affecting canvas render mode
        }
      ''';

      wrapper.appendChild(style);

      final video = web.document.createElement('video') as web.HTMLVideoElement;
      video.id = videoElId;
      video.autoplay = true;
      video.setAttribute('playsinline', 'true');

      wrapper.appendChild(video);

      AgoraRteWebViewRegistry.register(viewKey, video);

      // Bindcanvas → player after the video element is in the DOM.
      canvas.addView(viewKey).then((_) {
        onLog?.call('Web video element bound to canvas');
        if (player != null) {
          player.setCanvas(canvas).then((_) {
            onLog?.call('Canvas re-associated with player after addView');
            onViewCreated?.call();
          }).catchError((e) {
            onLog?.call('Re-setCanvas error: $e');
            onViewCreated?.call();
          });
        } else {
          onViewCreated?.call();
        }
      }).catchError((e) {
        onLog?.call('Web addView error: $e');
      });

      return wrapper;
    });
  }

  return HtmlElementView(viewType: viewType);
}

final Set<String> _registeredViewTypes = {};
