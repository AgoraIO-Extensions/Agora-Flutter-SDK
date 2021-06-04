@JS()
library agora_rtc_engine;

import 'dart:async';
import 'dart:convert';

// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:js';
import 'dart:ui' as ui;

import 'package:agora_rtc_engine/src/enums.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';
import 'package:js/js_util.dart';

@JS('IrisRtcEngine')
class _IrisRtcEngine {
  external _IrisRtcDeviceManager get deviceManager;

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
    eventChannel.setController(pluginInstance._controller);

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

  final _controller = StreamController();
  final _IrisRtcEngine _engine = _IrisRtcEngine();

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    _engine.setEventHandler(allowInterop((String event, String data) {
      _controller.add({'methodName': event, 'data': data});
    }));
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    switch (call.method) {
      case 'callApi':
        return promiseToFuture(
            _engine.callApi(args['apiType'], args['params']));
      default:
        throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
  }

  // ignore: public_member_api_docs
  Future<dynamic> handleADMMethodCall(MethodCall call) async {
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    switch (call.method) {
      case 'callApi':
        return promiseToFuture(_engine.deviceManager
            .callApiAudio(args['apiType'], args['params']));
      default:
        throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
  }

  // ignore: public_member_api_docs
  Future<dynamic> handleVDMMethodCall(MethodCall call) async {
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    switch (call.method) {
      case 'callApi':
        return promiseToFuture(_engine.deviceManager
            .callApiVideo(args['apiType'], args['params']));
      default:
        throw PlatformException(code: ErrorCode.NotSupported.toString());
    }
  }

  // ignore: public_member_api_docs
  Future<dynamic> handleViewMethodCall(MethodCall call, Element element) async {
    var args = <String, dynamic>{};
    if (call.arguments != null) {
      args = Map<String, dynamic>.from(call.arguments);
    }
    switch (call.method) {
      case 'setData':
        var data = Map<String, dynamic>.from(args['data']);
        if (data['uid'] == 0) {
          final kEngineSetupLocalVideo = 20;
          return promiseToFuture(_engine.callApi(
              kEngineSetupLocalVideo,
              jsonEncode({
                'canvas': {
                  'uid': 0,
                },
              }),
              element));
        } else {
          final kEngineSetupLocalVideo = 21;
          return promiseToFuture(_engine.callApi(
              kEngineSetupLocalVideo,
              jsonEncode({
                'canvas': {
                  'uid': data['uid'],
                }
              }),
              element));
        }
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'agora_rtc_engine for web doesn\'t implement \'${call.method}\'',
        );
    }
  }
}
