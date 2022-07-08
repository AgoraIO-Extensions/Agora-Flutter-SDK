import 'package:agora_rtc_ng/agora_rtc_ng.dart';
import 'package:agora_rtc_ng_example/config/agora.config.dart' as config;
import 'package:agora_rtc_ng_example/examples/example_actions_widget.dart';
import 'package:agora_rtc_ng_example/examples/log_sink.dart';
import 'package:flutter/material.dart';

/// MultiChannel Example
class SetContentInspect extends StatefulWidget {
  /// Construct the [JoinChannelVideo]
  const SetContentInspect({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SetContentInspect> {
  late final RtcEngine _engine;

  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  bool _isStartContentInspect = false;

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
    // await _localVideoController.dispose();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
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
      onContentInspectResult: (ContentInspectResult result) {
        logSink.log('[onContentInspectResult] result: $result');
      },
    ));
    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      info: '',
      uid: config.uid,
    );
  }

  void _leaveChannel() async {
    await _engine.setContentInspect(const ContentInspectConfig(
      enable: false,
      modules: [
        ContentInspectModule(type: ContentInspectType.contentInspectModeration)
      ],
      moduleCount: 1,
    ));

    await _engine.leaveChannel();
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
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
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
                  ? () {
                      _isStartContentInspect = !_isStartContentInspect;

                      if (_isStartContentInspect) {
                        _engine.setContentInspect(const ContentInspectConfig(
                          enable: true,
                          deviceWork: true,
                          deviceworkType: ContentInspectDeviceType
                              .contentInspectDeviceAgora,
                          modules: [
                            ContentInspectModule(
                              type: ContentInspectType.contentInspectModeration,
                              frequency: 2,
                            )
                          ],
                          moduleCount: 1,
                        ));
                      } else {
                        _engine.setContentInspect(const ContentInspectConfig(
                          enable: false,
                          deviceWork: true,
                          deviceworkType: ContentInspectDeviceType
                              .contentInspectDeviceAgora,
                          modules: [
                            ContentInspectModule(
                              type: ContentInspectType.contentInspectModeration,
                              frequency: 2,
                            )
                          ],
                          moduleCount: 1,
                        ));
                      }

                      setState(() {});
                    }
                  : null,
              child: Text(
                  '${_isStartContentInspect ? 'Stop' : 'Start'} ContentInspect'),
            ),
          ],
        );
      },
    );
  }
}
