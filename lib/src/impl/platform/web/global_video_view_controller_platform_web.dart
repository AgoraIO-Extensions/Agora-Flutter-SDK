import 'dart:async';
import 'dart:html' as html;
import 'dart:ui' as ui;

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/platform/global_video_view_controller_platform.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs

const _platformRendererViewType = 'AgoraSurfaceView';

String _getViewType(int id) {
  return 'agora_rtc_engine/${_platformRendererViewType}_$id';
}

class _View {
  _View(this._platformViewId)
      : _div = html.DivElement()
          ..id = _getViewType(_platformViewId)
          ..style.width = '100%'
          ..style.height = '100%' {
    // this._div = html.DivElement()
    //     ..id = _getViewType(platformViewId)
    //     ..style.width = '100%'
    //     ..style.height = '100%';

    final observer = html.IntersectionObserver((entries, observer) {
      observer.unobserve(_div);
      _viewCompleter.complete(_div);
    });
    observer.observe(_div);
  }
  final int _platformViewId;
  final html.DivElement _div;
  final _viewCompleter = Completer<html.HtmlElement>();
  Future<String> getHandle() async {
    final div = await _viewCompleter.future;
    return div.id;
  }
}

// TODO(littlegnal): Need handle remove view logic on web
// final Map<int, html.HtmlElement> _viewMap = {};

final Map<int, _View> _viewMap = {};

class GlobalVideoViewControllerWeb extends GlobalVideoViewControllerPlatfrom {
  GlobalVideoViewControllerWeb(
      IrisMethodChannel irisMethodChannel, RtcEngine rtcEngine)
      : super(irisMethodChannel, rtcEngine) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(_platformRendererViewType,
        (int viewId) {
      // final div = html.DivElement()
      //   ..id = _getViewType(viewId)
      //   ..style.width = '100%'
      //   ..style.height = '100%';

        final view = _View(viewId);

      // _viewMap[viewId] = div;
      _viewMap[viewId] = view;
      print('registerViewFactory');

      // final observer = html.IntersectionObserver((entries, observer) {
      //   observer.unobserve(div);
      // });
      // observer.observe(div);

      return view._div;
    });
  }

  @override
  Future<void> detachVideoFrameBufferManager(int irisRtcEngineIntPtr) {
    _viewMap.clear();
    return super.detachVideoFrameBufferManager(irisRtcEngineIntPtr);
  }

  @override
  Future<void> setupVideoView(Object viewHandle, VideoCanvas videoCanvas,
      {RtcConnection? connection}) async {
    // The `viewHandle` is the platform view id on web
    final viewId = viewHandle as int;

    final div = _viewMap[viewId]!;
    // ignore: undefined_prefixed_name
    // final div = ui.platformViewRegistry.getViewById(viewId) as html.DivElement;

    // context.callMethod();

    print('setupVideoView');
    final divId = await div.getHandle();

    // await super.setupVideoView(div.id, videoCanvas, connection: connection);
    await super.setupVideoView(divId, videoCanvas, connection: connection);
  }
}
