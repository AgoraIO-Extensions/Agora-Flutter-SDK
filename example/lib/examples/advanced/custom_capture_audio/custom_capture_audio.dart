import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'custom_capture_audio_api.generated.dart';

const int _defaultSampleRate = 16000;
const int _defaultChannelCount = 1;

/// The push position of the external audio frame. see [Android API reference](https://docs.agora.io/en/Voice/API%20Reference/java/enumio_1_1agora_1_1rtc_1_1_constants_1_1_audio_external_source_pos.html).
enum AudioExternalSourcePos {
  /// 0: The position before local playback. If you need to play the external audio
  /// frame on the local client, set this position.
  externalPlayoutSource,

  /// 1: The position after audio capture and before audio pre-processing. If you
  /// need the audio module of the SDK to process the external audio frame, set
  /// this position.
  externalRecordSourcePreProcess,

  /// 2: The position after audio pre-processing and before audio encoding. If
  /// you do not need the audio module of the SDK to process the external audio
  /// frame, set this position.
  externalRecordSourcePostProcess
}

/// Extension for AudioExternalSourcePos
extension AudioExternalSourcePosExt on AudioExternalSourcePos {
  /// Get int value acroding the AudioExternalSourcePos value
  int get value {
    switch (this) {
      case AudioExternalSourcePos.externalPlayoutSource:
        return 0;
      case AudioExternalSourcePos.externalRecordSourcePreProcess:
        return 1;
      case AudioExternalSourcePos.externalRecordSourcePostProcess:
        return 2;
    }
  }
}

/// CustomCaptureAudio Example
class CustomCaptureAudio extends StatefulWidget {
  /// Construct the [CustomCaptureAudio]
  const CustomCaptureAudio({Key? key}) : super(key: key);

  @override
  _CustomCaptureAudioState createState() => _CustomCaptureAudioState();
}

class _CustomCaptureAudioState extends State<CustomCaptureAudio> {
  final CustomCaptureAudioApi _api = CustomCaptureAudioApi();
  bool _isJoined = false;
  bool _isMute = false;
  double _playoutSliderValue = 100.0;
  double _preProcessSliderValue = 100.0;
  double _postProcessSliderValue = 100.0;
  AudioExternalSourcePos _audioExternalSourcePos =
      AudioExternalSourcePos.externalPlayoutSource;
  late final RtcEngine _engine;
  late final TextEditingController _channelIdController;

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: config.channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _destroyEngine();
  }

  void _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));

    _engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) async {
      logSink.log('joinChannelSuccess $channel $uid $elapsed');
      await _api.startAudioRecord(_defaultSampleRate, _defaultChannelCount);
      setState(() {
        _isJoined = true;
      });
    }, leaveChannel: (RtcStats stats) {
      logSink.log('leaveChannel ${stats.toJson()}');
      setState(() {
        _isJoined = false;
      });
    }));
  }

  void _joinChannel() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
      await Permission.microphone.request();
    }

    // make this room live broadcasting room
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    await _engine.setDefaultAudioRouteToSpeakerphone(true);

    // Sets the external audio source.
    // PS: Ensure that you call this method before the joinChannel method
    await _api.setExternalAudioSource(
        true, _defaultSampleRate, _defaultChannelCount);

    // Set audio route to speaker
    await _engine.setDefaultAudioRouteToSpeakerphone(true);

    final option = ChannelMediaOptions();
    option.autoSubscribeAudio = true;
    option.autoSubscribeVideo = false;

    // start joining channel
    // 1. Users can only see each other after they join the
    // same channel successfully using the same app id.
    // 2. If app certificate is turned on at dashboard, token is needed
    // when joining channel. The channel name and uid used to calculate
    // the token has to match the ones used for channel join
    await _engine.joinChannel(
        config.token, _channelIdController.text, null, 0, option);
  }

  Future<void> _leaveChannel() async {
    if (_isMute) {
      await _muteLocalAudioStream();
    }
    await _api.stopAudioRecord();
    await _engine.leaveChannel();
  }

  void _destroyEngine() async {
    await _engine.leaveChannel();
    await _engine.destroy();
  }

  void _sourcePosChanged() {
    var volume = 0;
    switch (_audioExternalSourcePos) {
      case AudioExternalSourcePos.externalPlayoutSource:
        volume = _playoutSliderValue.toInt();
        break;
      case AudioExternalSourcePos.externalRecordSourcePreProcess:
        volume = _preProcessSliderValue.toInt();
        break;
      case AudioExternalSourcePos.externalRecordSourcePostProcess:
        volume = _postProcessSliderValue.toInt();
        break;
    }
    _api.setExternalAudioSourceVolume(
      _audioExternalSourcePos.value,
      volume,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _channelIdController,
          decoration: const InputDecoration(hintText: 'Channel ID'),
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
        if (_isJoined) ...[
          ListTile(
            title: Row(
              children: [
                const Text('PlayOut'),
                Expanded(
                  child: Slider(
                    value: _playoutSliderValue,
                    min: 0,
                    max: 100,
                    label: _playoutSliderValue.round().toString(),
                    onChanged: (double value) {
                      _playoutSliderValue = value;
                      _sourcePosChanged();
                      setState(() {});
                    },
                  ),
                )
              ],
            ),
            leading: Radio<AudioExternalSourcePos>(
              value: AudioExternalSourcePos.externalPlayoutSource,
              groupValue: _audioExternalSourcePos,
              onChanged: (AudioExternalSourcePos? value) {
                _audioExternalSourcePos = value!;
                _sourcePosChanged();
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text('PreProcess'),
                Expanded(
                  child: Slider(
                    value: _preProcessSliderValue,
                    min: 0,
                    max: 100,
                    divisions: 100,
                    label: _preProcessSliderValue.round().toString(),
                    onChanged: (double value) {
                      _preProcessSliderValue = value;
                      _sourcePosChanged();
                      setState(() {});
                    },
                  ),
                )
              ],
            ),
            leading: Radio<AudioExternalSourcePos>(
              value: AudioExternalSourcePos.externalRecordSourcePreProcess,
              groupValue: _audioExternalSourcePos,
              onChanged: (AudioExternalSourcePos? value) {
                _audioExternalSourcePos = value!;
                _sourcePosChanged();
                setState(() {});
              },
            ),
          ),
          ListTile(
            title: Row(
              children: [
                const Text('PostProcess'),
                Expanded(
                  child: Slider(
                    value: _postProcessSliderValue,
                    min: 0,
                    max: 100,
                    label: _postProcessSliderValue.round().toString(),
                    onChanged: (double value) {
                      _postProcessSliderValue = value;

                      _sourcePosChanged();
                      setState(() {});
                    },
                  ),
                )
              ],
            ),
            leading: Radio<AudioExternalSourcePos>(
              value: AudioExternalSourcePos.externalRecordSourcePostProcess,
              groupValue: _audioExternalSourcePos,
              onChanged: (AudioExternalSourcePos? value) {
                _audioExternalSourcePos = value!;
                _sourcePosChanged();
                setState(() {});
              },
            ),
          ),
          ElevatedButton(
            onPressed: !_isJoined ? null : _muteLocalAudioStream,
            child: Text('${_isMute ? 'Open' : 'Mute'} microphone'),
          ),
        ],
      ],
    );
  }

  Future<void> _muteLocalAudioStream() async {
    _isMute = !_isMute;
    await _engine.muteLocalAudioStream(_isMute);
    setState(() {});
  }
}
