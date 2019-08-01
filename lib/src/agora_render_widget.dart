// Created by 超悟空 on 2019/7/10.
// Version 1.0 2019/7/10
// Since 1.0 2019/7/10

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

/// 简单渲染窗口控件
///
/// 自动创建和销毁内部原生控件，自动绑定用户
class AgoraRenderWidget extends StatefulWidget {
  /// 绑定的uid
  final int uid;

  /// 是否是自己
  ///
  /// 当为true时使用[AgoraRtcEngine.setupLocalVideo]绑定视频窗口，
  /// 否则使用[AgoraRtcEngine.setupRemoteVideo]绑定视频窗口
  final bool self;

  /// 窗口填充模式
  final VideoRenderMode mode;

  AgoraRenderWidget(
    this.uid, {
    this.mode = VideoRenderMode.Hidden,
    this.self = false,
  })  : assert(uid != null),
        assert(mode != null),
        assert(self != null);

  @override
  State<StatefulWidget> createState() => _AgoraRenderWidgetState();
}

class _AgoraRenderWidgetState extends State<AgoraRenderWidget> {
  /// 原生组件
  Widget _nativeView;

  /// 原生组件id
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
    super.dispose();
  }

  @override
  void didUpdateWidget(AgoraRenderWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if ((widget.uid != oldWidget.uid || widget.self != oldWidget.self) &&
        _viewId != null) {
      _bindView();
      return;
    }

    if (widget.mode != oldWidget.mode) {
      _changeMode();
      return;
    }
  }

  /// 绑定用户和原生控件
  void _bindView() {
    if (widget.self) {
      AgoraRtcEngine.setupLocalVideo(_viewId, widget.mode);
    } else {
      AgoraRtcEngine.setupRemoteVideo(_viewId, widget.mode, widget.uid);
    }
  }

  /// 改变缩放模式
  void _changeMode() {
    if (widget.self) {
      AgoraRtcEngine.setLocalRenderMode(widget.mode);
    } else {
      AgoraRtcEngine.setRemoteRenderMode(widget.uid, widget.mode);
    }
  }

  @override
  Widget build(BuildContext context) => _nativeView;
}
