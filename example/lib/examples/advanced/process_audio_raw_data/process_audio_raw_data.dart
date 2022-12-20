import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// ProcessVideoRawData Example
class ProcessAudioRawData extends StatefulWidget {
  /// Construct the [ProcessAudioRawData]
  const ProcessAudioRawData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ProcessAudioRawData> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  bool _isUseFlutterTexture = false;
  ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;
  late File _audioFile;
  late File _playbackAudioFile;
  late AudioFrameObserver _audioFrameObserver;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);

    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _stopAudioFrameRecord();
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    await _engine.setLogFilter(LogFilterType.logFilterError);

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
        setState(() {
          remoteUid.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));

    await _engine.enableVideo();

    _audioFrameObserver = AudioFrameObserver(
      onRecordAudioFrame: (channelId, audioFrame) async {
        debugPrint(
            '[onRecordAudioFrame] channelId: $channelId, audioFrame: ${audioFrame.toJson()}');
        if (!isJoined) {
          return;
        }
        if (audioFrame.buffer != null) {
          await _audioFile.writeAsBytes(audioFrame.buffer!.toList(),
              mode: FileMode.append, flush: true);
        }
      },
      onPlaybackAudioFrame: (String channelId, AudioFrame audioFrame) async {
        debugPrint(
            '[onPlaybackAudioFrame] channelId: $channelId, audioFrame: ${audioFrame.toJson()}');
        if (!isJoined) {
          return;
        }
        if (audioFrame.buffer != null) {
          await _playbackAudioFile.writeAsBytes(audioFrame.buffer!.toList(),
              mode: FileMode.append, flush: true);
        }
      },
    );

    await _engine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        frameRate: 15,
        bitrate: 800,
      ),
    );

    await _engine.startPreview();

    await _startAudioFrameRecord();

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _startAudioFrameRecord() async {
    Directory appDocDir = Platform.isAndroid
        ? (await getExternalStorageDirectory())!
        : await getApplicationDocumentsDirectory();

    _audioFile = File(path.join(appDocDir.absolute.path, 'record_audio.raw'));
    if (await _audioFile.exists()) {
      await _audioFile.delete();
    }
    await _audioFile.create();
    logSink
        .log('onRecordAudioFrame file output to: ${_audioFile.absolute.path}');

    _playbackAudioFile = File(path.join(
      appDocDir.absolute.path,
      'playback_audio.raw',
    ));
    if (await _playbackAudioFile.exists()) {
      await _playbackAudioFile.delete();
    }
    await _playbackAudioFile.create();
    logSink.log(
        'onPlaybackAudioFrame file output to: ${_playbackAudioFile.absolute.path}');

    _engine.getMediaEngine().registerAudioFrameObserver(_audioFrameObserver);
    await _engine.setPlaybackAudioFrameParameters(
        sampleRate: 32000,
        channel: 1,
        mode: RawAudioFrameOpModeType.rawAudioFrameOpModeReadOnly,
        samplesPerCall: 1024);
    await _engine.setRecordingAudioFrameParameters(
        sampleRate: 32000,
        channel: 1,
        mode: RawAudioFrameOpModeType.rawAudioFrameOpModeReadOnly,
        samplesPerCall: 1024);
  }

  void _stopAudioFrameRecord() {
    _engine.getMediaEngine().unregisterAudioFrameObserver(_audioFrameObserver);
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      uid: config.uid,
      options: ChannelMediaOptions(
        channelProfile: _channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return const Center(
          child: Text('No Preview'),
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
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

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
            if (!kIsWeb &&
                (defaultTargetPlatform == TargetPlatform.android ||
                    defaultTargetPlatform == TargetPlatform.iOS))
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                      'Rendered by SurfaceView \n(default TextureView): '),
                  Switch(
                    value: _isUseFlutterTexture,
                    onChanged: isJoined
                        ? null
                        : (changed) {
                            setState(() {
                              _isUseFlutterTexture = changed;
                            });
                          },
                  )
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            const Text('Channel Profile: '),
            DropdownButton<ChannelProfileType>(
              items: items,
              value: _channelProfileType,
              onChanged: isJoined
                  ? null
                  : (v) {
                      setState(() {
                        _channelProfileType = v!;
                      });
                    },
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
            if (defaultTargetPlatform == TargetPlatform.android ||
                defaultTargetPlatform == TargetPlatform.iOS) ...[
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _switchCamera,
                child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
              ),
            ],
          ],
        );
      },
    );
    // if (!_isInit) return Container();
  }
}
