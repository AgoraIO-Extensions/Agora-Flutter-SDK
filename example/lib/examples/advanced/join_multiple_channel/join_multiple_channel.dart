import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/agora_rtc_engine_debug.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

const _channelId0 = 'XPZ123';
const _channelId1 = 'channel1';
const _channelId2 = 'XPZ1234';
const _channelId3 = 'XPZ12345';

List<RtcConnection> buildJoinMultipleChannelConnections({
  required int uid0,
  required int uid1,
  required int uid2,
  required int uid3,
}) {
  return [
    RtcConnection(channelId: _channelId0, localUid: uid0),
    RtcConnection(channelId: _channelId1, localUid: uid1),
    RtcConnection(channelId: _channelId2, localUid: uid2),
    RtcConnection(channelId: _channelId3, localUid: uid3),
  ];
}

const ChannelMediaOptions kCustomerAudienceJoinOptions = ChannelMediaOptions(
  clientRoleType: ClientRoleType.clientRoleAudience,
  publishCameraTrack: false,
  publishMicrophoneTrack: false,
  autoSubscribeAudio: true,
  autoSubscribeVideo: true,
  audienceLatencyLevel: AudienceLatencyLevelType.audienceLatencyLevelLowLatency,
);

List<int> buildCustomerAudiencePlayoutDelaySequence() => const [0, 100, 200, 100];

/// Remote user bound to the [connection] from [onUserJoined] (not a shared channel field).
class _RemotePeer {
  const _RemotePeer(this.connection, this.uid);
  final RtcConnection connection;
  final int uid;
}

/// JoinMultipleChannel Example
class JoinMultipleChannel extends StatefulWidget {
  /// Construct the [JoinMultipleChannel]
  const JoinMultipleChannel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinMultipleChannel> with WidgetsBindingObserver {
  late final RtcEngineEx _engine;
  bool _isReady = false;
  bool _customerReproMode = true;
  bool _rebindRemoteViewsOnResume = false;
  int _remoteViewGeneration = 0;
  /// Set in [_joinChannelX] and again in [onJoinChannelSuccess] so UI never reads stale `late` after hot reload.
  RtcConnection? _channel0, _channel1, _channel2, _channel3;
  bool isJoined0 = false,
      isJoined1 = false,
      isJoined2 = false,
      isJoined3 = false;
  List<_RemotePeer> remotePeers0 = [],
      remotePeers1 = [],
      remotePeers2 = [],
      remotePeers3 = [];
  late final TextEditingController _channel0UidController;
  late final TextEditingController _channel1UidController;
  late final TextEditingController _channel2UidController;
  late final TextEditingController _channel3UidController;
  bool _startDumpVideo = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _channel0UidController = TextEditingController(text: '1000');
    _channel1UidController = TextEditingController(text: '1001');
    _channel2UidController = TextEditingController(text: '1002');
    _channel3UidController = TextEditingController(text: '1003');
    _initEngine();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _channel0UidController.dispose();
    _channel1UidController.dispose();
    _channel2UidController.dispose();
    _channel3UidController.dispose();
    _engine.release();
    super.dispose();
  }

  int? _parseConnUid(TextEditingController c) =>
      int.tryParse(c.text.trim());

  /// Routes SDK callbacks to the correct channel.
  ///
  /// 1) Match [RtcConnection.localUid] to the uid used in each Join text field
  ///    (same value passed to [joinChannelEx]) — works even if `_channelX`
  ///    is out of sync after hot reload.
  /// 2) Match stored `_channelX?.localUid`.
  /// 3) Match [RtcConnection.channelId] (trimmed); longer ids before `XPZ1234`
  ///    so `XPZ12345` is not confused with `XPZ1234`.
  int _connectionBucket(RtcConnection connection) {
    final lu = connection.localUid;
    if (lu != null) {
      final u0 = _parseConnUid(_channel0UidController);
      final u1 = _parseConnUid(_channel1UidController);
      final u2 = _parseConnUid(_channel2UidController);
      final u3 = _parseConnUid(_channel3UidController);
      if (u0 != null && lu == u0) return 0;
      if (u1 != null && lu == u1) return 1;
      if (u2 != null && lu == u2) return 2;
      if (u3 != null && lu == u3) return 3;
      if (_channel0?.localUid == lu) return 0;
      if (_channel1?.localUid == lu) return 1;
      if (_channel2?.localUid == lu) return 2;
      if (_channel3?.localUid == lu) return 3;
    }
    final id = connection.channelId?.trim();
    if (id == null || id.isEmpty) return -1;
    if (id == _channelId3) return 3;
    if (id == _channelId2) return 2;
    if (id == _channelId1) return 1;
    if (id == _channelId0) return 0;
    return -1;
  }

