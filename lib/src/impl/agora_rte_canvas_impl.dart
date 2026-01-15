import 'dart:async';
import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:flutter/services.dart';

/// RTE 画布实现类
class AgoraRteCanvasImpl implements AgoraRteCanvas {
  @override
  final String canvasId;
  final MethodChannel _channel;

  AgoraRteCanvasImpl(this.canvasId, this._channel);

  /// 处理回调（由 AgoraRteCoreImpl 调用）
  /// 
  /// 注意：当前 AgoraRteCanvas 没有定义观察者回调机制。
  /// Canvas 主要用于视图渲染配置（视频渲染模式、镜像模式、裁剪区域等），
  /// 不涉及状态变化或事件回调。
  /// 
  /// 此方法保留用于未来可能的扩展，如果原生 SDK 添加了 Canvas 相关的回调机制。
  void handleCallback(String method, Map args) {
    // 当前没有 Canvas 相关的回调需要处理
    // 如果未来原生 SDK 添加了 Canvas 回调（如视图添加/移除事件等），
    // 可以在这里添加相应的处理逻辑
    
    // 示例：如果未来有视图添加回调
    // switch (method) {
    //   case 'rteCanvasOnViewAdded':
    //     // 处理视图添加回调
    //     break;
    //   case 'rteCanvasOnViewRemoved':
    //     // 处理视图移除回调
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
    return AgoraRteCanvasConfig(
      videoRenderMode: result['videoRenderMode'] != null
          ? AgoraRteVideoRenderMode.values[result['videoRenderMode']]
          : null,
      videoMirrorMode: result['videoMirrorMode'] != null
          ? AgoraRteVideoMirrorMode.values[result['videoMirrorMode']]
          : null,
      cropArea: result['cropArea'] != null
          ? AgoraRteRect.fromJson(Map<String, dynamic>.from(result['cropArea']))
          : null,
    );
  }

  // 单个配置属性的 getter/setter
  Future<AgoraRteVideoRenderMode> getVideoRenderMode() async {
    final result = await _channel.invokeMethod(
        'rteCanvasGetVideoRenderMode', {'canvasId': canvasId});
    return AgoraRteVideoRenderMode.values[result ?? 0];
  }

  Future<void> setVideoRenderMode(AgoraRteVideoRenderMode mode) async {
    await _channel.invokeMethod('rteCanvasSetVideoRenderMode', {
      'canvasId': canvasId,
      'mode': mode.index,
    });
  }

  Future<AgoraRteVideoMirrorMode> getVideoMirrorMode() async {
    final result = await _channel.invokeMethod(
        'rteCanvasGetVideoMirrorMode', {'canvasId': canvasId});
    return AgoraRteVideoMirrorMode.values[result ?? 0];
  }

  Future<void> setVideoMirrorMode(AgoraRteVideoMirrorMode mode) async {
    await _channel.invokeMethod('rteCanvasSetVideoMirrorMode', {
      'canvasId': canvasId,
      'mode': mode.index,
    });
  }

  Future<AgoraRteRect> getCropArea() async {
    final result = await _channel.invokeMethod(
        'rteCanvasGetCropArea', {'canvasId': canvasId});
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
    await _channel.invokeMethod('rteCanvasAddView', {
      'canvasId': canvasId,
      'viewPtr': viewPtr,
      'config': config?.toJson(),
    });
  }

  @override
  Future<void> removeView(int viewPtr, {AgoraRteViewConfig? config}) async {
    await _channel.invokeMethod('rteCanvasRemoveView', {
      'canvasId': canvasId,
      'viewPtr': viewPtr,
      'config': config?.toJson(),
    });
  }
}
