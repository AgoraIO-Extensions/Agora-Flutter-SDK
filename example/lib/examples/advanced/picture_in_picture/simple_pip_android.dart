// ignore_for_file: avoid_print

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:flutter/material.dart';

///=============================================
/// PictureInPicture Example
class PictureInPicture extends StatefulWidget {
  /// Construct the [PictureInPicture]
  const PictureInPicture({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PictureInPicture> with WidgetsBindingObserver {
  late final RtcEngine _engine;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  late TextEditingController _channelIdController;

  bool _isJoined = false;
  bool _isInPipMode = false;
  bool? _isPipSupported;
  int _remoteUid = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _channelIdController = TextEditingController(text: config.channelId);

    _initEngine();
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print("enter inactive");
      // autoEnterPip take effect on android for now, so we need to call startPip here
      // Note: startPip is not allowed in state 'paused', which is same as on iOS
      await _engine.startPip();
    } else if (state == AppLifecycleState.resumed) {
      print("enter foreground");
    }
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    var activityHandle = await _engine.getCurrentActivityHandle();
    if (activityHandle != 0) {
      await _engine.setupPip(PipOptions(
        contentSource: activityHandle,
        contentWidth: 400,
        contentHeight: 400,
        // autoEnterPip: true, // no effect on android
      ));
    } else {
      print('activityHandle is 0, can not enter pip mode');
    }

    _rtcEngineEventHandler = RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        print('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');

        setState(() {
          _isJoined = true;
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        print(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          _isJoined = false;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        print(
            '[onUserJoined] connection: ${connection.toJson()} rUid: $rUid elapsed: $elapsed');
        setState(() {
          _remoteUid = rUid;
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        print(
            '[onUserOffline] connection: ${connection.toJson()} rUid: $rUid reason: $reason');
        setState(() {
          _remoteUid = 0;
        });
      },
      onPipStateChanged: (state) {
        print('[onPipStateChanged] state: $state');
        var isInPipMode = state == PipState.pipStateStarted;
        setState(() {
          _isInPipMode = isInPipMode;
        });
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();

    _isPipSupported = await _engine.isPipSupported();
    setState(() {});
  }

  Future<void> _joinChannel() async {
    try {
      await _engine.joinChannel(
        token: config.token,
        channelId: _channelIdController.text,
        uid: config.uid,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleAudience,
        ),
      );
    } catch (e) {
      print('joinChannel failed: $e');
    }
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();

    setState(() {
      _remoteUid = 0;
    });
  }

  Widget _videoViewStack(Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_remoteUid != 0)
          SizedBox(
            width: size.width,
            height: size.height,
            child: AgoraVideoView(
              controller: VideoViewController.remote(
                rtcEngine: _engine,
                canvas: VideoCanvas(
                    uid: _remoteUid, renderMode: RenderModeType.renderModeFit),
                connection: RtcConnection(channelId: _channelIdController.text),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isPipSupported == null) {
      return Container();
    }

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
                    onPressed: _isJoined ? _leaveChannel : _joinChannel,
                    child: Text('${_isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _channelIdController,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
          ],
        );
      },
    );
  }
}
