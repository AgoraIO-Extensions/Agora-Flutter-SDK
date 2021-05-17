import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// CreateStreamData Example
class CreateStreamData extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<CreateStreamData> {
  late final RtcEngine _engine;
  bool isJoined = false;
  int? remoteUid;
  bool isLowAudio = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    _engine = await RtcEngine.createWithConfig(RtcEngineConfig(config.appId));
    this._addListener();

    // enable video module and set up video encoding configs
    await _engine.enableVideo();

    // make this room live broadcasting room
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await this._updateClientRole(ClientRole.Broadcaster);

    // Set audio route to speaker
    await _engine.setDefaultAudioRoutetoSpeakerphone(true);

    // start joining channel
    // 1. Users can only see each other after they join the
    // same channel successfully using the same app id.
    // 2. If app certificate is turned on at dashboard, token is needed
    // when joining channel. The channel name and uid used to calculate
    // the token has to match the ones used for channel join
    await _engine.joinChannel(config.token, config.channelId, null, 0, null);
  }

  Future<void> _showMyDialog(int uid, int streamId, String data) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Receive from uid:${uid}'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text('StreamId ${streamId}:${data}')],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _addListener() {
    _engine.setEventHandler(RtcEngineEventHandler(warning: (warningCode) {
      log('Warning ${warningCode}');
    }, error: (errorCode) {
      log('Warning ${errorCode}');
    }, joinChannelSuccess: (channel, uid, elapsed) {
      log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
      ;
      setState(() {
        isJoined = true;
      });
    }, userJoined: (uid, elapsed) {
      log('userJoined $uid $elapsed');
      this.setState(() {
        remoteUid = uid;
      });
    }, userOffline: (uid, reason) {
      log('userOffline $uid $reason');
      this.setState(() {
        remoteUid = null;
      });
    }, streamMessage: (int uid, int streamId, String data) {
      _showMyDialog(uid, streamId, data);
      log('streamMessage $uid $streamId $data');
    }, streamMessageError:
        (int uid, int streamId, ErrorCode error, int missed, int cached) {
      log('streamMessage $uid $streamId $error $missed $cached');
    }));
  }

  _updateClientRole(ClientRole role) async {
    var option;
    if (role == ClientRole.Broadcaster) {
      await _engine.setVideoEncoderConfiguration(VideoEncoderConfiguration(
          dimensions: VideoDimensions(640, 360),
          frameRate: VideoFrameRate.Fps30,
          orientationMode: VideoOutputOrientationMode.Adaptative));
      // enable camera/mic, this will bring up permission dialog for first time
      await _engine.enableLocalAudio(true);
      await _engine.enableLocalVideo(true);
    } else {
      // You have to provide client role options if set to audience
      option = ClientRoleOptions(isLowAudio
          ? AudienceLatencyLevelType.LowLatency
          : AudienceLatencyLevelType.UltraLowLatency);
    }
    await _engine.setClientRole(role, option);
  }

  _onPressSend() async {
    if (_controller.text.length == 0) {
      return;
    }

    var streamId = await _engine.createDataStreamWithConfig(
        DataStreamConfig(syncWithAudio: false, ordered: false));
    if (streamId != null) {
      _engine.sendStreamMessage(streamId, _controller.text);
    }
    _controller.clear();
  }

  final TextEditingController _controller = TextEditingController();

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
                : _renderVideo(),
            if (isJoined)
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Input Message',
                          ))),
                  ElevatedButton(
                    onPressed: _onPressSend,
                    child: Text('Send'),
                  ),
                ],
              )
          ],
        ),
      ],
    );
  }

  _renderVideo() {
    return Row(children: [
      Expanded(
          child: AspectRatio(
        aspectRatio: 1,
        child: RtcLocalView.SurfaceView(),
      )),
      Expanded(
        child: AspectRatio(
          aspectRatio: 1,
          child: remoteUid != null
              ? RtcRemoteView.SurfaceView(
                  uid: remoteUid!,
                )
              : Container(
                  color: Colors.grey[200],
                ),
        ),
      )
    ]);
  }
}
