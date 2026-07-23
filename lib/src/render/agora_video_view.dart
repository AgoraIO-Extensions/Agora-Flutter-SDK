import 'package:agora_rtc_engine/src/render/video_view_controller.dart';
import 'package:flutter/material.dart';

import '../impl/agora_video_view_impl.dart';

/// The AgoraVideoView class, used to render local and remote video.
class AgoraVideoView extends StatefulWidget {
  /// @nodoc
  const AgoraVideoView({
    Key? key,
    required this.controller,
    this.onAgoraVideoViewCreated,
  }) : super(key: key);

  /// Controls the type of video to render:
  ///  To render video from RtcEngine, see VideoViewController.
  ///  To render video from the media player, see MediaPlayerController.
  final VideoViewControllerBase controller;

  /// @nodoc
  final void Function(int viewId)? onAgoraVideoViewCreated;

  @override
  State<AgoraVideoView> createState() => AgoraVideoViewState();
}
