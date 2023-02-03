import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;

void testCases() {

  testWidgets(
    'registerAudioFrameObserver smoke test',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaPlayerController = MediaPlayerController(
          rtcEngine: rtcEngine, canvas: const VideoCanvas(uid: 0));
      await mediaPlayerController.initialize();

      final MediaPlayerSourceObserver mediaPlayerSourceObserver =
          MediaPlayerSourceObserver(
        onPlayerSourceStateChanged:
            (MediaPlayerState state, MediaPlayerError ec) async {
          if (state == MediaPlayerState.playerStateOpenCompleted) {
            await mediaPlayerController.play();
          }
        },
      );
      mediaPlayerController
          .registerPlayerSourceObserver(mediaPlayerSourceObserver);

      Completer<bool>? eventCalledCompleter = Completer();
      final MediaPlayerAudioFrameObserver observer =
          MediaPlayerAudioFrameObserver(
        onFrame: (AudioPcmFrame frame) {
          if (eventCalledCompleter == null) return;
          eventCalledCompleter.complete(true);
        },
      );
      mediaPlayerController.registerAudioFrameObserver(
        observer,
      );

      await rtcEngine.enableVideo();

      await mediaPlayerController.open(
          url:
              'https://agoracdn.s3.us-west-1.amazonaws.com/videos/Agora.io-Interactions.mp4',
          startPos: 0);

      final eventCalled = await eventCalledCompleter.future;
      expect(eventCalled, isTrue);
      eventCalledCompleter = null;

      mediaPlayerController.unregisterAudioFrameObserver(observer);
      mediaPlayerController
          .unregisterPlayerSourceObserver(mediaPlayerSourceObserver);

      await mediaPlayerController.dispose();
      await rtcEngine.release();
    },
    // TODO(littlegnal): This case is not work on github action, should be fixed in the future
    skip: Platform.isAndroid,
  );

  testWidgets(
    'registerVideoFrameObserver smoke test',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaPlayerController = MediaPlayerController(
          rtcEngine: rtcEngine, canvas: const VideoCanvas(uid: 0));
      await mediaPlayerController.initialize();

      final MediaPlayerSourceObserver mediaPlayerSourceObserver =
          MediaPlayerSourceObserver(
        onPlayerSourceStateChanged:
            (MediaPlayerState state, MediaPlayerError ec) async {
          if (state == MediaPlayerState.playerStateOpenCompleted) {
            await mediaPlayerController.play();
          }
        },
      );
      mediaPlayerController
          .registerPlayerSourceObserver(mediaPlayerSourceObserver);

      Completer<bool>? eventCalledCompleter = Completer();

      final MediaPlayerVideoFrameObserver observer =
          MediaPlayerVideoFrameObserver(
        onFrame: (frame) {
          if (eventCalledCompleter == null) return;
          eventCalledCompleter.complete(true);
        },
      );
      mediaPlayerController.registerVideoFrameObserver(
        observer,
      );

      await rtcEngine.enableVideo();

      await mediaPlayerController.open(
          url:
              'https://agoracdn.s3.us-west-1.amazonaws.com/videos/Agora.io-Interactions.mp4',
          startPos: 0);

      final eventCalled = await eventCalledCompleter.future;
      expect(eventCalled, isTrue);
      eventCalledCompleter = null;

      mediaPlayerController.unregisterVideoFrameObserver(observer);
      mediaPlayerController
          .unregisterPlayerSourceObserver(mediaPlayerSourceObserver);

      await mediaPlayerController.dispose();
      await rtcEngine.release();
    },
// TODO(littlegnal): This case is not work on github action, should be fixed in the future
    skip: Platform.isAndroid,
  );

  testWidgets(
    'registerMediaPlayerAudioSpectrumObserver',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final mediaPlayerController = MediaPlayerController(
          rtcEngine: rtcEngine, canvas: const VideoCanvas(uid: 0));
      await mediaPlayerController.initialize();

      final MediaPlayerSourceObserver mediaPlayerSourceObserver =
          MediaPlayerSourceObserver(
        onPlayerSourceStateChanged:
            (MediaPlayerState state, MediaPlayerError ec) async {
          if (state == MediaPlayerState.playerStateOpenCompleted) {
            await mediaPlayerController.play();
          }
        },
      );
      mediaPlayerController
          .registerPlayerSourceObserver(mediaPlayerSourceObserver);

      Completer<bool>? eventCalledCompleter = Completer();

      final AudioSpectrumObserver observer = AudioSpectrumObserver(
        onLocalAudioSpectrum: (data) {
          if (eventCalledCompleter == null) return;
          eventCalledCompleter.complete(true);
        },
      );
      mediaPlayerController.registerMediaPlayerAudioSpectrumObserver(
          observer: observer, intervalInMS: 500);

      await rtcEngine.enableVideo();

      await mediaPlayerController.open(
          url:
              'https://agoracdn.s3.us-west-1.amazonaws.com/videos/Agora.io-Interactions.mp4',
          startPos: 0);

      final eventCalled = await eventCalledCompleter.future;
      expect(eventCalled, isTrue);
      eventCalledCompleter = null;

      mediaPlayerController
          .unregisterMediaPlayerAudioSpectrumObserver(observer);
      mediaPlayerController
          .unregisterPlayerSourceObserver(mediaPlayerSourceObserver);

      await mediaPlayerController.dispose();
      await rtcEngine.release();
    },
//  skip: !(),
  );
}
