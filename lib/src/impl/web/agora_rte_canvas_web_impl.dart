import 'dart:js_interop';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/agora_rte_canvas_config.dart';
import 'package:agora_rtc_engine/src/agora_rte_enums.dart';
import 'agora_rte_js_interop.dart';

/// Web implementation of [AgoraRteCanvas].
/// Passes the registered HTMLElement directly to JS Canvas.addView().
class AgoraRteCanvasWebImpl implements AgoraRteCanvas {
  @override
  final String canvasId;

  final JsCanvas jsCanvas;

  AgoraRteCanvasConfig _config = const AgoraRteCanvasConfig();

  AgoraRteCanvasWebImpl(this.canvasId, this.jsCanvas);

  @override
  Future<void> setConfigs(AgoraRteCanvasConfig config) async {
    _config = AgoraRteCanvasConfig(
      videoRenderMode: config.videoRenderMode ?? _config.videoRenderMode,
      videoMirrorMode: config.videoMirrorMode ?? _config.videoMirrorMode,
      cropArea: config.cropArea ?? _config.cropArea,
    );
    final rConfig = JsCanvasConfig(
      renderMode: _config.videoRenderMode?.index.toJS,
      mirrorMode: _config.videoMirrorMode?.index.toJS,
    );
    await jsCanvas.setConfigs(rConfig).toDart;
  }

  @override
  Future<AgoraRteCanvasConfig> getConfigs() async {
    final jsConfig = jsCanvas.getConfigs();
    return AgoraRteCanvasConfig(
      videoRenderMode: _mapVideoRenderMode(jsConfig.renderMode?.toDartInt),
      videoMirrorMode: _mapVideoMirrorMode(jsConfig.mirrorMode?.toDartInt),
    );
  }

  AgoraRteVideoRenderMode? _mapVideoRenderMode(int? value) {
    if (value == null) return null;
    if (value >= 0 && value < AgoraRteVideoRenderMode.values.length) {
      return AgoraRteVideoRenderMode.values[value];
    }
    return null;
  }

  AgoraRteVideoMirrorMode? _mapVideoMirrorMode(int? value) {
    if (value == null) return null;
    if (value >= 0 && value < AgoraRteVideoMirrorMode.values.length) {
      return AgoraRteVideoMirrorMode.values[value];
    }
    return null;
  }

  @override
  Future<void> addView(int viewPtr, {AgoraRteViewConfig? config}) async {
  }

  @override
  Future<void> removeView(int viewPtr, {AgoraRteViewConfig? config}) async {
  }
}
