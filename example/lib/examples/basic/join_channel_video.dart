import 'dart:developer';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// MultiChannel Example
class JoinChannelVideo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<JoinChannelVideo> {
  RtcEngine _engine = null;
  String channelId = config.channelId;
  bool isJoined = false, switchCamera = true;
  int remoteUid;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    this._initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine?.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.create(config.appId);
    this._addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine?.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        log('userJoined  ${uid} ${elapsed}');
        setState(() {
          remoteUid = uid;
        });
      },
      userOffline: (uid, reason) {
        log('userOffline  ${uid} ${reason}');
        if (uid == remoteUid) {
          setState(() {
            remoteUid = null;
          });
        }
      },
      leaveChannel: (stats) {
        log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      warning: (i) => log('warning $i', name: 'AGORA'),
      transcodingUpdated: () => log('transcodingUpdated', name: 'AGORA'),
      audioMixingFinished: () => log('audioMixingFinished', name: 'AGORA'),
      mediaEngineLoadSuccess: () =>
          log('mediaEngineLoadSuccess', name: 'AGORA'),
      mediaEngineStartCallSuccess: () =>
          log('mediaEngineStartCallSuccess', name: 'AGORA'),
      connectionInterrupted: () => log('connectionInterrupted', name: 'AGORA'),
      connectionBanned: () => log('connectionBanned', name: 'AGORA'),
      cameraReady: () => log('cameraReady', name: 'AGORA'),
      videoStopped: () => log('videoStopped', name: 'AGORA'),
      error: (i) => log('error $i', name: 'AGORA'),
      connectionLost: () => log('connectionLost)', name: 'AGORA'),
      requestToken: () => log('requestToken)', name: 'AGORA'),
      apiCallExecuted: (i, j, ki) =>
          log('apiCallExecuted $i,$j', name: 'AGORA'),
      rejoinChannelSuccess: (i, j, k) =>
          log('rejoinChannelSuccess $i,$j', name: 'AGORA'),
      localUserRegistered: (i, j) =>
          log('localUserRegistered $i,$j', name: 'AGORA'),
      userInfoUpdated: (i, j) => log('userInfoUpdated $i,$j', name: 'AGORA'),
      clientRoleChanged: (i, j) =>
          log('clientRoleChanged $i,$j', name: 'AGORA'),
      connectionStateChanged: (i, j) =>
          log('connectionStateChanged $i,$j', name: 'AGORA'),
      networkTypeChanged: (i) => log('networkTypeChanged $i', name: 'AGORA'),
      tokenPrivilegeWillExpire: (i) =>
          log('tokenPrivilegeWillExpire $i', name: 'AGORA'),
      audioVolumeIndication: (i, j) =>
          log('audioVolumeIndication $i,$j', name: 'AGORA'),
      activeSpeaker: (i) => log('activeSpeaker $i', name: 'AGORA'),
      firstLocalAudioFrame: (i) =>
          log('firstLocalAudioFrame $i', name: 'AGORA'),
      firstLocalVideoFrame: (i, j, k) =>
          log('firstLocalVideoFrame $i,$j', name: 'AGORA'),
      userMuteVideo: (i, j) => log('userMuteVideo $i,$j', name: 'AGORA'),
      videoSizeChanged: (i, j, k, l) =>
          log('videoSizeChanged $i,$j', name: 'AGORA'),
      localVideoStateChanged: (i, j) =>
          log('localVideoStateChanged $i,$j', name: 'AGORA'),
      localAudioStateChanged: (i, j) =>
          log('localAudioStateChanged $i,$j', name: 'AGORA'),
      audioRouteChanged: (i) => log('audioRouteChanged $i', name: 'AGORA'),
      cameraFocusAreaChanged: (i) =>
          log('cameraFocusAreaChanged $i', name: 'AGORA'),
      cameraExposureAreaChanged: (i) =>
          log('cameraExposureAreaChanged $i', name: 'AGORA'),
      facePositionChanged: (i, j, k) =>
          log('facePositionChanged $i,$j', name: 'AGORA'),
      rtcStats: (i) => log('rtcStats $i', name: 'AGORA'),
      lastmileQuality: (i) => log('lastmileQuality $i', name: 'AGORA'),
      networkQuality: (i, j, k) => log('networkQuality $i,$j', name: 'AGORA'),
      lastmileProbeResult: (i) => log('lastmileProbeResult $i', name: 'AGORA'),
      localVideoStats: (i) => log('localVideoStats $i', name: 'AGORA'),
      localAudioStats: (i) => log('localAudioStats $i', name: 'AGORA'),
      remoteVideoStats: (i) => log('remoteVideoStats $i', name: 'AGORA'),
      remoteAudioStats: (i) => log('remoteAudioStats $i', name: 'AGORA'),
      audioMixingStateChanged: (i, j) =>
          log('audioMixingStateChanged $i,$j', name: 'AGORA'),
      audioEffectFinished: (i) => log('audioEffectFinished $i', name: 'AGORA'),
      streamInjectedStatus: (i, j, k) =>
          log('streamInjectedStatus $i,$j', name: 'AGORA'),
      streamMessage: (i, j, k) => log('streamMessage $i,$j', name: 'AGORA'),
      channelMediaRelayEvent: (i) =>
          log('channelMediaRelayEvent $i', name: 'AGORA'),
      firstRemoteAudioFrame: (i, j) =>
          log('firstRemoteAudioFrame $i,$j', name: 'AGORA'),
      firstRemoteAudioDecoded: (i, j) =>
          log('firstRemoteAudioDecoded $i,$j', name: 'AGORA'),
      userMuteAudio: (i, j) => log('userMuteAudio $i,$j', name: 'AGORA'),
      streamPublished: (i, j) => log('streamPublished $i,$j', name: 'AGORA'),
      streamUnpublished: (i) => log('streamUnpublished $i', name: 'AGORA'),
      userEnableVideo: (i, j) => log('userEnableVideo $i,$j', name: 'AGORA'),
      userEnableLocalVideo: (i, j) =>
          log('userEnableLocalVideo $i,$j', name: 'AGORA'),
      microphoneEnabled: (i) => log('microphoneEnabled $i', name: 'AGORA'),
      audioQuality: (i, j, k, l) => log('audioQuality $i,$j', name: 'AGORA'),
      metadataReceived: (i, j, k) =>
          log('metadataReceived $i,$j', name: 'AGORA'),
      rtmpStreamingEvent: (i, j) =>
          log('rtmpStreamingEvent $i,$j', name: 'AGORA'),
      remoteVideoStateChanged: (i, j, k, l) =>
          log('remoteVideoStateChanged $i,$j,$k,$l', name: 'AGORA'),
      remoteAudioStateChanged: (i, j, k, l) =>
          log('remoteAudioStateChanged $i,$j,$k,$l', name: 'AGORA'),
      localPublishFallbackToAudioOnly: (i) =>
          log('localPublishFallbackToAudioOnly $i', name: 'AGORA'),
      remoteSubscribeFallbackToAudioOnly: (i, j) =>
          log('remoteSubscribeFallbackToAudioOnly $i,$j', name: 'AGORA'),
      rtmpStreamingStateChanged: (i, j, k) =>
          log('rtmpStreamingStateChanged $i,$j,$k', name: 'AGORA'),
      streamMessageError: (i, j, k, l, m) =>
          log('streamMessageError $i,$j,$k,$l,$m', name: 'AGORA'),
      channelMediaRelayStateChanged: (i, j) =>
          log('channelMediaRelayStateChanged $i,$j', name: 'AGORA'),
      firstRemoteVideoFrame: (i, j, k, l) =>
          log('firstRemoteVideoFrame $i,$j,$k,$l', name: 'AGORA'),
      remoteAudioTransportStats: (i, j, k, l) =>
          log('remoteAudioTransportStats $i,$j,$k,$l', name: 'AGORA'),
      remoteVideoTransportStats: (i, j, k, l) =>
          log('remoteVideoTransportStats $i,$j,$k,$l', name: 'AGORA'),
      firstRemoteVideoDecoded: (i, j, k, l) =>
          log('firstRemoteVideoDecoded $i,$j,$k,$l', name: 'AGORA'),
      firstLocalAudioFramePublished: (i) =>
          log('firstLocalAudioFramePublished $i', name: 'AGORA'),
      firstLocalVideoFramePublished: (i) =>
          log('firstLocalVideoFramePublished $i', name: 'AGORA'),
      audioPublishStateChanged: (i, j, k, l) =>
          log('audioPublishStateChanged $i,$j,$k,$l', name: 'AGORA'),
      videoPublishStateChanged: (i, j, k, l) =>
          log('videoPublishStateChanged $i,$j,$k,$l', name: 'AGORA'),
      audioSubscribeStateChanged: (i, j, k, l, m) =>
          log('audioSubscribeStateChanged $i,$j,$k,$l,$m', name: 'AGORA'),
      videoSubscribeStateChanged: (i, j, k, l, m) =>
          log('videoSubscribeStateChanged $i,$j,$k,$l,$m', name: 'AGORA'),
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine?.joinChannel(config.token, channelId, null, 0);
  }

  _leaveChannel() async {
    await _engine?.leaveChannel();
  }

  _switchCamera() {
    _engine?.switchCamera()?.then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    })?.catchError((err) {
      log('switchCamera $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Channel ID'),
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
                  child: RaisedButton(
                    onPressed:
                        isJoined ? this._leaveChannel : this._joinChannel,
                    child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                )
              ],
            ),
            _renderVideo(),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RaisedButton(
                onPressed: this._switchCamera,
                child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
              ),
            ],
          ),
        )
      ],
    );
  }

  _renderVideo() {
    return Expanded(
      child: Stack(
        children: [
          RtcLocalView.SurfaceView(),
          remoteUid != null
              ? Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 200,
                    height: 200,
                    child: RtcRemoteView.SurfaceView(
                      uid: remoteUid,
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
