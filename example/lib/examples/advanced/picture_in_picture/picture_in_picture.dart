// ignore_for_file: avoid_print

import 'dart:io';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// PictureInPicture Example
class PictureInPicture extends StatefulWidget {
  /// Construct the [PictureInPicture]
  const PictureInPicture({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class PIPUser {
  final int uid;
  int viewId;
  bool hasVideo;

  PIPUser({required this.uid, required this.viewId, required this.hasVideo});

  /// if uid and viewId are the same, then the two PIPUser are the same.
  @override
  bool operator ==(Object other) =>
      other is PIPUser && other.uid == uid && other.viewId == viewId;

  @override
  int get hashCode => Object.hash(uid, viewId);
}

class _State extends State<PictureInPicture> with WidgetsBindingObserver {
  late final RtcEngine _engine;

  bool _isJoined = false;
  late TextEditingController _controller;
  late TextEditingController _contentWidthController;
  late TextEditingController _contentHeightController;

  late final RtcEngineEventHandler _rtcEngineEventHandler;
  final Map<int, PIPUser> _pipUsers = {};

  bool _isInPipMode = false;
  bool? _isPipSupported;
  PIPUser? _currentPipUser;

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
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);

    _dispose();

    super.dispose();
  }

  Future<void> _dispose() async {
    _controller.dispose();
    _contentWidthController.dispose();
    _contentHeightController.dispose();

    _pipUsers.clear();

    // just in case, destroy the pip view before dispose
    await _destroyPip(false);

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
      if (Platform.isAndroid) {
        await _startPip();
      }
    } else if (state == AppLifecycleState.paused) {
      print("enter background");
      //
      // do not call startPip on both Android and iOS, coz the system
      // do not allow to enter pip mode when the app is in background.
      //
      // for iOS, if you want to enter pip mode when the app is in background, you can
      // set the `autoEnterPip` to true when calling `setupPictureInPicture`.
      //
      // for Android, you can call `startPip` when the state is `inactive` like above.
      //
    } else if (state == AppLifecycleState.resumed) {
      print("enter foreground");

      // you can call `stopPip` when the app is in background, no matter on Android
      // or iOS.
      //
      // on Android, the `stopPip` will do nothing, coz the only way to exit pip
      // mode is to resume the app through the system control buttons on PIP view.
      //
      // on iOS, the `stopPip` will call system functions to exit pip mode.
      //
      await _stopPip();
    }
  }

  Future<void> _setupPip(PIPUser? pipUser) async {
    if (pipUser == null) {
      print('setupPip, but pipUser is null, return directly.');
      return;
    }

    // On Android, the `contentWidth` and `contentHeight` are used to calculate the aspect ratio,
    // not the actual dimensions of the Picture-in-Picture window.
    //
    // For more details, see:
    // https://developer.android.com/reference/android/app/PictureInPictureParams.Builder#setAspectRatio(android.util.Rational)
    int contentWidth = int.tryParse(_contentWidthController.text) ?? 150;
    int contentHeight = int.tryParse(_contentHeightController.text) ?? 300;
    bool autoEnterPip = true;

    if (Platform.isIOS) {
      // on iOS, call setupPip with different parameters will re-create the pip view.
      // so there is no need to call destroyPip before setupPip.

      if (pipUser.viewId == 0 || pipUser.hasVideo == false) {
        print('setupPip, but pipUser.viewId is 0, return directly.');
        return;
      }

      print(
          'setupPip, call setupPip with pipUser: ${pipUser.uid} viewId: ${pipUser.viewId}');

      await _engine.setupPip(PipOptions(
        contentSource: pipUser.viewId,
        contentWidth: contentWidth,
        contentHeight: contentHeight,
        autoEnterPip: autoEnterPip,
        canvas: VideoCanvas(
            view: pipUser.viewId,
            uid: pipUser.uid,
            renderMode: RenderModeType.renderModeFit),
      ));
    } else if (Platform.isAndroid) {
      var activityHandle = await _engine.getCurrentActivityHandle();
      if (activityHandle == 0) {
        print('setupPip, but activityHandle is 0, return directly.');
        return;
      }

      print('setupPip, call setupPip');

      // on Android, the pip mode do not need to create PlatformView, it use current Activity's content view.
      // so we just call setupPip directly.
      await _engine.setupPip(PipOptions(
        contentSource: activityHandle,
        contentWidth: contentWidth,
        contentHeight: contentHeight,
        autoEnterPip: autoEnterPip,
        canvas: null,
      ));
    }

    setState(() {
      _currentPipUser = pipUser;
    });
  }

