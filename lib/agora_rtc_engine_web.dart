@JS()
library agora_rtc_engine_web;

import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';

// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui_web' as ui;

import 'package:agora_rtc_engine/src/enums.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

@JS('IrisRtcEngine')
@staticInterop
class _IrisRtcEngine {
  external factory _IrisRtcEngine();
}

extension _IrisRtcEngineExtension on _IrisRtcEngine {
  external _IrisRtcChannel get channel;

  external _IrisRtcDeviceManager get deviceManager;

  external JSPromise<JSAny?> callApi(int apiType, String params,
      [JSAny? extra]);

  external void setEventHandler(JSFunction params);
}

@JS('IrisRtcChannel')
@staticInterop
class _IrisRtcChannel {}

extension _IrisRtcChannelExtension on _IrisRtcChannel {
  external JSPromise<JSAny?> callApi(int apiType, String params);

  external void setEventHandler(JSFunction params);
}

@JS('IrisRtcDeviceManager')
@staticInterop
class _IrisRtcDeviceManager {}

extension _IrisRtcDeviceManagerExtension on _IrisRtcDeviceManager {
  external JSPromise<JSAny?> callApiAudio(int apiType, String params);

  external JSPromise<JSAny?> callApiVideo(int apiType, String params);
}

Future<Object?> _toDartFuture(JSPromise<JSAny?> promise) async {
  return (await promise.toDart)?.dartify();
}

/// A web implementation of the AgoraRtcEngine plugin.
class AgoraRtcEngineWeb {
  // ignore: public_member_api_docs
  static void registerWith(Registrar registrar) {
    final methodChannel = MethodChannel(
      'agora_rtc_engine',
      const StandardMethodCodec(),
      registrar,
    );
    final eventChannel = PluginEventChannel(
        'agora_rtc_engine/events', const StandardMethodCodec(), registrar);

    final pluginInstance = AgoraRtcEngineWeb();
    methodChannel.setMethodCallHandler(pluginInstance.handleMethodCall);
    eventChannel.setController(pluginInstance._controllerEngine);

    MethodChannel(
      'agora_rtc_channel',
      const StandardMethodCodec(),
      registrar,
    ).setMethodCallHandler(pluginInstance.handleChannelMethodCall);
    PluginEventChannel(
            'agora_rtc_channel/events', const StandardMethodCodec(), registrar)
        .setController(pluginInstance._controllerChannel);

    MethodChannel(
      'agora_rtc_audio_device_manager',
      const StandardMethodCodec(),
      registrar,
    ).setMethodCallHandler(pluginInstance.handleADMMethodCall);

    MethodChannel(
      'agora_rtc_video_device_manager',
      const StandardMethodCodec(),
      registrar,
    ).setMethodCallHandler(pluginInstance.handleVDMMethodCall);

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory('AgoraSurfaceView',
        (int viewId) {
      var element = DivElement();
      MethodChannel('agora_rtc_engine/surface_view_$viewId',
              const StandardMethodCodec(), registrar)
          .setMethodCallHandler(
              (call) => pluginInstance.handleViewMethodCall(call, element));
      return element;
    });

    var element = ScriptElement()
      ..src =
          'assets/packages/agora_rtc_engine/assets/AgoraRtcWrapper.bundle.js'
      ..type = 'application/javascript';
    late StreamSubscription<Event> loadSubscription;
    loadSubscription = element.onLoad.listen((event) {
      loadSubscription.cancel();
      pluginInstance._engineMain = _IrisRtcEngine();
      pluginInstance._engineSub = _IrisRtcEngine();
    });
    document.body!.append(element);
  }

  final _controllerEngine = StreamController();
  final _controllerChannel = StreamController();
  late _IrisRtcEngine _engineMain;
  late _IrisRtcEngine _engineSub;

  _IrisRtcEngine _engine(Map<String, dynamic> args) {
    bool subProcess = args['subProcess'];
    if (subProcess) {
      return _engineSub;
    } else {
      return _engineMain;
    }
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    if (call.method == 'callApi') {
      int apiType = args['apiType'];
      if (apiType == 0) {
        _engine(args).setEventHandler(((JSString event, JSString data) {
          _controllerEngine.add({
            'methodName': event.toDart,
            'data': data.toDart,
            'subProcess': _engine(args) == _engineSub,
          });
        }).toJS);
        _engine(args).channel.setEventHandler(((JSString event, JSString data) {
              _controllerChannel.add({
                'methodName': event.toDart,
                'data': data.toDart,
              });
            }).toJS);
      }
      String param = args['params'];
      return _toDartFuture(_engine(args).callApi(apiType, param));
    } else {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
  }

  // ignore: public_member_api_docs
  Future<dynamic> handleChannelMethodCall(MethodCall call) async {
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    if (call.method == 'callApi') {
      int apiType = args['apiType'];
      String param = args['params'];
      return _toDartFuture(_engineMain.channel.callApi(apiType, param));
    } else {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
  }

  // ignore: public_member_api_docs
  Future<dynamic> handleADMMethodCall(MethodCall call) async {
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    if (call.method == 'callApi') {
      int apiType = args['apiType'];
      String param = args['params'];
      return _toDartFuture(
          _engineMain.deviceManager.callApiAudio(apiType, param));
    } else {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
  }

  // ignore: public_member_api_docs
  Future<dynamic> handleVDMMethodCall(MethodCall call) async {
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    if (call.method == 'callApi') {
      int apiType = args['apiType'];
      String param = args['params'];
      return _toDartFuture(
          _engineMain.deviceManager.callApiVideo(apiType, param));
    } else {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
  }

  // ignore: public_member_api_docs
  Future<dynamic> handleViewMethodCall(MethodCall call, Element element) async {
    var data = <String, dynamic>{};
    if (call.arguments != null) {
      data = Map<String, dynamic>.from(call.arguments);
    }
    if (call.method == 'setData') {
      final uid = data['userId'];
      if (uid == 0) {
        const kEngineSetupLocalVideo = 20;
        return _toDartFuture(_engine(data).callApi(
            kEngineSetupLocalVideo,
            jsonEncode({
              'canvas': {
                'uid': 0,
                'channelId': data['channelId'],
                'renderMode': data['renderMode'],
                'mirrorMode': data['mirrorMode'],
              },
            }),
            JSObject.fromInteropObject(element)));
      } else {
        const kEngineSetupRemoteVideo = 21;
        return _toDartFuture(_engine(data).callApi(
            kEngineSetupRemoteVideo,
            jsonEncode({
              'canvas': {
                'uid': uid,
                'channelId': data['channelId'],
                'renderMode': data['renderMode'],
                'mirrorMode': data['mirrorMode'],
              }
            }),
            JSObject.fromInteropObject(element)));
      }
    } else {
      throw PlatformException(
        code: 'Unimplemented',
        details:
            'agora_rtc_engine for web doesn\'t implement \'${call.method}\'',
      );
    }
  }
}
