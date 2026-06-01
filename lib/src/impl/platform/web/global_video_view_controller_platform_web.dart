import 'dart:html' as html;
import 'dart:ui_web' as ui;

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/platform/global_video_view_controller_platform.dart';
import 'package:agora_rtc_engine/src/impl/platform/web/html_element_attach_gate.dart';
import 'package:flutter/foundation.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs

const _platformRendererViewType = 'AgoraSurfaceView';

String _getViewType(int id) {
  return 'agora_rtc_engine/${_platformRendererViewType}_$id';
}

class _View {
  _View(int platformViewId)
      : _element = html.DivElement()
          ..id = _getViewType(platformViewId)
          ..style.width = '100%'
          ..style.height = '100%' {
    // Wait until the element is injected into the DOM,
    // see https://github.com/flutter/flutter/issues/143922#issuecomment-1960133128
    _attachGate = HtmlElementAttachGate(_element);
  }

  final html.HtmlElement _element;
  html.HtmlElement get element => _element;

  late final HtmlElementAttachGate _attachGate;
  bool _isDisposed = false;

  bool get isDisposed => _isDisposed;

  void dispose() {
    if (_isDisposed) {
      return;
    }

    _isDisposed = true;
    _attachGate.dispose();
    _element.children.clear();
  }

  Future<String?> waitAndGetId() async {
    final div = await _attachGate.attachedElement;
    return div?.id;
  }
}

final Map<int, _View> _viewMap = {};

class GlobalVideoViewControllerWeb extends GlobalVideoViewControllerPlatfrom {
  GlobalVideoViewControllerWeb(
      IrisMethodChannel irisMethodChannel, RtcEngine rtcEngine)
      : super(irisMethodChannel, rtcEngine) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(_platformRendererViewType,
        (int viewId) {
      final view = _View(viewId);
      _viewMap[viewId] = view;
      return view.element;
    });
  }

  @override
  Future<void> detachVideoFrameBufferManager(int irisRtcEngineIntPtr) async {
    for (final view in _viewMap.values) {
      view.dispose();
    }
    _viewMap.clear();
    await super.detachVideoFrameBufferManager(irisRtcEngineIntPtr);
  }

  @override
  Future<void> setupVideoView(Object viewHandle, VideoCanvas videoCanvas,
      {RtcConnection? connection}) async {
    // The `viewHandle` is the platform view id on web
    final viewId = viewHandle as int;

    if (videoCanvas.setupMode == VideoViewSetupMode.videoViewSetupRemove) {
      final view = _viewMap[viewId];
      if (view?.element.isConnected == true) {
        view!.element.children.clear();
      } else {
        _viewMap.remove(viewId)?.dispose();
      }
      return;
    }

    final view = _viewMap[viewId];
    if (view == null || view.isDisposed) {
      return;
    }

    final divId = await view.waitAndGetId();
    if (divId == null ||
        view.isDisposed ||
        view.element.isConnected != true ||
        !identical(_viewMap[viewId], view)) {
      return;
    }

    await super.setupVideoView(divId, videoCanvas, connection: connection);
  }

  @visibleForTesting
  html.HtmlElement debugCreatePlatformView(int viewId) {
    final view = _View(viewId);
    _viewMap[viewId] = view;
    return view.element;
  }
}
