import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/agora_rtc_engine_debug.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'remote_media_target.dart';

const _channelId0 = 'channel0';
const _channelId1 = 'channel1';

/// JoinMultipleChannel Example
class JoinMultipleChannel extends StatefulWidget {
  /// Construct the [JoinMultipleChannel]
  const JoinMultipleChannel({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinMultipleChannel> {
  late final RtcEngineEx _engine;
  bool _isReadyPreview = false;
  late RtcConnection _channel0, _channel1;
  String? renderChannelId;
  bool isJoined0 = false, isJoined1 = false;
  List<int> remoteUid0 = [], remoteUid1 = [];
  late final TextEditingController _channel0UidController;
  late final TextEditingController _channel1UidController;
  late final TextEditingController _remoteUidController;
  bool _startDumpVideo = false;
  int _remotePlaybackVolume = 100;
  final Set<String> _mutedLocalAudio = {};
  final Set<String> _mutedRemoteAudio = {};
  final Set<String> _mutedRemoteVideo = {};
  final Set<String> _audioVolumeIndicationEnabled = {};
  String _lastExOperation = 'Not run';
  bool? _lastExOperationSucceeded;

  @override
  void initState() {
    super.initState();
    _channel0UidController = TextEditingController(text: '1000');
    _channel1UidController = TextEditingController(text: '1001');
    _remoteUidController = TextEditingController();
    _initEngine();
  }

  @override
  void dispose() {
    _channel0UidController.dispose();
    _channel1UidController.dispose();
    _remoteUidController.dispose();
    super.dispose();
    _engine.release();
  }

  _initEngine() async {
    _engine = createAgoraRtcEngineEx();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    // Set enableArgusCounters after initialize (since RtcEngineContext is auto-generated)
    _engine.setEnableArgusCounters(true);

    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        if (connection.channelId == _channelId0) {
          setState(() {
            isJoined0 = true;
          });
        } else if (connection.channelId == _channelId1) {
          setState(() {
            isJoined1 = true;
          });
        }
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        if (connection.channelId == _channelId0) {
          setState(() {
            remoteUid0.add(rUid);
          });
        } else if (connection.channelId == _channelId1) {
          setState(() {
            remoteUid1.add(rUid);
          });
        }
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        if (connection.channelId == _channelId0) {
          setState(() {
            remoteUid0.remove(rUid);
            _clearRemoteMediaState(connection, rUid);
          });
        } else if (connection.channelId == _channelId1) {
          setState(() {
            remoteUid1.remove(rUid);
            _clearRemoteMediaState(connection, rUid);
          });
        }
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        if (connection.channelId == _channelId0) {
          setState(() {
            isJoined0 = false;
            remoteUid0.clear();
            _clearConnectionMediaState(connection);
          });
        } else if (connection.channelId == _channelId1) {
          setState(() {
            isJoined1 = false;
            remoteUid1.clear();
            _clearConnectionMediaState(connection);
          });
        }
      },
      onLocalVideoStats: (RtcConnection connection, VideoSourceType sourceType,
          LocalVideoStats stats) {
        logSink.log(
            'onLocalVideoStats: connection: ${connection.toJson()} stats: ${stats.uid}');
      },
      onAudioVolumeIndication: (RtcConnection connection, List speakers,
          int speakerNumber, int totalVolume) {
        logSink.log(
            '[onAudioVolumeIndication] connection: ${connection.toJson()} speakers: $speakerNumber totalVolume: $totalVolume');
      },
    ));

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel0() async {
    final uid = int.tryParse(_channel0UidController.text);
    if (uid == null) return;
    _channel0 = RtcConnection(channelId: _channelId0, localUid: uid);
    await _engine.joinChannelEx(
        token: '',
        connection: _channel0,
        options: const ChannelMediaOptions(
            clientRoleType: ClientRoleType.clientRoleBroadcaster));
  }

  void _joinChannel1() async {
    final uid = int.tryParse(_channel1UidController.text);
    if (uid == null) return;
    _channel1 = RtcConnection(channelId: _channelId1, localUid: uid);
    await _engine.joinChannelEx(
        token: '',
        connection: _channel1,
        options: const ChannelMediaOptions(
            clientRoleType: ClientRoleType.clientRoleBroadcaster));
  }

  _publishChannel0() async {
    if (isJoined1) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel1);
    }

