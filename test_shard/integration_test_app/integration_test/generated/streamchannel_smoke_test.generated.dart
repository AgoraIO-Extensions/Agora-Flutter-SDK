/// GENERATED BY testcase_gen. DO NOT MODIFY BY HAND.

// ignore_for_file: deprecated_member_use,constant_identifier_names

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:integration_test_app/main.dart' as app;

void streamChannelSmokeTestCases() {
  testWidgets(
    'join',
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

      RtmClient rtmClient = createAgoraRtmClient();
      final streamChannel = await rtmClient.createStreamChannel('');

      try {
        const String optionsToken = "hello";
        const JoinChannelOptions options = JoinChannelOptions(
          token: optionsToken,
        );
        await streamChannel.join(
          options,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[join] error: ${e.toString()}');
        }
        expect(e is AgoraRtcException, true);
        debugPrint('[join] errorcode: ${(e as AgoraRtcException).code}');
      }

      await streamChannel.release();
      await rtmClient.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'leave',
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

      RtmClient rtmClient = createAgoraRtmClient();
      final streamChannel = await rtmClient.createStreamChannel('');

      try {
        await streamChannel.leave();
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[leave] error: ${e.toString()}');
        }
        expect(e is AgoraRtcException, true);
        debugPrint('[leave] errorcode: ${(e as AgoraRtcException).code}');
      }

      await streamChannel.release();
      await rtmClient.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'getChannelName',
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

      RtmClient rtmClient = createAgoraRtmClient();
      final streamChannel = await rtmClient.createStreamChannel('');

      try {
        await streamChannel.getChannelName();
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[getChannelName] error: ${e.toString()}');
        }
        expect(e is AgoraRtcException, true);
        debugPrint(
            '[getChannelName] errorcode: ${(e as AgoraRtcException).code}');
      }

      await streamChannel.release();
      await rtmClient.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'joinTopic',
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

      RtmClient rtmClient = createAgoraRtmClient();
      final streamChannel = await rtmClient.createStreamChannel('');

      try {
        const String topic = "hello";
        const RtmMessageQos optionsQos = RtmMessageQos.rtmMessageQosUnordered;
        Uint8List optionsMeta = Uint8List.fromList([1, 2, 3, 4, 5]);
        const int optionsMetaLength = 10;
        final JoinTopicOptions options = JoinTopicOptions(
          qos: optionsQos,
          meta: optionsMeta,
          metaLength: optionsMetaLength,
        );
        await streamChannel.joinTopic(
          topic: topic,
          options: options,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[joinTopic] error: ${e.toString()}');
        }
        expect(e is AgoraRtcException, true);
        debugPrint('[joinTopic] errorcode: ${(e as AgoraRtcException).code}');
      }

      await streamChannel.release();
      await rtmClient.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'publishTopicMessage',
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

      RtmClient rtmClient = createAgoraRtmClient();
      final streamChannel = await rtmClient.createStreamChannel('');

      try {
        const String topic = "hello";
        Uint8List message = Uint8List.fromList([1, 2, 3, 4, 5]);
        const int length = 10;
        await streamChannel.publishTopicMessage(
          topic: topic,
          message: message,
          length: length,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[publishTopicMessage] error: ${e.toString()}');
        }
        expect(e is AgoraRtcException, true);
        debugPrint(
            '[publishTopicMessage] errorcode: ${(e as AgoraRtcException).code}');
      }

      await streamChannel.release();
      await rtmClient.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'leaveTopic',
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

      RtmClient rtmClient = createAgoraRtmClient();
      final streamChannel = await rtmClient.createStreamChannel('');

      try {
        const String topic = "hello";
        await streamChannel.leaveTopic(
          topic,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[leaveTopic] error: ${e.toString()}');
        }
        expect(e is AgoraRtcException, true);
        debugPrint('[leaveTopic] errorcode: ${(e as AgoraRtcException).code}');
      }

      await streamChannel.release();
      await rtmClient.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'subscribeTopic',
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

      RtmClient rtmClient = createAgoraRtmClient();
      final streamChannel = await rtmClient.createStreamChannel('');

      try {
        const String topic = "hello";
        const List<String> optionsUsers = [];
        const int optionsUserCount = 10;
        const TopicOptions options = TopicOptions(
          users: optionsUsers,
          userCount: optionsUserCount,
        );
        await streamChannel.subscribeTopic(
          topic: topic,
          options: options,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[subscribeTopic] error: ${e.toString()}');
        }
        expect(e is AgoraRtcException, true);
        debugPrint(
            '[subscribeTopic] errorcode: ${(e as AgoraRtcException).code}');
      }

      await streamChannel.release();
      await rtmClient.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'unsubscribeTopic',
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

      RtmClient rtmClient = createAgoraRtmClient();
      final streamChannel = await rtmClient.createStreamChannel('');

      try {
        const String topic = "hello";
        const List<String> optionsUsers = [];
        const int optionsUserCount = 10;
        const TopicOptions options = TopicOptions(
          users: optionsUsers,
          userCount: optionsUserCount,
        );
        await streamChannel.unsubscribeTopic(
          topic: topic,
          options: options,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[unsubscribeTopic] error: ${e.toString()}');
        }
        expect(e is AgoraRtcException, true);
        debugPrint(
            '[unsubscribeTopic] errorcode: ${(e as AgoraRtcException).code}');
      }

      await streamChannel.release();
      await rtmClient.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'getSubscribedUserList',
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

      RtmClient rtmClient = createAgoraRtmClient();
      final streamChannel = await rtmClient.createStreamChannel('');

      try {
        const String topic = "hello";
        await streamChannel.getSubscribedUserList(
          topic,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[getSubscribedUserList] error: ${e.toString()}');
        }
        expect(e is AgoraRtcException, true);
        debugPrint(
            '[getSubscribedUserList] errorcode: ${(e as AgoraRtcException).code}');
      }

      await streamChannel.release();
      await rtmClient.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );

  testWidgets(
    'release',
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

      RtmClient rtmClient = createAgoraRtmClient();
      final streamChannel = await rtmClient.createStreamChannel('');

      try {
        await streamChannel.release();
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[release] error: ${e.toString()}');
        }
        expect(e is AgoraRtcException, true);
        debugPrint('[release] errorcode: ${(e as AgoraRtcException).code}');
      }

      await streamChannel.release();
      await rtmClient.release();
      await rtcEngine.release();
    },
//  skip: !(),
  );
}
