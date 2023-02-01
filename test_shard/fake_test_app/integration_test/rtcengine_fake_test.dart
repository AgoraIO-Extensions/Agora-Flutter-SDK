import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:iris_tester/iris_tester.dart';
// import 'package:path_provider/path_provider.dart';
import 'generated/rtcengine_fake_test.generated.dart' as generated;
// import 'package:integration_test_app/main.dart' as app;
import 'package:path/path.dart' as path;
import 'package:iris_method_channel/iris_method_channel.dart';

// import 'package:fake_test_app/fake_remote_user.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  generated.rtcEngineSmokeTestCases();

  testWidgets(
    'startChannelMediaRelay',
    (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
        await rtcEngine.startChannelMediaRelay(
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
    'updateChannelMediaRelay',
    (WidgetTester tester) async {
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
        await rtcEngine.updateChannelMediaRelay(
          configuration,
        );
      } catch (e) {
        if (e is! AgoraRtcException) {
          debugPrint('[updateChannelMediaRelay] error: ${e.toString()}');
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
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
      final irisTester = IrisTester();
      final debugApiEngineIntPtr = irisTester.createDebugApiEngine();
      setMockIrisMethodChannelNativeHandle(debugApiEngineIntPtr);

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
}
