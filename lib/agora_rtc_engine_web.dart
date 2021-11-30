@JS()
library agora_rtc_engine_web;

import 'dart:async';
import 'dart:convert';

// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:agora_rtc_engine/src/enums.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS('IrisRtcEngine')
class _IrisRtcEngine {
  external _IrisRtcEngine();

  external _IrisRtcChannel get channel;

  external _IrisRtcDeviceManager get deviceManager;

  external Future<dynamic> callApi(int apiType, String params, [Object? extra]);

  external void setEventHandler(Function params);
}

@JS('IrisRtcChannel')
class _IrisRtcChannel {
  external Future<dynamic> callApi(int apiType, String params, [Object? extra]);

  external void setEventHandler(Function params);
}

@JS('IrisRtcDeviceManager')
class _IrisRtcDeviceManager {
  external Future<dynamic> callApiAudio(int apiType, String params,
      [Object? extra]);

  external Future<dynamic> callApiVideo(int apiType, String params,
      [Object? extra]);
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
    eventChannel.setController(pluginInstance._controller_engine);

    MethodChannel(
      'agora_rtc_channel',
      const StandardMethodCodec(),
      registrar,
    ).setMethodCallHandler(pluginInstance.handleChannelMethodCall);
    PluginEventChannel(
            'agora_rtc_channel/events', const StandardMethodCodec(), registrar)
        .setController(pluginInstance._controller_channel);

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

    ui.platformViewRegistry.registerViewFactory('AgoraSurfaceView',
        (int viewId) {
      var element = DivElement();
      MethodChannel('agora_rtc_engine/surface_view_$viewId',
              const StandardMethodCodec(), registrar)
          .setMethodCallHandler(
              (call) => pluginInstance.handleViewMethodCall(call, element));
      return element;
    });
  }

  final _controller_engine = StreamController();
  final _controller_channel = StreamController();
  final _IrisRtcEngine _engine_main = _IrisRtcEngine();
  final _IrisRtcEngine _engine_sub = _IrisRtcEngine();

  _IrisRtcEngine _engine(Map<String, dynamic> args) {
    bool subProcess = args['subProcess'];
    if (subProcess) {
      return _engine_sub;
    } else {
      return _engine_main;
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
        _engine(args).setEventHandler(allowInterop((String event, String data) {
          _controller_engine.add({
            'methodName': event,
            'data': data,
            'subProcess': _engine(args) == _engine_sub,
          });
        }));
        _engine(args)
            .channel
            .setEventHandler(allowInterop((String event, String data) {
          _controller_channel.add({
            'methodName': event,
            'data': data,
          });
        }));
      }
      String param = args['params'];
      return promiseToFuture(_engine(args).callApi(apiType, param));
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
      return promiseToFuture(_engine_main.channel.callApi(apiType, param));
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
      return promiseToFuture(
          _engine_main.deviceManager.callApiAudio(apiType, param));
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
      return promiseToFuture(
          _engine_main.deviceManager.callApiVideo(apiType, param));
    } else {
      throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
  }

  // ignore: public_member_api_docs
  Future<dynamic> handleViewMethodCall(MethodCall call, Element element) async {
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    if (call.method == 'setData') {
      var data = Map<String, dynamic>.from(args['data']);
      if (data['uid'] == 0) {
        final kEngineSetupLocalVideo = 20;
        return promiseToFuture(_engine(args).callApi(
            kEngineSetupLocalVideo,
            jsonEncode({
              'canvas': {
                'uid': 0,
                'channelId': data['channelId'],
                'renderMode': data['renderMode'],
                'mirrorMode': data['mirrorMode'],
              },
            }),
            element));
      } else {
        final kEngineSetupRemoteVideo = 21;
        return promiseToFuture(_engine(args).callApi(
            kEngineSetupRemoteVideo,
            jsonEncode({
              'canvas': {
                'uid': data['uid'],
                'channelId': data['channelId'],
                'renderMode': data['renderMode'],
                'mirrorMode': data['mirrorMode'],
              }
            }),
            element));
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
