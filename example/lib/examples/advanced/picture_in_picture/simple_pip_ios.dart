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

  bool? _isPipSupported;
  bool _isInPipMode = false;

  bool _isJoined = false;
  bool _hasVideo = false;
  int _remoteUid = 0;
  int _remoteVideoViewId = 0;

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

    _dispose();

    super.dispose();
  }

  Future<void> _dispose() async {
    _remoteVideoViewId = 0;
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print("enter inactive");
      // Note: do not call startPip here, it may will trigger error and take no effect
      // coz the system do not allow to call startPip in un-foreground state on ios
    } else if (state == AppLifecycleState.paused) {
      print("enter background");

      // Note: do not call startPip here, it may will trigger error and take no effect
      // coz the system do not allow to call startPip in un-foreground state on ios
    } else if (state == AppLifecycleState.resumed) {
      print("enter foreground");
      await _stopPip();
    }
  }

  // must call this function after the video view is created and the video stream is ready
  Future<void> _setupPip() async {
    if (_remoteVideoViewId == 0 || _remoteUid == 0) {
      print('skip setupPip, viewId: $_remoteVideoViewId, uid: $_remoteUid');
      return;
    }

    print('setupPip with uid: $_remoteUid, viewId: $_remoteVideoViewId');
    await _engine.setupPip(PipOptions(
      contentSource: _remoteVideoViewId,
      contentWidth: 150,
      contentHeight: 300,
      autoEnterPip: true,
      canvas: VideoCanvas(
          view: _remoteVideoViewId,
          uid: _remoteUid,
          renderMode: RenderModeType.renderModeFit),
    ));
  }

  // whenever you want to destroy the pip view, you should call this function
  Future<void> _destroyPip(bool updateState) async {
    print('destroyPip');

    // set contentSource and canvas to null to destroy the pip view
    await _engine.setupPip(const PipOptions(
      contentSource: 0,
      contentWidth: 0,
      contentHeight: 0,
      canvas: null,
    ));

    if (updateState) {
      setState(() {
        _isInPipMode = false;
      });
    }
  }

  // whenever you want to stop the pip view, you should call this function
  Future<void> _stopPip() async {
    if (!_isInPipMode) {
      return;
    }

    print('stopPip');
    await _engine.stopPip();
  }

  Future<void> _onAgoraVideoViewCreated(int viewId) async {
    _remoteVideoViewId = viewId;

    // autoEnterPip is crucial
    // If you want to enable PiP when entering background, set it to true.
    // This is because Flutter background events and SDK calls are asynchronous
    // and the timing is unreliable. Using startPip API directly may fail,
    // so setting autoEnterPip to true is necessary.
    //
    // While failures will trigger callbacks, iOS doesn't allow startPip calls
    // when the app is already in background. If it fails, you cannot re-enable
    // PiP without returning to foreground.
    //
    // For manual control (e.g., showing PiP window during in-app navigation),
    // you can set it to either true or false, then use startPip to manually
    // enable PiP mode.
    //
    // Note: createPlatformView is an asynchronous operation. We cannot guarantee
    // the timing between view creation and video stream binding in the SDK.
    // However, for better PiP experience, we must create platformView as early
    // as possible. As a result, setupPip may fail on iOS when the view is created
    // but the video stream is not ready yet(which need to be optimized).
    //
    // To avoid this issue, we may need to call setupPip again after the video stream is ready.
    try {
      await _setupPip();
    } catch (e) {
      print('setupPip failed: $e');
    }

    setState(() {});
  }

  Future<void> _onAgoraVideoViewDisposing(int viewId) async {
    print('onAgoraVideoViewDisposing viewId: $viewId');

    _destroyPip(false);

    if (_remoteVideoViewId != 0) {
      setState(() {
        _remoteVideoViewId = 0;
      });
    }
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));

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
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid');

        // ignore the event if the uid is not the same as the current remote uid
        if (_remoteUid != 0 && _remoteUid != rUid) {
          return;
        }

        if (_remoteUid == rUid) {
          // Flutter may reuse views due to state merging, which prevents onAgoraVideoViewCreated from triggering
          // However, destroyPip may have been called in the background, so we need to manually call _setupPip
          _setupPip();
        } else {
          setState(() {
            _remoteUid = rUid;
          });
        }
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        print(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');

        // ignore the event if the uid is not the same as the current remote uid
        if (_remoteUid != rUid) {
          return;
        }

        _destroyPip(true);

        setState(() {
          _remoteUid = 0;
          _hasVideo = false;
          _remoteVideoViewId = 0;
        });
      },
      onRemoteVideoStateChanged:
          (connection, remoteUid, state, reason, elapsed) {
        print(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');

        // ignore the event if the uid is not the same as the current remote uid
        if (_remoteUid != remoteUid) {
          return;
        }

        // Check if video state is not stopped or failed, since video can recover from frozen state
        var hasVideo = (state != RemoteVideoState.remoteVideoStateStopped &&
            state != RemoteVideoState.remoteVideoStateFailed);
        var hasVideoStateChanged = _hasVideo != hasVideo;
        if (!hasVideoStateChanged) {
          return;
        }

        if (hasVideoStateChanged && !hasVideo) {
          // should we call destroyPip here?
          _destroyPip(true);
        }

        if (hasVideoStateChanged && hasVideo) {
          // Call setupPictureInPicture to reset the internal binding between the PiP view and video stream
          // Note: Setting up PiP view in background won't display the PiP window
          // This is necessary because:
          // 1. The SDK won't automatically rebind video stream to PiP view when the internal binding is broken
          // 2. Flutter may reuse views due to state merging, which prevents onAgoraVideoViewCreated from triggering
          // Therefore, we need to manually call _setupPip
          _setupPip();
        }

        setState(() {
          _hasVideo = hasVideo;
        });
      },
      onPipStateChanged: (state) {
        print('[onPipStateChanged] state: $state');

        if (state == PipState.pipStateFailed) {
          // call setup again will reset the pip state, even you have the same options
          _setupPip();
        }

        var isPipActive = state == PipState.pipStateStarted;
        if (_isInPipMode != isPipActive) {
          setState(() {
            _isInPipMode = isPipActive;
          });
        }
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
    await _destroyPip(true);
    await _engine.leaveChannel();

    setState(() {
      _remoteUid = 0;
    });
  }

  Widget _videoViewStack(Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Due to inability to control AgoraVideoView creation timing and state merging,
        // we need to create AgoraVideoView as early as possible to get the native view instance and reuse it
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
              onAgoraVideoViewCreated: _onAgoraVideoViewCreated,
              onAgoraVideoViewDisposing: _onAgoraVideoViewDisposing,
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
