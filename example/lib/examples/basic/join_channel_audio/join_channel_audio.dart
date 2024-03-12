import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:agora_rtc_engine_example/components/log_sink.dart';

/// JoinChannelAudio Example
class JoinChannelAudio extends StatefulWidget {
  /// Construct the [JoinChannelAudio]
  const JoinChannelAudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelAudio> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  final String _selectedUid = '';
  bool isJoined = false,
      openMicrophone = true,
      muteMicrophone = false,
      muteAllRemoteAudio = false,
      enableSpeakerphone = true,
      playEffect = false;
  bool _enableInEarMonitoring = false;
  double _recordingVolume = 100,
      _playbackVolume = 100,
      _inEarMonitoringVolume = 100;
  late TextEditingController _controller;
  late final TextEditingController _selectedUidController;
  ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _selectedUidController = TextEditingController(text: _selectedUid);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
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
      onRemoteAudioStateChanged: (RtcConnection connection, int remoteUid,
          RemoteAudioState state, RemoteAudioStateReason reason, int elapsed) {
        logSink.log(
            '[onRemoteAudioStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableAudio();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    await _engine.joinChannel(
        token: config.token,
        channelId: _controller.text,
        uid: config.uid,
        options: ChannelMediaOptions(
          channelProfile: _channelProfileType,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ));
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
    setState(() {
      isJoined = false;
      openMicrophone = true;
      muteMicrophone = false;
      muteAllRemoteAudio = false;
      enableSpeakerphone = true;
      playEffect = false;
      _enableInEarMonitoring = false;
      _recordingVolume = 100;
      _playbackVolume = 100;
      _inEarMonitoringVolume = 100;
    });
  }

  _switchMicrophone() async {
    // await await _engine.muteLocalAudioStream(!openMicrophone);
    await _engine.enableLocalAudio(!openMicrophone);
    setState(() {
      openMicrophone = !openMicrophone;
    });
  }

  _muteLocalAudioStream() async {
    await _engine.muteLocalAudioStream(!muteMicrophone);
    setState(() {
      muteMicrophone = !muteMicrophone;
    });
  }

  _muteAllRemoteAudioStreams() async {
    await _engine.muteAllRemoteAudioStreams(!muteAllRemoteAudio);
    setState(() {
      muteAllRemoteAudio = !muteAllRemoteAudio;
    });
  }

  _switchSpeakerphone() async {
    await _engine.setEnableSpeakerphone(!enableSpeakerphone);
    setState(() {
      enableSpeakerphone = !enableSpeakerphone;
    });
  }

  _switchEffect() async {
    if (playEffect) {
      await _engine.stopEffect(1);
      setState(() {
        playEffect = false;
      });
    } else {
      final path =
          (await _engine.getAssetAbsolutePath("assets/Sound_Horizon.mp3"))!;
      await _engine.playEffect(
          soundId: 1,
          filePath: path,
          loopCount: 0,
          pitch: 1,
          pan: 1,
          gain: 100,
          publish: true);
      // .then((value) {
      setState(() {
        playEffect = true;
      });
    }
  }

  _onChangeInEarMonitoringVolume(double value) async {
    _inEarMonitoringVolume = value;
    await _engine.setInEarMonitoringVolume(_inEarMonitoringVolume.toInt());
    setState(() {});
  }

  _toggleInEarMonitoring(value) async {
    try {
      await _engine.enableInEarMonitoring(
          enabled: value,
          includeAudioFilters: EarMonitoringFilterType.earMonitoringFilterNone);
      _enableInEarMonitoring = value;
      setState(() {});
    } catch (e) {
      // Do nothing
    }
  }

  @override
  Widget build(BuildContext context) {
    final channelProfileType = [
      ChannelProfileType.channelProfileLiveBroadcasting,
      ChannelProfileType.channelProfileCommunication,
    ];
    final items = channelProfileType
        .map((e) => DropdownMenuItem(
              child: Text(
                e.toString().split('.')[1],
              ),
              value: e,
            ))
        .toList();

    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
            const Text('Channel Profile: '),
            DropdownButton<ChannelProfileType>(
                items: items,
                value: _channelProfileType,
                onChanged: isJoined
                    ? null
                    : (v) async {
                        setState(() {
                          _channelProfileType = v!;
                        });
                      }),
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
            if (kIsWeb) ...[
              TextField(
                controller: _selectedUidController,
                decoration: const InputDecoration(
                    hintText: 'input userID you want to mute/unmute'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _engine.muteRemoteAudioStream(
                      uid: int.tryParse(_selectedUidController.text) ?? -1,
                      mute: true);
                },
                child: Text('mute Remote Audio'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await _engine.muteRemoteAudioStream(
                      uid: int.tryParse(_selectedUidController.text) ?? -1,
                      mute: false);
                },
                child: Text('unmute Remote Audio'),
              ),
            ],
          ],
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (kIsWeb) ...[
                    ElevatedButton(
                      onPressed: _muteLocalAudioStream,
                      child: Text(
                          'Microphone ${muteMicrophone ? 'muted' : 'unmute'}'),
                    ),
                    ElevatedButton(
                      onPressed: _muteAllRemoteAudioStreams,
                      child: Text(
                          'All Remote Microphone ${muteAllRemoteAudio ? 'muted' : 'unmute'}'),
                    ),
                  ],
                  ElevatedButton(
                    onPressed: _switchMicrophone,
                    child: Text('Microphone ${openMicrophone ? 'on' : 'off'}'),
                  ),
                  if (!kIsWeb) ...[
                    ElevatedButton(
                      onPressed: isJoined ? _switchSpeakerphone : null,
                      child: Text(
                          enableSpeakerphone ? 'Speakerphone' : 'Earpiece'),
                    ),
                    if (!kIsWeb)
                      ElevatedButton(
                        onPressed: isJoined ? _switchEffect : null,
                        child: Text('${playEffect ? 'Stop' : 'Play'} effect'),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('RecordingVolume:'),
                        Slider(
                          value: _recordingVolume,
                          min: 0,
                          max: 400,
                          divisions: 5,
                          label: 'RecordingVolume',
                          onChanged: isJoined
                              ? (double value) async {
                                  setState(() {
                                    _recordingVolume = value;
                                  });
                                  await _engine.adjustRecordingSignalVolume(
                                      value.toInt());
                                }
                              : null,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('PlaybackVolume:'),
                        Slider(
                          value: _playbackVolume,
                          min: 0,
                          max: 400,
                          divisions: 5,
                          label: 'PlaybackVolume',
                          onChanged: isJoined
                              ? (double value) async {
                                  setState(() {
                                    _playbackVolume = value;
                                  });
                                  await _engine.adjustPlaybackSignalVolume(
                                      value.toInt());
                                }
                              : null,
                        )
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(mainAxisSize: MainAxisSize.min, children: [
                          const Text('InEar Monitoring Volume:'),
                          Switch(
                            value: _enableInEarMonitoring,
                            onChanged: isJoined ? _toggleInEarMonitoring : null,
                            activeTrackColor: Colors.grey[350],
                            activeColor: Colors.white,
                          )
                        ]),
                        if (_enableInEarMonitoring)
                          SizedBox(
                              width: 300,
                              child: Slider(
                                value: _inEarMonitoringVolume,
                                min: 0,
                                max: 100,
                                divisions: 5,
                                label:
                                    'InEar Monitoring Volume $_inEarMonitoringVolume',
                                onChanged: isJoined
                                    ? _onChangeInEarMonitoringVolume
                                    : null,
                              ))
                      ],
                    ),
                  ],
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            ))
      ],
    );
  }
}
