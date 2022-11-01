import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class FakeRemoteUser {
  FakeRemoteUser(this._rtcEngineEx);

  final RtcEngineEx _rtcEngineEx;

  late final MediaPlayerController _mediaPlayerController;

  Future<void> joinChannel(
      {String channelName = 'testonaction', int remoteUid = 67890}) async {
    // Use the the MediaPlayer to simulate a remote user
    _mediaPlayerController = await _remoteUserController(
        _rtcEngineEx, channelName,
        remoteUid: remoteUid);
  }

  Future<void> leaveChannel() async {
    await _mediaPlayerController.stop();
    await _mediaPlayerController.dispose();
  }

  Future<MediaPlayerController> _remoteUserController(
      RtcEngineEx rtcEngine, String channelName,
      {int remoteUid = 67890}) async {
    final mediaPlayerControllerPlayed = Completer<void>();
    final mediaPlayerController = MediaPlayerController(
        rtcEngine: rtcEngine, canvas: const VideoCanvas(uid: 0));
    await mediaPlayerController.initialize();

    final MediaPlayerSourceObserver mediaPlayerSourceObserver =
        MediaPlayerSourceObserver(
      onPlayerSourceStateChanged:
          (MediaPlayerState state, MediaPlayerError ec) async {
        if (state == MediaPlayerState.playerStateOpenCompleted) {
          await mediaPlayerController.play();
          await mediaPlayerController.setLoopCount(99999);
          mediaPlayerControllerPlayed.complete();
        }
      },
    );
    mediaPlayerController
        .registerPlayerSourceObserver(mediaPlayerSourceObserver);

    await mediaPlayerController.open(
        url:
            'https://agoracdn.s3.us-west-1.amazonaws.com/videos/Agora.io-Interactions.mp4',
        startPos: 0);

    await mediaPlayerControllerPlayed.future;

    await rtcEngine.joinChannelEx(
      token: '',
      connection: RtcConnection(
        channelId: channelName,
        localUid: remoteUid,
      ),
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: false,
        autoSubscribeVideo: false,
        enableAudioRecordingOrPlayout: true,
        publishMediaPlayerAudioTrack: true,
        publishMediaPlayerVideoTrack: true,
        publishMediaPlayerId: mediaPlayerController.getMediaPlayerId(),
      ),
    );

    return mediaPlayerController;
  }
}
