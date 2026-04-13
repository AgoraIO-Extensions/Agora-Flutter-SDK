import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const _channelId0 = 'channel0';
const _channelId1 = 'channel1';

List<RtcConnection> buildPictureInPictureJoinChannelExConnections({
  required int uid0,
  required int uid1,
}) {
  return [
    RtcConnection(channelId: _channelId0, localUid: uid0),
    RtcConnection(channelId: _channelId1, localUid: uid1),
  ];
}

/// Picture-in-picture example using two `joinChannelEx` connections.
class PictureInPictureJoinChannelEx extends StatefulWidget {
  const PictureInPictureJoinChannelEx({Key? key}) : super(key: key);

  @override
  State<PictureInPictureJoinChannelEx> createState() =>
      _PictureInPictureJoinChannelExState();
}

class _PictureInPictureJoinChannelExState
    extends State<PictureInPictureJoinChannelEx> {
  late final TextEditingController _channel0UidController;
  late final TextEditingController _channel1UidController;
  late final TextEditingController _contentWidthController;
  late final TextEditingController _contentHeightController;

  late final RtcEngineEx _engine;
  late final AgoraPipController _pipController;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  final Set<String> _joinedChannelIds = <String>{};
  final Map<String, Set<int>> _remoteUsersByChannel = <String, Set<int>>{};

  RtcConnection? _channel0;
  RtcConnection? _channel1;

  bool _isInPipMode = false;
  bool _isPipDisposed = true;
  bool? _isPipSupported;
  bool _isPipAutoEnterSupported = false;
  bool _isUseFlutterTexture = false;

  double _pipContentRow = 1;
  double _pipContentCol = 1;
  ClientRoleType _clientRoleType = ClientRoleType.clientRoleBroadcaster;

  @override
  void initState() {
    super.initState();
    _channel0UidController = TextEditingController(text: '1000');
    _channel1UidController = TextEditingController(text: '1001');
    _contentWidthController = TextEditingController(text: '16');
    _contentHeightController = TextEditingController(text: '9');
    _initEngine();
  }

  @override
  void dispose() {
    _channel0UidController.dispose();
    _channel1UidController.dispose();
    _contentWidthController.dispose();
    _contentHeightController.dispose();
    super.dispose();
    _dispose();
  }

  bool get _isAnyJoined => _joinedChannelIds.isNotEmpty;

  RtcConnection get _channel0Draft =>
      buildPictureInPictureJoinChannelExConnections(
        uid0: int.tryParse(_channel0UidController.text) ?? 1000,
        uid1: int.tryParse(_channel1UidController.text) ?? 1001,
      )[0];

  RtcConnection get _channel1Draft =>
      buildPictureInPictureJoinChannelExConnections(
        uid0: int.tryParse(_channel0UidController.text) ?? 1000,
        uid1: int.tryParse(_channel1UidController.text) ?? 1001,
      )[1];

  List<RtcConnection> get _activeConnections =>
      [_channel0, _channel1].whereType<RtcConnection>().toList();

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _pipController.dispose();
    for (final connection in _activeConnections) {
      if (_joinedChannelIds.contains(connection.channelId)) {
        await _engine.leaveChannelEx(connection: connection);
      }
    }
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngineEx();
    _pipController = _engine.createPipController();
    await _engine.initialize(RtcEngineContext(appId: config.appId));

    _rtcEngineEventHandler = RtcEngineEventHandler(
      onError: (err, msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (connection, elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        final channelId = connection.channelId;
        if (channelId == null) {
          return;
        }
        setState(() {
          _joinedChannelIds.add(channelId);
        });
      },
      onUserJoined: (connection, remoteUid, elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $remoteUid elapsed: $elapsed');
        final channelId = connection.channelId;
        if (channelId == null) {
          return;
        }
        final remoteUsers =
            _remoteUsersByChannel.putIfAbsent(channelId, () => <int>{});
        remoteUsers.add(remoteUid);
        if (!_isPipDisposed) {
          _setupPip();
        }
        setState(() {});
      },
      onUserOffline: (connection, remoteUid, reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()} remoteUid: $remoteUid reason: $reason');
        final channelId = connection.channelId;
        if (channelId == null) {
          return;
        }
        _remoteUsersByChannel[channelId]?.remove(remoteUid);
        if (!_isPipDisposed) {
          _setupPip();
        }
        setState(() {});
      },
      onLeaveChannel: (connection, stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        final channelId = connection.channelId;
        if (channelId == null) {
          return;
        }
        _remoteUsersByChannel.remove(channelId);
        if (!_isPipDisposed) {
          _setupPip();
        }
        setState(() {
          _joinedChannelIds.remove(channelId);
        });
      },
    );

    await _pipController.registerPipStateChangedObserver(
      AgoraPipStateChangedObserver(
        onPipStateChanged: (state, error) {
          logSink.log('[onPipStateChanged] state: $state, error: $error');
          setState(() {
            _isInPipMode = state == AgoraPipState.pipStateStarted;
          });
          if (state == AgoraPipState.pipStateFailed) {
            _disposePip();
          }
        },
      ),
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    await _engine.startPreview();

    final pipSupported = await _pipController.pipIsSupported();
    final autoEnterSupported = await _pipController.pipIsAutoEnterSupported();
    setState(() {
      _isPipSupported = pipSupported;
      _isPipAutoEnterSupported = autoEnterSupported;
    });
  }

  Future<void> _joinConnection(RtcConnection connection) async {
    await _engine.joinChannelEx(
      token: config.token,
      connection: connection,
      options: ChannelMediaOptions(clientRoleType: _clientRoleType),
    );
  }

  Future<void> _joinChannel0() async {
    final uid = int.tryParse(_channel0UidController.text);
    if (uid == null) {
      return;
    }
    _channel0 = RtcConnection(channelId: _channelId0, localUid: uid);
    await _joinConnection(_channel0!);
  }

  Future<void> _joinChannel1() async {
    final uid = int.tryParse(_channel1UidController.text);
    if (uid == null) {
      return;
    }
    _channel1 = RtcConnection(channelId: _channelId1, localUid: uid);
    await _joinConnection(_channel1!);
  }

  Future<void> _leaveConnection(RtcConnection connection) async {
    if (!_joinedChannelIds.contains(connection.channelId)) {
      return;
    }
    await _engine.leaveChannelEx(connection: connection);
  }

  Future<void> _disposePip() async {
    await _pipController.pipDispose();
    setState(() {
      _isInPipMode = false;
      _isPipDisposed = true;
    });
  }

  Future<void> _setupPip() async {
    final contentWidth = int.tryParse(_contentWidthController.text) ?? 16;
    final contentHeight = int.tryParse(_contentHeightController.text) ?? 9;

    final joinedConnections = _activeConnections
        .where((connection) => _joinedChannelIds.contains(connection.channelId))
        .toList();
    final localConnection = joinedConnections.isNotEmpty
        ? joinedConnections.first
        : (_channel0 ?? _channel0Draft);

    final options = Platform.isAndroid
        ? AgoraPipOptions(
            autoEnterEnabled: _isPipAutoEnterSupported,
            aspectRatioX: contentWidth,
            aspectRatioY: contentHeight,
            seamlessResizeEnabled: true,
            useExternalStateMonitor: false,
            externalStateMonitorInterval: 100,
          )
        : AgoraPipOptions(
            autoEnterEnabled: _isPipAutoEnterSupported,
            preferredContentWidth: contentWidth * 40,
            preferredContentHeight: contentHeight * 40,
            sourceContentView: 0,
            contentView: 0,
            contentViewLayout: AgoraPipContentViewLayout(
              padding: 0,
              spacing: 2,
              row: _pipContentRow.toInt(),
              column: _pipContentCol.toInt(),
            ),
            videoStreams: [
              if (_clientRoleType == ClientRoleType.clientRoleBroadcaster)
                AgoraPipVideoStream(
                  connection: localConnection,
                  canvas: const VideoCanvas(
                    uid: 0,
                    sourceType: VideoSourceType.videoSourceCamera,
                    setupMode: VideoViewSetupMode.videoViewSetupAdd,
                    renderMode: RenderModeType.renderModeHidden,
                    mirrorMode: VideoMirrorModeType.videoMirrorModeEnabled,
                  ),
                ),
              ..._remoteUsersByChannel.entries.expand((entry) {
                final connection = _activeConnections.firstWhere(
                  (item) => item.channelId == entry.key,
                );
                return entry.value.map(
                  (remoteUid) => AgoraPipVideoStream(
                    connection: connection,
                    canvas: VideoCanvas(
                      uid: remoteUid,
                      sourceType: VideoSourceType.videoSourceRemote,
                      setupMode: VideoViewSetupMode.videoViewSetupAdd,
                      renderMode: RenderModeType.renderModeHidden,
                    ),
                  ),
                );
              }),
            ],
            controlStyle: 2,
          );

    final result = await _pipController.pipSetup(options);
    if (result) {
      setState(() {
        _isPipDisposed = false;
      });
    }
  }

  Widget _videoViewCard({
    required bool isLocal,
    int? remoteUid,
    RtcConnection? connection,
    String? label,
    double? width,
    double? height,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: AgoraVideoView(
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
              onAgoraVideoViewCreated: (viewId) {
                if (isLocal) {
                  _engine.startPreview();
                }
              },
            ),
          ),
          if (label != null)
            Positioned(
              left: 4,
              top: 4,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                color: Colors.black54,
                child: Text(
                  label,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _videoViewStack() {
    return Stack(
      children: [
        _videoViewCard(
          isLocal: true,
          label: 'local',
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _remoteUsersByChannel.entries
                  .expand((entry) => entry.value.map((remoteUid) {
                        final connection = _activeConnections.firstWhere(
                          (item) => item.channelId == entry.key,
                        );
                        return _videoViewCard(
                          isLocal: false,
                          remoteUid: remoteUid,
                          connection: connection,
                          label: '${entry.key}:$remoteUid',
                          width: 200,
                          height: 200,
                        );
                      }))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _connectionAction({
    required String title,
    required RtcConnection connection,
    required VoidCallback onJoin,
  }) {
    final joined = _joinedChannelIds.contains(connection.channelId);
    return Row(
      children: [
        Expanded(
          child: Text(
            '$title -> ${connection.channelId} (${connection.localUid})',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        ElevatedButton(
          onPressed: joined ? () => _leaveConnection(connection) : onJoin,
          child: Text(joined ? 'Leave' : 'Join'),
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

    if (_isInPipMode &&
        (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)) {
      return _videoViewStack();
    }

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(child: _videoViewStack()),
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
                    const Text(
                      'Picture-in-picture example using channel0/channel1 with joinChannelEx.',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _channel0UidController,
                            decoration: const InputDecoration(
                              hintText: 'channel0 uid',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: TextField(
                            controller: _channel1UidController,
                            decoration: const InputDecoration(
                              hintText: 'channel1 uid',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(),
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 8,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Text(
                          'Texture:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Switch(
                          value: _isUseFlutterTexture,
                          onChanged: _isAnyJoined
                              ? null
                              : (changed) {
                                  setState(() {
                                    _isUseFlutterTexture = changed;
                                  });
                                },
                        ),
                        const SizedBox(width: 8),
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
                              ]
                                  .map((role) => DropdownMenuItem(
                                        value: role,
                                        child:
                                            Text(role.toString().split('.')[1]),
                                      ))
                                  .toList(),
                              onChanged: _isAnyJoined
                                  ? null
                                  : (value) {
                                      if (value == null) {
                                        return;
                                      }
                                      setState(() {
                                        _clientRoleType = value;
                                      });
                                    },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    _connectionAction(
                      title: 'Connection 0',
                      connection: _channel0 ?? _channel0Draft,
                      onJoin: _joinChannel0,
                    ),
                    const SizedBox(height: 4),
                    _connectionAction(
                      title: 'Connection 1',
                      connection: _channel1 ?? _channel1Draft,
                      onJoin: _joinChannel1,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
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
                      ],
                    ),
                    if (Platform.isIOS) ...[
                      Row(
                        children: [
                          Text(
                            'Row: ${_pipContentRow.toInt()}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Slider(
                              value: _pipContentRow,
                              min: 1,
                              max: 4,
                              divisions: 3,
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
                              min: 1,
                              max: 4,
                              divisions: 3,
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
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ElevatedButton(
                          onPressed: _setupPip,
                          child: const Text('Setup PIP'),
                        ),
                        ElevatedButton(
                          onPressed: _isInPipMode
                              ? _pipController.pipStop
                              : _pipController.pipStart,
                          child: Text(_isInPipMode ? 'Stop PIP' : 'Start PIP'),
                        ),
                        ElevatedButton(
                          onPressed: _disposePip,
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
