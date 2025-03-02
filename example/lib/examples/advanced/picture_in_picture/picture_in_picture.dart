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

const int kInvalidViewId = 0;

class _State extends State<PictureInPicture> with WidgetsBindingObserver {
  late TextEditingController _channelIdController;
  late TextEditingController _contentWidthController;
  late TextEditingController _contentHeightController;

  int _contextWidth = 0;
  int _contextHeight = 0;

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

    // Known limitations of Picture-in-Picture (PiP) mode on Android:
    //
    // 1. Cannot differentiate between Recent Apps vs Quick Settings Bar triggers:
    //    Both generate the same window focus change event (false), preventing selective 
    //    PiP activation for Recent Apps only.
    //
    // 2. Recent Apps interaction:
    //    When entering PiP from Recent Apps, the app is removed from recent apps list.
    //    Users must exit PiP before they can force close the app from Recent Apps.
    //
    // 3. PiP activation constraints:
    //    - pipStart() calls are not guaranteed to enter PiP mode
    //    - Most reliable when called during inactive state
    //    - autoEnterEnabled flag alone may not trigger PiP
    //    - Even implementing onUserLeaveHint callback per documentation may not ensure activation
    // 
    // Based on extensive testing, we recommend using the overlay (floating) window when available,
    // as it provides optimal user experience. Picture-in-Picture mode should be used as a fallback
    // option on Android devices where overlay windows are not supported or permitted.

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

    // The AppLifecycleState.hidden state was introduced in Flutter 3.13.0 to handle when
    // the app is temporarily hidden but not paused (e.g. during app switching on iOS).
    // Since this code needs to support Flutter 3.7.0+ for Agora SDK compatibility, we use
    // a switch statement that only handles lifecycle states available in all supported versions.
    // This allows us to safely ignore the hidden state and avoid unintentionally entering PiP
    // mode when the app recovers from being paused.
    // See: https://docs.flutter.dev/release/breaking-changes/add-applifecyclestate-hidden
    switch (state) {
      case AppLifecycleState.resumed:
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (_lastAppLifecycleState != state) {
          setState(() {
            _lastAppLifecycleState = state;
          });
        }
        break;
      default:
        break;
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

  Future<void> _setupAndStartPip(RtcConnection? connection, int? uid,
      int? viewId, Rect? sourceRectHint) async {
    if (_currentPipUid != uid) {
      // Note: no need to call dispose before setup or re-setup no matter you are using
      // Flutter texture or not, the implementation of pip controller in native side will
      // handle it.
      // await _disposePip();

      bool isLocal = uid == config.uid;

      AgoraPipOptions options = AgoraPipOptions(
        autoEnterEnabled: _isPipAutoEnterSupported,
        // android only
        // For optimal PiP display on Android:
        // 1. Set sourceRectHint to match the dimensions of the target video view
        // 2. Set aspectRatio to match the video view's aspect ratio
        // This ensures smooth transitions and proper video positioning in PiP mode
        // See: https://developer.android.com/reference/android/app/PictureInPictureParams.Builder#setSourceRectHint(android.graphics.Rect)
        aspectRatioX: sourceRectHint?.width.toInt() ?? _contextWidth,
        aspectRatioY: sourceRectHint?.height.toInt() ?? _contextHeight,
        sourceRectHintLeft: sourceRectHint?.left.toInt() ?? 0,
        sourceRectHintTop: sourceRectHint?.top.toInt() ?? 0,
        sourceRectHintRight: sourceRectHint?.right.toInt() ?? _contextWidth,
        sourceRectHintBottom: sourceRectHint?.bottom.toInt() ?? _contextHeight,
        // ios only
        preferredContentWidth:
            int.tryParse(_contentWidthController.text) ?? 960,
        preferredContentHeight:
            int.tryParse(_contentHeightController.text) ?? 540,

        connection: connection,
        videoCanvas: (uid != null && viewId != null)
            ? VideoCanvas(
                // Must set uid to 0 for the local view, otherwise the video will not be displayed.
                uid: isLocal ? 0 : uid,
                // The view represents the handle of the video view, which is the
                // native view id. Setting it to 0 will use the root view as the
                // source view.
                view: _isUseFlutterTexture ? 0 : viewId,
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

    // Note: always call pipStart even the autoEnterEnabled is true.
    await _engine.pipStart();
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

    var isPipSupported = await _engine.pipIsSupported();
    var isPipAutoEnterSupported = await _engine.pipIsAutoEnterSupported();

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

  Widget _videoViewCard({
    required bool isLocal,
    int? remoteUid,
    RtcConnection? connection,
    int? viewId,
    double? width,
    double? height,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) => SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            AgoraVideoView(
              controller: isLocal
                  ? VideoViewController(
                      rtcEngine: _engine,
                      useFlutterTexture: _isUseFlutterTexture,
                      canvas: VideoCanvas(
                        uid: 0,
                        setupMode: _isUseFlutterTexture
                            ? VideoViewSetupMode.videoViewSetupAdd
                            : null,
                      ),
                    )
                  : VideoViewController.remote(
                      rtcEngine: _engine,
                      useFlutterTexture: _isUseFlutterTexture,
                      canvas: VideoCanvas(
                        uid: remoteUid,
                        setupMode: _isUseFlutterTexture
                            ? VideoViewSetupMode.videoViewSetupAdd
                            : null,
                      ),
                      connection: connection!,
                    ),
              onAgoraVideoViewCreated: (createdViewId) {
                if (isLocal) {
                  _localViewId = createdViewId;
                  _engine.startPreview();
                } else {
                  _remoteViewIds[remoteUid!] = createdViewId;
                }
              },
            ),
            // No additional overlay needed for Android
            // For iOS, we need to add an overlay on the original video area
            // Ideally we should destroy the VideoViewController, but this is not currently supported
            // Testing shows that a PiP view has minimal performance impact, especially when app is in background
            // So we temporarily use an overlay to indicate this video is in PiP mode
            if (!Platform.isAndroid &&
                _isInPipMode &&
                (isLocal ? 0 : remoteUid) == _currentPipUid)
              Container(
                color: Colors.black,
              ),
            if (!(_isInPipMode))
              Positioned(
                right: 0,
                bottom: 0,
                child: ElevatedButton(
                  onPressed: () {
                    _setupAndStartPip(
                      connection,
                      isLocal ? 0 : remoteUid,
                      isLocal ? _localViewId : _remoteViewIds[remoteUid],
                      context.findRenderObject()?.paintBounds,
                    );
                  },
                  child: const Text('Enter PIP'),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _videoViewStack() {
    return Stack(
      children: [
        _videoViewCard(isLocal: true),
        Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.of(_remoteViewIds.entries.map(
                (entry) => _videoViewCard(
                  isLocal: false,
                  remoteUid: entry.key,
                  connection: RtcConnection(
                    channelId: _channelIdController.text,
                    localUid: config.uid,
                  ),
                  width: 100,
                  height: 100,
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
    _contextWidth = MediaQuery.of(context).size.width.toInt();
    _contextHeight = MediaQuery.of(context).size.height.toInt();

    if (_isPipSupported == null) {
      return Container();
    }

    if (_isPipSupported == false) {
      return const Center(
        child: Text('The picture-in-picture is not supported on this device.'),
      );
    }

    // On Android, we need to adjust the UI layout when in PiP mode.
    // Note: Layout changes during PiP exit may cause visual flickering on Android.
    // This happens because we monitor PiP state using a delayed task(100ms) rather than
    // native state handlers, since Flutter's main activity doesn't forward PiP events.
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
