import 'dart:async';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/platform/global_video_view_controller_platform.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs

const _platformRendererViewType = 'AgoraSurfaceView';

String _getViewType(int id) {
  return 'agora_rtc_engine/${_platformRendererViewType}_$id';
}

// TODO(littlegnal): Need handle remove view logic on web
final Map<int, HtmlElement> _viewMap = {};

class GlobalVideoViewControllerWeb extends GlobalVideoViewControllerPlatfrom {
  GlobalVideoViewControllerWeb(
      IrisMethodChannel irisMethodChannel, RtcEngine rtcEngine)
      : super(irisMethodChannel, rtcEngine) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(_platformRendererViewType,
        (int viewId) {
      final div = DivElement()
        ..id = _getViewType(viewId)
        ..style.width = '100%'
        ..style.height = '100%';

      _viewMap[viewId] = div;
      print('registerViewFactory');

      return div;
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

    // final div = _viewMap[viewId]!;
    // ignore: undefined_prefixed_name
     final div = ui.platformViewRegistry.getViewById(viewId)
        as DivElement;

        print('setupVideoView');

    await super.setupVideoView(div.id, videoCanvas, connection: connection);
  }
}
