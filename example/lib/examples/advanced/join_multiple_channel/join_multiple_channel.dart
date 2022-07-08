import 'package:agora_rtc_ng/agora_rtc_ng.dart';
import 'package:agora_rtc_ng_example/config/agora.config.dart' as config;
import 'package:agora_rtc_ng_example/examples/example_actions_widget.dart';
import 'package:agora_rtc_ng_example/examples/log_sink.dart';
import 'package:flutter/material.dart';

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
  late final RtcConnection _channel0, _channel1;
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
    _engine.release();
  }

  _initEngine() async {
    _engine = createAgoraRtcEngineEx();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(RtcEngineEventHandler(
      onWarning: (warn, msg) {
        logSink.log('[onWarning] warn: $warn, msg: $msg');
      },
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
          });
        } else if (connection.channelId == _channelId1) {
          setState(() {
            remoteUid1.remove(rUid);
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
          });
        } else if (connection.channelId == _channelId1) {
          setState(() {
            isJoined1 = false;
            remoteUid1.clear();
          });
        }
      },
    ));

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    _channel0 = const RtcConnection(channelId: _channelId0, localUid: 1000);

    _channel1 = const RtcConnection(channelId: _channelId1, localUid: 1001);

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel0() async {
    await _engine.joinChannelEx(
        token: '',
        connection: _channel0,
        options: const ChannelMediaOptions(
            clientRoleType: ClientRoleType.clientRoleBroadcaster));
  }

  void _joinChannel1() async {
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
              publishAudioTrack: false, publishCameraTrack: false),
          connection: _channel1);
    }

    if (isJoined0) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishAudioTrack: true, publishCameraTrack: true),
          connection: _channel0);
    }
  }

  _publishChannel1() async {
    if (isJoined0) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishAudioTrack: false, publishCameraTrack: false),
          connection: _channel0);
    }

    if (isJoined1) {
      await _engine.updateChannelMediaOptionsEx(
          options: const ChannelMediaOptions(
              publishAudioTrack: true, publishCameraTrack: true),
          connection: _channel1);
    }
  }

  _leaveChannel0() async {
    if (isJoined0) {
      await _engine.leaveChannelEx(_channel0);
    }
  }

  _leaveChannel1() async {
    if (isJoined1) {
      await _engine.leaveChannelEx(_channel1);
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
              ),
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
          ],
        );
      },
    );
  }
}
