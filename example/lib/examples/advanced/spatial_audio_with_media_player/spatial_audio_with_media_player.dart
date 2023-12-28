import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// SpatialAudioWithMediaPlayer Example
class SpatialAudioWithMediaPlayer extends StatefulWidget {
  const SpatialAudioWithMediaPlayer({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SpatialAudioWithMediaPlayer> {
  late final RtcEngineEx _engine;
  bool _isReadyPreview = false;

  late final MediaPlayerController _mediaPlayerController;

  late final TextEditingController _textEditingController;

  bool _isUrlOpened = false;
  bool _isPlaying = false;
  bool isJoined = false;

  static const int _uid = 123;
  static const int _uidMpk = 67890;

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
    await _engine.getLocalSpatialAudioEngine().release();
    await _mediaPlayerController.dispose();

    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngineEx();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      audioScenario: AudioScenarioType.audioScenarioGameStreaming,
    ));

    await _engine.getLocalSpatialAudioEngine().initialize();

    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');

        List<double> f1 = [0.0, 0.0, 0.0];
        List<double> f2 = [1.0, 0.0, 0.0];
        List<double> f3 = [0.0, 1.0, 0.0];
        List<double> f4 = [0.0, 0.0, 1.0];

        _engine.getLocalSpatialAudioEngine().updateSelfPositionEx(
            position: f1,
            axisForward: f2,
            axisRight: f3,
            axisUp: f4,
            connection: connection);

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

    await _engine.enableAudio();
    await _engine.enableVideo();
    await _engine.enableSpatialAudio(true);
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

  Future<void> _open() async {
    if (!_isUrlOpened) {
      await _mediaPlayerController.open(
          url: _textEditingController.text, startPos: 0);
      await _mediaPlayerController.adjustPlayoutVolume(0);
    } else {
      if (_isPlaying) {
        await _mediaPlayerController.stop();
      } else {
        await _mediaPlayerController.play();
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
        localUid: _uid,
      ),
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: true,
        autoSubscribeVideo: true,
        enableAudioRecordingOrPlayout: true,
        // publishMicrophoneTrack: true,
        publishCameraTrack: true,
      ),
    );

    await _engine.joinChannelEx(
      token: '',
      connection: RtcConnection(
        channelId: _channelIdController.text,
        localUid: _uidMpk,
      ),
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: false,
        autoSubscribeVideo: false,
        enableAudioRecordingOrPlayout: false,
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

  Future<void> _onLeftLocationPress() async {
    List<double> f1 = [0.0, -1.0, 0.0];
    await _engine.getLocalSpatialAudioEngine().updateRemotePositionEx(
        uid: _uidMpk,
        posInfo:
            RemoteVoicePositionInfo(position: f1, forward: [0.0, 0.0, 0.0]),
        connection: RtcConnection(
          channelId: _channelIdController.text,
          localUid: _uid,
        ));
  }

  Future<void> _onRightLocationPress() async {
    List<double> f1 = [0.0, 1.0, 0.0];
    await _engine.getLocalSpatialAudioEngine().updateRemotePositionEx(
        uid: _uidMpk,
        posInfo:
            RemoteVoicePositionInfo(position: f1, forward: [0.0, 0.0, 0.0]),
        connection: RtcConnection(
          channelId: _channelIdController.text,
          localUid: _uid,
        ));
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
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isJoined ? _onLeftLocationPress : null,
              child: const Text('Left Location'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: isJoined ? _onRightLocationPress : null,
              child: const Text('Right Location'),
            ),
          ],
        );
      },
    );
  }
}
