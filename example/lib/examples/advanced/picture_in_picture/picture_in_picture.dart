import 'dart:io';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// PictureInPicture Example
class PictureInPicture extends StatefulWidget {
  /// Construct the [PictureInPicture]
  const PictureInPicture({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PictureInPicture> with WidgetsBindingObserver {
  late final RtcEngine _engine;

  bool isJoined = false;
  bool switchCamera = true;
  bool switchRender = true;
  bool openCamera = true;
  bool muteCamera = false;
  bool muteAllRemoteVideo = false;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  late TextEditingController _contentWidthController;
  late TextEditingController _contentHeightController;

  late final RtcEngineEventHandler _rtcEngineEventHandler;

  late final PIPVideoViewController _localVideoViewPipController;
  final Map<int, PIPVideoViewController> _remotePipControllers = {};

  bool _isInPipMode = false;
  bool? _isPipSupported;
  late PIPVideoViewController? _currentPipController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _controller = TextEditingController(text: config.channelId);
    _contentWidthController = TextEditingController(text: '150');
    _contentHeightController = TextEditingController(text: '300');

    _initEngine();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print("enter inactive");
      if (Platform.isAndroid) {
        await _startPip();
      }
    } else if (state == AppLifecycleState.paused) {
      print("enter background");
      //
      // do not call startPictureInPicture on both Android and iOS, coz the system
      // do not allow to enter pip mode when the app is in background.
      //
      // for iOS, if you want to enter pip mode when the app is in background, you can
      // set the `autoEnterPip` to true when calling `setupPictureInPicture`.
      //
      // for Android, you can call `startPictureInPicture` when the state is `inactive` like above.
      //
    } else if (state == AppLifecycleState.resumed) {
      print("enter foreground");

      // you can call `stopPictureInPicture` when the app is in background, no matter on Android
      // or iOS.
      //
      // on Android, the `stopPictureInPicture` will do nothing, coz the only way to exit pip
      // mode is to resume the app through the system control buttons on PIP view.
      //
      // on iOS, the `stopPictureInPicture` will call system functions to exit pip mode.
      //
      await _stopPip();
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    _controller.dispose();
    _contentWidthController.dispose();
    _contentHeightController.dispose();

    // only do this on iOS just in case, and it's not necessary on Android(no necessary and no effect).
    if (Platform.isIOS) {
      // to make sure the pip will be stopped, set the contentSource to 0 and canvas to null
      // when the app is disposed.
      await _engine.setupPip(const PipOptions(
          contentSource: 0,
          contentWidth: 0,
          contentHeight: 0,
          autoEnterPip: false,
          canvas: null));
    }

    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _setupPip(PIPVideoViewController pipVideoViewController,
      int contentWidth, int contentHeight, bool autoEnterPip) async {
    // there is no need to call destroyPictureInPicture on last PIPVideoViewController,
    // coz setupPictureInPicture will always destroy the internal
    // PIP controller before creating a new one.

    _currentPipController = pipVideoViewController;
    await _currentPipController!.setupPictureInPicture(PipOptions(
        contentWidth: contentWidth,
        contentHeight: contentHeight,
        autoEnterPip: autoEnterPip));

    setState(() {/* do nothing */});
  }

  Future<void> _destroyPip() async {
    if (_currentPipController != null) {
      await _currentPipController!.destroyPictureInPicture();
    }

    _currentPipController = null;

    setState(() {/* do nothing */});
  }

  Future<void> _destroyAndAutoSwitchPipViewIfNeed(
      PIPVideoViewController pipVideoViewController) async {
    if (Platform.isAndroid) {
      // on Android, the PIP mode do not need to create PlatformView, it use current Activity's content view.
      // so threre is no need to switch PIP view.
      return;
    }

    if (_currentPipController == pipVideoViewController) {
      await _destroyPip();

      // always change the pip view to the last remote video view, and current is not in PIP mode.
      // if no remote video view, change the pip view to local video view.
      if (_remotePipControllers.isNotEmpty) {
        _setupPip(_remotePipControllers.values.last, 150, 300, true);
      } else {
        _setupPip(_localVideoViewPipController, 150, 300, true);
      }
    }
  }

  Future<void> _startPip() async {
    if (_currentPipController != null) {
      await _currentPipController!.startPictureInPicture();
    }
  }

  Future<void> _stopPip() async {
    if (_currentPipController != null) {
      await _currentPipController!.stopPictureInPicture();
    }
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    _localVideoViewPipController = PIPVideoViewController(
      rtcEngine: _engine,
      canvas: const VideoCanvas(
          uid: 0, setupMode: VideoViewSetupMode.videoViewSetupAdd),
    );

    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    _rtcEngineEventHandler = RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) async {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        setState(() {
          remoteUid.add(rUid);
          _remotePipControllers.putIfAbsent(
              rUid,
              () => PIPVideoViewController.remote(
                    rtcEngine: _engine,
                    canvas: VideoCanvas(uid: rUid),
                    connection: RtcConnection(channelId: _controller.text),
                  ));
        });

        // do not setup PIP here, coz the platform view may not be ready yet.
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');

        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
          final remotePipController = _remotePipControllers.remove(rUid);
          if (remotePipController != null) {
            _destroyAndAutoSwitchPipViewIfNeed(remotePipController);
          }
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
          _remotePipControllers.clear();
        });
      },
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
          RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
        logSink.log(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
      },
      onPipStateChanged: (state) {
        logSink.log('[onPipStateChanged] state: $state');
        if (state == PipState.pipStateFailed) {
          // try to enter pip mode again if failed with the last PIPVideoViewController.
          _setupPip(_currentPipController!, 150, 300, true);
        }

        setState(() {
          _isInPipMode = state == PipState.pipStateStarted;
        });
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    await _engine.startPreview();

    _isPipSupported = await _localVideoViewPipController.isPipSupported();

    // if the device supports pip and is Android, create a PIPVideoViewController immediately, coz
    // PIP mode on Android do not need to create PlatformView, it use current Activity's content view.
    if (_isPipSupported == true && Platform.isAndroid) {
      _setupPip(
          PIPVideoViewController(
              rtcEngine: _engine, canvas: const VideoCanvas(uid: 0)),
          150,
          300,
          true);
    }

    setState(() {});
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      uid: config.uid,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _destroyPip();
    await _engine.leaveChannel();
    setState(() {
      openCamera = true;
      muteCamera = false;
      muteAllRemoteVideo = false;
    });
  }

  Widget _videoViewStack() {
    return Stack(
      children: [
        Stack(
          children: [
            AgoraVideoView(
              controller: _localVideoViewPipController,
              onAgoraVideoViewCreated: (viewId) {
                _engine.startPreview();

                // setup PIP with local video view by default only when the view is ready and current is not in PIP mode.
                if (!_isInPipMode) {
                  _setupPip(_localVideoViewPipController, 150, 300, true);
                }
              },
            ),
            if (!_isInPipMode)
              Positioned(
                right: 0,
                bottom: 0,
                child: ElevatedButton(
                  onPressed: () {
                    int contentWidth =
                        int.tryParse(_contentWidthController.text) ?? 0;
                    int contentHeight =
                        int.tryParse(_contentHeightController.text) ?? 0;

                    _setupPip(
                        _localVideoViewPipController,
                        // On Android, the `contentWidth` and `contentHeight` are used to calculate the aspect ratio,
                        // not the actual dimensions of the Picture-in-Picture window.
                        // For more details, see:
                        // https://developer.android.com/reference/android/app/PictureInPictureParams.Builder#setAspectRatio(android.util.Rational)
                        contentWidth,
                        contentHeight,
                        true);
                    _startPip();
                  },
                  child: const Text('Enter PIP'),
                ),
              )
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.of(_remotePipControllers.entries.map(
                (entry) => SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      AgoraVideoView(
                        controller: entry.value,
                        onAgoraVideoViewCreated: (viewId) {
                          // always change the pip view to the last remote video view, and current is not in PIP mode.
                          if (!_isInPipMode) {
                            _setupPip(entry.value, 150, 300, true);
                          }
                        },
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: ElevatedButton(
                            onPressed: () {
                              int contentWidth =
                                  int.tryParse(_contentWidthController.text) ??
                                      0;
                              int contentHeight =
                                  int.tryParse(_contentHeightController.text) ??
                                      0;
                              _setupPip(
                                  entry.value,
                                  // On Android, the `contentWidth` and `contentHeight` are used to calculate the aspect ratio,
                                  // not the actual dimensions of the Picture-in-Picture window.
                                  // For more details, see:
                                  // https://developer.android.com/reference/android/app/PictureInPictureParams.Builder#setAspectRatio(android.util.Rational)
                                  contentWidth,
                                  contentHeight,
                                  true);
                              _startPip();
                            },
                            child: const Text('Enter PIP'),
                          )),
                    ],
                  ),
                ),
              )),
            ),
          ),
        )
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

    // We only need to adjust the UI on Android in pip mode.
    if (_isInPipMode && defaultTargetPlatform == TargetPlatform.android) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('contentWidth: '),
                      TextField(
                        controller: _contentWidthController,
                        decoration: const InputDecoration(
                          hintText: 'contentWidth',
                          border: OutlineInputBorder(gapPadding: 0.0),
                          isDense: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('contentHeigth: '),
                      TextField(
                        controller: _contentHeightController,
                        decoration: const InputDecoration(
                          hintText: 'contentHeigth',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: isJoined ? _leaveChannel : _joinChannel,
                    child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
