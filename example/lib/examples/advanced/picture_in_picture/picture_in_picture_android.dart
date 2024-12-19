// ignore_for_file: avoid_print

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RTCModel {
  static final shard = RTCModel._();
  late final RtcEngine engine;
  late RtcEngineEventHandler? _handler;
  late RtcEngineEventHandler _internal_handler;

  RTCModel._() {
    engine = createAgoraRtcEngine();
  }

  void setHandler(RtcEngineEventHandler handler) {
    _handler = handler;

    _internal_handler = RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        print('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print('[onJoinChannelSuccess] connection: ${connection.toJson()}');
        _handler?.onJoinChannelSuccess!(connection, elapsed);
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        print(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid');
        _handler?.onUserJoined!(connection, rUid, elapsed);
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        print(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');

        _handler?.onUserOffline!(connection, rUid, reason);
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        print('[onLeaveChannel] connection: ${connection.toJson()}');
        _handler?.onLeaveChannel!(connection, stats);
      },
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
          RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
        print(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason');
        _handler?.onRemoteVideoStateChanged!(
            connection, remoteUid, state, reason, elapsed);
      },
      onPipStateChanged: (state) {
        print('[onPipStateChanged] state: $state');
        _handler?.onPipStateChanged!(state);
      },
    );
    engine.registerEventHandler(_internal_handler);
  }

  void unsetHandler() {
    _handler = null;
  }
}

///=============================================
/// PictureInPicture Example
class PictureInPicture extends StatefulWidget {
  /// Construct the [PictureInPicture]
  const PictureInPicture({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PictureInPicture> with WidgetsBindingObserver {
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  PIPVideoViewController? _pipVideoViewController;

  bool _isInPipMode = false;
  bool _isPipSupported = false;
  bool _hasVideo = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _initEngine();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print("应用进入非活动状态");
      // 查看inactive定义，android和ios都会触发inactive，但场景不一样，ios
      // 这里不是全部的场景都允许调用startPictureInPicture，android可以
      // android现在设置autoEnter无效，底层实现没有去设置，所以需要这里主动调用
      await _pipVideoViewController?.startPictureInPicture();
    } else if (state == AppLifecycleState.resumed) {
      print("应用从后台返回前台");
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initEngine() async {
    await RTCModel.shard.engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    _rtcEngineEventHandler = RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {},
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        var newPipVideoViewController = PIPVideoViewController.remote(
          rtcEngine: RTCModel.shard.engine,
          canvas: VideoCanvas(uid: rUid),
          connection: RtcConnection(channelId: config.channelId),
        );

        setState(() {
          _pipVideoViewController = newPipVideoViewController;
          _pipVideoViewController?.setupPictureInPicture(const PipOptions(
            contentWidth: 150, contentHeight: 300, autoEnterPip: true));
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        if (_hasVideo) {
          setState(() {
            _hasVideo = false;
          });
        }
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {},
      onRemoteVideoStateChanged:
          (connection, remoteUid, state, reason, elapsed) {
        var hasVideo = state == RemoteVideoState.remoteVideoStateStarting ||
            state == RemoteVideoState.remoteVideoStateDecoding;

        setState(() {
          _hasVideo = hasVideo;
        });
      },
      onPipStateChanged: (state) {
        var isInPipMode = state == PipState.pipStateStarted;
        if (state == PipState.pipStateFailed) {
          // call setup again will reset the pip state, even you have the same options
          _pipVideoViewController?.setupPictureInPicture(const PipOptions(
              contentWidth: 150, contentHeight: 300, autoEnterPip: true));
        }
        setState(() {
          _isInPipMode = isInPipMode;
        });
      },
    );

    RTCModel.shard.setHandler(_rtcEngineEventHandler);

    await RTCModel.shard.engine.enableVideo();
    var isPipSupported = await RTCModel.shard.engine.isPipSupported();
    setState(() {
      _isPipSupported = isPipSupported;
    });
  }

  Future<void> _joinChannel() async {
    await RTCModel.shard.engine.joinChannel(
      token: config.token,
      channelId: config.channelId,
      uid: config.uid,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _pipVideoViewController?.dispose();

    await RTCModel.shard.engine.leaveChannel();
  }

  Widget _videoViewStack(Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_hasVideo && _pipVideoViewController != null)
          SizedBox(
            width: size.width,
            height: size.height,
            child: AgoraVideoView(
              controller: _pipVideoViewController!,
              onAgoraVideoViewCreated: (viewId) async {
                // do nothing for android
              },
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isPipSupported == false) {
      return const Center(
        child: Text('The picture-in-picture is not supported on this device.'),
      );
    }
    final size = MediaQuery.sizeOf(context);

    // only show the video view in pip mode
    if (_isInPipMode) {
      return _videoViewStack(size);
    }

    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        return Container(
          width: size.width,
          height: size.height,
          alignment: Alignment.center,
          child: _videoViewStack(size),
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _joinChannel,
                    child: Text('Join channel'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _leaveChannel,
                    child: Text('Leave channel'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
