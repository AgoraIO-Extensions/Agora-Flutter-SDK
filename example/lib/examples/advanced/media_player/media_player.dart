import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// MediaPlayer Example
class MediaPlayer extends StatefulWidget {
  const MediaPlayer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<MediaPlayer> {
  late final RtcEngineEx _engine;
  bool _isReadyPreview = false;

  late MediaPlayerController _mediaPlayerController;

  late final TextEditingController _textEditingController;

  late TextEditingController _channelIdController;
  late TextEditingController _loopCountController;
  late TextEditingController _streamInfoIndexController;
  bool _isMuted = false;

  bool _isUrlOpened = false;
  bool _isPlaying = false;
  bool _isPause = true;

  int _seekPos = 0;
  int _duration = 0;
  int _playoutVolume = 100;
  int _streamCount = 0;

  bool isJoined = false;

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: config.channelId);
    _textEditingController = TextEditingController(
        text:
            'https://agoracdn.s3.us-west-1.amazonaws.com/videos/Agora.io-Interactions.mp4');
    _loopCountController = TextEditingController(text: '1');
    _streamInfoIndexController = TextEditingController(text: '1');
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _channelIdController.dispose();
    _textEditingController.dispose();
    _loopCountController.dispose();

    _dispose();
  }

  void _dispose() async {
    await _mediaPlayerController.dispose();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngineEx();
    _mediaPlayerController = MediaPlayerController(
        rtcEngine: _engine, canvas: const VideoCanvas(uid: 0));
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
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));

    _mediaPlayerController = MediaPlayerController(
        rtcEngine: _engine, canvas: const VideoCanvas(uid: 0));
    await _mediaPlayerController.initialize();
    _mediaPlayerController.registerPlayerSourceObserver(
      MediaPlayerSourceObserver(
        onCompleted: () {
          logSink.log('[onCompleted]');
        },
        onPlayerSourceStateChanged:
            (MediaPlayerState state, MediaPlayerReason ec) async {
          logSink.log('[onPlayerSourceStateChanged] state: $state ec: $ec');
          if (state == MediaPlayerState.playerStateOpenCompleted) {
            _streamCount = await _mediaPlayerController.getStreamCount();
            _duration = await _mediaPlayerController.getDuration();
            _isUrlOpened = true;
            _isPlaying = false;
            // _isStop = false;
            _isPause = false;
          } else if (state == MediaPlayerState.playerStateStopped) {
            _isUrlOpened = false;
            _isPlaying = false;
            // _isStop = true;
            _isPause = false;
            _seekPos = 0;
            _isMuted = false;
          } else if (state == MediaPlayerState.playerStatePlaying) {
            _isPlaying = true;
            _isPause = false;
          } else if (state == MediaPlayerState.playerStatePaused) {
            _isPause = true;
          }

          setState(() {});
        },
        onPositionChanged: (int positionMs, int timestampMs) {
          logSink.log(
              '[onPositionChanged] position: $positionMs, timestampMs: $timestampMs');

          setState(() {
            _seekPos = positionMs;
          });
        },
        onPlayerEvent:
            (MediaPlayerEvent eventCode, int elapsedTime, String message) {
          logSink.log(
              '[onPlayerEvent] eventCode: $eventCode, elapsedTime: $elapsedTime, message: $message');
        },
      ),
    );

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _leaveChannel() async {
    if (_isUrlOpened) {
      await _mediaPlayerController.stop();
    }
    await _engine.leaveChannel();
  }

  void _joinChannel() async {
    await _engine.joinChannelEx(
      token: '',
      connection: RtcConnection(
        channelId: _channelIdController.text,
        localUid: 456,
      ),
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishMediaPlayerAudioTrack: true,
        publishMediaPlayerVideoTrack: true,
        publishMediaPlayerId: _mediaPlayerController.getMediaPlayerId(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        if (_isUrlOpened) {
          return AgoraVideoView(
            controller: _mediaPlayerController,
          );
        }

        return const Center(
          child: Text('MediaPlayer'),
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Media URL',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: !_isUrlOpened
                    ? () async {
                        await _mediaPlayerController.open(
                            url: _textEditingController.text, startPos: 0);
                      }
                    : null,
                child: const Text('Open'),
              ),
              const SizedBox(
                height: 20,
              ),
            ]),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _channelIdController,
                    decoration: const InputDecoration(hintText: 'Channel ID'),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isPlaying
                      ? (isJoined ? _leaveChannel : _joinChannel)
                      : null,
                  child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            if (_isUrlOpened)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Slider(
                            value: _seekPos.toDouble(),
                            min: 0,
                            max: _duration.toDouble(),
                            divisions: 100,
                            label: '${(_seekPos / 1000.round())} s',
                            onChanged: (double value) {
                              _seekPos = value.toInt();
                              _mediaPlayerController.seek(_seekPos);
                              setState(() {});
                            }),
                      ),
                      Text(
                        '${(_seekPos / 1000).round()}/${(_duration / 1000).round()}s',
                        style: const TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (!_isPlaying) {
                        _mediaPlayerController.play();
                      } else {
                        _mediaPlayerController.stop();
                      }
                    },
                    child: Text(!_isPlaying ? 'Play' : 'Stop'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _isPlaying
                        ? () {
                            if (!_isPause) {
                              _mediaPlayerController.pause();
                            } else {
                              _mediaPlayerController.resume();
                            }
                          }
                        : null,
                    child: Text(!_isPause ? 'Pause' : 'Resume'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _loopCountController,
                          decoration:
                              const InputDecoration(hintText: 'Loop count'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final loopCount =
                              int.tryParse(_loopCountController.text) ?? -1;
                          if (loopCount != -1) {
                            await _mediaPlayerController
                                .setLoopCount(loopCount);
                          }
                        },
                        child: const Text('Update loop count'),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    const Text('mute: '),
                    Switch(
                      value: _isMuted,
                      onChanged: (changed) async {
                        _isMuted = changed;
                        await _mediaPlayerController.mute(_isMuted);
                        setState(() {});
                      },
                    )
                  ]),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Playout volume',
                        style: TextStyle(fontSize: 10),
                      ),
                      Expanded(
                        child: Slider(
                            value: _playoutVolume.toDouble(),
                            min: 0,
                            max: 100,
                            divisions: 100,
                            label: '${_playoutVolume.round()}',
                            onChanged: (double value) async {
                              _playoutVolume = value.toInt();
                              _mediaPlayerController
                                  .adjustPlayoutVolume(_playoutVolume);

                              setState(() {});
                            }),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text('Total stream count: $_streamCount'),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _streamInfoIndexController,
                          decoration:
                              const InputDecoration(hintText: 'Loop count'),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _streamCount < 1
                            ? null
                            : () async {
                                final streamIndex = int.tryParse(
                                        _streamInfoIndexController.text) ??
                                    -1;
                                if (streamIndex >= 0 &&
                                    streamIndex < _streamCount) {
                                  final info = await _mediaPlayerController
                                      .getStreamInfo(streamIndex);
                                  logSink.log(
                                      '[getStreamInfo] index: $streamIndex, info: ${info.toJson()}');
                                }
                              },
                        child: const Text('Get stream info'),
                      ),
                    ],
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
