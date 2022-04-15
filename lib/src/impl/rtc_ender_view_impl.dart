import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/src/rtc_render_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'api_types.dart';
import 'enum_converter.dart';
import 'rtc_engine_impl.dart';

ApiTypeEngine _getSetRenderModeApiType(int uid) {
  return uid == 0
      ? ApiTypeEngine.kEngineSetLocalRenderMode
      : ApiTypeEngine.kEngineSetRemoteRenderMode;
}

ApiTypeEngine _getSetupVideoApiType(int uid) {
  return uid == 0
      ? ApiTypeEngine.kEngineSetupLocalVideo
      : ApiTypeEngine.kEngineSetupRemoteVideo;
}

final Map<int, MethodChannel> _channels = {};

/// The implementation of [RtcSurfaceView]
class RtcSurfaceViewState extends State<RtcSurfaceView> {
  int? _id;
  int? _renderMode;
  int? _mirrorMode;

  ApiTypeEngine get _apiType => widget.uid == 0
      ? ApiTypeEngine.kEngineSetupLocalVideo
      : ApiTypeEngine.kEngineSetupRemoteVideo;

  Map<String, dynamic> get _creationParams => {
        'callApi': {
          'apiType': _apiType.index,
          'params': jsonEncode({
            'canvas': {
              'uid': widget.uid,
              'channelId': widget.channelId,
              'renderMode': _renderMode,
              'mirrorMode': _mirrorMode,
            }
          }),
        },
      };

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AndroidView(
          viewType: 'AgoraSurfaceView',
          onPlatformViewCreated: _onPlatformViewCreated,
          hitTestBehavior: PlatformViewHitTestBehavior.transparent,
          creationParams: {
            ..._creationParams,
            'setZOrderOnTop': {
              'onTop': widget.zOrderOnTop,
            },
            'setZOrderMediaOverlay': {
              'isMediaOverlay': widget.zOrderMediaOverlay,
            },
          },
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: widget.gestureRecognizers,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: UiKitView(
          viewType: 'AgoraSurfaceView',
          onPlatformViewCreated: _onPlatformViewCreated,
          hitTestBehavior: PlatformViewHitTestBehavior.transparent,
          creationParams: _creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: widget.gestureRecognizers,
        ),
      );
    } else if (kIsWeb) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: PlatformViewLink(
          viewType: 'AgoraSurfaceView',
          onCreatePlatformView: _onCreatePlatformView,
          surfaceFactory:
              (BuildContext context, PlatformViewController controller) {
            return PlatformViewSurface(
              controller: controller,
              hitTestBehavior: PlatformViewHitTestBehavior.transparent,
              gestureRecognizers: widget.gestureRecognizers != null
                  ? widget.gestureRecognizers!
                  : const <Factory<OneSequenceGestureRecognizer>>{},
            );
          },
        ),
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the plugin');
  }

  @override
  void initState() {
    super.initState();
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();
  }

  @override
  void didUpdateWidget(RtcSurfaceView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uid != widget.uid ||
        oldWidget.channelId != widget.channelId) {
      _setData();
    }
    if (oldWidget.renderMode != widget.renderMode) {
      if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {
        _setData();
      } else {
        _setRenderMode();
      }
    }
    if (oldWidget.mirrorMode != widget.mirrorMode) {
      if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {
        _setData();
      } else {
        _setMirrorMode();
      }
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (oldWidget.zOrderOnTop != widget.zOrderOnTop) {
        _setZOrderOnTop();
      }
      if (oldWidget.zOrderMediaOverlay != widget.zOrderMediaOverlay) {
        _setZOrderMediaOverlay();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _channels.remove(_id);
  }

  void _setData() {
    var params = <String, dynamic>{
      'userId': widget.uid,
      'channelId': widget.channelId,
    };
    if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {
      params['subProcess'] = widget.subProcess;
    }
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    params['renderMode'] = _renderMode;

    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();
    params['mirrorMode'] = _mirrorMode;

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      RtcEngineImpl.methodChannel.invokeMethod('callApi', {
        'apiType': _getSetRenderModeApiType(widget.uid).index,
        'params': jsonEncode(params),
      });
    } else {
      _channels[_id]?.invokeMethod('setData', params);
    }
  }

  void _setRenderMode() {
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();

    RtcEngineImpl.methodChannel.invokeMethod('callApi', {
      'apiType': _getSetRenderModeApiType(widget.uid).index,
      'params': jsonEncode({
        'userId': widget.uid,
        'renderMode': _renderMode,
        'mirrorMode': _mirrorMode,
      }),
    });
  }

  void _setMirrorMode() {
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();
    RtcEngineImpl.methodChannel.invokeMethod('callApi', {
      'apiType': _getSetRenderModeApiType(widget.uid).index,
      'params': jsonEncode({
        'userId': widget.uid,
        'renderMode': _renderMode,
        'mirrorMode': _mirrorMode,
      }),
    });
  }

  void _setZOrderOnTop() {
    _channels[_id]?.invokeMethod('setZOrderOnTop', {
      'onTop': widget.zOrderOnTop,
    });
  }

  void _setZOrderMediaOverlay() {
    _channels[_id]?.invokeMethod('setZOrderMediaOverlay', {
      'isMediaOverlay': widget.zOrderMediaOverlay,
    });
  }

  Future<void> _onPlatformViewCreated(int id) async {
    _id = id;
    if (!_channels.containsKey(id)) {
      _channels[id] = MethodChannel('agora_rtc_engine/surface_view_$id');
    }
    widget.onPlatformViewCreated?.call(id);
  }

  PlatformViewController _onCreatePlatformView(
      PlatformViewCreationParams params) {
    final controller = _HtmlElementViewController(params.id, params.viewType);
    controller._initialize().then((_) {
      params.onPlatformViewCreated(params.id);
      _onPlatformViewCreated(params.id);
      _setData();
    });
    return controller;
  }
}