  Future<void> _startPip() async {
    print(
        'startPip, current pip user: ${_currentPipUser?.uid} viewId: ${_currentPipUser?.viewId}');

    if (_isInPipMode) {
      print('startPip, but already in pip mode, return directly.');
      return;
    }

    // on Android, the pip mode do not need to create PlatformView, it use current Activity's content view.
    // so we just call startPip directly.
    if (_currentPipUser == null && !Platform.isAndroid) {
      print('startPip, but current pip user is null, return directly.');
      return;
    }

    print('startPip, call startPip');
    await _engine.startPip();
  }

  Future<void> _stopPip() async {
    print(
        'stopPip, current pip user: ${_currentPipUser?.uid} viewId: ${_currentPipUser?.viewId}');
    if (!_isInPipMode) {
      print('stopPip, but not in pip mode, return directly.');
      return;
    }

    print('stopPip, call stopPip');

    try {
      // on Android, the stopPip will do nothing, coz the only way to exit pip
      // mode is to resume the app through the system control buttons on PIP view.
      if (Platform.isIOS) {
        await _engine.stopPip();
      }
    } catch (e) {
      print('stopPip failed: $e');
    }
  }

  // whenever you want to destroy the pip view, you should call this function
  Future<void> _destroyPip(bool upateState) async {
    if (Platform.isAndroid) {
      // on Android, the PIP mode do not need to create PlatformView, it use current Activity's content view.
      // so threre is no need to switch PIP view.
      print('destroyPip, but on Android, return directly.');
      return;
    }

    print('destroyPip, upateState: $upateState');

    // set contentSource and canvas to null to destroy the pip view
    await _engine.setupPip(const PipOptions(
      contentSource: 0,
      contentWidth: 0,
      contentHeight: 0,
      autoEnterPip: false,
      canvas: null,
    ));

    if (upateState) {
      setState(() {
        _currentPipUser = null;
        _isInPipMode = false;
      });
    }
  }

  // call this when user offline or user video state changed to false
  Future<void> _autoSwitchNextPipView() async {
    print('autoSwitchNextPipView, current pip user: ${_currentPipUser?.uid}');

    // if _currentPipUser is not null and is not local user, then we do not need to switch pip view
    if (_currentPipUser != null &&
        _currentPipUser!.uid != 0 &&
        _currentPipUser!.viewId != 0 &&
        _currentPipUser!.hasVideo) {
      print(
          'autoSwitchNextPipView, but _currentPipUser is not null and is not local user, return directly.');
      return;
    }

    // find a user that has video and is not the current pip user.
    // if no such user return the first user, which is the local user.
    var nextPipUser = _pipUsers.values.lastWhere(
        (element) =>
            element.uid != 0 &&
            element.viewId != 0 &&
            element.hasVideo &&
            element != _currentPipUser,
        orElse: () => _pipUsers.values.first);

    if (_currentPipUser != null) {
      print(
          'autoSwitchNextPipView, destroy last pip view ${_currentPipUser?.uid} ${_currentPipUser?.viewId}');
      await _destroyPip(true);
    }

    print(
        'autoSwitchNextPipView, setup pip for next pip user: ${nextPipUser.uid}');
    await _setupPip(nextPipUser);
  }

