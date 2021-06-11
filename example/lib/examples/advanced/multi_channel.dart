import 'dart:developer';

import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const _channelId0 = 'channel0';
const _channelId1 = 'channel1';

/// MultiChannel Example
class MultiChannel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MultiChannel> {
  late final RtcEngine _engine;
  late final RtcChannel _channel0, _channel1;
  String? renderChannelId;
  bool isJoined0 = false, isJoined1 = false;
  List<int> remoteUid0 = [], remoteUid1 = [];

  @override
  void initState() {
    super.initState();
    this._initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    _channel0 = await RtcChannel.create(_channelId0);
    this._addListener(_channel0);

    _channel1 = await RtcChannel.create(_channelId1);
    this._addListener(_channel1);
  }

  _joinChannel0() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }

    await _channel0.setClientRole(ClientRole.Broadcaster);
    await _channel0.joinChannel(
        null,
        null,
        0,
        ChannelMediaOptions(
            autoSubscribeAudio: true, autoSubscribeVideo: true));
  }

  _joinChannel1() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }

    await _channel1.setClientRole(ClientRole.Broadcaster);
    await _channel1.joinChannel(
        null,
        null,
        0,
        ChannelMediaOptions(
            autoSubscribeAudio: true, autoSubscribeVideo: true));
  }

  _addListener(RtcChannel channel) {
    String channelId = channel.channelId;
    channel.setEventHandler(RtcChannelEventHandler(
      warning: (warningCode) {
        log('warning ${warningCode}');
      },
      error: (errorCode) {
        log('error ${errorCode}');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        if (channelId == _channelId0) {
          setState(() {
            isJoined0 = true;
          });
        } else if (channelId == _channelId1) {
          setState(() {
            isJoined1 = true;
          });
        }
      },
      userJoined: (uid, elapsed) {
        log('userJoined ${channel.channelId} $uid $elapsed');
      },
      userOffline: (uid, reason) {
        log('userOffline ${channel.channelId} $uid $reason');
      },
      leaveChannel: (stats) {
        log('leaveChannel ${channel.channelId} ${stats.toJson()}');
        if (channelId == _channelId0) {
          this.setState(() {
            isJoined0 = false;
            remoteUid0.clear();
          });
        } else if (channelId == _channelId1) {
          this.setState(() {
            isJoined1 = false;
            remoteUid1.clear();
          });
        }
      },
      remoteVideoStateChanged: (uid, state, reason, elapsed) {
        log('remoteVideoStateChanged ${uid} ${state} ${reason} ${elapsed}');
        if (state == VideoRemoteState.Starting) {
          if (channelId == _channelId0) {
            this.setState(() {
              remoteUid0.add(uid);
            });
          } else if (channelId == _channelId1) {
            this.setState(() {
              remoteUid1.add(uid);
            });
          }
        } else if (state == VideoRemoteState.Stopped) {
          if (channelId == _channelId0) {
            this.setState(() {
              remoteUid0.removeWhere((element) => element == uid);
            });
          } else if (channelId == _channelId1) {
            this.setState(() {
              remoteUid1.removeWhere((element) => element == uid);
            });
          }
        }
      },
    ));
  }

  _publishChannel0() async {
    await _channel1.unpublish();
    await _channel0.publish();
  }

  _publishChannel1() async {
    await _channel0.unpublish();
    await _channel1.publish();
  }

  _leaveChannel0() async {
    await _channel0.leaveChannel();
  }

  _leaveChannel1() async {
    await _channel1.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isJoined0) {
                        this._leaveChannel0();
                      } else {
                        this._joinChannel0();
                      }
                    },
                    child: Text('${isJoined0 ? 'Leave' : 'Join'} $_channelId0'),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isJoined1) {
                        this._leaveChannel1();
                      } else {
                        this._joinChannel1();
                      }
                    },
                    child: Text('${isJoined1 ? 'Leave' : 'Join'} $_channelId1'),
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
              ElevatedButton(
                onPressed: this._publishChannel0,
                child: Text('Publish ${_channelId0}'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    renderChannelId = _channelId0;
                  });
                },
                child: Text('Render ${_channelId0}'),
              ),
              ElevatedButton(
                onPressed: this._publishChannel1,
                child: Text('Publish ${_channelId1}'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    renderChannelId = _channelId1;
                  });
                },
                child: Text('Render ${_channelId1}'),
              ),
            ],
          ),
        )
      ],
    );
  }

  _renderVideo() {
    List<int>? remoteUid = null;
    if (renderChannelId == _channelId0) {
      remoteUid = remoteUid0;
    } else if (renderChannelId == _channelId1) {
      remoteUid = remoteUid1;
    }
    return Expanded(
      child: Stack(
        children: [
          kIsWeb ? RtcLocalView.SurfaceView() : RtcLocalView.TextureView(),
          if (remoteUid != null)
            Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.of(remoteUid.map(
                    (e) => Container(
                      width: 120,
                      height: 120,
                      child: kIsWeb
                          ? RtcRemoteView.SurfaceView(
                              uid: e,
                              channelId: renderChannelId!,
                            )
                          : RtcRemoteView.TextureView(
                              uid: e,
                              channelId: renderChannelId!,
                            ),
                    ),
                  )),
                ),
              ),
            )
        ],
      ),
    );
  }
}
