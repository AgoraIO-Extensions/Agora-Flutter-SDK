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
  );

  testWidgets(
    'registerEventHandler multiple times',
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

      Completer<bool> event1CalledCompleter = Completer();
      Completer<bool> event2CalledCompleter = Completer();

      rtcEngine.registerEventHandler(RtcEngineEventHandler(
        onUserJoined: (connection, remoteUid, elapsed) {
          if (event1CalledCompleter.isCompleted) {
            return;
          }

          event1CalledCompleter.complete(true);
        },
      ));

      rtcEngine.registerEventHandler(RtcEngineEventHandler(
        onUserJoined: (connection, remoteUid, elapsed) {
          if (event2CalledCompleter.isCompleted) {
            return;
          }

          event2CalledCompleter.complete(true);
        },
      ));

      await rtcEngine.enableVideo();

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
      await remoteUser.joinChannel(remoteUid: 123);

      expect(await event1CalledCompleter.future, isTrue);
      expect(await event2CalledCompleter.future, isTrue);

      await remoteUser.leaveChannel();
      await rtcEngine.leaveChannel();
      await rtcEngine.release();
    },
  );

  testWidgets(
    'unregisterEventHandler smoke test',
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

      Completer<bool> event1CalledCompleter = Completer();
      Completer<bool> event2CalledCompleter = Completer();

      final eventHandler1 = RtcEngineEventHandler(
        onUserJoined: (connection, remoteUid, elapsed) {
          if (event1CalledCompleter.isCompleted) {
            return;
          }

          event1CalledCompleter.complete(true);
        },
      );

      rtcEngine.registerEventHandler(eventHandler1);

      bool event2Called = false;

      final eventHandler2 = RtcEngineEventHandler(
        onUserJoined: (connection, remoteUid, elapsed) {
          event2Called = true;
        },
      );

      // Delay 2 seconds to ensure the rtcEngine.registerEventHandler(eventHandler1) call completed.
      await Future.delayed(const Duration(seconds: 2));

      rtcEngine.registerEventHandler(eventHandler2);

      // Delay 2 seconds to ensure the rtcEngine.registerEventHandler(eventHandler2) call completed.
      await Future.delayed(const Duration(seconds: 2));
      rtcEngine.unregisterEventHandler(eventHandler2);

      await rtcEngine.enableVideo();

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
      await remoteUser.joinChannel(remoteUid: 123);

      expect(await event1CalledCompleter.future, isTrue);

      // Delay 2 seconds to ensure the event2Called be triggered.
      await Future.delayed(const Duration(seconds: 2));

      expect(event2Called, isFalse);

      await remoteUser.leaveChannel();
      await rtcEngine.leaveChannel();
      await rtcEngine.release();
    },
  );
}
