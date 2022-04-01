import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

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
  late final RtcEngine _engine;
  late final RtcChannel _channel0, _channel1;
  String? renderChannelId;
  bool isJoined0 = false, isJoined1 = false;
  List<int> remoteUid0 = [], remoteUid1 = [];

  @override
  void initState() {
    super.initState();
    _initEngine();
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
    _addListener(_channel0);

    _channel1 = await RtcChannel.create(_channelId1);
    _addListener(_channel1);
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
          publishLocalAudio: false,
          publishLocalVideo: false,
        ));
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
          publishLocalAudio: false,
          publishLocalVideo: false,
        ));
  }

  _addListener(RtcChannel channel) {
    String channelId = channel.channelId;
    channel.setEventHandler(RtcChannelEventHandler(
      warning: (warningCode) {
        logSink.log('warning $warningCode');
      },
      error: (errorCode) {
        logSink.log('error $errorCode');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess $channel $uid $elapsed');
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
        logSink.log('userJoined ${channel.channelId} $uid $elapsed');
        if (channelId == _channelId0) {
          setState(() {
            remoteUid0.add(uid);
          });
        } else if (channelId == _channelId1) {
          setState(() {
            remoteUid1.add(uid);
          });
        }
      },
      userOffline: (uid, reason) {
        logSink.log('userOffline ${channel.channelId} $uid $reason');
        if (channelId == _channelId0) {
          setState(() {
            remoteUid0.removeWhere((element) => element == uid);
          });
        } else if (channelId == _channelId1) {
          setState(() {
            remoteUid1.removeWhere((element) => element == uid);
          });
        }
      },
      leaveChannel: (stats) {
        logSink.log('leaveChannel ${channel.channelId} ${stats.toJson()}');
        if (channelId == _channelId0) {
          setState(() {
            isJoined0 = false;
            remoteUid0.clear();
          });
        } else if (channelId == _channelId1) {
          setState(() {
            isJoined1 = false;
            remoteUid1.clear();
          });
        }
      },
    ));
  }

  _publishChannel0() async {
    await _channel1.muteLocalVideoStream(true);
    await _channel0.muteLocalVideoStream(false);
  }

  _publishChannel1() async {
    await _channel0.muteLocalVideoStream(true);
    await _channel1.muteLocalVideoStream(false);
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
            _renderVideo(),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: _publishChannel0,
                child: const Text('Publish $_channelId0'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    renderChannelId = _channelId0;
                  });
                },
                child: const Text('Render $_channelId0'),
              ),
              ElevatedButton(
                onPressed: _publishChannel1,
                child: const Text('Publish $_channelId1'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    renderChannelId = _channelId1;
                  });
                },
                child: const Text('Render $_channelId1'),
              ),
            ],
          ),
        )
      ],
    );
  }

  _renderVideo() {
    List<int> remoteUid = [];
    if (renderChannelId == _channelId0) {
      remoteUid = remoteUid0;
    } else if (renderChannelId == _channelId1) {
      remoteUid = remoteUid1;
    }
    return Expanded(
      child: Stack(
        children: [
          kIsWeb
              ? const rtc_local_view.SurfaceView()
              : const rtc_local_view.TextureView(),
          if (remoteUid.isNotEmpty)
            Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: remoteUid
                      .map(
                        (e) => SizedBox(
                          width: 120,
                          height: 120,
                          child: kIsWeb
                              ? rtc_remote_view.SurfaceView(
                                  uid: e,
                                  channelId: renderChannelId!,
                                )
                              : rtc_remote_view.TextureView(
                                  uid: e,
                                  channelId: renderChannelId!,
                                ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
        ],
      ),
    );
  }
}