    if (isJoined0) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: true, publishCameraTrack: true),
          connection: _channel0);
    }
  }

  _publishChannel1() async {
    if (isJoined0) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: false, publishCameraTrack: false),
          connection: _channel0);
    }

    if (isJoined1) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishMicrophoneTrack: true, publishCameraTrack: true),
          connection: _channel1);
    }
  }

  _leaveChannel0() async {
    if (isJoined0) {
      await _engine.leaveChannelEx(connection: _channel0);
      await _engine.startPreview();
    }
  }

  _leaveChannel1() async {
    if (isJoined1) {
      await _engine.leaveChannelEx(connection: _channel1);
      await _engine.startPreview();
    }
  }

  RtcConnection? _selectedConnection() {
    if (renderChannelId == _channelId0 && isJoined0) {
      return _channel0;
    }
    if (renderChannelId == _channelId1 && isJoined1) {
      return _channel1;
    }
    return null;
  }

  int? _selectedRemoteUid() {
    return _selectedRemoteTarget()?.remoteUid;
  }

  RemoteMediaTarget? _selectedRemoteTarget() {
    return resolveRemoteMediaTarget(
      renderChannelId: renderChannelId,
      channel0LocalUid: isJoined0 ? _channel0.localUid : null,
      channel1LocalUid: isJoined1 ? _channel1.localUid : null,
      remoteUid0: remoteUid0,
      remoteUid1: remoteUid1,
      remoteUidText: _remoteUidController.text,
    );
  }

  String _remoteMediaKey(RtcConnection connection, int uid) {
    return '${connection.channelId}:${connection.localUid}:$uid';
  }

  String _connectionMediaKey(RtcConnection connection) {
    return '${connection.channelId}:${connection.localUid}';
  }

  void _clearRemoteMediaState(RtcConnection connection, int uid) {
    final key = _remoteMediaKey(connection, uid);
    _mutedRemoteAudio.remove(key);
    _mutedRemoteVideo.remove(key);
  }

  void _clearConnectionMediaState(RtcConnection connection) {
    final prefix = '${_connectionMediaKey(connection)}:';
    _mutedLocalAudio.remove(_connectionMediaKey(connection));
    _audioVolumeIndicationEnabled.remove(_connectionMediaKey(connection));
    _mutedRemoteAudio.removeWhere((key) => key.startsWith(prefix));
    _mutedRemoteVideo.removeWhere((key) => key.startsWith(prefix));
  }

  bool _isSelectedLocalAudioMuted() {
    final connection = _selectedConnection();
    return connection != null &&
        _mutedLocalAudio.contains(_connectionMediaKey(connection));
  }

  bool _isSelectedRemoteAudioMuted() {
    final target = _selectedRemoteTarget();
    return target != null &&
        _mutedRemoteAudio.contains(
            '${target.channelId}:${target.localUid}:${target.remoteUid}');
  }

  bool _isSelectedRemoteVideoMuted() {
    final target = _selectedRemoteTarget();
    return target != null &&
        _mutedRemoteVideo.contains(
            '${target.channelId}:${target.localUid}:${target.remoteUid}');
  }

  Future<bool> _runExOperation({
    required String operation,
    required RtcConnection connection,
    int? remoteUid,
    required Future<void> Function() action,
  }) async {
    final target =
        'channel=${connection.channelId}, localUid=${connection.localUid}'
        '${remoteUid == null ? '' : ', remoteUid=$remoteUid'}';
    try {
      await action();
      if (mounted) {
        setState(() {
          _lastExOperation = 'Succeeded: $operation ($target)';
          _lastExOperationSucceeded = true;
        });
      }
      logSink.log('[Ex] Succeeded: $operation ($target)');
      return true;
    } catch (error) {
      if (mounted) {
        setState(() {
          _lastExOperation = 'Failed: $operation ($target): $error';
          _lastExOperationSucceeded = false;
        });
      }
      logSink.log('[Ex] Failed: $operation ($target): $error');
      return false;
    }
  }

  void _reportExInputError(String message) {
    setState(() {
      _lastExOperation = 'Failed: $message';
      _lastExOperationSucceeded = false;
    });
    logSink.log('[Ex] Failed: $message');
  }

  Future<void> _enableSelectedAudioVolumeIndication() async {
    final connection = _selectedConnection();
    if (connection == null) {
      _reportExInputError(
          'enableAudioVolumeIndicationEx requires a joined rendered channel');
      return;
    }
    final succeeded = await _runExOperation(
      operation: 'enableAudioVolumeIndicationEx',
      connection: connection,
      action: () => _engine.enableAudioVolumeIndicationEx(
        interval: 200,
        smooth: 3,
        reportVad: false,
        connection: connection,
      ),
    );
    if (succeeded && mounted) {
      setState(() {
        _audioVolumeIndicationEnabled.add(_connectionMediaKey(connection));
      });
    }
  }

  Future<void> _toggleSelectedLocalAudio() async {
    final connection = _selectedConnection();
    if (connection == null) {
      _reportExInputError(
          'muteLocalAudioStreamEx requires a joined rendered channel');
      return;
    }
    final key = _connectionMediaKey(connection);
    final mute = !_mutedLocalAudio.contains(key);
    final succeeded = await _runExOperation(
      operation: '${mute ? 'mute' : 'unmute'}LocalAudioStreamEx',
      connection: connection,
      action: () =>
          _engine.muteLocalAudioStreamEx(mute: mute, connection: connection),
    );
    if (succeeded && mounted) {
      setState(() {
        mute ? _mutedLocalAudio.add(key) : _mutedLocalAudio.remove(key);
      });
    }
  }

  Future<void> _setSelectedVideoEncoderConfiguration() async {
    final connection = _selectedConnection();
    if (connection == null) {
      _reportExInputError(
          'setVideoEncoderConfigurationEx requires a joined rendered channel');
      return;
    }
    await _runExOperation(
      operation: 'setVideoEncoderConfigurationEx 640x360/15fps/800kbps',
      connection: connection,
      action: () => _engine.setVideoEncoderConfigurationEx(
        config: const VideoEncoderConfiguration(
          dimensions: VideoDimensions(width: 640, height: 360),
          frameRate: 15,
          bitrate: 800,
        ),
        connection: connection,
      ),
    );
  }

  Future<void> _adjustSelectedRemotePlaybackVolume(int volume) async {
    final connection = _selectedConnection();
    final uid = _selectedRemoteUid();
    if (connection == null || uid == null) {
      _reportExInputError(
          'adjustUserPlaybackSignalVolumeEx requires a rendered channel and active remote uid');
      return;
    }
    final succeeded = await _runExOperation(
      operation: 'adjustUserPlaybackSignalVolumeEx volume=$volume',
      connection: connection,
      remoteUid: uid,
      action: () => _engine.adjustUserPlaybackSignalVolumeEx(
        uid: uid,
        volume: volume,
        connection: connection,
      ),
    );
    if (succeeded && mounted) {
      setState(() {
        _remotePlaybackVolume = volume;
      });
    }
  }

  Future<void> _toggleSelectedRemoteAudio() async {
    final connection = _selectedConnection();
    final uid = _selectedRemoteUid();
    if (connection == null || uid == null) {
      _reportExInputError(
          'muteRemoteAudioStreamEx requires a rendered channel and active remote uid');
      return;
    }
    final key = _remoteMediaKey(connection, uid);
    final mute = !_mutedRemoteAudio.contains(key);
    final succeeded = await _runExOperation(
      operation: '${mute ? 'mute' : 'unmute'}RemoteAudioStreamEx',
      connection: connection,
      remoteUid: uid,
      action: () => _engine.muteRemoteAudioStreamEx(
        uid: uid,
        mute: mute,
        connection: connection,
      ),
    );
    if (succeeded && mounted) {
      setState(() {
        mute ? _mutedRemoteAudio.add(key) : _mutedRemoteAudio.remove(key);
      });
    }
  }

  Future<void> _toggleSelectedRemoteVideo() async {
    final connection = _selectedConnection();
    final uid = _selectedRemoteUid();
    if (connection == null || uid == null) {
      _reportExInputError(
          'muteRemoteVideoStreamEx requires a rendered channel and active remote uid');
      return;
    }
    final key = _remoteMediaKey(connection, uid);
    final mute = !_mutedRemoteVideo.contains(key);
    final succeeded = await _runExOperation(
      operation: '${mute ? 'mute' : 'unmute'}RemoteVideoStreamEx',
      connection: connection,
      remoteUid: uid,
      action: () => _engine.muteRemoteVideoStreamEx(
        uid: uid,
        mute: mute,
        connection: connection,
      ),
    );
    if (succeeded && mounted) {
      setState(() {
        mute ? _mutedRemoteVideo.add(key) : _mutedRemoteVideo.remove(key);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        late RtcConnection connection;
        List<int> remoteUid = [];
        if (renderChannelId == _channelId0) {
          remoteUid = remoteUid0;
          connection = _channel0;
        } else if (renderChannelId == _channelId1) {
          remoteUid = remoteUid1;
          connection = _channel1;
        }

        return Stack(
          children: [
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
                useFlutterTexture: true,
                useAndroidSurfaceView: false,
              ),
              onAgoraVideoViewCreated: (viewId) {
                _engine.startPreview();
              },
            ),
            if (remoteUid.isNotEmpty)
              Align(
                alignment: Alignment.topLeft,
                child: Wrap(
                  children: remoteUid
                      .map(
                        (e) => SizedBox(
                            width: 120,
                            height: 120,
                            child: AgoraVideoView(
                              controller: VideoViewController.remote(
                                rtcEngine: _engine,
                                canvas: VideoCanvas(uid: e),
                                connection: connection,
                                useFlutterTexture: true,
                              ),
                            )),
                      )
                      .toList(),
                ),
              )
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
                    onPressed: _selectedConnection() == null
                        ? null
                        : _enableSelectedAudioVolumeIndication,
                    child: Text(_selectedConnection() != null &&
                            _audioVolumeIndicationEnabled.contains(
                                _connectionMediaKey(_selectedConnection()!))
                        ? 'Ex Audio Volume Enabled'
                        : 'Enable Ex Audio Volume'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedConnection() == null
                        ? null
                        : _toggleSelectedLocalAudio,
                    child: Text(_isSelectedLocalAudioMuted()
                        ? 'Unmute Local Audio Ex'
                        : 'Mute Local Audio Ex'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _selectedConnection() == null
                  ? null
                  : _setSelectedVideoEncoderConfiguration,
              child: const Text('Apply Ex Video 640x360 15fps'),
            ),
            const SizedBox(height: 8),
            Text(
              'Last Ex operation: $_lastExOperation',
              style: TextStyle(
                color: _lastExOperationSucceeded == false
                    ? Colors.red
                    : _lastExOperationSucceeded == true
                        ? Colors.green
                        : null,
              ),
            ),
            const SizedBox(height: 20),
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
            ElevatedButton(
              onPressed: isJoined0 ? _publishChannel0 : null,
              child: const Text('Publish $_channelId0'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: !isJoined0
                  ? null
                  : () {
                      setState(() {
                        renderChannelId = _channelId0;
                      });
                    },
              child: const Text('Render $_channelId0'),
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
              onPressed: !isJoined1
                  ? null
                  : () {
                      setState(() {
                        renderChannelId = _channelId1;
                      });
                    },
              child: const Text('Render $_channelId1'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _remoteUidController,
              decoration: const InputDecoration(
                hintText: 'Remote UID in rendered channel',
              ),
              keyboardType: TextInputType.number,
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Remote playback volume'),
                Expanded(
                  child: Slider(
                    value: _remotePlaybackVolume.toDouble(),
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: '$_remotePlaybackVolume',
                    onChanged: _selectedRemoteUid() == null
                        ? null
                        : (value) =>
                            _adjustSelectedRemotePlaybackVolume(value.toInt()),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedRemoteUid() == null
                        ? null
                        : _toggleSelectedRemoteAudio,
                    child: Text(_isSelectedRemoteAudioMuted()
                        ? 'Unmute Remote Audio'
                        : 'Mute Remote Audio'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _selectedRemoteUid() == null
                        ? null
                        : _toggleSelectedRemoteVideo,
                    child: Text(_isSelectedRemoteVideoMuted()
                        ? 'Unmute Remote Video'
                        : 'Mute Remote Video'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
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
