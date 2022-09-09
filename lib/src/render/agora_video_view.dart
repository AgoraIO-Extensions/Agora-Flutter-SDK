import 'package:agora_rtc_engine/src/render/video_view_controller.dart';
import 'package:flutter/material.dart';

import '../impl/agora_video_view_impl.dart';

/// AgoraVideoView 类，用于渲染本地和远端视频。
///
class AgoraVideoView extends StatefulWidget {
  /// @nodoc
  const AgoraVideoView({Key? key, required this.controller}) : super(key: key);

  /// 控制待渲染的视频类型： 如果渲染 RtcEngine 的视频，详见 VideoViewController 。如果渲染媒体播放器中的视频，详见 MediaPlayerController 。
  final VideoViewControllerBase controller;

  @override
  State<AgoraVideoView> createState() => AgoraVideoViewState();
}
