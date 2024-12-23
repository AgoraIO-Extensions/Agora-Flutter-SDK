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
      await _pipVideoViewController?.stopPictureInPicture();
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
        print("onUserJoined $rUid");
        if (_pipVideoViewController?.canvas.uid == rUid) {
          /// Flutter performs state merging, and the view might be reused, which can prevent the onAgoraVideoViewCreated callback from being triggered.
          /// However, it might have already triggered destroyPip in the background.
          /// Therefore, it is necessary to manually call setupPictureInPicture.
          _pipVideoViewController?.setupPictureInPicture(const PipOptions(
              contentWidth: 150, contentHeight: 300, autoEnterPip: true));
          return;
        }

        var newPipVideoViewController = PIPVideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: rUid),
          connection: RtcConnection(channelId: _channelIdController.text),
        );

        setState(() {
          _pipVideoViewController = newPipVideoViewController;
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        print("onUserOffline $rUid");
        if (_hasVideo) {
          _pipVideoViewController?.destroyPictureInPicture();

          setState(() {
            _hasVideo = false;
          });
        }
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {},
      onRemoteVideoStateChanged:
          (connection, remoteUid, state, reason, elapsed) {
        print("onRemoteVideoStateChanged $remoteUid $state $reason");
        var hasVideo = state == RemoteVideoState.remoteVideoStateStarting ||
            state == RemoteVideoState.remoteVideoStateDecoding;
        var hasVideoStateChanged = _hasVideo != hasVideo;

        if (hasVideoStateChanged && !hasVideo) {
          // Calling stopPictureInPicture to stop PiP mode in the background will not hide the PiP view.
          // _pipVideoViewController?.stopPictureInPicture();
          _pipVideoViewController?.destroyPictureInPicture();
        }

        if (hasVideoStateChanged && hasVideo) {
          /// Calls `setupPictureInPicture` to set up the Picture-in-Picture (PiP) view.
          /// This setup is done in the background and will not display the PiP view.
          /// The purpose is to reset the internal binding between the PiP view and the video stream,
          /// because the SDK does not automatically rebind the video stream to the PiP view when the internal binding is broken.
          ///
          /// Note: Flutter may merge states and reuse views, which prevents the `onAgoraVideoViewCreated` callback from being triggered.
          /// Therefore, it is necessary to manually call `setupPictureInPicture`.
          _pipVideoViewController?.setupPictureInPicture(const PipOptions(
              contentWidth: 150, contentHeight: 300, autoEnterPip: true));
        }

        setState(() {
          _hasVideo = hasVideo;
        });
      },
      onPipStateChanged: (state) {
        print("onPipStateChanged $state");
        if (state == PipState.pipStateFailed) {
          // call setup again will reset the pip state, even you have the same options
          _pipVideoViewController?.setupPictureInPicture(const PipOptions(
              contentWidth: 150, contentHeight: 300, autoEnterPip: true));
        }
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
        // Since the creation timing of AgoraVideoView cannot be controlled and due to the merging of intermediate states,
        // it is necessary to create AgoraVideoView as early as possible to obtain the native view instance and reuse it as much as possible.
        if (_hasVideo && _pipVideoViewController != null)
          AgoraVideoView(
            controller: _pipVideoViewController!,
            onAgoraVideoViewCreated: (viewId) async {
              /// The `autoEnterPip` parameter is crucial.
              ///
              /// If you want to enable Picture-in-Picture (PiP) mode when the app goes to the background,
              /// make sure to set this parameter to `true`. This is because Flutter's background events
              /// and SDK calls are asynchronous, and the timing of these calls can be unreliable.
              /// If you rely on calling the `startPip` method, there is a chance it might fail.
              /// Setting `autoEnterPip` to `true` ensures that PiP mode is automatically entered when the app goes to the background.
              ///
              /// Note that if the `startPip` call fails, there will be a callback. However, Apple does not allow
              /// an app that has already entered the background to call `startPip` again.
              /// Therefore, if the call fails, you cannot re-enter PiP mode without bringing the app back to the foreground.
              ///
              /// If you prefer to control PiP mode manually, such as displaying the PiP window during page transitions within the app,
              /// you can set `autoEnterPip` to either `true` or `false`. In this case, you can manually enable PiP mode by calling `startPip`.
              await _pipVideoViewController?.setupPictureInPicture(
                  const PipOptions(
                      contentWidth: 150,
                      contentHeight: 300,
                      autoEnterPip: true));
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
