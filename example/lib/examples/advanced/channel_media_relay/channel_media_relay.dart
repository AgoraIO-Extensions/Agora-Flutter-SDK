import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/components/remote_video_views_widget.dart';
import 'package:flutter/material.dart';

/// ChannelMediaRelay Example
class ChannelMediaRelay extends StatefulWidget {
  /// Construct the [ChannelMediaRelay]
  const ChannelMediaRelay({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ChannelMediaRelay> with KeepRemoteVideoViewsMixin {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  bool isJoined = false;
  int? remoteUid;
  bool isRelaying = false;
  late final TextEditingController _channelMediaRelayController;
  late final TextEditingController _channelController;

  @override
  void initState() {
    super.initState();
    _channelMediaRelayController = TextEditingController();
    _channelController = TextEditingController(text: config.channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
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
        setState(() {
          remoteUid = rUid;
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          remoteUid = null;
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      onChannelMediaRelayStateChanged:
          (ChannelMediaRelayState state, ChannelMediaRelayError code) {
        logSink.log(
            '[onChannelMediaRelayStateChanged] state: $state, code: $code');
        switch (state) {
          case ChannelMediaRelayState.relayStateIdle:
            setState(() {
              isRelaying = false;
            });
            break;
          case ChannelMediaRelayState.relayStateRunning:
            setState(() {
              isRelaying = true;
            });
            break;
          case ChannelMediaRelayState.relayStateFailure:
            setState(() {
              isRelaying = false;
            });
            break;
          default:
            setState(() {
              isRelaying = false;
            });
            break;
        }
      },
    ));

    // enable video module and set up video encoding configs
    await _engine.enableVideo();
    await _engine.startPreview();

    // make this room live broadcasting room
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel() async {
    // start joining channel
    // 1. Users can only see each other after they join the
    // same channel successfully using the same app id.
    // 2. If app certificate is turned on at dashboard, token is needed
    // when joining channel. The channel name and uid used to calculate
    // the token has to match the ones used for channel join
    await _engine.joinChannel(
        token: config.token,
        channelId: _channelController.text,
        uid: 0,
        options: const ChannelMediaOptions());

    setState(() {
      isJoined = true;
    });
  }

  void _leaveChannel() async {
    await _onPressRelayOrStop();

    await _engine.leaveChannel();

    setState(() {
      isJoined = false;
    });
  }

  Future<void> _onPressRelayOrStop() async {
    if (isRelaying) {
      await _engine.stopChannelMediaRelay();
      setState(() {
        isRelaying = !isRelaying;
      });
      return;
    }
    if (_channelMediaRelayController.text.isEmpty) {
      return;
    }

    await _engine.startOrUpdateChannelMediaRelay(ChannelMediaRelayConfiguration(
      srcInfo: ChannelMediaInfo(
        channelName: _channelController.text,
        token: config.token,
        uid: 0,
      ),
      destInfos: [
        ChannelMediaInfo(
            channelName: _channelMediaRelayController.text, token: '', uid: 0)
      ],
      destCount: 1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Stack(
          children: [
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RemoteVideoViewsWidget(
                key: keepRemoteVideoViewsKey,
                rtcEngine: _engine,
                channelId: _channelController.text,
              ),
            )
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          children: [
            TextField(
              controller: _channelController,
              readOnly: isJoined,
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
            if (isJoined)
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: TextField(
                          controller: _channelMediaRelayController,
                          decoration: const InputDecoration(
                            hintText: 'Enter target relay channel name',
                          ))),
                  ElevatedButton(
                    onPressed: _onPressRelayOrStop,
                    child: Text(!isRelaying ? 'Relay' : 'Stop'),
                  ),
                ],
              )
          ],
        );
      },
    );
  }
}