  /// Customer repro mode:
  /// keep the device as pure audience, continue rendering multi-remote Flutter
  /// textures, and on resume optionally force remote view rebinding to amplify
  /// texture lifecycle races without introducing publish/role noise.
  Future<void> _applyBackgroundMediaPolicy({required bool toBackground}) async {
    if (!_isReady) return;
    if (toBackground) {
      logSink.log('[lifecycle] paused: pure audience mode keeps remote texture '
          'rendering path active; no publish/role mutation');
    } else {
      logSink.log('[lifecycle] resumed: pure audience mode');
      if (_customerReproMode && _rebindRemoteViewsOnResume) {
        _forceRebindRemoteViews();
      }
    }
  }

  void _forceRebindRemoteViews() {
    logSink.log('[customer-repro] forceRebindRemoteViews generation: '
        '${_remoteViewGeneration + 1}');
    setState(() {
      _remoteViewGeneration++;
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _applyBackgroundMediaPolicy(toBackground: true);
        break;
      case AppLifecycleState.resumed:
        _applyBackgroundMediaPolicy(toBackground: false);
        break;
      default:
        break;
    }
  }

  _initEngine() async {
    _engine = createAgoraRtcEngineEx();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        switch (_connectionBucket(connection)) {
          case 0:
            setState(() {
              _channel0 = connection;
              isJoined0 = true;
            });
            break;
          case 1:
            setState(() {
              _channel1 = connection;
              isJoined1 = true;
            });
            break;
          case 2:
            setState(() {
              _channel2 = connection;
              isJoined2 = true;
            });
            break;
          case 3:
            setState(() {
              _channel3 = connection;
              isJoined3 = true;
            });
            break;
          default:
            logSink.log(
                '[onJoinChannelSuccess] unknown channel bucket for ${connection.toJson()}');
        }
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        final bucket = _connectionBucket(connection);
        if (bucket < 0) {
          logSink.log('[onUserJoined] unmapped bucket for ${connection.toJson()}');
          return;
        }
        setState(() {
          final peer = _RemotePeer(connection, rUid);
          switch (bucket) {
            case 0:
              remotePeers0.add(peer);
              break;
            case 1:
              remotePeers1.add(peer);
              break;
            case 2:
              remotePeers2.add(peer);
              break;
            case 3:
              remotePeers3.add(peer);
              break;
          }
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        final bucket = _connectionBucket(connection);
        if (bucket < 0) return;
        setState(() {
          switch (bucket) {
            case 0:
              remotePeers0.removeWhere((p) => p.uid == rUid);
              break;
            case 1:
              remotePeers1.removeWhere((p) => p.uid == rUid);
              break;
            case 2:
              remotePeers2.removeWhere((p) => p.uid == rUid);
              break;
            case 3:
              remotePeers3.removeWhere((p) => p.uid == rUid);
              break;
          }
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        switch (_connectionBucket(connection)) {
          case 0:
            setState(() {
              isJoined0 = false;
              remotePeers0.clear();
              _channel0 = null;
            });
            break;
          case 1:
            setState(() {
              isJoined1 = false;
              remotePeers1.clear();
              _channel1 = null;
            });
            break;
          case 2:
            setState(() {
              isJoined2 = false;
              remotePeers2.clear();
              _channel2 = null;
            });
            break;
          case 3:
            setState(() {
              isJoined3 = false;
              remotePeers3.clear();
              _channel3 = null;
            });
            break;
          default:
            logSink.log(
                '[onLeaveChannel] unknown bucket for ${connection.toJson()}');
        }
      },
    ));

    await _engine.enableVideo();

    setState(() {
      _isReady = true;
    });
    final params = <String, dynamic>{
      'che.video.videoCodecIndex': 1,
      'engine.video.enable_hw_decoder': true,
      'rtc.video.enable_pvc': false,
      'rtc.video.enable_sr': <String, dynamic>{
        'enabled': false,
        'mode': 2,
      },
      'che.audio.sf.enabled': false,
      'che.audio.md.enable': false,
      'che.audio.agc.enable': false,
      'che.audio.ans.enable': true,
      'che.audio.use_media_volume_in_solo': 0,
      // Interactive audience playout floor delay (ms); common values 0 / 100 / 200.
      'rtc.video.interactive_audience_playout_delay_min': 100,
    };

    final json = jsonEncode(params);
    await _engine.setParameters(json);
    logSink.log('[JoinChannelVideo] setParameters: $json');
  }

  Future<void> _joinSingleChannel({
    required int bucket,
    required String channelId,
    required TextEditingController controller,
  }) async {
    final uid = int.tryParse(controller.text);
    if (uid == null) return;
    final connection = RtcConnection(channelId: channelId, localUid: uid);
    switch (bucket) {
      case 0:
        _channel0 = connection;
        break;
      case 1:
        _channel1 = connection;
        break;
      case 2:
        _channel2 = connection;
        break;
      case 3:
        _channel3 = connection;
        break;
    }
    await _engine.joinChannelEx(
      token: '',
      connection: connection,
      options: kCustomerAudienceJoinOptions,
    );
  }

  Future<void> _joinChannel0() async {
    await _joinSingleChannel(
      bucket: 0,
      channelId: _channelId0,
      controller: _channel0UidController,
    );
  }

  Future<void> _joinChannel1() async {
    await _joinSingleChannel(
      bucket: 1,
      channelId: _channelId1,
      controller: _channel1UidController,
    );
  }

  Future<void> _joinChannel2() async {
    await _joinSingleChannel(
      bucket: 2,
      channelId: _channelId2,
      controller: _channel2UidController,
    );
  }

  Future<void> _joinChannel3() async {
    await _joinSingleChannel(
      bucket: 3,
      channelId: _channelId3,
      controller: _channel3UidController,
    );
  }

  Future<void> _runCustomerAudienceJoinAll() async {
    logSink.log('[customer-repro] joining all channels as pure audience');
    await _joinChannel0();
    await _joinChannel1();
    await _joinChannel2();
    await _joinChannel3();
  }

  Future<void> _toggleAudiencePlayoutDelay() async {
    for (final value in buildCustomerAudiencePlayoutDelaySequence()) {
      final json = jsonEncode(
        <String, dynamic>{'rtc.video.interactive_audience_playout_delay_min': value},
      );
      await _engine.setParameters(json);
      logSink.log('[customer-repro] setParameters: $json');
    }
  }

  Future<void> _runCustomerReproScript() async {
    await _runCustomerAudienceJoinAll();
    await _toggleAudiencePlayoutDelay();
    if (_rebindRemoteViewsOnResume) {
      _forceRebindRemoteViews();
    }
  }

  Future<void> _leaveAllChannels() async {
    await _leaveChannel0();
    await _leaveChannel1();
    await _leaveChannel2();
    await _leaveChannel3();
  }

  _publishChannel0() async {
    if (isJoined1 && _channel1 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel1!);
    }
    if (isJoined2 && _channel2 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel2!);
    }
    if (isJoined3 && _channel3 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel3!);
    }