  // call this when user joined or user video state changed to true
  Future<void> _switchPipViewToIfNeeded(int uid) async {
    // only switch pip view to the specificed user by uid in below cases:
    // 1. _currentPipUser is null
    // 2. _currentPipUser is local user and the specified user is remote user
    if (_currentPipUser == null || (_currentPipUser!.uid == 0 && uid != 0)) {
      print(
          'switchPipViewToIfNeeded, switch to uid: $uid, current pip user: ${_currentPipUser?.uid}');

      // do we realy need to destroy the pip view here?
      if (_currentPipUser != null) {
        await _destroyPip(true);
      }

      await _setupPip(_pipUsers[uid]!);
    } else {
      print(
          'switchPipViewToIfNeeded, no need to switch to uid: $uid, current pip user: ${_currentPipUser?.uid}');
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

        _pipUsers.putIfAbsent(
            0, () => PIPUser(uid: 0, viewId: 0, hasVideo: false));

        _switchPipViewToIfNeeded(0);

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
      onLocalVideoStateChanged: (source, state, reason) {
        print(
            '[onLocalVideoStateChanged] source: $source state: $state reason: $reason');
        bool hasVideo =
            (state != LocalVideoStreamState.localVideoStreamStateStopped &&
                state != LocalVideoStreamState.localVideoStreamStateFailed);
        bool isVideoStateChanged = _pipUsers[0]!.hasVideo != hasVideo;

        if (isVideoStateChanged) {
          _pipUsers[0]!.hasVideo = hasVideo;

          if (hasVideo) {
            _switchPipViewToIfNeeded(0);
          } else {
            _autoSwitchNextPipView();
          }

          setState(() {});
        }
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        print(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');

        _pipUsers.putIfAbsent(
            rUid, () => PIPUser(uid: rUid, viewId: 0, hasVideo: false));

        _switchPipViewToIfNeeded(rUid);

        setState(() {});
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        print(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');

        var pipUser = _pipUsers.remove(rUid);
        if (pipUser != null) {
          _autoSwitchNextPipView();
          setState(() {});
        }
      },
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
          RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
        print(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');

        if (!_pipUsers.containsKey(remoteUid)) {
          return;
        }

        // Check if video state is not stopped or failed, since video can recover from frozen state
        var hasVideo = (state != RemoteVideoState.remoteVideoStateStopped &&
            state != RemoteVideoState.remoteVideoStateFailed);
        var hasVideoStateChanged = _pipUsers[remoteUid]!.hasVideo != hasVideo;

        if (hasVideoStateChanged) {
          _pipUsers[remoteUid]!.hasVideo = hasVideo;

          if (hasVideo) {
            _switchPipViewToIfNeeded(remoteUid);
          } else {
            _autoSwitchNextPipView();
          }

          setState(() {});
        }
      },
      onPipStateChanged: (state) {
        print('[onPipStateChanged] state: $state');
        if (state == PipState.pipStateFailed) {
          var currentPipUser = _currentPipUser;
          if (currentPipUser != null) {
            _destroyPip(true);
            _setupPip(currentPipUser);
          }
        }

        setState(() {
          _isInPipMode = state == PipState.pipStateStarted;
        });
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    await _engine.startPreview();

    _isPipSupported = await _engine.isPipSupported();

    setState(() {});
  }

  Future<void> _joinChannel() async {
    try {
      await _engine.joinChannel(
        token: config.token,
        channelId: _controller.text,
        uid: config.uid,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );
    } catch (e) {
      print('joinChannel failed: $e');
    }
  }

  Future<void> _leaveChannel() async {
    try {
      _pipUsers.clear();

      await _destroyPip(true);
      await _engine.leaveChannel();

      setState(() {});
    } catch (e) {
      print('leaveChannel failed: $e');
    }
  }

  Future<void> _onAgoraVideoViewCreated(int uid, int viewId) async {
    print('onAgoraVideoViewCreated, uid: $uid, viewId: $viewId');

    _pipUsers[uid]!.viewId = viewId;

    await _switchPipViewToIfNeeded(uid);

    setState(() {});
  }

  Future<void> _onAgoraVideoViewDisposing(int uid) async {
    print('onAgoraVideoViewDisposing, uid: $uid');

    if (_pipUsers.containsKey(uid)) {
      _pipUsers[uid]!.viewId = 0;

      setState(() {});
    }
  }

  Future<void> _enterPipButtonOnPressed(int uid) async {
    print('enterPipButtonOnPressed, uid: $uid');
    await _setupPip(_pipUsers[uid]!);
  }

  Widget _videoViewStack() {
    return Stack(
      children: _pipUsers.isEmpty
          ? []
          : [
              Stack(
                children: [
                  AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: const VideoCanvas(
                          uid: 0, renderMode: RenderModeType.renderModeHidden),
                    ),
                    onAgoraVideoViewCreated: (viewId) async {
                      await _onAgoraVideoViewCreated(0, viewId);
                    },
                    onAgoraVideoViewDisposing: (viewId) async {
                      await _onAgoraVideoViewDisposing(0);
                    },
                  ),
                  if (!_isInPipMode &&
                      _pipUsers[0]!.hasVideo &&
                      _currentPipUser == _pipUsers[0])
                    Positioned(
                      right: 0,
                      bottom: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          await _enterPipButtonOnPressed(0);
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
                    children: List.of(_pipUsers.entries.map(
                      (entry) => entry.key == 0
                          ? const SizedBox()
                          : SizedBox(
                              width: 200,
                              height: 200,
                              child: Stack(
                                children: [
                                  AgoraVideoView(
                                    controller: VideoViewController.remote(
                                      rtcEngine: _engine,
                                      canvas: VideoCanvas(
                                          uid: entry.key,
                                          renderMode:
                                              RenderModeType.renderModeFit),
                                      connection: RtcConnection(
                                          channelId: _controller.text),
                                    ),
                                    onAgoraVideoViewCreated: (viewId) async {
                                      _onAgoraVideoViewCreated(
                                          entry.key, viewId);
                                    },
                                    onAgoraVideoViewDisposing: (viewId) async {
                                      _onAgoraVideoViewDisposing(entry.key);
                                    },
                                  ),
                                  if (!_isInPipMode &&
                                      entry.value.hasVideo &&
                                      _currentPipUser != entry.value)
                                    Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            await _enterPipButtonOnPressed(
                                                entry.key);
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
    if (_isInPipMode && Platform.isAndroid) {
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
