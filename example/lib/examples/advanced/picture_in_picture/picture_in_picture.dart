// ignore_for_file: avoid_print

import 'dart:ffi';
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

const int kInvalidViewId = 0;

class _State extends State<PictureInPicture> with WidgetsBindingObserver {
  late TextEditingController _channelIdController;
  late TextEditingController _contentWidthController;
  late TextEditingController _contentHeightController;

  bool _isJoined = false;
  bool _isUseFlutterTexture = false;

  bool _isInPipMode = false;
  bool? _isPipSupported;
  bool _isPipAutoEnterSupported = false;
  AppLifecycleState _lastAppLifecycleState = AppLifecycleState.resumed;

  int? _currentPipUid;
  int _localViewId = kInvalidViewId;
  final Map<int, int> _remoteViewIds = {};

  late final RtcEngine _engine;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _channelIdController = TextEditingController(text: config.channelId);
    _contentWidthController = TextEditingController(text: '960');
    _contentHeightController = TextEditingController(text: '540');

    _initEngine();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    logSink.log("[didChangeAppLifecycleState]: $state");

    if (state == AppLifecycleState.inactive) {
      // if you set the root view as the source view, you can call pipStart to enter pip mode on iOS.
      // however, if you call pipSetup after PlatformView is created, it may not work very well, coz
      // the source view need some time to be ready. So the best practice is set the autoEnterEnabled to true if
      // it is supported and call pipStart only in the resumed state.
      if (_lastAppLifecycleState != AppLifecycleState.paused &&
          !_isPipAutoEnterSupported) {
        await _engine.pipStart();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!Platform.isAndroid) {
        // on Android, the pipStop is not supported, the pipStop operation is only bring the activity to background.
        await _engine.pipStop();
      }
    }

    // do not auto enter pip when app recovered from paused state, and the hidden state always
    // triggers before change to the next state on both Android and iOS.
    if (state != AppLifecycleState.hidden && _lastAppLifecycleState != state) {
      setState(() {
        _lastAppLifecycleState = state;
      });
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);

    _channelIdController.dispose();
    _contentWidthController.dispose();
    _contentHeightController.dispose();

    _dispose();

