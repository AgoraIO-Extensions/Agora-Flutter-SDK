import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

/// AgoraRenderWidget - This widget will automatically manage the native view.
///
/// Enables create native view with `uid` `mode` `local` and destroy native view automatically.
///
class AgoraRenderWidget extends StatefulWidget {
  // uid
  final int uid;

  // local flag
  final bool local;

  // local preview flag;
  final bool preview;

  /// render mode
  final VideoRenderMode mode;

  AgoraRenderWidget(
    this.uid, {
    this.mode = VideoRenderMode.Hidden,
    this.local = false,
    this.preview = false,
  })  : assert(uid != null),
        assert(mode != null),
        assert(local != null),
        assert(preview != null),
        super(key: Key(uid.toString()));

  @override
  State<StatefulWidget> createState() => _AgoraRenderWidgetState();
}

class _AgoraRenderWidgetState extends State<AgoraRenderWidget> {
  Widget _nativeView;

  int _viewId;

  @override
  void initState() {
    super.initState();
    _nativeView = AgoraRtcEngine.createNativeView((viewId) {
      _viewId = viewId;
      _bindView();
    });
  }

  @override
  void dispose() {
    AgoraRtcEngine.removeNativeView(_viewId);
    if (widget.preview) AgoraRtcEngine.stopPreview();
    super.dispose();
  }

  @override
  void didUpdateWidget(AgoraRenderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if ((widget.uid != oldWidget.uid || widget.local != oldWidget.local) &&
        _viewId != null) {
      _bindView();
      return;
    }

    if (widget.mode != oldWidget.mode) {
      _changeRenderMode();
      return;
    }
  }

  void _bindView() {
    if (widget.local) {
      AgoraRtcEngine.setupLocalVideo(_viewId, widget.mode);
      if (widget.preview) AgoraRtcEngine.startPreview();
    } else {
      AgoraRtcEngine.setupRemoteVideo(_viewId, widget.mode, widget.uid);
    }
  }

  void _changeRenderMode() {
    if (widget.local) {
      AgoraRtcEngine.setLocalRenderMode(widget.mode);
    } else {
      AgoraRtcEngine.setRemoteRenderMode(widget.uid, widget.mode);
    }
  }

  @override
  Widget build(BuildContext context) => _nativeView;
}
