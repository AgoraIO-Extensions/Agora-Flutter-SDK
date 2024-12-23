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
  PIPVideoViewController? _pipVideoViewController;

  bool _isInPipMode = false;
  bool _isPipSupported = false;
  bool _hasVideo = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _channelIdController = TextEditingController(text: config.channelId);

    _initEngine();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print("enter inactive");

      /// Check the definition of `inactive`. Both Android and iOS will trigger `inactive`,
      /// but the scenarios are different. Not all scenarios on iOS allow calling
      /// `startPictureInPicture`, while Android does.
      ///
      /// Currently, setting `autoEnter` on Android is ineffective because the underlying
      /// implementation does not set it. Therefore, it needs to be called manually here.

      await _pipVideoViewController?.startPictureInPicture();
    } else if (state == AppLifecycleState.paused) {
      print("enter background");

      /// Important: Do not call `startPictureInPicture` here.
      /// Both iOS and Android systems do not allow starting PiP (Picture-in-Picture) mode in the background.
      /// On Android, it can be called in the inactive state.
      /// Especially on iOS, calling it may trigger related errors causing PiP to reset.
      /// Ensure that the PiP view is created early enough so that when switching to the background,
      /// the PiP view is already created and the system will automatically start PiP.
    } else if (state == AppLifecycleState.resumed) {
      print("enter foreground");
    }
  }

  @override
  Future<void> dispose() async {
    _channelIdController.dispose();
    WidgetsBinding.instance.removeObserver(this);

    _dispose();

    super.dispose();
  }

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    _rtcEngineEventHandler = RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {},
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        print('userJoined: $rUid');
        var newPipVideoViewController = PIPVideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: rUid),
          connection: RtcConnection(channelId: _channelIdController.text),
        );

        setState(() {
          _pipVideoViewController = newPipVideoViewController;
          _pipVideoViewController?.setupPictureInPicture(const PipOptions(
              contentWidth: 150, contentHeight: 300, autoEnterPip: true));
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        print('userOffline: $rUid');
        if (_hasVideo) {
          setState(() {
            _hasVideo = false;
          });
        }
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {},
      onRemoteVideoStateChanged:
          (connection, remoteUid, state, reason, elapsed) {
        print('remoteVideoStateChanged: $remoteUid, $state $reason');
        var hasVideo = state == RemoteVideoState.remoteVideoStateStarting ||
            state == RemoteVideoState.remoteVideoStateDecoding;

        setState(() {
          _hasVideo = hasVideo;
        });
      },
      onPipStateChanged: (state) {
        print('onPipStateChanged: $state');
        var isInPipMode = state == PipState.pipStateStarted;
        if (state == PipState.pipStateFailed) {
          _pipVideoViewController?.setupPictureInPicture(const PipOptions(
              contentWidth: 150, contentHeight: 300, autoEnterPip: true));
        }
        setState(() {
          _isInPipMode = isInPipMode;
        });
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    var isPipSupported = await _engine.isPipSupported();
    setState(() {
      _isPipSupported = isPipSupported;
    });
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _channelIdController.text,
      uid: config.uid,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _pipVideoViewController?.dispose();

    await _engine.leaveChannel();
  }

  Widget _videoViewStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_hasVideo && _pipVideoViewController != null)
          AgoraVideoView(
            controller: _pipVideoViewController!,
            onAgoraVideoViewCreated: (viewId) async {
              // do nothing for android
            },
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

    // only show the video view in pip mode
    if (_isInPipMode) {
      return _videoViewStack();
    }

    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: _videoViewStack()),
            const SizedBox(
              height: 50,
            )
          ],
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
