import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// SendMultiVideoStream Example
class SendMultiVideoStream extends StatefulWidget {
  const SendMultiVideoStream({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SendMultiVideoStream> {
  late final RtcEngineEx _engine;
  bool _isReadyPreview = false;

  late final MediaPlayerController _mediaPlayerController;

  late final TextEditingController _textEditingController;

  bool _isUrlOpened = false;
  bool _isPlaying = false;
  bool isJoined = false;

  late TextEditingController _channelIdController;

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: config.channelId);
    _textEditingController = TextEditingController(
        text:
            'https://agoracdn.s3.us-west-1.amazonaws.com/videos/Agora.io-Interactions.mp4');
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  void _dispose() async {
    await _mediaPlayerController.dispose();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngineEx();
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

    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.startPreview();

    _mediaPlayerController = MediaPlayerController(
        rtcEngine: _engine,
        canvas: const VideoCanvas(
          uid: 0,
          sourceType: VideoSourceType.videoSourceMediaPlayer,
        ));
    await _mediaPlayerController.initialize();
    _mediaPlayerController.registerPlayerSourceObserver(
      MediaPlayerSourceObserver(
        onCompleted: () {
          logSink.log('[onCompleted]');
        },
        onPlayerSourceStateChanged:
            (MediaPlayerState state, MediaPlayerReason ec) {
          logSink.log('[onPlayerSourceStateChanged] state: $state ec: $ec');
          if (state == MediaPlayerState.playerStateOpenCompleted) {
            debugPrint('src ${_mediaPlayerController.getPlaySrc()}');
            _mediaPlayerController.play();
            setState(() {
              _isUrlOpened = !_isUrlOpened;
              _isPlaying = !_isPlaying;
            });
          }
        },
        onPositionChanged: (int positionMs, int timestampMs) {
          logSink.log(
              '[onPositionChanged] position: $positionMs, timestampMs: $timestampMs');
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

  void _open() {
    if (!_isUrlOpened) {
      _mediaPlayerController.open(
          url: _textEditingController.text, startPos: 0);
    } else {
      if (_isPlaying) {
        _mediaPlayerController.stop();
      } else {
        _mediaPlayerController.play();
      }

      setState(() {
        _isPlaying = !_isPlaying;
        _isUrlOpened = !_isUrlOpened;
      });
    }
  }

  void _joinChannel() async {
    await _engine.joinChannelEx(
      token: '',
      connection: RtcConnection(
        channelId: _channelIdController.text,
        localUid: 123,
      ),
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishMicrophoneTrack: true,
        publishCameraTrack: true,
      ),
    );

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

  void _leaveChannel() async {
    if (_isPlaying) {
      _mediaPlayerController.stop();

      setState(() {
        _isUrlOpened = false;
        _isPlaying = false;
      });
    }
    await _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        final children = <Widget>[
          Expanded(
            flex: 1,
            child: AspectRatio(
              aspectRatio: 1,
              child: AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: _engine,
                  canvas: const VideoCanvas(
                    uid: 0,
                    sourceType: VideoSourceType.videoSourceCamera,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: _isUrlOpened
                  ? AgoraVideoView(
                      controller: _mediaPlayerController,
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Text('MediaPlayer'),
                      ),
                    ),
            ),
          ),
        ];
        if (isLayoutHorizontal) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _channelIdController,
                  decoration: const InputDecoration(hintText: 'Channel ID'),
                ),
              ],
            ),
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
                onPressed: !isJoined ? _open : null,
                child: Text(_isPlaying ? "Stop" : "Play"),
              ),
            ]),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _isPlaying
                        ? (isJoined ? _leaveChannel : _joinChannel)
                        : null,
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
