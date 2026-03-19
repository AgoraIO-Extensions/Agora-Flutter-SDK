import 'dart:ui_web' as ui_web;
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/impl/web/agora_rte_web_view_registry.dart';
import 'package:flutter/widgets.dart';
import 'package:web/web.dart' as web;

/// Called from [AgoraRteVideoView] on Web.
/// Creates an HTMLVideoElement inside a constraining wrapper div,
/// registers it in [AgoraRteWebViewRegistry], then calls canvas.addView
/// so the JS SDK can use it for rendering.
///
/// The wrapper div uses CSS to force the video element to stay within bounds,
/// even if the JS SDK internally resets the video element's inline styles.
///
/// Optional customizer callbacks allow the caller to modify the wrapper div,
/// style element, and video element after default properties are applied:
/// - [wrapperCustomizer]: `void Function(web.HTMLDivElement wrapper)`
/// - [styleCustomizer]: `void Function(web.HTMLStyleElement style, int viewKey)`
/// - [videoCustomizer]: `void Function(web.HTMLVideoElement video)`
Widget buildWebVideoView({
  required AgoraRteCanvas? canvas,
  required AgoraRtePlayer? player,
  required VoidCallback? onViewCreated,
  required Function(String)? onLog,
  Function? wrapperCustomizer,
  Function? styleCustomizer,
  Function? videoCustomizer,
}) {
  if (canvas == null) {
    return const SizedBox.shrink();
  }

  final int viewKey = canvas.canvasId.hashCode;
  final String viewType = 'agora-rte-video-$viewKey';

  if (!_registeredViewTypes.contains(viewType)) {
    _registeredViewTypes.add(viewType);
    ui_web.platformViewRegistry.registerViewFactory(viewType, (int id) {
      // Wrapper div that enforces size constraints via CSS.
      final wrapper =
          web.document.createElement('div') as web.HTMLDivElement;
      wrapper.id = 'agora-rte-wrapper-$viewKey';
      wrapper.style.width = '100%';
      wrapper.style.height = '100%';
      wrapper.style.overflow = 'hidden';
      wrapper.style.position = 'relative';

      // Allow caller to customize wrapper after defaults
      if (wrapperCustomizer != null) {
        wrapperCustomizer(wrapper);
      }

      // Inject a scoped style that forces the video to fill the wrapper.
      // This beats any inline styles the JS SDK may set on the video.
      final style =
          web.document.createElement('style') as web.HTMLStyleElement;
      style.textContent = '''
        #agora-rte-wrapper-$viewKey > video {
          width: 100% !important;
          height: 100% !important;
          position: absolute !important;
          top: 0 !important;
          left: 0 !important;
          object-fit: contain !important;
        }
      ''';

      // Allow caller to customize or replace style content
      if (styleCustomizer != null) {
        styleCustomizer(style, viewKey);
      }

      wrapper.appendChild(style);

      final video =
          web.document.createElement('video') as web.HTMLVideoElement;
      video.id = 'agora-rte-video-el-$viewKey';
      video.autoplay = true;
      video.controls = true;
      video.setAttribute('playsinline', 'true');

      // Allow caller to customize video element
      if (videoCustomizer != null) {
        videoCustomizer(video);
      }

      wrapper.appendChild(video);

      // Register the video element so canvas impl can retrieve it
      AgoraRteWebViewRegistry.register(viewKey, video);

      // Tell JS Canvas about this video element, then re-setCanvas on Player
      // so JS SDK knows the video element is available for rendering.
      // This fixes the timing issue where player.setCanvas was called
      // before canvas had any view element.
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
