// ignore_for_file: avoid_print

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

      /// Check the definition of `inactive`. Both Android and iOS will trigger `inactive`,
      /// but the scenarios are different. Not all scenarios on iOS allow calling
      /// `startPictureInPicture`, while Android does.
      ///
      /// Currently, setting `autoEnter` on Android is ineffective because the underlying
      /// implementation does not set it. Therefore, it needs to be called manually here.
      
      if (Platform.isAndroid) {
        await _remotePipControllers.entries.first.value.startPictureInPicture();
      }
      
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

      // Only works on iOS
      await _remotePipControllers.entries.first.value.stopPictureInPicture();
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);

    _controller.dispose();
    _contentWidthController.dispose();
    _contentHeightController.dispose();

    _dispose();

    super.dispose();
  }

  Future<void> _dispose() async {
    _localVideoViewPipController.dispose();
    _remotePipControllers.forEach((_, controller) {
      controller.dispose();
    });

    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
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
        await Future.delayed(const Duration(milliseconds: 500));
        await _remotePipControllers.entries.first.value.setupPictureInPicture(
            const PipOptions(
                contentWidth: 150, contentHeight: 300, autoEnterPip: true));
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');

        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
          final remotePipController = _remotePipControllers.remove(rUid);
          if (_isInPipMode && remotePipController?.isInPictureInPictureMode == true) {
            remotePipController!.destroyPictureInPicture();
          }
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
          _remotePipControllers.forEach((key, value) {
            if (value.isInPictureInPictureMode) {
              value.destroyPictureInPicture();
            }
          });
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
        
        setState(() {
          _isInPipMode = state == PipState.pipStateStarted;
        });
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    await _engine.startPreview();

    _isPipSupported = await _localVideoViewPipController.isPipSupported();
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
    if (Platform.isIOS) {
      await _engine.stopPip();
    }
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

                    _localVideoViewPipController.setupPictureInPicture(PipOptions(
                        // On Android, the `contentWidth` and `contentHeight` are used to calculate the aspect ratio,
                        // not the actual dimensions of the Picture-in-Picture window.
                        // For more details, see:
                        // https://developer.android.com/reference/android/app/PictureInPictureParams.Builder#setAspectRatio(android.util.Rational)
                        contentWidth: contentWidth,
                        contentHeight: contentHeight,
                        autoEnterPip: true));
                    _localVideoViewPipController.startPictureInPicture();
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
                      ),
                      if (!kIsWeb &&
                          defaultTargetPlatform == TargetPlatform.iOS)
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: ElevatedButton(
                              onPressed: () {
                                entry.value.setupPictureInPicture(
                                    const PipOptions(
                                        contentWidth: 150,
                                        contentHeight: 300,
                                        autoEnterPip: true));
                                entry.value.startPictureInPicture();
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
    if (_isInPipMode &&
        (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)) {
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
