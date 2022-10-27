import 'dart:async';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/fake_remote_user.dart';
import 'package:integration_test_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'registerAudioEncodedFrameObserver smoke test',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngineEx rtcEngine = createAgoraRtcEngineEx();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      // TODO(littlegnal): Remove when native sdk 410 done.
      rtcEngine.registerEventHandler(const RtcEngineEventHandler());
      await rtcEngine.enableVideo();

      Completer<bool> eventCalledCompleter = Completer();
      final AudioEncodedFrameObserver observer = AudioEncodedFrameObserver(
        onRecordAudioEncodedFrame: (Uint8List frameBuffer, int length,
            EncodedAudioFrameInfo audioEncodedFrameInfo) {
          debugPrint('onRecordAudioEncodedFrame');
        },
        onPlaybackAudioEncodedFrame: (Uint8List frameBuffer, int length,
            EncodedAudioFrameInfo audioEncodedFrameInfo) {
          debugPrint('onPlaybackAudioEncodedFrame');
        },
        onMixedAudioEncodedFrame: (Uint8List frameBuffer, int length,
            EncodedAudioFrameInfo audioEncodedFrameInfo) {
          debugPrint('onMixedAudioEncodedFrame');
          if (eventCalledCompleter.isCompleted) return;
          eventCalledCompleter.complete(true);
        },
      );
      rtcEngine.registerAudioEncodedFrameObserver(
          config: const AudioEncodedFrameObserverConfig(
              postionType: AudioEncodedFrameObserverPosition
                  .audioEncodedFrameObserverPositionMixed,
              encodingType: AudioEncodingType.audioEncodingTypeAac16000Medium),
          observer: observer);

      await rtcEngine.joinChannel(
        token: '',
        channelId: 'testonaction',
        uid: 0,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );

      final remoteUser = FakeRemoteUser(rtcEngine);
      await remoteUser.joinChannel();

      final eventCalled = await eventCalledCompleter.future;
      expect(eventCalled, isTrue);

      rtcEngine.unregisterAudioEncodedFrameObserver(
        observer,
      );

      await remoteUser.leaveChannel();
      await rtcEngine.leaveChannel();
      await rtcEngine.release();
    },
//  skip: !(),
  );
}
