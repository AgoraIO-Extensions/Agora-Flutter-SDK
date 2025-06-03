import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// MultiChannel Example
class LoopbackAudio extends StatefulWidget {
  /// Construct the [LoopbackAudio]
  const LoopbackAudio({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<LoopbackAudio> {
  late final RtcEngine _engine;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  late TextEditingController _appNameController;

  late final RtcEngineEventHandler _rtcEngineEventHandler;

  static const int kInvalidLoopbackAudioTrackId = -1;

  int _loopbackAudioTrackId = kInvalidLoopbackAudioTrackId;
  double _volume = 100.0;
  LoopbackAudioTrackType _loopbackAudioTrackType =
      LoopbackAudioTrackType.lookbackSystem;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);
    _appNameController = TextEditingController();

    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
    _appNameController.dispose();
  }

  Future<void> _dispose() async {
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    _rtcEngineEventHandler = RtcEngineEventHandler(
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
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);

    await _engine.enableVideo();
    await _engine.startPreview();
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      uid: config.uid,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster
      ),
    );
  }

  Future<void> _updateChannelMediaOptions() async {
    await _engine.updateChannelMediaOptions(
      ChannelMediaOptions(
        publishLoopbackAudioTrack:
            _loopbackAudioTrackId != kInvalidLoopbackAudioTrackId,
        publishLoopbackAudioTrackId: _loopbackAudioTrackId,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _createCustomAudioTrack() async {
    final trackId = await _engine.getMediaEngine().createLoopbackAudioTrack(
          LoopbackAudioTrackConfig(
            loopbackType: _loopbackAudioTrackType,
            appName: _appNameController.text.isNotEmpty
                ? _appNameController.text
                : null,
            volume: _volume.toInt(),
          ),
        );
    logSink.log('createLoopbackAudioTrack: $trackId');
    setState(() {
      _loopbackAudioTrackId = trackId;
    });
  }

  Future<void> _destroyLoopbackAudioTrack() async {
    final result = await _engine
        .getMediaEngine()
        .destroyLoopbackAudioTrack(_loopbackAudioTrackId);
    logSink.log('destroyLoopbackAudioTrack: $result');
    setState(() {
      _loopbackAudioTrackId = kInvalidLoopbackAudioTrackId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        return Stack(
          children: [
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
              ),
              onAgoraVideoViewCreated: (viewId) {
                _engine.startPreview();
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.of(remoteUid.map(
                    (e) => SizedBox(
                      width: 120,
                      height: 120,
                      child: AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: _engine,
                          canvas: VideoCanvas(uid: e),
                          connection:
                              RtcConnection(channelId: _controller.text),
                        ),
                      ),
                    ),
                  )),
                ),
              ),
            )
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        final loopbackAudioTrackType = [
          LoopbackAudioTrackType.lookbackSystem,
          LoopbackAudioTrackType.lookbackSystemExcludeSelf,
          LoopbackAudioTrackType.lookbackApplication,
        ];
        final loopbackAudioTrackTypeItems = loopbackAudioTrackType
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
            const SizedBox(
              height: 20,
            ),
            const Text('Loopback Audio Track Type: '),
            DropdownButton<LoopbackAudioTrackType>(
              items: loopbackAudioTrackTypeItems,
              value: _loopbackAudioTrackType,
              onChanged: _loopbackAudioTrackId == kInvalidLoopbackAudioTrackId
                  ? (v) {
                      setState(() {
                        _loopbackAudioTrackType = v!;
                      });
                    }
                  : null,
            ),
            const SizedBox(
              height: 20,
            ),
            if (_loopbackAudioTrackType ==
                LoopbackAudioTrackType.lookbackApplication)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Loopback Audio Track App Name:'),
                  TextField(
                    controller: _appNameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter target app name',
                    ),
                    enabled:
                        _loopbackAudioTrackId == kInvalidLoopbackAudioTrackId,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Loopback Audio Track Volume:'),
                Slider(
                  min: 0.0,
                  max: 100.0,
                  divisions: 100,
                  label: _volume.round().toString(),
                  value: _volume,
                  onChanged:
                      _loopbackAudioTrackId == kInvalidLoopbackAudioTrackId
                          ? (double value) {
                              setState(() {
                                _volume = value;
                              });
                            }
                          : null,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(children: [
              Expanded(
                  flex: 1,
                  child: ElevatedButton(
                      onPressed:
                          _loopbackAudioTrackId == kInvalidLoopbackAudioTrackId
                              ? _createCustomAudioTrack
                              : _destroyLoopbackAudioTrack,
                      child: Text(
                          '${_loopbackAudioTrackId == kInvalidLoopbackAudioTrackId ? 'Create' : 'Destroy'} Loopback Audio Track')))
            ]),
            if (isJoined) ...[
              const SizedBox(
                height: 20,
              ),
              Row(children: [
                Expanded(
                    flex: 1,
                    child: ElevatedButton(
                        onPressed: _updateChannelMediaOptions,
                        child: const Text('Update Channel Media Options'))),
              ]),
            ],
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
          ],
        );
      },
    );
  }
}
