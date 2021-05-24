import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/config/voice_changer.config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// VoiceChange Example
class VoiceChange extends StatefulWidget {
  RtcEngine _engine = null;

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<VoiceChange> {
  String renderChannelId;
  bool isJoined = false;
  ClientRole role;
  List<int> remoteUids = [];
  bool isLowAudio = true;
  int uidMySelf;
  int selectedVoiceToolBtn;
  AudioEffectPreset currentAudioEffectPreset;

  bool isEnableSlider1 = false;
  bool isEnableSlider2 = false;
  String sliderTitle1;
  String sliderTitle2;
  double minimumValue1;
  double maximumValue1;
  double minimumValue2;
  double maximumValue2;
  double sliderValue1;
  double sliderValue2;
  Map selectedFreq = FreqOptions[0];
  Map selectedReverbKey = ReverbKeyOptions[0];

  double voicePitchValue = 0.5;
  double bandGainValue = 0;
  double reverbValue = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget._engine?.destroy();
  }

  _initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    widget._engine =
        await RtcEngine.createWithConfig(RtcEngineConfig(config.appId));
    this._addListener();

    // enable video module and set up video encoding configs
    await widget._engine?.enableVideo();

    // make this room live broadcasting room
    await widget._engine?.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await this._updateClientRole(ClientRole.Broadcaster);

    // Set audio route to speaker
    await widget._engine?.setDefaultAudioRoutetoSpeakerphone(true);