    if (isJoined0 && _channel0 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: true, publishCameraTrack: true),
          connection: _channel0!);
    }
  }

  _publishChannel1() async {
    if (isJoined0 && _channel0 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel0!);
    }
    if (isJoined2 && _channel2 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel2!);
    }
    if (isJoined3 && _channel3 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel3!);
    }

    if (isJoined1 && _channel1 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: true, publishCameraTrack: true),
          connection: _channel1!);
    }
  }

  _publishChannel2() async {
    if (isJoined0 && _channel0 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel0!);
    }
    if (isJoined1 && _channel1 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel1!);
    }
    if (isJoined3 && _channel3 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel3!);
    }

    if (isJoined2 && _channel2 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: true, publishCameraTrack: true),
          connection: _channel2!);
    }
  }

  _publishChannel3() async {
    if (isJoined0 && _channel0 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel0!);
    }
    if (isJoined1 && _channel1 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel1!);
    }
    if (isJoined2 && _channel2 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel2!);
    }

    if (isJoined3 && _channel3 != null) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: true, publishCameraTrack: true),
          connection: _channel3!);
    }
  }

  _leaveChannel0() async {
    final conn = _channel0;
    if (isJoined0 && conn != null) {
      await _engine.leaveChannelEx(connection: conn);
    }
  }

  _leaveChannel1() async {
    final conn = _channel1;
    if (isJoined1 && conn != null) {
      await _engine.leaveChannelEx(connection: conn);
    }
  }

  _leaveChannel2() async {
    final conn = _channel2;
    if (isJoined2 && conn != null) {
      await _engine.leaveChannelEx(connection: conn);
    }
  }

  _leaveChannel3() async {
    final conn = _channel3;
    if (isJoined3 && conn != null) {
      await _engine.leaveChannelEx(connection: conn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReady) return Container();

        return Stack(
          children: [
            if (remotePeers0.isNotEmpty)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _channelId0,
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.of(remotePeers0.map(
                            (peer) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: AgoraVideoView(
                                  key: ValueKey(
                                      '${peer.connection.channelId}_${peer.connection.localUid}_${peer.uid}_${_remoteViewGeneration}'),
                                  controller: VideoViewController.remote(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: peer.uid),
                                    connection: peer.connection,
                                    useFlutterTexture: true,
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (remotePeers1.isNotEmpty)
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _channelId1,
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.of(remotePeers1.map(
                            (peer) => Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: AgoraVideoView(
                                  key: ValueKey(
                                      '${peer.connection.channelId}_${peer.connection.localUid}_${peer.uid}_${_remoteViewGeneration}'),
                                  controller: VideoViewController.remote(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: peer.uid),
                                    connection: peer.connection,
                                    useFlutterTexture: true,
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (remotePeers2.isNotEmpty)
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _channelId2,
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.of(remotePeers2.map(
                            (peer) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: AgoraVideoView(
                                  key: ValueKey(
                                      '${peer.connection.channelId}_${peer.connection.localUid}_${peer.uid}_${_remoteViewGeneration}'),
                                  controller: VideoViewController.remote(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: peer.uid),
                                    connection: peer.connection,
                                    useFlutterTexture: true,
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (remotePeers3.isNotEmpty)
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 150,left: 8,right: 8,bottom: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _channelId3,
                        style: const TextStyle(
                          color: Colors.white,
                          shadows: [
                            Shadow(blurRadius: 4, color: Colors.black54),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.of(remotePeers3.map(
                            (peer) => Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: SizedBox(
                                width: 120,
                                height: 120,
                                child: AgoraVideoView(
                                  key: ValueKey(
                                      '${peer.connection.channelId}_${peer.connection.localUid}_${peer.uid}_${_remoteViewGeneration}'),
                                  controller: VideoViewController.remote(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: peer.uid),
                                    connection: peer.connection,
                                    useFlutterTexture: true,
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _runCustomerReproScript,
                    child: const Text('Run Customer Audience Repro'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _runCustomerAudienceJoinAll,
                    child: const Text('Join All Audience'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _leaveAllChannels,
                    child: const Text('Leave All'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _forceRebindRemoteViews,
                    child: const Text('Rebind Remote Views'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Customer repro assumptions: pure audience only, multi-remote FlutterTexture rendering, no role/publish switching.',
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text('Rebind remote views on resume'),
                ),
                Switch(
                  value: _rebindRemoteViewsOnResume,
                  onChanged: (value) {
                    setState(() {
                      _rebindRemoteViewsOnResume = value;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _channel0UidController,
              decoration: const InputDecoration(
                hintText: 'Enter channel0 uid',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isJoined0) {
                        _leaveChannel0();
                      } else {
                        _joinChannel0();
                      }
                    },
                    child: Text('${isJoined0 ? 'Leave' : 'Join'} $_channelId0'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _channel1UidController,
              decoration: const InputDecoration(
                hintText: 'Enter channel1 uid',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isJoined1) {
                        _leaveChannel1();
                      } else {
                        _joinChannel1();
                      }
                    },
                    child: Text('${isJoined1 ? 'Leave' : 'Join'} $_channelId1'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _channel2UidController,
              decoration: const InputDecoration(
                hintText: 'Enter channel2 (XPZ1234) uid',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isJoined2) {
                        _leaveChannel2();
                      } else {
                        _joinChannel2();
                      }
                    },
                    child: Text('${isJoined2 ? 'Leave' : 'Join'} $_channelId2'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _channel3UidController,
              decoration: const InputDecoration(
                hintText: 'Enter channel3 (XPZ12345) uid',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isJoined3) {
                        _leaveChannel3();
                      } else {
                        _joinChannel3();
                      }
                    },
                    child: Text('${isJoined3 ? 'Leave' : 'Join'} $_channelId3'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (!_customerReproMode) ...[
              ElevatedButton(
                onPressed: isJoined0 ? _publishChannel0 : null,
                child: const Text('Publish $_channelId0'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: isJoined1 ? _publishChannel1 : null,
                child: const Text('Publish $_channelId1'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: isJoined2 ? _publishChannel2 : null,
                child: const Text('Publish $_channelId2'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: isJoined3 ? _publishChannel3 : null,
                child: const Text('Publish $_channelId3'),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
            if (defaultTargetPlatform == TargetPlatform.windows)
              ElevatedButton(
                onPressed: () async {
                  _startDumpVideo = !_startDumpVideo;

                  Directory appDocDir =
                      await getApplicationDocumentsDirectory();

                  if (_startDumpVideo) {
                    _engine.startDumpVideo(
                      VideoSourceType.videoSourceCamera.value(),
                      appDocDir.absolute.path,
                    );
                    logSink.log(
                        'Video data has dump to ${appDocDir.absolute.path}');
                  } else {
                    _engine.stopDumpVideo();
                  }

                  setState(() {});
                },
                child: Text('${_startDumpVideo ? 'Stop' : 'Start'} dump video'),
              ),
          ],
        );
      },
    );
  }
}
