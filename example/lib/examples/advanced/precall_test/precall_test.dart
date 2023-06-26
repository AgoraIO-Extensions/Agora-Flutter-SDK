import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// PreCallTest Example
class PreCallTest extends StatefulWidget {
  /// Construct the [PreCallTest]
  const PreCallTest({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PreCallTest> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  String channelId = config.channelId;
  bool isJoined = false;
  List<int> remoteUid = [];
  // List<VideoDeviceInfo> _vidoDevices = [];
  List<AudioDeviceInfo> _audioRecordingDevices = [];
  List<AudioDeviceInfo> _audioPlaybackDevices = [];
  // late final VideoDeviceManager _videoDeviceManager;
  late final AudioDeviceManager _audioDeviceManager;
  late TextEditingController _controller;
  late String _selectedRecordingDeviceId;
  bool _isSetRecordingDeviceEnabled = false;
  late String _selectedPlaybackDeviceId;
  bool _isSetPlaybackDeviceEnabled = false;
  bool _isStartEchoTest = false;
  bool _isStartRecordingDeviceTest = false;
  bool _isStartPlaybackDeviceTest = false;
  bool _isStartAudioDeviceLoopbackTest = false;
  bool _isStartLastmileProbeTest = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _controller.dispose();
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
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
        setState(() {
          isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        setState(() {});
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {});
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      onAudioVolumeIndication: (RtcConnection connection,
          List<AudioVolumeInfo> speakers, int speakerNumber, int totalVolume) {
        logSink.log(
            '[onAudioVolumeIndication] speakers: ${speakers.toString()}, speakerNumber: $speakerNumber, totalVolume: $totalVolume');
      },
      onLastmileProbeResult: (LastmileProbeResult result) {
        logSink.log('[onLastmileProbeResult] result: ${result.toJson()}');
      },
      onLastmileQuality: (QualityType quality) {
        logSink.log('[onLastmileQuality] quality: $quality');
      },
    ));

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _enumerateVideoDevices();

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel() async {
    await _engine.joinChannel(
        token: config.token,
        channelId: channelId,
        uid: config.uid,
        options: const ChannelMediaOptions());
  }

  _leaveChannel() async {
    if (_isStartEchoTest) {
      await _engine.stopEchoTest();
      _isStartEchoTest = false;
    }
    if (_isStartRecordingDeviceTest) {
      await _audioDeviceManager.stopRecordingDeviceTest();
      _isStartRecordingDeviceTest = false;
    }
    if (_isStartPlaybackDeviceTest) {
      await _audioDeviceManager.stopPlaybackDeviceTest();
      _isStartPlaybackDeviceTest = false;
    }
    if (_isStartAudioDeviceLoopbackTest) {
      await _audioDeviceManager.stopAudioDeviceLoopbackTest();
      _isStartAudioDeviceLoopbackTest = false;
    }
    if (_isStartLastmileProbeTest) {
      await _engine.stopLastmileProbeTest();
      _isStartLastmileProbeTest = false;
    }
    await _engine.leaveChannel();
  }

  Future<void> _enumerateVideoDevices() async {
    // _videoDeviceManager = _engine.getVideoDeviceManager();
    _audioDeviceManager = _engine.getAudioDeviceManager();
    _selectedRecordingDeviceId = await _audioDeviceManager.getRecordingDevice();
    debugPrint('_selectedRecordingDeviceId: $_selectedRecordingDeviceId');
    _selectedPlaybackDeviceId = await _audioDeviceManager.getPlaybackDevice();
    debugPrint('_selectedPlaybackDeviceId: $_selectedPlaybackDeviceId');
    // _selectedDeviceId = await _videoDeviceManager.getDevice();
    // final devices = await _videoDeviceManager.enumerateVideoDevices();
    _audioRecordingDevices =
        await _audioDeviceManager.enumerateRecordingDevices();
    debugPrint('_audioRecordingDevices: $_audioRecordingDevices');
    _audioPlaybackDevices =
        await _audioDeviceManager.enumeratePlaybackDevices();
    debugPrint('_audioPlaybackDevices: $_audioPlaybackDevices');
    setState(() {
      // _vidoDevices = devices;
    });
  }

  Widget _devicesDropDown(List<AudioDeviceInfo> devices, String selectedId,
      ValueChanged<String> onChanged) {
    if (devices.isEmpty) return Container();
    final dropDownMenus = <DropdownMenuItem<String>>[];
    for (var v in devices) {
      dropDownMenus.add(DropdownMenuItem(
        child: Text(
          v.deviceName!,
          style: const TextStyle(fontSize: 10),
        ),
        value: v.deviceId,
      ));
    }
    return DropdownButton<String>(
      items: dropDownMenus,
      value: selectedId,
      onChanged: (v) {
        onChanged(v!);
      },
    );
  }

  Future<void> _setRecordingDevice(String deviceId) async {
    await _audioDeviceManager.setRecordingDevice(deviceId);

    setState(() {
      _isSetRecordingDeviceEnabled = false;
    });
    logSink.log('setRecordingDevice deviceId: $deviceId');
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return AgoraVideoView(
          controller: VideoViewController(
            rtcEngine: _engine,
            canvas: const VideoCanvas(uid: 0),
          ),
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
              onChanged: (text) {
                setState(() {
                  channelId = text;
                });
              },
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isJoined
                  ? null
                  : () async {
                      _isStartEchoTest = !_isStartEchoTest;

                      if (_isStartEchoTest) {
                        await _engine.startEchoTest(const EchoTestConfiguration(
                            intervalInSeconds: 10, channelId: 'test'));
                      } else {
                        await _engine.stopEchoTest();
                      }

                      setState(() {});
                    },
              child: Text('${_isStartEchoTest ? 'Stop' : 'Start'} echo test'),
            ),
            const SizedBox(
              height: 20,
            ),
            _devicesDropDown(_audioRecordingDevices, _selectedRecordingDeviceId,
                (v) {
              setState(() {
                _isSetRecordingDeviceEnabled = _selectedRecordingDeviceId != v;
                _selectedRecordingDeviceId = v;
              });
            }),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _isSetRecordingDeviceEnabled
                  ? () {
                      _setRecordingDevice(_selectedRecordingDeviceId);
                    }
                  : null,
              child: const Text('Set recording device'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isJoined
                  ? null
                  : () async {
                      _isStartRecordingDeviceTest =
                          !_isStartRecordingDeviceTest;

                      if (_isStartRecordingDeviceTest) {
                        await _audioDeviceManager
                            .startRecordingDeviceTest(1000);

                        // _videoDeviceManager.startDeviceTest(1000);
                      } else {
                        await _audioDeviceManager.stopRecordingDeviceTest();
                      }

                      setState(() {});
                    },
              child: Text(
                  '${_isStartRecordingDeviceTest ? 'Stop' : 'Start'} recording device test'),
            ),
            const SizedBox(
              height: 20,
            ),
            _devicesDropDown(_audioPlaybackDevices, _selectedPlaybackDeviceId,
                (v) {
              setState(() {
                _isSetPlaybackDeviceEnabled = _selectedPlaybackDeviceId != v;
                _selectedPlaybackDeviceId = v;
              });
            }),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _isSetPlaybackDeviceEnabled
                  ? () async {
                      await _audioDeviceManager
                          .setPlaybackDevice(_selectedPlaybackDeviceId);

                      // _videoDeviceManager.setDevice(deviceId);
                      setState(() {
                        _isSetPlaybackDeviceEnabled = false;
                      });
                      logSink.log(
                          'setPlaybackDevice deviceId: $_selectedPlaybackDeviceId');
                    }
                  : null,
              child: const Text('Set playback device'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isJoined
                  ? null
                  : () async {
                      _isStartPlaybackDeviceTest = !_isStartPlaybackDeviceTest;

                      if (_isStartPlaybackDeviceTest) {
                        Directory appDocDir =
                            await getApplicationDocumentsDirectory();
                        String p = path.join(
                            appDocDir.path, 'Agora.io-Interactions.mp3');

                        final file = File(p);
                        if (!(await file.exists())) {
                          await file.create();
                          ByteData data = await rootBundle.load(
                              "assets/audio_mixing/Agora.io-Interactions.mp3");
                          List<int> bytes = data.buffer.asUint8List(
                              data.offsetInBytes, data.lengthInBytes);
                          await file.writeAsBytes(bytes);
                        }

                        await _audioDeviceManager.startPlaybackDeviceTest(p);
                      } else {
                        await _audioDeviceManager.stopPlaybackDeviceTest();
                      }

                      setState(() {});
                    },
              child: Text(
                  '${_isStartPlaybackDeviceTest ? 'Stop' : 'Start'} playback device test'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isJoined
                  ? null
                  : () async {
                      _isStartAudioDeviceLoopbackTest =
                          !_isStartAudioDeviceLoopbackTest;

                      if (_isStartAudioDeviceLoopbackTest) {
                        await _audioDeviceManager
                            .startAudioDeviceLoopbackTest(1000);
                      } else {
                        await _audioDeviceManager.stopAudioDeviceLoopbackTest();
                      }

                      setState(() {});
                    },
              child: Text(
                  '${_isStartAudioDeviceLoopbackTest ? 'Stop' : 'Start'} audio device loopback test'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isJoined
                  ? null
                  : () async {
                      _isStartLastmileProbeTest = !_isStartLastmileProbeTest;

                      if (_isStartLastmileProbeTest) {
                        LastmileProbeConfig config = const LastmileProbeConfig(
                          probeUplink: true,
                          probeDownlink: true,
                          expectedUplinkBitrate: 100000,
                          expectedDownlinkBitrate: 100000,
                        );
                        await _engine.startLastmileProbeTest(config);
                      } else {
                        await _engine.stopLastmileProbeTest();
                      }

                      setState(() {});
                    },
              child: Text(
                  '${_isStartLastmileProbeTest ? 'Stop' : 'Start'} lastmile probeTest test'),
            ),
          ],
        );
      },
    );
  }
}