    // start joining channel
    // 1. Users can only see each other after they join the
    // same channel successfully using the same app id.
    // 2. If app certificate is turned on at dashboard, token is needed
    // when joining channel. The channel name and uid used to calculate
    // the token has to match the ones used for channel join
    await widget._engine
        ?.joinChannel(config.token, config.channelId, null, 0, null);
  }

  _addListener() {
    widget._engine
        ?.setEventHandler(RtcEngineEventHandler(warning: (warningCode) {
      log('Warning ${warningCode}');
    }, error: (errorCode) {
      log('Warning ${errorCode}');
    }, joinChannelSuccess: (channel, uid, elapsed) {
      log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
      ;
      setState(() {
        isJoined = true;
        uidMySelf = uid;
      });
    }, userJoined: (uid, elapsed) {
      log('userJoined $uid $elapsed');
      this.setState(() {
        remoteUids.add(uid);
      });
    }, userOffline: (uid, reason) {
      log('userOffline $uid $reason');
      this.setState(() {
        remoteUids.remove(uid);
      });
    }));
  }

  _updateClientRole(ClientRole role) async {
    var option;
    if (role == ClientRole.Broadcaster) {
      await widget._engine?.setVideoEncoderConfiguration(
          VideoEncoderConfiguration(
              dimensions: VideoDimensions(640, 360),
              frameRate: VideoFrameRate.Fps30,
              orientationMode: VideoOutputOrientationMode.Adaptative));
      // enable camera/mic, this will bring up permission dialog for first time
      await widget._engine?.enableLocalAudio(true);
      await widget._engine?.enableLocalVideo(true);
    } else {
      // You have to provide client role options if set to audience
      option = ClientRoleOptions(isLowAudio
          ? AudienceLatencyLevelType.LowLatency
          : AudienceLatencyLevelType.UltraLowLatency);
    }
    await widget._engine?.setClientRole(role, option);
  }

  _onPressBFButtonn(dynamic type, int index) async {
    switch (index) {
      case 0:
      case 1:
        await widget._engine
            ?.setVoiceBeautifierPreset(type as VoiceBeautifierPreset);
        this._updateSliderUI(AudioEffectPreset.AudioEffectOff);
        break;
      case 2:
      case 3:
      case 4:
      case 5:
        await widget._engine?.setAudioEffectPreset(type as AudioEffectPreset);
        this._updateSliderUI(type as AudioEffectPreset);
        break;
      default:
        break;
    }
  }

  _updateSliderUI(AudioEffectPreset type) {
    this.setState(() {
      currentAudioEffectPreset = type;
      switch (type) {
        case AudioEffectPreset.RoomAcoustics3DVoice:
          isEnableSlider1 = true;
          isEnableSlider2 = false;
          sliderTitle1 = 'Cycle';
          minimumValue1 = 1;
          sliderValue1 = 1;
          maximumValue1 = 3;
          break;
        case AudioEffectPreset.PitchCorrection:
          isEnableSlider1 = true;
          isEnableSlider2 = true;
          sliderTitle1 = 'Tonic Mode';
          sliderTitle2 = 'Tonic Pitch';
          minimumValue1 = 1;
          sliderValue1 = 1;
          maximumValue1 = 3;
          minimumValue2 = 1;
          sliderValue2 = 1;
          maximumValue2 = 12;
          break;
        default:
          isEnableSlider1 = false;
          isEnableSlider2 = false;
          break;
      }
    });
  }

  _onAudioEffectUpdate({
    double value1,
    double value2,
  }) async {
    this.setState(() {
      if (value1 != null) {
        sliderValue1 = value1;
      }
      if (value2 != null) {
        sliderValue2 = value2;
      }
      widget._engine?.setAudioEffectParameters(
          currentAudioEffectPreset,
          (isEnableSlider1 ? sliderValue1 ?? minimumValue1 : 0).toInt(),
          (isEnableSlider2 ? sliderValue2 ?? minimumValue2 : 0).toInt());
    });
  }

  _onPressChangeFreq() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Band Frequency'),
          actions: <Widget>[
            for (var freqOpt in FreqOptions)
              TextButton(
                child: Text(freqOpt['text']),
                onPressed: () {
                  setState(() {
                    selectedFreq = freqOpt;
                    widget._engine?.setLocalVoiceEqualization(
                        freqOpt['type'], bandGainValue.toInt());
                  });
                  Navigator.of(context).pop();
                },
              ),
          ],
        );
      },
    );
  }

  _onPressChangeReverbKey() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Set Reverb Key'),
          actions: <Widget>[
            for (var reverbKey in ReverbKeyOptions)
              TextButton(
                child: Text(reverbKey['text']),
                onPressed: () {
                  setState(() {
                    selectedReverbKey = reverbKey;
                  });
                  Navigator.of(context).pop();
                },
              ),
          ],
        );
      },
    );
  }

  _renderToolBar() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        child: Column(
          children: [
            Row(children: [
              Text('Voice Beautifier & Effects Preset',
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            Container(
                width: MediaQuery.of(context).size.width,
                child: Wrap(children: [
                  for (var i = 0; i < VoiceChangeConfig.length; i++)
                    _renderBtnItem(VoiceChangeConfig[i], i)
                ])),
            if (isEnableSlider1)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(sliderTitle1),
                    flex: 1,
                  ),
                  Expanded(
                    child: Slider(
                      value: sliderValue1,
                      min: minimumValue1,
                      max: maximumValue1,
                      divisions: 5,
                      label: sliderTitle1,
                      onChanged: (double value) {
                        _onAudioEffectUpdate(value1: value);
                      },
                    ),
                    flex: 2,
                  )
                ],
              ),
            if (isEnableSlider2)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(child: Text(sliderTitle2), flex: 1),
                  Expanded(
                      child: Slider(
                        value: sliderValue2,
                        min: minimumValue2,
                        max: maximumValue2,
                        divisions: 5,
                        label: sliderTitle1,
                        onChanged: (double value) {
                          _onAudioEffectUpdate(value2: value);
                        },
                      ),
                      flex: 2)
                ],
              ),
            Row(children: [
              Text('Customize Voice Effects',
                  style: TextStyle(fontWeight: FontWeight.bold))
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pitch:'),
                Slider(
                  value: voicePitchValue,
                  min: 0.5,
                  max: 2,
                  divisions: 5,
                  onChanged: (double value) {
                    setState(() {
                      voicePitchValue = value;
                    });
                    widget._engine?.setLocalVoicePitch(value);
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BandFreq'),
                TextButton(
                  child: Text(selectedFreq['text']),
                  onPressed: _onPressChangeFreq,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BandGain:'),
                Slider(
                  value: bandGainValue,
                  min: 0,
                  max: 9,
                  divisions: 5,
                  onChanged: (double value) async {
                    this.setState(() {
                      bandGainValue = value;
                    });
                    widget._engine?.setLocalVoiceEqualization(
                        selectedFreq['type'], value.toInt());
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BandKey'),
                TextButton(
                  child: Text(selectedReverbKey['text']),
                  onPressed: _onPressChangeReverbKey,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('ReverbValue:'),
                Slider(
                  value: reverbValue,
                  min: selectedReverbKey['min'],
                  max: selectedReverbKey['max'],
                  divisions: 5,
                  onChanged: (double value) async {
                    setState(() {
                      reverbValue = value;
                    });
                    await widget._engine?.setLocalVoiceReverb(
                        selectedReverbKey['type'], value.toInt());
                  },
                )
              ],
            ),
          ],
        ));
  }

  _renderBtnItem(Map<String, dynamic> config, int index) {
    return _CusBtn(
        config['alertTitle'], selectedVoiceToolBtn != index, config['options'],
        (type) {
      setState(() {
        selectedVoiceToolBtn = index;
      });
      _onPressBFButtonn(type, index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            !isJoined
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: RaisedButton(
                          onPressed: _initEngine,
                          child: Text('Join channel'),
                        ),
                      )
                    ],
                  )
                : _renderUserUid(),
            if (isJoined) _renderToolBar()
          ],
        ),
      ],
    );
  }

  _renderUserUid() {
    final size = MediaQuery.of(context).size;
    var list = [uidMySelf, ...remoteUids];
    return Container(
      width: size.width,
      height: 200,
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              child: Text(
                'AUDIO ONLY ${index == 0 ? 'LOCAL' : 'REMOTE'} UID: ${list[index]}',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              padding: EdgeInsets.all(4.0),
            ),
          );
        },
      ),
    );
  }
}

class _CusBtn extends StatefulWidget {
  String alertTitle;
  dynamic options;
  bool isOff = false;
  void Function(dynamic type) onPressed;

  _CusBtn(this.alertTitle, this.isOff, this.options, this.onPressed);

  @override
  State<StatefulWidget> createState() => _CusBtnState(isOff);
}

class _CusBtnState extends State<_CusBtn> {
  String title = "Off";
  bool isEnable;

  _CusBtnState(this.isEnable);

  @override
  void didUpdateWidget(covariant _CusBtn oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    this.setState(() {
      isEnable = !widget.isOff;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(isEnable ? title : 'Off'),
      onPressed: _showMyDialog,
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(widget.alertTitle),
          actions: <Widget>[
            for (var option in widget.options)
              TextButton(
                child: Text(option['text']),
                onPressed: () {
                  setState(() {
                    isEnable = true;
                    title = option['text'];
                    widget.onPressed(option['type']);
                  });
                  Navigator.of(context).pop();
                },
              ),
          ],
        );
      },
    );
  }
}
