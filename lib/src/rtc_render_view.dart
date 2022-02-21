import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'enum_converter.dart';
import 'enums.dart';
import 'rtc_engine.dart';
import 'api_types.dart';

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

///
/// The RtcSurfaceView class, which is used for rendering the local and remote video.
/// This class corresponds to different classes on different platforms:
///
/// Android: SurfaceView (https://developer.android.com/reference/android/view/SurfaceView).
/// iOS: UIView (https://developer.apple.com/documentation/uikit/uiview).
/// Web: DivElement (https://api.dart.dev/stable/2.15.0/dart-html/DivElement-class.html).
/// Does not apply to macOS or Windows.
///
class RtcSurfaceView extends StatefulWidget {
  ///
  /// The user ID.
  ///
  final int uid;

  ///
  /// The channel name. This parameter signifies the channel in which users engage in real-time audio and video interaction. Under the premise of the same App ID, users who fill in the same channel ID enter the same channel for audio and video interaction. The string length must be less than 64 bytes. Supported characters:
  /// The 26 lowercase English letters: a to z.
  /// The 26 uppercase English letters: A to Z.
  /// The 10 numeric characters: 0 to 9.
  /// Space
  /// "!", "#", "$", "%", "&", "(", ")", "+", "-", ":", ";", "<", "=", ".", ">", "?", "@", "[", "]", "^", "_", "{", "}", "|", "~", ","
  ///
  ///
  ///
  final String? channelId;

  ///
  /// The video render mode. For details, see VideoRenderMode.
  ///
  final VideoRenderMode renderMode;

  ///
  /// The video mirror mode. For details, see VideoMirrorMode.
  ///
  final VideoMirrorMode mirrorMode;

  ///
  /// Whether to place the surface on top of another surface view in the window, but still behind the window itsellf.
  /// This parameter is for Android only.
  ///
  final bool zOrderOnTop;

  final bool zOrderMediaOverlay;

  ///
  /// Occurs when a platform view is created.
  ///
  final PlatformViewCreatedCallback? onPlatformViewCreated;

  ///
  /// The gesture object that should be consumed by the Web view. It is possible for other gesture recognizers to be competing
  /// with the web view on pointer events, e.g if the web view is inside a [ListView] the [ListView] will want to handle vertical
  /// drags. The web view will claim gestures that are recognized by any of the recognizers on this list.
  /// When this set is empty or null, the web view will only handle pointer events for gestures that were not claimed by any
  /// other gesture recognizer.
  ///
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  ///
  /// Whether to create a sub process.
  ///
  final bool subProcess;

  /// Constructs a [RtcSurfaceView]
  RtcSurfaceView({
    Key? key,
    required this.uid,
    this.channelId,
    this.renderMode = VideoRenderMode.Hidden,
    this.mirrorMode = VideoMirrorMode.Auto,
    this.zOrderOnTop = false,
    this.zOrderMediaOverlay = false,
    this.onPlatformViewCreated,
    this.gestureRecognizers,
    this.subProcess = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RtcSurfaceViewState();
  }
}

class _RtcSurfaceViewState extends State<RtcSurfaceView> {
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
          onPlatformViewCreated: onPlatformViewCreated,
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
          onPlatformViewCreated: onPlatformViewCreated,
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
          onCreatePlatformView: onCreatePlatformView,
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
      setData();
    }
    if (oldWidget.renderMode != widget.renderMode) {
      if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {
        setData();
      } else {
        setRenderMode();
      }
    }
    if (oldWidget.mirrorMode != widget.mirrorMode) {
      if (kIsWeb || (Platform.isWindows || Platform.isMacOS)) {
        setData();
      } else {
        setMirrorMode();
      }
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      if (oldWidget.zOrderOnTop != widget.zOrderOnTop) {
        setZOrderOnTop();
      }
      if (oldWidget.zOrderMediaOverlay != widget.zOrderMediaOverlay) {
        setZOrderMediaOverlay();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _channels.remove(_id);
  }

  void setData() {
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
      RtcEngine.methodChannel.invokeMethod('callApi', {
        'apiType': _getSetRenderModeApiType(widget.uid).index,
        'params': jsonEncode(params),
      });
    } else {
      _channels[_id]?.invokeMethod('setData', params);
    }
  }

  void setRenderMode() {
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();

    RtcEngine.methodChannel.invokeMethod('callApi', {
      'apiType': _getSetRenderModeApiType(widget.uid).index,
      'params': jsonEncode({
        'userId': widget.uid,
        'renderMode': _renderMode,
        'mirrorMode': _mirrorMode,
      }),
    });
  }

  void setMirrorMode() {
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();
    RtcEngine.methodChannel.invokeMethod('callApi', {
      'apiType': _getSetRenderModeApiType(widget.uid).index,
      'params': jsonEncode({
        'userId': widget.uid,
        'renderMode': _renderMode,
        'mirrorMode': _mirrorMode,
      }),
    });
  }

  void setZOrderOnTop() {
    _channels[_id]?.invokeMethod('setZOrderOnTop', {
      'onTop': widget.zOrderOnTop,
    });
  }

