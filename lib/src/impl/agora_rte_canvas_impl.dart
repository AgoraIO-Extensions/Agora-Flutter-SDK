import 'dart:async';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/agora_rte_enums.dart';
import 'package:agora_rtc_engine/src/agora_rte_canvas_config.dart';
import 'package:flutter/services.dart';

/// RTE canvas implementation
class AgoraRteCanvasImpl implements AgoraRteCanvas {
  @override
  final String canvasId;
  final MethodChannel _channel;

  AgoraRteCanvasImpl(this.canvasId, this._channel);

  /// Handle callbacks (called by AgoraRteCoreImpl)
  ///
  /// Note: Currently AgoraRteCanvas does not define observer callback mechanism.
  /// Canvas is mainly used for view rendering configuration (video render mode, mirror mode, crop area, etc.),
  /// does not involve state changes or event callbacks.
  ///
  /// This method is reserved for future extensions, if native SDK adds Canvas related callback mechanisms.
  void handleCallback(String method, Map args) {
    // Currently no Canvas related callbacks to handle
    // If native SDK adds Canvas callbacks (e.g., view add/remove events) in the future,
    // corresponding handling logic can be added here

    // Example: if there is a view add callback in the future
    // switch (method) {
    //   case 'rteCanvasOnViewAdded':
    //     // Handle view add callback
    //     break;
    //   case 'rteCanvasOnViewRemoved':
    //     // Handle view remove callback
    //     break;
    // }
  }

  @override
  Future<void> setConfigs(AgoraRteCanvasConfig config) async {
    await _channel.invokeMethod('rteCanvasSetConfigs', {
      'canvasId': canvasId,
      'config': config.toJson(),
    });
  }

  @override
  Future<AgoraRteCanvasConfig> getConfigs() async {
    final Map result = await _channel
        .invokeMethod('rteCanvasGetConfigs', {'canvasId': canvasId});
    return AgoraRteCanvasConfig.fromJson(Map<String, dynamic>.from(result));
  }

  Future<AgoraRteVideoRenderMode> getVideoRenderMode() async {
    final result = await _channel
        .invokeMethod('rteCanvasGetVideoRenderMode', {'canvasId': canvasId});
    return AgoraRteVideoRenderMode.values[result ?? 0];
  }

  Future<void> setVideoRenderMode(AgoraRteVideoRenderMode mode) async {
    await _channel.invokeMethod('rteCanvasSetVideoRenderMode', {
      'canvasId': canvasId,
      'mode': mode.index,
    });
  }

  Future<AgoraRteVideoMirrorMode> getVideoMirrorMode() async {
    final result = await _channel
        .invokeMethod('rteCanvasGetVideoMirrorMode', {'canvasId': canvasId});
    return AgoraRteVideoMirrorMode.values[result ?? 0];
  }

  Future<void> setVideoMirrorMode(AgoraRteVideoMirrorMode mode) async {
    await _channel.invokeMethod('rteCanvasSetVideoMirrorMode', {
      'canvasId': canvasId,
      'mode': mode.index,
    });
  }

  Future<AgoraRteRect> getCropArea() async {
    final result = await _channel
        .invokeMethod('rteCanvasGetCropArea', {'canvasId': canvasId});
    return AgoraRteRect.fromJson(Map<String, dynamic>.from(result ?? {}));
  }

  Future<void> setCropArea(AgoraRteRect cropArea) async {
    await _channel.invokeMethod('rteCanvasSetCropArea', {
      'canvasId': canvasId,
      'x': cropArea.x,
      'y': cropArea.y,
      'width': cropArea.width,
      'height': cropArea.height,
    });
  }

  @override
  Future<void> addView(int viewPtr, {AgoraRteViewConfig? config}) async {
    final result = await _channel.invokeMethod<bool>('rteCanvasAddView', {
      'canvasId': canvasId,
      'viewPtr': viewPtr,
      'config': config?.toJson(),
    });
    if (result != true) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'Failed to add view to canvas');
    }
  }

  @override
  Future<void> removeView(int viewPtr, {AgoraRteViewConfig? config}) async {
    final result = await _channel.invokeMethod<bool>('rteCanvasRemoveView', {
      'canvasId': canvasId,
      'viewPtr': viewPtr,
      'config': config?.toJson(),
    });
    if (result != true) {
      throw PlatformException(
          code: 'RTE_ERROR', message: 'Failed to remove view from canvas');
    }
  }
}
