import 'dart:convert';

import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/agora_rtc_engine_ex.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ignore_for_file: public_member_api_docs

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

mixin RtcRenderMixin<T extends StatefulWidget> on State<T> {
  @protected
  MethodChannel? methodChannel;

  int? _viewId;

  @protected
  MethodChannel? getMethodChannel() {
    return methodChannel;
  }

  void maybeCreateChannel(int viewId, String viewType) {
    methodChannel = MethodChannel('agora_rtc_ng/${viewType}_$viewId');
  }

  @protected
  Widget buildPlatformView({
    required String viewType,
    Map<String, Object?>? creationParams,
    PlatformViewCreatedCallback? onPlatformViewCreated,
    Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers,
  }) {
    // `kIsWeb` check needs put first, since `defaultTargetPlatform == TargetPlatform.android` or
    // `defaultTargetPlatform == TargetPlatform.iOS` is true in mobile web.
    if (kIsWeb) {
      return HtmlElementView(
        viewType: viewType,
        onPlatformViewCreated: _onPlatformViewCreated(
          viewType,
          onPlatformViewCreated,
        ),
      );
    }

    if (defaultTargetPlatform == TargetPlatform.android) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: AndroidView(
          viewType: viewType,
          onPlatformViewCreated: _onPlatformViewCreated(
            viewType,
            onPlatformViewCreated,
          ),
          hitTestBehavior: PlatformViewHitTestBehavior.transparent,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: gestureRecognizers,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: UiKitView(
          viewType: viewType,
          onPlatformViewCreated: _onPlatformViewCreated(
            viewType,
            onPlatformViewCreated,
          ),
          hitTestBehavior: PlatformViewHitTestBehavior.transparent,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: gestureRecognizers,
        ),
      );
    } else if (kIsWeb) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: PlatformViewLink(
          viewType: viewType,
          onCreatePlatformView: _onCreateHtmlElementPlatformView(
            viewType,
            onPlatformViewCreated,
          ),
          surfaceFactory:
              (BuildContext context, PlatformViewController controller) {
            return PlatformViewSurface(
              controller: controller,
              hitTestBehavior: PlatformViewHitTestBehavior.transparent,
              gestureRecognizers: gestureRecognizers ??
                  const <Factory<OneSequenceGestureRecognizer>>{},
            );
          },
        ),
      );
    }
    return Text('$defaultTargetPlatform is not yet supported by the plugin');
  }

  @protected
  Widget buildTexure(int textureId) {
    return Texture(textureId: textureId);
  }

  PlatformViewCreatedCallback _onPlatformViewCreated(
      String viewType, PlatformViewCreatedCallback? onPlatformViewCreated) {
    return (int id) {
      _viewId = id;
      maybeCreateChannel(id, viewType);
      onPlatformViewCreated?.call(_viewId!);
    };
  }

  CreatePlatformViewCallback _onCreateHtmlElementPlatformView(
      String viewType, PlatformViewCreatedCallback? onPlatformViewCreated) {
    return (PlatformViewCreationParams params) {
      final controller = _HtmlElementViewController(params.id, params.viewType);
      controller._initialize().then((_) {
        params.onPlatformViewCreated(params.id);
        _onPlatformViewCreated(viewType, onPlatformViewCreated)(params.id);
      });
      return controller;
    };
  }
}

@immutable
class RtcRenderer extends StatefulWidget {
  const RtcRenderer({
    Key? key,
    required this.canvas,
    this.connection,
    required this.viewType,
    this.extraParams = const <String, Object?>{},
    this.onPlatformViewCreated,
    this.gestureRecognizers,
  }) : super(key: key);
  final PlatformViewCreatedCallback? onPlatformViewCreated;

  final Set<Factory<OneSequenceGestureRecognizer>>? gestureRecognizers;

  final String viewType;

  final VideoCanvas canvas;

  final RtcConnection? connection;

  final Map<String, Object?> extraParams;

  @override
  State<RtcRenderer> createState() {
    return RtcRendererState();
  }
}

class RtcRendererState<T extends RtcRenderer> extends State<T>
    with RtcRenderMixin {
  Map<String, dynamic> superCreationParams(
    String viewType,
    VideoCanvas canvas,
    RtcConnection? connection,
  ) {
    return {
      'viewType': viewType,
      'callApi': {
        'params': jsonEncode({
          'canvas': canvas.toJson(),
          'connection': connection?.toJson(),
        }),
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    return buildPlatformView(
      viewType: widget.viewType,
      creationParams: {
        ...superCreationParams(
          widget.viewType,
          widget.canvas,
          widget.connection,
        ),
        ...widget.extraParams,
      },
      onPlatformViewCreated: widget.onPlatformViewCreated,
      gestureRecognizers: widget.gestureRecognizers,
    );
  }
}