    super.dispose();
  }

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_rtcEngineEventHandler);

    await _engine.unregisterPipStateChangedObserver();
    await _engine.pipDispose();
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _disposePip() async {
    await _engine.pipDispose();
    setState(() {
      _isInPipMode = false;
      _currentPipUid = null;
    });
  }

  Future<void> _setupPip(
      RtcConnection? connection, int? uid, int? viewId) async {
    if (_currentPipUid != uid) {
      // When using Flutter texture, the pip controller uses the root view as its source view,
      // so we only need to update the video stream when the uid changes. However, when
      // not using Flutter texture, we must dispose and re-setup the pip controller on
      // uid changes, since it's bound directly to the platform view.
      if (!_isUseFlutterTexture && _isInPipMode) {
        await _disposePip();
      }

      bool isLocal = uid == config.uid;

      int contentWidth = int.tryParse(_contentWidthController.text) ?? 960;
      int contentHeight = int.tryParse(_contentHeightController.text) ?? 540;
      AgoraPipOptions options = AgoraPipOptions(
        autoEnterEnabled: _isPipAutoEnterSupported,
        // android only
        aspectRatioX: contentWidth,
        aspectRatioY: contentHeight,
        sourceRectHintLeft: 0,
        sourceRectHintTop: 0,
        sourceRectHintRight: 100,
        sourceRectHintBottom: 100,
        // ios only
        preferredContentWidth: contentWidth,
        preferredContentHeight: contentHeight,

        connection: connection,
        videoCanvas: (uid != null && viewId != null)
            ? VideoCanvas(
                // Must set uid to 0 for the local view, otherwise the video will not be displayed.
                uid: isLocal ? 0 : uid!,
                // The view represents the handle of the video view, which is the
                // native view id. Setting it to 0 will use the root view as the
                // source view.
                view: _isUseFlutterTexture ? 0 : viewId!,
                mirrorMode: isLocal
                    ? VideoMirrorModeType.videoMirrorModeEnabled
                    : VideoMirrorModeType.videoMirrorModeDisabled,
                renderMode: RenderModeType.renderModeFit,
                sourceType: isLocal
                    ? VideoSourceType.videoSourceCamera
                    : VideoSourceType.videoSourceRemote,
                // The setupMode is fixed to videoViewSetupAdd in the native side,
                // so there is no need to set it explicitly here, and it will be ignored.
                // If you don't want to display the video when PiP starts,
                // you'll need to hide the video view manually.
                // setupMode: VideoViewSetupMode.videoViewSetupAdd,
              )
            : null,
      );

      logSink.log('[setupPip] options: ${options.toDictionary()}');

      await _engine.pipSetup(options);

      _currentPipUid = uid;

      setState(() {});
    }

    if (!_isInPipMode) {
      await _engine.pipStart();
    }
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();

    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    _rtcEngineEventHandler = RtcEngineEventHandler(
        onError: (ErrorCodeType err, String msg) {
      logSink.log('[onError] err: $err, msg: $msg');
    }, onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
      logSink.log(
          '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
      setState(() {
        _isJoined = true;
      });
    }, onUserJoined: (RtcConnection connection, int rUid, int elapsed) async {
      logSink.log(
          '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
      setState(() {
        // default view id is invalid
        _remoteViewIds[rUid] = kInvalidViewId;
      });
    }, onUserOffline:
            (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
      logSink.log(
          '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');

      _remoteViewIds.remove(rUid);
      if (_isInPipMode && _currentPipUid == rUid) {
        _disposePip();
      }
      setState(() {});
    }, onLeaveChannel: (RtcConnection connection, RtcStats stats) {
      logSink.log(
          '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
      setState(() {
        _isJoined = false;
        _remoteViewIds.clear();

        // only dispose the pip controller when current pip uid is not the local uid
        if (_isInPipMode && _currentPipUid != config.uid) {
          _disposePip();
        }
      });
    }, onRemoteVideoStateChanged: (RtcConnection connection,
            int remoteUid,
            RemoteVideoState state,
            RemoteVideoStateReason reason,
            int elapsed) {
      logSink.log(
          '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
    });

    _engine.registerPipStateChangedObserver(AgoraPipStateChangedObserver(
      onPipStateChanged: (state, error) {
        logSink.log('[onPipStateChanged] state: $state, error: $error');
        setState(() {
          _isInPipMode = state == AgoraPipState.pipStateStarted;
        });

        if (state == AgoraPipState.pipStateFailed) {
          logSink.log('[onPipStateChanged] state: $state, error: $error');
          // if you destroy the source view of pip controller, some error may happen,
          // so we need to dispose the pip controller here.
          _disposePip();
        }
      },
    ));

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    await _engine.startPreview();

    var isPipSupported = await _engine.isPipSupported();
    var isPipAutoEnterSupported = await _engine.isPipAutoEnterSupported();

    // There is no need to set connection and videoCanvas for pipSetup on Android,
    // because the pipSetup will use the root view as the source view.
    if (Platform.isAndroid && isPipSupported) {
      _setupPip(null, null, null);
    }

    setState(() {
      _isPipSupported = isPipSupported;
      _isPipAutoEnterSupported = isPipAutoEnterSupported;
    });
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _channelIdController.text,
      uid: config.uid,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Widget _videoViewStack() {
    return Stack(
      children: [
        Stack(
          children: [
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                useFlutterTexture: _isUseFlutterTexture,
                canvas: VideoCanvas(
                    uid: 0,
                    // Must set setupMode to videoViewSetupAdd when using Flutter texture, otherwise the video will not be displayed.
                    // This is because:
                    // 1. The default setupMode is videoViewSetupReplace in video_view_controller_impl.dart
                    //    when createTextureRender is called
                    // 2. The textureRender will recreate when the app is switched to background
                    // TODO: This behavior may need optimization in the future
                    setupMode: _isUseFlutterTexture
                        ? VideoViewSetupMode.videoViewSetupAdd
                        : null),
              ),
              onAgoraVideoViewCreated: (viewId) {
                _localViewId = viewId;
                _engine.startPreview();
              },
            ),
            if (!_isInPipMode ||
                _lastAppLifecycleState == AppLifecycleState.resumed)
              Positioned(
                right: 0,
                bottom: 0,
                child: ElevatedButton(
                  onPressed: () {
                    _setupPip(null, config.uid, _localViewId);
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
              children: List.of(_remoteViewIds.entries.map(
                (entry) => SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    children: [
                      AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: _engine,
                          useFlutterTexture: _isUseFlutterTexture,
                          canvas: VideoCanvas(
                              uid: entry.key,
                              // Must set setupMode to videoViewSetupAdd when using Flutter texture, otherwise the video will not be displayed.
                              // This has the same reason as the local view above.
                              setupMode: _isUseFlutterTexture
                                  ? VideoViewSetupMode.videoViewSetupAdd
                                  : null),
                          connection: RtcConnection(
                              channelId: _channelIdController.text,
                              localUid: config.uid),
                        ),
                        onAgoraVideoViewCreated: (viewId) {
                          _remoteViewIds[entry.key] = viewId;
                        },
                      ),
                      if (!_isInPipMode ||
                          _lastAppLifecycleState == AppLifecycleState.resumed)
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: ElevatedButton(
                              onPressed: () {
                                _setupPip(
                                    RtcConnection(
                                        channelId: _channelIdController.text,
                                        localUid: config.uid),
                                    entry.key,
                                    _remoteViewIds[entry.key]);
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
            if (!kIsWeb &&
                (defaultTargetPlatform == TargetPlatform.android ||
                    defaultTargetPlatform == TargetPlatform.iOS))
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Rendered by Flutter texture: '),
                      Switch(
                        value: _isUseFlutterTexture,
                        onChanged: _isJoined
                            ? null
                            : (changed) {
                                setState(() {
                                  _isUseFlutterTexture = changed;
                                });
                              },
                      )
                    ],
                  ),
                ],
              ),
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
              controller: _channelIdController,
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
                    onPressed: _isJoined ? _leaveChannel : _joinChannel,
                    child: Text('${_isJoined ? 'Leave' : 'Join'} channel'),
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
