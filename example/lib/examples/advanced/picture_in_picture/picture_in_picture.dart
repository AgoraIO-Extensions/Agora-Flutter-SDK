// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/log_sink.dart';

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
  bool _isPipDisposed = true;
  bool? _isPipSupported;
  bool _isPipAutoEnterSupported = false;
  AppLifecycleState _lastAppLifecycleState = AppLifecycleState.resumed;

  double _pipContentRow = 1;
  double _pipContentCol = 0;
  ClientRoleType _clientRoleType = ClientRoleType.clientRoleBroadcaster;

  final Map<int, RtcConnection> _remoteUsers = {};

  late final RtcEngine _engine;
  late final RtcEngineEventHandler _rtcEngineEventHandler;
  late final AgoraPipController _pipController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _channelIdController = TextEditingController(text: config.channelId);

    _initEngine();
    _initContentSizeByPhysicalSize();
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
        await _pipController.pipStart();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (!Platform.isAndroid) {
        // on Android, the pipStop is not supported, the pipStop operation is only bring the activity to background.
        await _pipController.pipStop();
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

    await _pipController.dispose();
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _disposePip() async {
    await _pipController.pipDispose();

    setState(() {
      _isInPipMode = false;
      _isPipDisposed = true;
    });
  }

  Future<void> _initContentSizeByPhysicalSize() async {
    // We highly recommend to set the aspect ratio or preferred width and height based on the screen size,
    // which will make the PiP experience more seamless.

    // Initialize controllers with default values based on platform
    final size = WidgetsBinding.instance.window.physicalSize;
    final scale = WidgetsBinding.instance.window.devicePixelRatio;
    final width = size.width / scale;
    final height = size.height / scale;

    if (Platform.isIOS) {
      _contentWidthController =
          TextEditingController(text: width.toStringAsFixed(0));
      _contentHeightController =
          TextEditingController(text: height.toStringAsFixed(0));
    } else {
      // Find the simplest ratio that matches the aspect ratio
      int gcd(int a, int b) {
        while (b != 0) {
          final t = b;
          b = a % b;
          a = t;
        }
        return a;
      }

      final divisor = gcd(width.toInt(), height.toInt());
      final x = (width / divisor).round();
      final y = (height / divisor).round();

      _contentWidthController = TextEditingController(text: x.toString());
      _contentHeightController = TextEditingController(text: y.toString());
    }
  }

  Future<void> _setupPip() async {
    int contentWidth = int.tryParse(_contentWidthController.text) ?? 960;
    int contentHeight = int.tryParse(_contentHeightController.text) ?? 540;

    AgoraPipOptions options;
    if (Platform.isAndroid) {
      options = AgoraPipOptions(
        // Setting autoEnterEnabled to true enables seamless transition to PiP mode when the app enters background,
        // providing the best user experience recommended by both Android and iOS platforms.
        autoEnterEnabled: _isPipAutoEnterSupported,

        // Keep the aspect ratio same as the video view. The aspectRatioX and aspectRatioY values
        // should match your video dimensions for optimal display. For example, for 1080p video,
        // use 16:9 ratio (1920:1080 simplified to 16:9).
        aspectRatioX: contentWidth,
        aspectRatioY: contentHeight,

        // According to https://developer.android.com/develop/ui/views/picture-in-picture#set-sourcerecthint
        // The sourceRectHint defines the initial position and size of the PiP window during the transition animation.
        // Setting proper values helps create a smooth animation from your video view to the PiP window.
        // If not set correctly, the system may apply a default content overlay, resulting in a jarring transition.
        sourceRectHintLeft: 0,
        sourceRectHintTop: 0,
        sourceRectHintRight: 0,
        sourceRectHintBottom: 0,

        // According to https://developer.android.com/develop/ui/views/picture-in-picture#seamless-resizing
        // The seamlessResizeEnabled flag enables smooth resizing of the PiP window.
        // Set this to true for video content to allow continuous playback during resizing.
        // Set this to false for non-video content where seamless resizing isn't needed.
        seamlessResizeEnabled: true,

        // The external state monitor checks the PiP view state at the interval specified by externalStateMonitorInterval (100ms).
        // This is necessary because FlutterActivity does not forward PiP state change events to the Flutter side.
        // Even if your Activity is a subclass of AgoraPIPFlutterActivity, you can still use the external state monitor to track PiP state changes.
        useExternalStateMonitor: false,
        externalStateMonitorInterval: 100,
      );
    } else if (Platform.isIOS) {
      options = AgoraPipOptions(
        // Setting autoEnterEnabled to true enables seamless transition to PiP mode when the app enters background,
        // providing the best user experience recommended by both Android and iOS platforms.
        autoEnterEnabled: _isPipAutoEnterSupported,

        // Use preferredContentWidth and preferredContentHeight to set the size of the PIP window.
        // These values determine the initial dimensions and can be adjusted while PIP is active.
        // For optimal user experience, we recommend matching these dimensions to your video view size.
        // The system may adjust the final window size to maintain system constraints.
        preferredContentWidth: contentWidth,
        preferredContentHeight: contentHeight,

        // The sourceContentView determines the source frame for the PiP animation and restore target.
        // Pass 0 to use the app's root view. For optimal animation, set this to the view containing
        // your video content. The system uses this view for the PiP enter/exit animations and as the
        // restore target when returning to the app or stopping PiP.
        sourceContentView: 0,

        // The contentView determines which view will be displayed in the PIP window.
        // If you pass 0, the PIP controller will automatically manage and display all video streams.
        // If you pass a specific view ID, you become responsible for managing the content shown in the PIP window.
        contentView: 0, // force to use native view

        // The contentViewLayout determines the layout of video streams in the PIP window.
        // You can customize the grid layout by specifying:
        // - padding: Space between the window edge and content (in pixels)
        // - spacing: Space between video streams (in pixels)
        // - row: Number of rows in the grid layout
        // - column: Number of columns in the grid layout
        //
        // The SDK provides a basic grid layout system that arranges video streams in a row x column matrix.
        // For example:
        // - row=2, column=2: Up to 4 video streams in a 2x2 grid
        // - row=1, column=2: Up to 2 video streams side by side
        // - row=2, column=1: Up to 2 video streams stacked vertically
        //
        // Note:
        // - This layout configuration only takes effect when contentView is 0 (using native view)
        // - The grid layout is filled from left-to-right, top-to-bottom
        // - Empty cells will be left blank if there are fewer streams than grid spaces
        // - For custom layouts beyond the grid system, set contentView to your own view ID
        contentViewLayout: AgoraPipContentViewLayout(
          padding: 0,
          spacing: 2,
          row: _pipContentRow.toInt(),
          column: _pipContentCol.toInt(),
        ),

        // The videoStreams array specifies which video streams to display in the PIP window.
        // Each stream can be configured with properties like uid, sourceType, setupMode, and renderMode.
        // Note:
        // - This configuration only takes effect when contentView is set to 0 (native view mode).
        // - The streams will be laid out according to the contentViewLayout grid configuration.
        // - The order of the video streams in the array determines the display order in the PIP window.
        // - The SDK will automatically create and manage native views for each video stream.
        // - The view property in VideoCanvas will be replaced by the SDK-managed native view.
        // - You can customize the rendering of each stream using properties like renderMode and mirrorMode.
        videoStreams: [
          // Only add local video stream if client role is broadcaster
          if (_clientRoleType == ClientRoleType.clientRoleBroadcaster)
            AgoraPipVideoStream(
              connection: RtcConnection(
                channelId: _channelIdController.text,
                localUid: config.uid,
              ),
              canvas: const VideoCanvas(
                uid: 0,
                sourceType: VideoSourceType.videoSourceCamera,
                setupMode: VideoViewSetupMode.videoViewSetupAdd,
                renderMode: RenderModeType.renderModeHidden,
                // you should determine the mirror mode based on your use case, like if you are using the front camera,
                // you should set the mirror mode to enabled otherwise disabled to get better user experience.
                mirrorMode: VideoMirrorModeType.videoMirrorModeEnabled,
              ),
            ),
          // Add all remote video streams
          ..._remoteUsers.entries.map((entry) => AgoraPipVideoStream(
                connection: entry.value,
                canvas: VideoCanvas(
                    uid: entry.key,
                    sourceType: VideoSourceType.videoSourceRemote,
                    setupMode: VideoViewSetupMode.videoViewSetupAdd,
                    renderMode: RenderModeType.renderModeHidden),
              )),
        ],

        // The controlStyle property determines which controls are visible in the PiP window.
        // Available styles:
        // * 0: Show all system controls (default) - includes play/pause, forward/backward, close and restore buttons
        // * 1: Hide forward and backward buttons - shows only play/pause, close and restore buttons
        // * 2: Hide play/pause button and progress bar - shows only close and restore buttons (recommended)
        // * 3: Hide all system controls - no buttons visible, including close and restore
        //
        // Note: For most video conferencing use cases, style 2 is recommended since playback controls
        // are not relevant and may confuse users. The close and restore buttons provide essential
        // window management functionality.
        // Note: We do not handle the event of other controls, so the recommended style is 2 or 3.
        controlStyle: 2, // only show close and restore button
      );
    } else {
      logSink.log('[setupPip] not supported on this platform');
      return;
    }

    logSink.log('[setupPip] options: ${options.toDictionary()}');

    final result = await _pipController.pipSetup(options);
    if (result) {
      setState(() {
        _isPipDisposed = false;
      });
    }
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    _pipController = _engine.createPipController();
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
      _remoteUsers[rUid] = connection;

      if (!_isPipDisposed) {
        _setupPip();
      }
      setState(() {});
    }, onUserOffline:
            (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
      logSink.log(
          '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
      _remoteUsers.remove(rUid);

      if (!_isPipDisposed) {
        _setupPip();
      }

      setState(() {});
    }, onLeaveChannel: (RtcConnection connection, RtcStats stats) {
      logSink.log(
          '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
      _remoteUsers.clear();
      if (!_isPipDisposed) {
        _setupPip();
      }

      setState(() {
        _isJoined = false;
      });
    }, onRemoteVideoStateChanged: (RtcConnection connection,
            int remoteUid,
            RemoteVideoState state,
            RemoteVideoStateReason reason,
            int elapsed) {
      logSink.log(
          '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
    });

    _pipController.registerPipStateChangedObserver(AgoraPipStateChangedObserver(
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

    var isPipSupported = await _pipController.pipIsSupported();
    var isPipAutoEnterSupported =
        await _pipController.pipIsAutoEnterSupported();

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
      options: ChannelMediaOptions(
        clientRoleType: _clientRoleType,
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
                      canvas: const VideoCanvas(
                        uid: 0,
                        setupMode: VideoViewSetupMode.videoViewSetupAdd,
                        sourceType: VideoSourceType.videoSourceCamera,
                      ),
                    )
                  : VideoViewController.remote(
                      rtcEngine: _engine,
                      useFlutterTexture: _isUseFlutterTexture,
                      canvas: VideoCanvas(
                        uid: remoteUid,
                        setupMode: VideoViewSetupMode.videoViewSetupAdd,
                        sourceType: VideoSourceType.videoSourceRemote,
                      ),
                      connection: connection!,
                    ),
              onAgoraVideoViewCreated: (createdViewId) {
                if (isLocal) {
                  _engine.startPreview();
                }
              },
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
              children: List.of(_remoteUsers.entries.map(
                (entry) => _videoViewCard(
                  isLocal: false,
                  remoteUid: entry.key,
                  connection: entry.value,
                  width: 200,
                  height: 200,
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

    // On Android, we need to adjust the UI layout when in PiP mode.
    // Note: Layout changes during PiP exit may cause visual flickering on Android.
    // This happens because we monitor PiP state using a delayed task(100ms) rather than
    // native state handlers, since Flutter's main activity doesn't forward PiP events.
    if (_isInPipMode &&
        (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)) {
      return _videoViewStack();
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Video as background
            Positioned.fill(
              child: _videoViewStack(),
            ),

            // Controls at the bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.black.withOpacity(0.5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // First row: Channel ID + Flutter texture switch + Join/Leave button
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _channelIdController,
                            decoration: const InputDecoration(
                              hintText: 'Channel ID',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                            ),
                          ),
                        ),
                        if (!kIsWeb &&
                            (defaultTargetPlatform == TargetPlatform.android ||
                                defaultTargetPlatform ==
                                    TargetPlatform.iOS)) ...[
                          const SizedBox(width: 4),
                          // Flutter texture switch
                          const Text(
                            'Texture:',
                            style: TextStyle(color: Colors.white),
                          ),
                          Switch(
                            value: _isUseFlutterTexture,
                            onChanged: _isJoined
                                ? null
                                : (changed) {
                                    setState(() {
                                      _isUseFlutterTexture = changed;
                                    });
                                  },
                          ),
                        ],
                        const SizedBox(width: 4),
                        ElevatedButton(
                          onPressed: _isJoined ? _leaveChannel : _joinChannel,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: Text(
                              _isJoined ? 'Leave Channel' : 'Join Channel'),
                        ),
                      ],
                    ),
                    // Second row: Client Role Type
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          'Client Role: ',
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: DropdownButton<ClientRoleType>(
                              value: _clientRoleType,
                              isExpanded: true,
                              underline: Container(),
                              items: [
                                ClientRoleType.clientRoleBroadcaster,
                                ClientRoleType.clientRoleAudience,
                              ].map((role) => DropdownMenuItem(
                                value: role,
                                child: Text(
                                  role.toString().split('.')[1],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              )).toList(),
                              onChanged: _isJoined ? null : (value) {
                                if (value != null) {
                                  setState(() {
                                    _clientRoleType = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Third row: Content size and layout
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        // Content Width
                        Expanded(
                          child: TextField(
                            controller: _contentWidthController,
                            decoration: const InputDecoration(
                              hintText: 'Width',
                              border: OutlineInputBorder(),
                              isDense: true,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        // Content Height
                        Expanded(
                          child: TextField(
                            controller: _contentHeightController,
                            decoration: const InputDecoration(
                              hintText: 'Height',
                              border: OutlineInputBorder(),
                              isDense: true,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                            ),
                          ),
                        ),
                        if (Platform.isIOS) ...[
                          const SizedBox(width: 4),
                        ]
                      ],
                    ),
                    // Fourth row: Row and Column (iOS only)
                    if (Platform.isIOS) ...[
                      const SizedBox(width: 4),
                      Row(
                        children: [
                          Text(
                            'Row: ${_pipContentRow.toInt()}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Slider(
                              value: _pipContentRow,
                              min: 0,
                              max: 10,
                              divisions: 10,
                              label: _pipContentRow.toInt().toString(),
                              onChanged: (value) {
                                setState(() {
                                  _pipContentRow = value;
                                });
                              },
                            ),
                          ),
                          Text(
                            'Column: ${_pipContentCol.toInt()}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Slider(
                              value: _pipContentCol,
                              min: 0,
                              max: 10,
                              divisions: 10,
                              label: _pipContentCol.toInt().toString(),
                              onChanged: (value) {
                                setState(() {
                                  _pipContentCol = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                    // Fifth row: Setup PIP + Start PIP + Stop PIP + Dispose PIP
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: _setupPip,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: const Text('Setup PIP'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _isInPipMode
                              ? _pipController.pipStop
                              : _pipController.pipStart,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: Text(_isInPipMode ? 'Stop PIP' : 'Start PIP'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _disposePip,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                          ),
                          child: const Text('Dispose PIP'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
