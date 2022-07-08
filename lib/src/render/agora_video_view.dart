import 'package:agora_rtc_ng/src/impl/video_view_controller_impl.dart';
import 'package:flutter/material.dart';
import '../impl/agora_video_view_impl.dart';

/// The AgoraVideoView Class for rendering local and remote video.
class AgoraVideoView extends StatefulWidget {
  /// @nodoc
  const AgoraVideoView({Key? key, required this.controller}) : super(key: key);

  /// Controls the type of video to render:
  /// If you want to render video of the RtcEngine, see VideoViewController .
  /// If you want to render video of the media player, see MediaPlayerController .
  final VideoViewControllerBase controller;

  @override
  State<AgoraVideoView> createState() => AgoraVideoViewState();
}