  void setZOrderMediaOverlay() {
    _channels[_id]?.invokeMethod('setZOrderMediaOverlay', {
      'isMediaOverlay': widget.zOrderMediaOverlay,
    });
  }

  Future<void> onPlatformViewCreated(int id) async {
    _id = id;
    if (!_channels.containsKey(id)) {
      _channels[id] = MethodChannel('agora_rtc_engine/surface_view_$id');
    }
    widget.onPlatformViewCreated?.call(id);
  }

  PlatformViewController onCreatePlatformView(
      PlatformViewCreationParams params) {
    final controller = _HtmlElementViewController(params.id, params.viewType);
    controller._initialize().then((_) {
      params.onPlatformViewCreated(params.id);
      onPlatformViewCreated(params.id);
      setData();
    });
    return controller;
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

///
/// The RtcTextureView class, which is used for rendering
/// the local and remote video.
/// This class corresponds to different classes in on different platforms:
///
/// Android: TextureView (https://developer.android.com/reference/android/view/TextureView)
/// or FlutterTexture (https://api.flutter.dev/objcdoc/Protocols/FlutterTexture.html).
/// iOS/macOS/Windows: FlutterTexture (https://api.flutter.dev/objcdoc/Protocols/FlutterTexture.html).
/// Does not apply to Web.
///
class RtcTextureView extends StatefulWidget {
  ///
  /// The user ID.
  ///
  final int uid;

  ///
  ///
  ///
  final String? channelId;

  ///
  /// The video render mode. For details, see VideoRenderMode.
  ///
  final VideoRenderMode renderMode;

  ///
  /// The video mirror mode. For details, see VideoMirrorMode.
  ///
  final VideoMirrorMode mirrorMode;

  ///
  /// Occurs when a platform view is created.
  ///
  final PlatformViewCreatedCallback? onPlatformViewCreated;

  ///
  /// The gesture object that should be consumed by the Web view. It is possible for other gesture recognizers to be competing
  /// with the web view on pointer events, e.g if the web view is inside a [ListView] the [ListView] will want to handle vertical
  /// drags. The web view will claim gestures that are recognized by any of the recognizers on this list.
  /// When this set is empty or null, the web view will only handle pointer events for gestures that were not claimed by any
  /// other gesture recognizer.
  ///
  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  ///
  /// Whether to use FlutterTexture for rendering the view.
  ///
  final bool useFlutterTexture;

  ///
  /// Whether to create a sub process.
  ///
  final bool subProcess;

  /// Constructs a [RtcTextureView]
  RtcTextureView({
    Key? key,
    required this.uid,
    this.channelId,
    this.renderMode = VideoRenderMode.Hidden,
    this.mirrorMode = VideoMirrorMode.Auto,
    this.onPlatformViewCreated,
    this.gestureRecognizers,
    this.useFlutterTexture = true,
    this.subProcess = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _RtcTextureViewState();
  }
}

class _RtcTextureViewState extends State<RtcTextureView> {
  int? _id;
  int? _renderMode;
  int? _mirrorMode;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Text('Web is not yet supported by the plugin');
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
            onPlatformViewCreated: onPlatformViewCreated,
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
      RtcEngine.methodChannel.invokeMethod('createTextureRender', {
        'subProcess': widget.subProcess,
      }).then((value) {
        setState(() {
          _id = value;
        });
        if (!_channels.containsKey(value)) {
          _channels[value] =
              MethodChannel('agora_rtc_engine/texture_render_$value');
          setData();
        }
      });
    }
  }

  @override
  void didUpdateWidget(RtcTextureView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.uid != widget.uid ||
        oldWidget.channelId != widget.channelId) {
      setData();
    }
    if (oldWidget.renderMode != widget.renderMode) {
      setRenderMode();
    }
    if (oldWidget.mirrorMode != widget.mirrorMode) {
      setMirrorMode();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _channels.remove(_id);
    if (widget.useFlutterTexture &&
        defaultTargetPlatform != TargetPlatform.android) {
      RtcEngine.methodChannel.invokeMethod('destroyTextureRender', {
        'id': _id,
        'subProcess': widget.subProcess,
      });
    }
  }

  void setData() {
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

  void setRenderMode() {
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();

    RtcEngine.methodChannel.invokeMethod('callApi', {
      'apiType': _getSetRenderModeApiType(widget.uid).index,
      'params': jsonEncode({
        'userId': widget.uid,
        'renderMode': _renderMode,
        'mirrorMode': _mirrorMode,
      }),
    });
  }

  void setMirrorMode() {
    _renderMode = VideoRenderModeConverter(widget.renderMode).value();
    _mirrorMode = VideoMirrorModeConverter(widget.mirrorMode).value();

    RtcEngine.methodChannel.invokeMethod('callApi', {
      'apiType': _getSetRenderModeApiType(widget.uid).index,
      'params': jsonEncode({
        'userId': widget.uid,
        'renderMode': _renderMode,
        'mirrorMode': _mirrorMode,
      }),
    });
  }

  Future<void> onPlatformViewCreated(int id) async {
    _id = id;
    if (!_channels.containsKey(id)) {
      _channels[id] = MethodChannel('agora_rtc_engine/texture_view_$id');
    }
    widget.onPlatformViewCreated?.call(id);
  }
}