/// The implementation of [RtcTextureView]
class RtcTextureViewState extends State<RtcTextureView> {
  int? _id;
  int? _renderMode;
  int? _mirrorMode;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Text('Web is not yet supported by the plugin');
    }
    if (widget.useFlutterTexture &&
        defaultTargetPlatform != TargetPlatform.android) {
      if (_id != null) {
        return Texture(textureId: _id!);
      }
      return Container();
    } else {
      if (defaultTargetPlatform == TargetPlatform.android) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: AndroidView(
            viewType: 'AgoraTextureView',
            onPlatformViewCreated: _onPlatformViewCreated,
            hitTestBehavior: PlatformViewHitTestBehavior.transparent,
            creationParams: {
              'callApi': {
                'apiType': _getSetupVideoApiType(widget.uid).index,
                'params': jsonEncode({
                  'canvas': {
                    'uid': widget.uid,
                    'channelId': widget.channelId,
                    'renderMode': _renderMode,
                    'mirrorMode': _mirrorMode,
                  }
                }),
              },
            },
            creationParamsCodec: const StandardMessageCodec(),
            gestureRecognizers: widget.gestureRecognizers,
          ),
        );
      }
      return Text('$defaultTargetPlatform is not yet supported by the plugin');
    }
  }

  @override
  void initState() {
    super.initState();
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();
    if (widget.useFlutterTexture &&
        defaultTargetPlatform != TargetPlatform.android) {
      RtcEngineImpl.methodChannel.invokeMethod('createTextureRender', {
        'subProcess': widget.subProcess,
      }).then((value) {
        setState(() {
          _id = value;
        });
        if (!_channels.containsKey(value)) {
          _channels[value] =
              MethodChannel('agora_rtc_engine/texture_render_$value');
          _setData();
        }
      });
    }
  }

  @override
  void didUpdateWidget(RtcTextureView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uid != widget.uid ||
        oldWidget.channelId != widget.channelId) {
      _setData();
    }
    if (oldWidget.renderMode != widget.renderMode) {
      _setRenderMode();
    }
    if (oldWidget.mirrorMode != widget.mirrorMode) {
      _setMirrorMode();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _channels.remove(_id);
    if (widget.useFlutterTexture &&
        defaultTargetPlatform != TargetPlatform.android) {
      RtcEngineImpl.methodChannel.invokeMethod('destroyTextureRender', {
        'id': _id,
        'subProcess': widget.subProcess,
      });
    }
  }

  void _setData() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      var params = <String, dynamic>{
        'canvas': {
          'uid': widget.uid,
          'channelId': widget.channelId,
          'renderMode': _renderMode,
          'mirrorMode': _mirrorMode,
        },
      };
      _channels[_id]?.invokeMethod('callApi', {
        'apiType': _getSetupVideoApiType(widget.uid).index,
        'params': jsonEncode(params),
      });

      return;
    }
    var params = <String, dynamic>{
      'data': {
        'uid': widget.uid,
        'channelId': widget.channelId,
      },
    };
    if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {
      params['subProcess'] = widget.subProcess;
    }
    _channels[_id]?.invokeMethod('setData', params);
  }

  void _setRenderMode() {
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();

    RtcEngineImpl.methodChannel.invokeMethod('callApi', {
      'apiType': _getSetRenderModeApiType(widget.uid).index,
      'params': jsonEncode({
        'userId': widget.uid,
        'renderMode': _renderMode,
        'mirrorMode': _mirrorMode,
      }),
    });
  }

  void _setMirrorMode() {
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();

    RtcEngineImpl.methodChannel.invokeMethod('callApi', {
      'apiType': _getSetRenderModeApiType(widget.uid).index,
      'params': jsonEncode({
        'userId': widget.uid,
        'renderMode': _renderMode,
        'mirrorMode': _mirrorMode,
      }),
    });
  }

  Future<void> _onPlatformViewCreated(int id) async {
    _id = id;
    if (!_channels.containsKey(id)) {
      _channels[id] = MethodChannel('agora_rtc_engine/texture_view_$id');
    }
    widget.onPlatformViewCreated?.call(id);
  }
}

class _HtmlElementViewController extends PlatformViewController
    with WidgetsBindingObserver {
  _HtmlElementViewController(
    this.viewId,
    this.viewType,
  );

  @override
  final int viewId;

  /// The unique identifier for the HTML view type to be embedded by this widget.
  ///
  /// A PlatformViewFactory for this type must have been registered.
  final String viewType;

  bool _initialized = false;

  Future<void> _initialize() async {
    final args = <String, dynamic>{
      'id': viewId,
      'viewType': viewType,
    };
    await SystemChannels.platform_views.invokeMethod<void>('create', args);
    _initialized = true;
  }

  @override
  Future<void> clearFocus() async {
    // Currently this does nothing on Flutter Web.
    // TODO(het): Implement this. See https://github.com/flutter/flutter/issues/39496
  }

  @override
  Future<void> dispatchPointerEvent(PointerEvent event) async {
    // We do not dispatch pointer events to HTML views because they may contain
    // cross-origin iframes, which only accept user-generated events.
  }

  @override
  Future<void> dispose() async {
    if (_initialized) {
      await SystemChannels.platform_views.invokeMethod<void>('dispose', viewId);
    }
  }
}
