import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../generated/rtcengineex_fake_test.generated.dart' as generated;

void testCases() {
  generated.rtcEngineExSmokeTestCases();

  testWidgets(
    'setSubscribeAudioBlocklistEx',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngineEx rtcEngineEx = createAgoraRtcEngineEx();
      await rtcEngineEx.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const List<int> uidList = [10];
        const int uidNumber = 1;
        const String connectionChannelId = "hello";
        const int connectionLocalUid = 10;
        const RtcConnection connection = RtcConnection(
          channelId: connectionChannelId,
          localUid: connectionLocalUid,
        );
        await rtcEngineEx.setSubscribeAudioBlocklistEx(
          uidList: uidList,
          uidNumber: uidNumber,
          connection: connection,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setSubscribeAudioBlocklistEx] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngineEx.release();
    },
//  skip: !(),
  );

  testWidgets(
    'setSubscribeAudioAllowlistEx',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngineEx rtcEngineEx = createAgoraRtcEngineEx();
      await rtcEngineEx.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const List<int> uidList = [10];
        const int uidNumber = 1;
        const String connectionChannelId = "hello";
        const int connectionLocalUid = 10;
        const RtcConnection connection = RtcConnection(
          channelId: connectionChannelId,
          localUid: connectionLocalUid,
        );
        await rtcEngineEx.setSubscribeAudioAllowlistEx(
          uidList: uidList,
          uidNumber: uidNumber,
          connection: connection,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setSubscribeAudioAllowlistEx] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngineEx.release();
    },
//  skip: !(),
  );

  testWidgets(
    'setSubscribeVideoBlocklistEx',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngineEx rtcEngineEx = createAgoraRtcEngineEx();
      await rtcEngineEx.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const List<int> uidList = [10];
        const int uidNumber = 1;
        const String connectionChannelId = "hello";
        const int connectionLocalUid = 10;
        const RtcConnection connection = RtcConnection(
          channelId: connectionChannelId,
          localUid: connectionLocalUid,
        );
        await rtcEngineEx.setSubscribeVideoBlocklistEx(
          uidList: uidList,
          uidNumber: uidNumber,
          connection: connection,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setSubscribeVideoBlocklistEx] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngineEx.release();
    },
//  skip: !(),
  );

  testWidgets(
    'setSubscribeVideoAllowlistEx',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngineEx rtcEngineEx = createAgoraRtcEngineEx();
      await rtcEngineEx.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const List<int> uidList = [10];
        const int uidNumber = 1;
        const String connectionChannelId = "hello";
        const int connectionLocalUid = 10;
        const RtcConnection connection = RtcConnection(
          channelId: connectionChannelId,
          localUid: connectionLocalUid,
        );
        await rtcEngineEx.setSubscribeVideoAllowlistEx(
          uidList: uidList,
          uidNumber: uidNumber,
          connection: connection,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setSubscribeVideoAllowlistEx] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngineEx.release();
    },
//  skip: !(),
  );

  testWidgets(
    'startOrUpdateChannelMediaRelayEx',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngineEx rtcEngineEx = createAgoraRtcEngineEx();
      await rtcEngineEx.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const String srcInfoChannelName = "hello";
        const String srcInfoToken = "hello";
        const int srcInfoUid = 10;
        const ChannelMediaInfo configurationSrcInfo = ChannelMediaInfo(
          channelName: srcInfoChannelName,
          token: srcInfoToken,
          uid: srcInfoUid,
        );
        const List<ChannelMediaInfo> configurationDestInfos = [
          ChannelMediaInfo(channelName: 'hello', token: 'hello', uid: 100),
        ];
        const int configurationDestCount = 1;
        const ChannelMediaRelayConfiguration configuration =
            ChannelMediaRelayConfiguration(
          srcInfo: configurationSrcInfo,
          destInfos: configurationDestInfos,
          destCount: configurationDestCount,
        );
        const String connectionChannelId = "hello";
        const int connectionLocalUid = 10;
        const RtcConnection connection = RtcConnection(
          channelId: connectionChannelId,
          localUid: connectionLocalUid,
        );
        await rtcEngineEx.startOrUpdateChannelMediaRelayEx(
          configuration: configuration,
          connection: connection,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[startChannelMediaRelayEx] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngineEx.release();
    },
  );

  testWidgets(
    'setHighPriorityUserListEx',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngineEx rtcEngineEx = createAgoraRtcEngineEx();
      await rtcEngineEx.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const List<int> uidList = [1];
        const int uidNum = 1;
        const StreamFallbackOptions option =
            StreamFallbackOptions.streamFallbackOptionDisabled;
        const String connectionChannelId = "hello";
        const int connectionLocalUid = 10;
        const RtcConnection connection = RtcConnection(
          channelId: connectionChannelId,
          localUid: connectionLocalUid,
        );
        await rtcEngineEx.setHighPriorityUserListEx(
          uidList: uidList,
          uidNum: uidNum,
          option: option,
          connection: connection,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setHighPriorityUserListEx] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngineEx.release();
    },
//  skip: !(),
  );
}
