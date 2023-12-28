import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import '../generated/rtcengine_fake_test.generated.dart' as generated;

void testCases() {
  generated.rtcEngineSmokeTestCases();

  testWidgets(
    'startOrUpdateChannelMediaRelay',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
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
        await rtcEngine.startOrUpdateChannelMediaRelay(
          configuration,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[startChannelMediaRelay] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngine.release();
    },
  );

  testWidgets(
    'setLocalAccessPoint',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const LocalProxyMode configMode = LocalProxyMode.connectivityFirst;
        const String logUploadServerServerDomain = "hello";
        const String logUploadServerServerPath = "hello";
        const int logUploadServerServerPort = 10;
        const bool logUploadServerServerHttps = true;
        const LogUploadServerInfo advancedConfigLogUploadServer =
            LogUploadServerInfo(
          serverDomain: logUploadServerServerDomain,
          serverPath: logUploadServerServerPath,
          serverPort: logUploadServerServerPort,
          serverHttps: logUploadServerServerHttps,
        );
        const AdvancedConfigInfo configAdvancedConfig = AdvancedConfigInfo(
          logUploadServer: advancedConfigLogUploadServer,
        );
        const List<String> configIpList = ['127.0.0.1'];
        const int configIpListSize = 1;
        const List<String> configDomainList = ['127.0.0.1'];
        const int configDomainListSize = 1;
        const String configVerifyDomainName = "hello";
        const LocalAccessPointConfiguration config =
            LocalAccessPointConfiguration(
          ipList: configIpList,
          ipListSize: configIpListSize,
          domainList: configDomainList,
          domainListSize: configDomainListSize,
          verifyDomainName: configVerifyDomainName,
          mode: configMode,
          advancedConfig: configAdvancedConfig,
        );
        await rtcEngine.setLocalAccessPoint(
          config,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setLocalAccessPoint] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngine.release();
    },
  );

  testWidgets(
    'setSubscribeAudioBlocklist',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const List<int> uidList = [10];
        const int uidNumber = 1;
        await rtcEngine.setSubscribeAudioBlocklist(
          uidList: uidList,
          uidNumber: uidNumber,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setSubscribeAudioBlocklist] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngine.release();
    },
  );

  testWidgets(
    'setSubscribeAudioAllowlist',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const List<int> uidList = [10];
        const int uidNumber = 1;
        await rtcEngine.setSubscribeAudioAllowlist(
          uidList: uidList,
          uidNumber: uidNumber,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setSubscribeAudioAllowlist] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngine.release();
    },
  );

  testWidgets(
    'setSubscribeVideoBlocklist',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const List<int> uidList = [10];
        const int uidNumber = 1;
        await rtcEngine.setSubscribeVideoBlocklist(
          uidList: uidList,
          uidNumber: uidNumber,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setSubscribeVideoBlocklist] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngine.release();
    },
  );

  testWidgets(
    'setSubscribeVideoAllowlist',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const List<int> uidList = [10];
        const int uidNumber = 1;
        await rtcEngine.setSubscribeVideoAllowlist(
          uidList: uidList,
          uidNumber: uidNumber,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setSubscribeVideoAllowlist] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngine.release();
    },
  );

  testWidgets(
    'createMediaRecorder',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        final mediaRecorder = await rtcEngine.createMediaRecorder(
            RecorderStreamInfo(channelId: 'hello', uid: 0));

        await rtcEngine.destroyMediaRecorder(mediaRecorder!);
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[createMediaRecorder] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngine.release();
    },
  );

  testWidgets(
    'queryCodecCapability',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const int size = 0;
        await rtcEngine.queryCodecCapability(
          size,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[queryCodecCapability] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngine.release();
    },
  );

  testWidgets(
    'setHighPriorityUserList',
    (WidgetTester tester) async {
      String engineAppId = const String.fromEnvironment('TEST_APP_ID',
          defaultValue: '<YOUR_APP_ID>');

      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: engineAppId,
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      try {
        const List<int> uidList = [1];
        const int uidNum = 1;
        const StreamFallbackOptions option =
            StreamFallbackOptions.streamFallbackOptionDisabled;
        await rtcEngine.setHighPriorityUserList(
          uidList: uidList,
          uidNum: uidNum,
          option: option,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[setHighPriorityUserList] error: ${e.toString()}');
          rethrow;
        }

        if (e.code != -4) {
          // Only not supported error supported.
          rethrow;
        }
      }

      await rtcEngine.release();
    },
  );
}
