import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/api_types.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

// ignore_for_file: deprecated_member_use

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late RtcEngine rtcEngine;
  late FakeIrisRtcEngine fakeIrisEngine;

  tearDown(() async {
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  group('createWithContext', () {
    testWidgets('with `appId`', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      final context = RtcEngineContext('123');

      rtcEngine = await RtcEngine.createWithContext(context);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineInitialize.index,
        jsonEncode({
          'context': context.toJson(),
          'appGroup': null,
        }),
      );

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetAppType.index,
        jsonEncode({
          'appType': 4,
        }),
      );
    });

    testWidgets('with `appId` and `areaCode`', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      final context = RtcEngineContext(
        '123',
        areaCode: const [AreaCode.GLOB],
      );

      rtcEngine = await RtcEngine.createWithContext(context);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineInitialize.index,
        jsonEncode({
          'context': context.toJson(),
          'appGroup': null,
        }),
      );

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetAppType.index,
        jsonEncode({
          'appType': 4,
        }),
      );
    });

    testWidgets('with `appId`, `areaCode` and `logConfig`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      final context = RtcEngineContext(
        '123',
        areaCode: const [AreaCode.CN],
        logConfig: LogConfig(filePath: '/path'),
      );

      rtcEngine = await RtcEngine.createWithContext(context);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineInitialize.index,
        jsonEncode({
          'context': context.toJson(),
          'appGroup': null,
        }),
      );

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetAppType.index,
        jsonEncode({
          'appType': 4,
        }),
      );
    });
  });

  testWidgets('create', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineInitialize.index,
      jsonEncode({
        'context': RtcEngineContext('123').toJson(),
        'appGroup': null,
      }),
    );

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetAppType.index,
      jsonEncode({
        'appType': 4,
      }),
    );
  });

  testWidgets(
    'getErrorDescription',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      fakeIrisEngine.mockCallApiResult(
        ApiTypeEngine.kEngineGetErrorDescription.index,
        jsonEncode({
          'code': 1,
        }),
        'Fail',
      );

      final ret = await rtcEngine.getErrorDescription(1);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineGetErrorDescription.index,
        jsonEncode({
          'code': 1,
        }),
      );
      expect(ret, 'Fail');
    },
    // TODO(littlegnal): Temporary skip for Windows, cause it will be crash this time
    skip: Platform.isWindows,
  );

  testWidgets('setChannelProfile', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    const channelProfile = ChannelProfile.LiveBroadcasting;
    await rtcEngine.setChannelProfile(channelProfile);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetChannelProfile.index,
      jsonEncode({
        'profile': 1,
      }),
    );
  });

  group('setClientRole', () {
    testWidgets('with `role`', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.setClientRole(ClientRole.Broadcaster);
      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetClientRole.index,
        jsonEncode({
          'role': 1,
          'options': null,
        }),
      );
    });

    testWidgets('with `role` and `options`', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      final options = ClientRoleOptions(
        audienceLatencyLevel: AudienceLatencyLevelType.UltraLowLatency,
      );
      await rtcEngine.setClientRole(ClientRole.Broadcaster, options);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetClientRole.index,
        jsonEncode({
          'role': 1,
          'options': options.toJson(),
        }),
      );
    });
  });

  group('joinChannel', () {
    testWidgets('with `token`, `channelName`, `optionalInfo` and `optionalUid`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.joinChannel(null, 'testapi', null, 1);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineJoinChannel.index,
        jsonEncode({
          'token': null,
          'channelId': 'testapi',
          'info': null,
          'uid': 1,
          'options': null,
        }),
      );
    });

    testWidgets(
        'with `token`, `channelName`, `optionalInfo`, `optionalUid` and `options`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      final ChannelMediaOptions options =
          ChannelMediaOptions(autoSubscribeAudio: true);
      await rtcEngine.joinChannel(null, 'testapi', null, 1, options);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineJoinChannel.index,
        jsonEncode({
          'token': null,
          'channelId': 'testapi',
          'info': null,
          'uid': 1,
          'options': options.toJson(),
        }),
      );
    });
  });

  group('switchChannel', () {
    testWidgets('with `token`, `channelName`', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.switchChannel(null, 'testapi');

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSwitchChannel.index,
        jsonEncode({
          'token': null,
          'channelId': 'testapi',
          'options': null,
        }),
      );
    });

    testWidgets('with `token`, `channelName`, `options`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      final ChannelMediaOptions options =
          ChannelMediaOptions(autoSubscribeAudio: true);
      await rtcEngine.switchChannel(null, 'testapi', options);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSwitchChannel.index,
        jsonEncode({
          'token': null,
          'channelId': 'testapi',
          'options': options.toJson(),
        }),
      );
    });
  });

  testWidgets('leaveChannel', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.leaveChannel();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineLeaveChannel.index,
      jsonEncode({}),
    );
  });

  testWidgets('renewToken', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.renewToken('123');

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineRenewToken.index,
      jsonEncode({
        'token': '123',
      }),
    );
  });

  testWidgets('getConnectionState', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    fakeIrisEngine.mockCallApiReturnCode(
      ApiTypeEngine.kEngineGetConnectionState.index,
      jsonEncode({}),
      3,
    );

    rtcEngine = await _createEngine();
    final ret = await rtcEngine.getConnectionState();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineGetConnectionState.index,
      jsonEncode({}),
    );

    expect(ret, ConnectionStateType.Connected);
  });

  testWidgets('getCallId', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    fakeIrisEngine.mockCallApiResult(
      ApiTypeEngine.kEngineGetCallId.index,
      jsonEncode({}),
      '2',
    );

    rtcEngine = await _createEngine();
    final ret = await rtcEngine.getCallId();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineGetCallId.index,
      jsonEncode({}),
    );

    expect(ret, '2');
  });

  group('rate', () {
    testWidgets('with `callId`, `rating`', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.rate('123', 5);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineRate.index,
        jsonEncode({
          'callId': '123',
          'rating': 5,
          'description': null,
        }),
      );
    });

    testWidgets('with `callId`, `rating`, `description`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.rate('123', 5, description: 'des');

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineRate.index,
        jsonEncode({
          'callId': '123',
          'rating': 5,
          'description': 'des',
        }),
      );
    });
  });

  testWidgets('complain', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.complain('123', 'des');

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineComplain.index,
      jsonEncode({
        'callId': '123',
        'description': 'des',
      }),
    );
  });

  testWidgets('setParameters', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setParameters('params');

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetParameters.index,
      jsonEncode({
        'parameters': 'params',
      }),
    );
  });

  testWidgets('getUserInfoByUid', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    final expectedUserInfo = UserInfo(10, 'user1');

    fakeIrisEngine.mockCallApiResult(
      ApiTypeEngine.kEngineGetUserInfoByUid.index,
      jsonEncode({
        'uid': 10,
      }),
      jsonEncode(expectedUserInfo.toJson()),
    );

    rtcEngine = await _createEngine();
    final ret = await rtcEngine.getUserInfoByUid(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineGetUserInfoByUid.index,
      jsonEncode({
        'uid': 10,
      }),
    );

    expect(jsonEncode(ret), jsonEncode(expectedUserInfo.toJson()));
  });

  testWidgets('getUserInfoByUserAccount', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    final expectedUserInfo = UserInfo(10, 'user1');

    fakeIrisEngine.mockCallApiResult(
      ApiTypeEngine.kEngineGetUserInfoByUserAccount.index,
      jsonEncode({
        'userAccount': 'user1',
      }),
      jsonEncode(expectedUserInfo.toJson()),
    );

    rtcEngine = await _createEngine();
    final ret = await rtcEngine.getUserInfoByUserAccount('user1');

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineGetUserInfoByUserAccount.index,
      jsonEncode({
        'userAccount': 'user1',
      }),
    );

    expect(jsonEncode(ret), jsonEncode(expectedUserInfo.toJson()));
  });

  group('joinChannelWithUserAccount', () {
    testWidgets('with `token`, `channelName`, `userAccount`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.joinChannelWithUserAccount(null, 'testapi', 'user1');

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineJoinChannelWithUserAccount.index,
        jsonEncode({
          'token': null,
          'channelId': 'testapi',
          'userAccount': 'user1',
          'options': null,
        }),
      );
    });

    testWidgets('with `token`, `channelName`, `userAccount`, `options`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      final ChannelMediaOptions options = ChannelMediaOptions(
        autoSubscribeAudio: true,
      );
      await rtcEngine.joinChannelWithUserAccount(
          null, 'testapi', 'user1', options);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineJoinChannelWithUserAccount.index,
        jsonEncode({
          'token': null,
          'channelId': 'testapi',
          'userAccount': 'user1',
          'options': options.toJson(),
        }),
      );
    });
  });

  testWidgets('registerLocalUserAccount', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.registerLocalUserAccount('123', 'user1');

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineRegisterLocalUserAccount.index,
      jsonEncode({
        'appId': '123',
        'userAccount': 'user1',
      }),
    );
  });

  testWidgets('adjustPlaybackSignalVolume', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.adjustPlaybackSignalVolume(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineAdjustPlaybackSignalVolume.index,
      jsonEncode({
        'volume': 10,
      }),
    );
  });

  testWidgets('adjustRecordingSignalVolume', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.adjustRecordingSignalVolume(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineAdjustRecordingSignalVolume.index,
      jsonEncode({
        'volume': 10,
      }),
    );
  });

  testWidgets('adjustUserPlaybackSignalVolume', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.adjustUserPlaybackSignalVolume(123, 10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineAdjustUserPlaybackSignalVolume.index,
      jsonEncode({
        'uid': 123,
        'volume': 10,
      }),
    );
  });

  testWidgets(
    'enableLoopbackRecording',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.enableLoopbackRecording(true);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineEnableLoopBackRecording.index,
        jsonEncode({
          'enabled': true,
          'deviceName': null,
        }),
      );
    },
    skip: (Platform.isAndroid || Platform.isIOS),
  );

  testWidgets('disableAudio', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.disableAudio();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineDisableAudio.index,
      jsonEncode({}),
    );
  });

  testWidgets('enableAudio', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.enableAudio();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableAudio.index,
      jsonEncode({}),
    );
  });

  testWidgets('enableAudioVolumeIndication', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.enableAudioVolumeIndication(10, 10, true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableAudioVolumeIndication.index,
      jsonEncode({
        'interval': 10,
        'smooth': 10,
        'report_vad': true,
      }),
    );
  });

  testWidgets('enableLocalAudio', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.enableLocalAudio(true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableLocalAudio.index,
      jsonEncode({
        'enabled': true,
      }),
    );
  });

  testWidgets('muteAllRemoteAudioStreams', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.muteAllRemoteAudioStreams(true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineMuteAllRemoteAudioStreams.index,
      jsonEncode({
        'mute': true,
      }),
    );
  });

  testWidgets('muteLocalAudioStream', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.muteLocalAudioStream(true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineMuteLocalAudioStream.index,
      jsonEncode({
        'mute': true,
      }),
    );
  });

  testWidgets('muteRemoteAudioStream', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.muteRemoteAudioStream(10, true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineMuteRemoteAudioStream.index,
      jsonEncode({
        'userId': 10,
        'mute': true,
      }),
    );
  });

  testWidgets('setAudioProfile', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setAudioProfile(
      AudioProfile.Default,
      AudioScenario.Default,
    );

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetAudioProfile.index,
      jsonEncode({
        'profile': 0,
        'scenario': 0,
      }),
    );
  });

  testWidgets('disableVideo', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.disableVideo();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineDisableVideo.index,
      jsonEncode({}),
    );
  });

  testWidgets('enableLocalVideo', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.enableLocalVideo(true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableLocalVideo.index,
      jsonEncode({
        'enabled': true,
      }),
    );
  });

  testWidgets('enableVideo', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.enableVideo();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableVideo.index,
      jsonEncode({}),
    );
  });

  testWidgets('muteAllRemoteVideoStreams', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.muteAllRemoteVideoStreams(true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineMuteAllRemoteVideoStreams.index,
      jsonEncode({
        'mute': true,
      }),
    );
  });

  testWidgets('muteLocalVideoStream', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.muteLocalVideoStream(true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineMuteLocalVideoStream.index,
      jsonEncode({
        'mute': true,
      }),
    );
  });

  testWidgets('muteRemoteVideoStream', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.muteRemoteVideoStream(10, true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineMuteRemoteVideoStream.index,
      jsonEncode({
        'userId': 10,
        'mute': true,
      }),
    );
  });

  testWidgets('setBeautyEffectOptions', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    BeautyOptions options =
        BeautyOptions(lighteningContrastLevel: LighteningContrastLevel.High);
    await rtcEngine.setBeautyEffectOptions(true, options);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetBeautyEffectOptions.index,
      jsonEncode({
        'enabled': true,
        'options': options.toJson(),
      }),
    );
  });

  testWidgets('setVideoEncoderConfiguration', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    VideoEncoderConfiguration config = VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 10, height: 10));
    await rtcEngine.setVideoEncoderConfiguration(config);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetVideoEncoderConfiguration.index,
      jsonEncode({
        'config': config.toJson(),
      }),
    );
  });

  testWidgets('startPreview', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.startPreview();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStartPreview.index,
      jsonEncode({}),
    );
  });

  testWidgets('stopPreview', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.stopPreview();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStopPreview.index,
      jsonEncode({}),
    );
  });

  testWidgets('adjustAudioMixingPlayoutVolume', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.adjustAudioMixingPlayoutVolume(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineAdjustAudioMixingPlayoutVolume.index,
      jsonEncode({
        'volume': 10,
      }),
    );
  });

  testWidgets('adjustAudioMixingPublishVolume', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.adjustAudioMixingPublishVolume(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineAdjustAudioMixingPublishVolume.index,
      jsonEncode({
        'volume': 10,
      }),
    );
  });

  testWidgets('adjustAudioMixingVolume', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.adjustAudioMixingVolume(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineAdjustAudioMixingVolume.index,
      jsonEncode({
        'volume': 10,
      }),
    );
  });

  testWidgets('getAudioMixingCurrentPosition', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    fakeIrisEngine.mockCallApiReturnCode(
        ApiTypeEngine.kEngineGetAudioMixingCurrentPosition.index,
        jsonEncode({}),
        10);

    rtcEngine = await _createEngine();

    final ret = await rtcEngine.getAudioMixingCurrentPosition();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineGetAudioMixingCurrentPosition.index,
      jsonEncode({}),
    );

    expect(ret, 10);
  });

  testWidgets('getAudioMixingDuration', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    fakeIrisEngine.mockCallApiReturnCode(
        ApiTypeEngine.kEngineGetAudioMixingDuration.index, jsonEncode({}), 10);

    rtcEngine = await _createEngine();

    final ret = await rtcEngine.getAudioMixingDuration();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineGetAudioMixingDuration.index,
      jsonEncode({}),
    );

    expect(ret, 10);
  });

  testWidgets('getAudioMixingPlayoutVolume', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    fakeIrisEngine.mockCallApiReturnCode(
        ApiTypeEngine.kEngineGetAudioMixingPlayoutVolume.index,
        jsonEncode({}),
        10);

    rtcEngine = await _createEngine();

    final ret = await rtcEngine.getAudioMixingPlayoutVolume();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineGetAudioMixingPlayoutVolume.index,
      jsonEncode({}),
    );

    expect(ret, 10);
  });

  testWidgets('getAudioMixingPublishVolume', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    fakeIrisEngine.mockCallApiReturnCode(
        ApiTypeEngine.kEngineGetAudioMixingPublishVolume.index,
        jsonEncode({}),
        10);

    rtcEngine = await _createEngine();

    final ret = await rtcEngine.getAudioMixingPublishVolume();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineGetAudioMixingPublishVolume.index,
      jsonEncode({}),
    );

    expect(ret, 10);
  });

  testWidgets('pauseAudioMixing', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.pauseAudioMixing();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEnginePauseAudioMixing.index,
      jsonEncode({}),
    );
  });

  testWidgets('resumeAudioMixing', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.resumeAudioMixing();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineResumeAudioMixing.index,
      jsonEncode({}),
    );
  });

  testWidgets('setAudioMixingPosition', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.setAudioMixingPosition(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetAudioMixingPosition.index,
      jsonEncode({
        'pos': 10,
      }),
    );
  });

  group('startAudioMixing', () {
    testWidgets('with `filePath`, `loopback`, `replace`, `cycle`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.startAudioMixing('/path', true, true, 10);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineStartAudioMixing.index,
        jsonEncode({
          'filePath': '/path',
          'loopback': true,
          'replace': true,
          'cycle': 10,
          'startPos': null,
        }),
      );
    });

    testWidgets('with `filePath`, `loopback`, `replace`, `cycle`, `startPos`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.startAudioMixing('/path', true, true, 10, 20);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineStartAudioMixing.index,
        jsonEncode({
          'filePath': '/path',
          'loopback': true,
          'replace': true,
          'cycle': 10,
          'startPos': 20,
        }),
      );
    });
  });

  testWidgets('stopAudioMixing', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.stopAudioMixing();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStopAudioMixing.index,
      jsonEncode({}),
    );
  });

  testWidgets('addInjectStreamUrl', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    final LiveInjectStreamConfig config =
        LiveInjectStreamConfig(width: 10, height: 10);

    await rtcEngine.addInjectStreamUrl('https://example.com', config);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineAddInjectStreamUrl.index,
      jsonEncode({
        'url': 'https://example.com',
        'config': config.toJson(),
      }),
    );
  });

  testWidgets('addPublishStreamUrl', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.addPublishStreamUrl('https://example.com', true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineAddPublishStreamUrl.index,
      jsonEncode({
        'url': 'https://example.com',
        'transcodingEnabled': true,
      }),
    );
  });

  testWidgets('addVideoWatermark', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    final WatermarkOptions options = WatermarkOptions(visibleInPreview: true);
    await rtcEngine.addVideoWatermark('https://example.com', options);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineAddVideoWaterMark.index,
      jsonEncode({
        'watermarkUrl': 'https://example.com',
        'options': options.toJson(),
      }),
    );
  });

  testWidgets('clearVideoWatermarks', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.clearVideoWatermarks();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineClearVideoWaterMarks.index,
      jsonEncode({}),
    );
  });

  testWidgets('createDataStream', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    fakeIrisEngine.mockCallApiReturnCode(
        ApiTypeEngine.kEngineCreateDataStream.index,
        jsonEncode({
          'reliable': true,
          'ordered': true,
        }),
        10);

    rtcEngine = await _createEngine();

    final ret = await rtcEngine.createDataStream(true, true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineCreateDataStream.index,
      jsonEncode({
        'reliable': true,
        'ordered': true,
      }),
    );

    expect(ret, 10);
  });

  testWidgets('disableLastmileTest', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.disableLastmileTest();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineDisableLastMileTest.index,
      jsonEncode({}),
    );
  });

  testWidgets('enableDualStreamMode', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.enableDualStreamMode(true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableDualStreamMode.index,
      jsonEncode({
        'enabled': true,
      }),
    );
  });

  testWidgets(
    'enableInEarMonitoring',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.enableInEarMonitoring(true);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineEnableInEarMonitoring.index,
        jsonEncode({
          'enabled': true,
        }),
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets('enableLastmileTest', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.enableLastmileTest();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableLastMileTest.index,
      jsonEncode({}),
    );
  });

  testWidgets('enableSoundPositionIndication', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.enableSoundPositionIndication(true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableSoundPositionIndication.index,
      jsonEncode({
        'enabled': true,
      }),
    );
  });

  testWidgets(
    'isSpeakerphoneEnabled',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      fakeIrisEngine.mockCallApiReturnCode(
        ApiTypeEngine.kEngineIsSpeakerPhoneEnabled.index,
        jsonEncode({}),
        1,
      );

      rtcEngine = await _createEngine();

      final ret = await rtcEngine.isSpeakerphoneEnabled();

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineIsSpeakerPhoneEnabled.index,
        jsonEncode({}),
      );

      expect(ret, true);
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets('pauseAllEffects', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.pauseAllEffects();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEnginePauseAllEffects.index,
      jsonEncode({}),
    );
  });

  testWidgets('pauseEffect', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.pauseEffect(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEnginePauseEffect.index,
      jsonEncode({
        'soundId': 10,
      }),
    );
  });

  group('playEffect', () {
    testWidgets(
        'with `soundId`, `filePath`, `loopCount`, `pitch`, `pan`, `gain`, `publish`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.playEffect(10, '/path', 10, 1.0, 2.0, 3, true);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEnginePlayEffect.index,
        jsonEncode({
          'soundId': 10,
          'filePath': '/path',
          'loopCount': 10,
          'pitch': 1.0,
          'pan': 2.0,
          'gain': 3,
          'publish': true,
          'startPos': null,
        }),
      );
    });

    testWidgets(
        'with `soundId`, `filePath`, `loopCount`, `pitch`, `pan`, `gain`, `publish`, `startPos`',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.playEffect(10, '/path', 10, 1.0, 2.0, 3, true, 20);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEnginePlayEffect.index,
        jsonEncode({
          'soundId': 10,
          'filePath': '/path',
          'loopCount': 10,
          'pitch': 1.0,
          'pan': 2.0,
          'gain': 3,
          'publish': true,
          'startPos': 20,
        }),
      );
    });
  });

  testWidgets('setEffectPosition', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.setEffectPosition(10, 20);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetEffectPosition.index,
      jsonEncode({
        'soundId': 10,
        'pos': 20,
      }),
    );
  });

  testWidgets('getEffectDuration', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.getEffectDuration('/path');

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineGetEffectDuration.index,
      jsonEncode({
        'filePath': '/path',
      }),
    );
  });

  testWidgets('getEffectCurrentPosition', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.getEffectCurrentPosition(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineGetEffectCurrentPosition.index,
      jsonEncode({
        'soundId': 10,
      }),
    );
  });

  testWidgets('preloadEffect', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.preloadEffect(10, '/path');

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEnginePreloadEffect.index,
      jsonEncode({
        'soundId': 10,
        'filePath': '/path',
      }),
    );
  });

  testWidgets('preloadEffect', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.preloadEffect(10, '/path');

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEnginePreloadEffect.index,
      jsonEncode({
        'soundId': 10,
        'filePath': '/path',
      }),
    );
  });

  testWidgets('registerMediaMetadataObserver', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.registerMediaMetadataObserver();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineRegisterMediaMetadataObserver.index,
      jsonEncode({'type': 0}),
    );
  });

  testWidgets('removeInjectStreamUrl', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.removeInjectStreamUrl('https://example.com');

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineRemoveInjectStreamUrl.index,
      jsonEncode({
        'url': 'https://example.com',
      }),
    );
  });

  testWidgets('removePublishStreamUrl', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.removePublishStreamUrl('https://example.com');

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineRemovePublishStreamUrl.index,
      jsonEncode({
        'url': 'https://example.com',
      }),
    );
  });

  testWidgets('resumeAllEffects', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.resumeAllEffects();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineResumeAllEffects.index,
      jsonEncode({}),
    );
  });

  testWidgets('resumeEffect', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.resumeEffect(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineResumeEffect.index,
      jsonEncode({
        'soundId': 10,
      }),
    );
  });

  testWidgets('sendMetadata', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    final bytes = Uint8List.fromList([1, 1, 1, 1, 1]);

    fakeIrisEngine.setExplicitBufferSize(
        ApiTypeEngine.kEngineResumeEffect.index,
        jsonEncode({
          'metadata': {
            'size': bytes.length,
          },
        }),
        bytes.length);

    rtcEngine = await _createEngine();

    await rtcEngine.sendMetadata(bytes);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSendMetadata.index,
      jsonEncode({
        'metadata': {
          'size': bytes.length,
        },
      }),
      buffer: bytes,
      bufferSize: bytes.length,
    );
  });

  testWidgets('sendStreamMessage', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    final bytes = Uint8List.fromList([1, 1, 1, 1, 1]);

    fakeIrisEngine.setExplicitBufferSize(
        ApiTypeEngine.kEngineSendStreamMessage.index,
        jsonEncode({
          'streamId': 10,
          'length': bytes.length,
        }),
        bytes.length);

    rtcEngine = await _createEngine();

    await rtcEngine.sendStreamMessage(10, bytes);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSendStreamMessage.index,
      jsonEncode({
        'streamId': 10,
        'length': bytes.length,
      }),
      buffer: bytes,
      bufferSize: bytes.length,
    );
  });

  testWidgets(
    'setCameraCapturerConfiguration',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      final CameraCapturerConfiguration config = CameraCapturerConfiguration(
          preference: CameraCaptureOutputPreference.Performance);
      await rtcEngine.setCameraCapturerConfiguration(config);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetCameraCapturerConfiguration.index,
        jsonEncode({
          'config': config.toJson(),
        }),
      );
    },
    //!(Platform.isAndroid || Platform.isIOS),
    skip: true, // TODO(littlegnal): [MS-102785] Wait for iris fix it
  );

  testWidgets(
    'setDefaultAudioRoutetoSpeakerphone',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.setDefaultAudioRouteToSpeakerphone(true);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetDefaultAudioRouteToSpeakerPhone.index,
        jsonEncode({
          'defaultToSpeaker': true,
        }),
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets('setEffectsVolume', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.setEffectsVolume(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetEffectsVolume.index,
      jsonEncode({
        'volume': 10,
      }),
    );
  });

  testWidgets(
    'setEnableSpeakerphone',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.setEnableSpeakerphone(true);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetEnableSpeakerPhone.index,
        jsonEncode({
          'speakerOn': true,
        }),
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'setInEarMonitoringVolume',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.setInEarMonitoringVolume(10);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetInEarMonitoringVolume.index,
        jsonEncode({
          'volume': 10,
        }),
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets('setLiveTranscoding', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    final LiveTranscoding transcoding =
        LiveTranscoding([TranscodingUser(100)], width: 10, height: 10);
    await rtcEngine.setLiveTranscoding(transcoding);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetLiveTranscoding.index,
      jsonEncode({
        'transcoding': transcoding.toJson(),
      }),
    );
  });

  testWidgets('setLocalPublishFallbackOption', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine
        .setLocalPublishFallbackOption(StreamFallbackOptions.AudioOnly);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetLocalPublishFallbackOption.index,
      jsonEncode({
        'option': 2,
      }),
    );
  });

  testWidgets('setLocalVoiceEqualization', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setLocalVoiceEqualization(
      AudioEqualizationBandFrequency.Band4K,
      10,
    );

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetLocalVoiceEqualization.index,
      jsonEncode({
        'bandFrequency': 7,
        'bandGain': 10,
      }),
    );
  });

  testWidgets('setLocalVoicePitch', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setLocalVoicePitch(10.0);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetLocalVoicePitch.index,
      jsonEncode({
        'pitch': 10.0,
      }),
    );
  });

  testWidgets('setLocalVoiceReverb', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setLocalVoiceReverb(AudioReverbType.RoomSize, 10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetLocalVoiceReverb.index,
      jsonEncode({
        'reverbKey': 2,
        'value': 10,
      }),
    );
  });

  testWidgets('setMaxMetadataSize', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setMaxMetadataSize(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetMaxMetadataSize.index,
      jsonEncode({
        'size': 10,
      }),
    );
  });

  testWidgets('setRemoteDefaultVideoStreamType', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setRemoteDefaultVideoStreamType(VideoStreamType.High);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetRemoteDefaultVideoStreamType.index,
      jsonEncode({
        'streamType': 0,
      }),
    );
  });

  testWidgets('setRemoteSubscribeFallbackOption', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine
        .setRemoteSubscribeFallbackOption(StreamFallbackOptions.AudioOnly);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetRemoteSubscribeFallbackOption.index,
      jsonEncode({
        'option': 2,
      }),
    );
  });

  testWidgets('setRemoteUserPriority', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setRemoteUserPriority(10, UserPriority.High);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetRemoteUserPriority.index,
      jsonEncode({
        'uid': 10,
        'userPriority': 50,
      }),
    );
  });

  testWidgets('setRemoteVideoStreamType', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setRemoteVideoStreamType(10, VideoStreamType.High);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetRemoteVideoStreamType.index,
      jsonEncode({
        'userId': 10,
        'streamType': 0,
      }),
    );
  });

  testWidgets('setRemoteVoicePosition', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setRemoteVoicePosition(10, 1.0, 2.0);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetRemoteVoicePosition.index,
      jsonEncode({
        'uid': 10,
        'pan': 1.0,
        'gain': 2.0,
      }),
    );
  });

  testWidgets('setVolumeOfEffect', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setVolumeOfEffect(10, 10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetVolumeOfEffect.index,
      jsonEncode({
        'soundId': 10,
        'volume': 10,
      }),
    );
  });

  testWidgets('startAudioRecordingWithConfig', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    final AudioRecordingConfiguration config =
        AudioRecordingConfiguration('/path');
    await rtcEngine.startAudioRecordingWithConfig(config);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStartAudioRecording.index,
      jsonEncode({
        'config': config.toJson(),
      }),
    );
  });

  testWidgets('startChannelMediaRelay', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    final ChannelMediaRelayConfiguration config =
        ChannelMediaRelayConfiguration(
      ChannelMediaInfo('testapi', 10),
      [ChannelMediaInfo('testapi', 100)],
    );
    await rtcEngine.startChannelMediaRelay(config);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStartChannelMediaRelay.index,
      jsonEncode({
        'configuration': config.toJson(),
      }),
    );
  });

  testWidgets('startEchoTest', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.startEchoTest(intervalInSeconds: 10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStartEchoTest.index,
      jsonEncode({
        'intervalInSeconds': 10,
      }),
    );
  });

  testWidgets('startEchoTest EchoTestConfiguration',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    var config = EchoTestConfiguration(enableAudio: true);
    await rtcEngine.startEchoTest(config: config);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStartEchoTest.index,
      jsonEncode({
        'config': config.toJson(),
      }),
    );
  });

  testWidgets('startLastmileProbeTest', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    final LastmileProbeConfig config = LastmileProbeConfig(true, true, 10, 20);

    await rtcEngine.startLastmileProbeTest(config);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStartLastMileProbeTest.index,
      jsonEncode({
        'config': config.toJson(),
      }),
    );
  });

  testWidgets('stopAllEffects', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.stopAllEffects();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStopAllEffects.index,
      jsonEncode({}),
    );
  });

  testWidgets('stopAudioRecording', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.stopAudioRecording();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStopAudioRecording.index,
      jsonEncode({}),
    );
  });

  testWidgets('stopChannelMediaRelay', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.stopChannelMediaRelay();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStopChannelMediaRelay.index,
      jsonEncode({}),
    );
  });

  testWidgets('stopEchoTest', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.stopEchoTest();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStopEchoTest.index,
      jsonEncode({}),
    );
  });

  testWidgets('stopEffect', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.stopEffect(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStopEffect.index,
      jsonEncode({
        'soundId': 10,
      }),
    );
  });

  testWidgets('stopLastmileProbeTest', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.stopLastmileProbeTest();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineStopLastMileProbeTest.index,
      jsonEncode({}),
    );
  });

  testWidgets(
    'switchCamera',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.switchCamera();

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSwitchCamera.index,
        jsonEncode({}),
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets('unloadEffect', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.unloadEffect(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineUnloadEffect.index,
      jsonEncode({
        'soundId': 10,
      }),
    );
  });

  testWidgets('unregisterMediaMetadataObserver', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.unregisterMediaMetadataObserver();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineUnRegisterMediaMetadataObserver.index,
      jsonEncode({'type': 0}),
    );
  });

  testWidgets('updateChannelMediaRelay', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    final ChannelMediaRelayConfiguration config =
        ChannelMediaRelayConfiguration(
      ChannelMediaInfo('testapi', 10),
      [ChannelMediaInfo('testapi', 10)],
    );
    await rtcEngine.updateChannelMediaRelay(config);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineUpdateChannelMediaRelay.index,
      jsonEncode({
        'configuration': config.toJson(),
      }),
    );
  });

  testWidgets(
    'enableFaceDetection',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();

      await rtcEngine.enableFaceDetection(true);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineEnableFaceDetection.index,
        jsonEncode({
          'enable': true,
        }),
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets('setAudioMixingPitch', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();

    await rtcEngine.setAudioMixingPitch(10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetAudioMixingPitch.index,
      jsonEncode({
        'pitch': 10,
      }),
    );
  });

  testWidgets('enableEncryption', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    final EncryptionConfig config =
        EncryptionConfig(encryptionMode: EncryptionMode.AES128ECB);
    await rtcEngine.enableEncryption(true, config);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableEncryption.index,
      jsonEncode({
        'enabled': true,
        'config': config.toJson(),
      }),
    );
  });

  testWidgets('sendCustomReportMessage', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.sendCustomReportMessage(
        '123', 'category', 'event', 'label', 10);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSendCustomReportMessage.index,
      jsonEncode({
        'id': '123',
        'category': 'category',
        'event': 'event',
        'label': 'label',
        'value': 10,
      }),
    );
  });

  testWidgets(
    'setAudioSessionOperationRestriction',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.setAudioSessionOperationRestriction(
          AudioSessionOperationRestriction.All);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetAudioSessionOperationRestriction.index,
        jsonEncode({
          'restriction': 1 << 7,
        }),
      );
    },
    skip: !Platform.isIOS,
  );

  testWidgets('setAudioEffectParameters', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setAudioEffectParameters(
        AudioEffectPreset.AudioEffectOff, 1, 2);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetAudioEffectParameters.index,
      jsonEncode({
        'preset': 0x00000000,
        'param1': 1,
        'param2': 2,
      }),
    );
  });

  testWidgets('setAudioEffectPreset', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setAudioEffectPreset(AudioEffectPreset.PitchCorrection);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetAudioEffectPreset.index,
      jsonEncode({
        'preset': 0x02040100,
      }),
    );
  });

  testWidgets('setVoiceBeautifierPreset', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine
        .setVoiceBeautifierPreset(VoiceBeautifierPreset.SingingBeautifier);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetVoiceBeautifierPreset.index,
      jsonEncode({
        'preset': 0x01020100,
      }),
    );
  });

  testWidgets('createDataStreamWithConfig', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    final DataStreamConfig config = DataStreamConfig(true, true);
    await rtcEngine.createDataStreamWithConfig(config);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineCreateDataStream.index,
      jsonEncode({
        'config': config.toJson(),
      }),
    );
  });

  testWidgets('enableDeepLearningDenoise', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.enableDeepLearningDenoise(true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableDeepLearningDenoise.index,
      jsonEncode({
        'enable': true,
      }),
    );
  });

  testWidgets('enableRemoteSuperResolution', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.enableRemoteSuperResolution(10, true);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineEnableRemoteSuperResolution.index,
      jsonEncode({
        'userId': 10,
        'enable': true,
      }),
    );
  });

  testWidgets('setCloudProxy', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setCloudProxy(CloudProxyType.TCP);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetCloudProxy.index,
      jsonEncode({
        'proxyType': 2,
      }),
    );
  });

  testWidgets('uploadLogFile', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    fakeIrisEngine.mockCallApiResult(
      ApiTypeEngine.kEngineUploadLogFile.index,
      jsonEncode({}),
      '1',
    );

    rtcEngine = await _createEngine();
    final ret = await rtcEngine.uploadLogFile();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineUploadLogFile.index,
      jsonEncode({}),
    );

    expect(ret, '1');
  });

  testWidgets('setVoiceBeautifierParameters', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setVoiceBeautifierParameters(
        VoiceBeautifierPreset.SingingBeautifier, 1, 2);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetVoiceBeautifierParameters.index,
      jsonEncode({
        'preset': 0x01020100,
        'param1': 1,
        'param2': 2,
      }),
    );
  });

  testWidgets('setVoiceConversionPreset', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.setVoiceConversionPreset(VoiceConversionPreset.Sweet);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetVoiceConversionPreset.index,
      jsonEncode({
        'preset': 50397696,
      }),
    );
  });

  testWidgets('pauseAllChannelMediaRelay', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.pauseAllChannelMediaRelay();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEnginePauseAllChannelMediaRelay.index,
      jsonEncode({}),
    );
  });

  testWidgets('resumeAllChannelMediaRelay', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    await rtcEngine.resumeAllChannelMediaRelay();

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineResumeAllChannelMediaRelay.index,
      jsonEncode({}),
    );
  });

  testWidgets('setLocalAccessPoint', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();

    rtcEngine = await _createEngine();
    const config = LocalAccessPointConfiguration();
    await rtcEngine.setLocalAccessPoint(config);

    fakeIrisEngine.expectCalledApi(
      ApiTypeEngine.kEngineSetLocalAccessPoint.index,
      jsonEncode({
        'config': config.toJson(),
      }),
    );
  });

  testWidgets(
    'setScreenCaptureContentHint',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.setScreenCaptureContentHint(VideoContentHint.Motion);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineSetScreenCaptureContentHint.index,
        jsonEncode({
          'contentHint': 1,
        }),
      );
    },
    skip: (Platform.isAndroid || Platform.isIOS),
  );

  group('startScreenCaptureByDisplayId', () {
    testWidgets(
      'with `displayId`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        await rtcEngine.startScreenCaptureByDisplayId(
          10,
        );

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCaptureByDisplayId.index,
          jsonEncode({
            'displayId': 10,
            'regionRect': null,
            'captureParams': null,
          }),
        );
      },
      skip: !Platform.isMacOS,
    );

    testWidgets(
      'with `displayId`, `regionRect`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        final rect = Rectangle(x: 10, y: 10);
        await rtcEngine.startScreenCaptureByDisplayId(10, rect);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCaptureByDisplayId.index,
          jsonEncode({
            'displayId': 10,
            'regionRect': rect.toJson(),
            'captureParams': null,
          }),
        );
      },
      skip: !Platform.isMacOS,
    );

    testWidgets(
      'with `displayId`, `regionRect`, `captureParams`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        final rect = Rectangle(x: 10, y: 10);
        final ScreenCaptureParameters params = ScreenCaptureParameters(
            dimensions: VideoDimensions(width: 10, height: 10));
        await rtcEngine.startScreenCaptureByDisplayId(10, rect, params);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCaptureByDisplayId.index,
          jsonEncode({
            'displayId': 10,
            'regionRect': rect.toJson(),
            'captureParams': params.toJson(),
          }),
        );
      },
      skip: !Platform.isMacOS,
    );
  });

  group('startScreenCaptureByScreenRect', () {
    testWidgets(
      'with `screenRect`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        final rect = Rectangle(x: 10, y: 10);
        await rtcEngine.startScreenCaptureByScreenRect(rect);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCaptureByScreenRect.index,
          jsonEncode({
            'screenRect': rect.toJson(),
            'regionRect': null,
            'captureParams': null,
          }),
        );
      },
      skip: !Platform.isWindows,
    );

    testWidgets(
      'with `screenRect`, `regionRect`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        final screenRect = Rectangle(x: 10, y: 10);
        final regionRect = Rectangle(x: 20, y: 20);

        await rtcEngine.startScreenCaptureByScreenRect(screenRect, regionRect);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCaptureByScreenRect.index,
          jsonEncode({
            'screenRect': screenRect.toJson(),
            'regionRect': regionRect.toJson(),
            'captureParams': null,
          }),
        );
      },
      skip: !Platform.isWindows,
    );

    testWidgets(
      'with `screenRect`, `regionRect`, `captureParams`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        final screenRect = Rectangle(x: 10, y: 10);
        final regionRect = Rectangle(x: 20, y: 20);
        final ScreenCaptureParameters params = ScreenCaptureParameters(
            dimensions: VideoDimensions(width: 10, height: 10));
        await rtcEngine.startScreenCaptureByScreenRect(
            screenRect, regionRect, params);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCaptureByScreenRect.index,
          jsonEncode({
            'screenRect': screenRect.toJson(),
            'regionRect': regionRect.toJson(),
            'captureParams': params.toJson(),
          }),
        );
      },
      skip: !Platform.isWindows,
    );
  });

  group('startScreenCaptureByWindowId', () {
    testWidgets(
      'with `windowId`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        await rtcEngine.startScreenCaptureByWindowId(10);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCaptureByWindowId.index,
          jsonEncode({
            'windowId': 10,
            'regionRect': null,
            'captureParams': null,
          }),
        );
      },
      skip: (Platform.isAndroid || Platform.isIOS),
    );

    testWidgets(
      'with `windowId`, `regionRect`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        final regionRect = Rectangle(x: 20, y: 20);
        await rtcEngine.startScreenCaptureByWindowId(10, regionRect);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCaptureByWindowId.index,
          jsonEncode({
            'windowId': 10,
            'regionRect': regionRect.toJson(),
            'captureParams': null,
          }),
        );
      },
      skip: (Platform.isAndroid || Platform.isIOS),
    );

    testWidgets(
      'with `windowId`, `regionRect`, `captureParams`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        final regionRect = Rectangle(x: 20, y: 20);
        final ScreenCaptureParameters params = ScreenCaptureParameters(
            dimensions: VideoDimensions(width: 10, height: 10));
        await rtcEngine.startScreenCaptureByWindowId(10, regionRect, params);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCaptureByWindowId.index,
          jsonEncode({
            'windowId': 10,
            'regionRect': regionRect.toJson(),
            'captureParams': params.toJson(),
          }),
        );
      },
      skip: (Platform.isAndroid || Platform.isIOS),
    );
  });

  testWidgets(
    'stopScreenCapture',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.stopScreenCapture();

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineStopScreenCapture.index,
        jsonEncode({}),
      );
    },
    skip: (Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'updateScreenCaptureParameters',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      final ScreenCaptureParameters params = ScreenCaptureParameters(
          dimensions: VideoDimensions(width: 10, height: 10));
      await rtcEngine.updateScreenCaptureParameters(params);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineUpdateScreenCaptureParameters.index,
        jsonEncode({
          'captureParams': params.toJson(),
        }),
      );
    },
    skip: (Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'updateScreenCaptureRegion',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      final Rectangle rect = Rectangle(width: 10, height: 10);
      await rtcEngine.updateScreenCaptureRegion(rect);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineUpdateScreenCaptureRegion.index,
        jsonEncode({
          'regionRect': rect.toJson(),
        }),
      );
    },
    skip: (Platform.isAndroid || Platform.isIOS),
  );

  group('startScreenCapture', () {
    testWidgets(
      'with `windowId`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        await rtcEngine.startScreenCapture(10);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCapture.index,
          jsonEncode({
            'windowId': 10,
            'captureFreq': 0,
            'rect': null,
            'bitrate': 0,
          }),
        );
      },
      skip: (Platform.isAndroid || Platform.isIOS),
    );

    testWidgets(
      'with `windowId`, `captureFreq`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        await rtcEngine.startScreenCapture(10, 20);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCapture.index,
          jsonEncode({
            'windowId': 10,
            'captureFreq': 20,
            'rect': null,
            'bitrate': 0,
          }),
        );
      },
      skip: (Platform.isAndroid || Platform.isIOS),
    );

    testWidgets(
      'with `windowId`, `captureFreq`, `rect`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        final rect = Rect(left: 10, right: 10);
        await rtcEngine.startScreenCapture(10, 20, rect);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCapture.index,
          jsonEncode({
            'windowId': 10,
            'captureFreq': 20,
            'rect': rect.toJson(),
            'bitrate': 0,
          }),
        );
      },
      skip: (Platform.isAndroid || Platform.isIOS),
    );

    testWidgets(
      'with `windowId`, `captureFreq`, `rect`, `bitrate`',
      (WidgetTester tester) async {
        app.main();
        await tester.pumpAndSettle();
        fakeIrisEngine = FakeIrisRtcEngine();
        await fakeIrisEngine.initialize();

        rtcEngine = await _createEngine();
        final rect = Rect(left: 10, right: 10);
        await rtcEngine.startScreenCapture(10, 20, rect, 30);

        fakeIrisEngine.expectCalledApi(
          ApiTypeEngine.kEngineStartScreenCapture.index,
          jsonEncode({
            'windowId': 10,
            'captureFreq': 20,
            'rect': rect.toJson(),
            'bitrate': 30,
          }),
        );
      },
      skip: (Platform.isAndroid || Platform.isIOS),
    );
  });

  testWidgets(
    'getCameraMaxZoomFactor',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.getCameraMaxZoomFactor();

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineGetCameraMaxZoomFactor.index,
        jsonEncode({}),
      );
    },
    skip: !Platform.isAndroid, // Can only run on Android emulator
  );

  testWidgets(
    'isCameraAutoFocusFaceModeSupported',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.isCameraAutoFocusFaceModeSupported();

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineIsCameraAutoFocusFaceModeSupported.index,
        jsonEncode({}),
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'isCameraExposurePositionSupported',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.isCameraExposurePositionSupported();

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineIsCameraExposurePositionSupported.index,
        jsonEncode({}),
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'isCameraFocusSupported',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.isCameraFocusSupported();

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineIsCameraFocusSupported.index,
        jsonEncode({}),
      );
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'isCameraZoomSupported',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      fakeIrisEngine.mockCallApiReturnCode(
          ApiTypeEngine.kEngineIsCameraZoomSupported.index, jsonEncode({}), 1);
      rtcEngine = await _createEngine();

      final ret = await rtcEngine.isCameraZoomSupported();

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineIsCameraZoomSupported.index,
        jsonEncode({}),
      );

      expect(ret, true);
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'takeSnapshot',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      await rtcEngine.takeSnapshot('testapi', 20, '/path');

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineTakeSnapshot.index,
        jsonEncode({
          'channel': 'testapi',
          'uid': 20,
          'filePath': '/path',
        }),
      );
    },

    // skip: !Platform.isAndroid,
    // TODO(littlegnal): [MS-99390] Currently fail on Android
    skip: true,
  );

  testWidgets(
    'enableContentInspect',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();

      rtcEngine = await _createEngine();
      const modules = [ContentInspectModule()];
      ContentInspectConfig config =
          const ContentInspectConfig(modules: modules);
      await rtcEngine.enableContentInspect(true, config);

      fakeIrisEngine.expectCalledApi(
        ApiTypeEngine.kEngineEnableContentInspect.index,
        jsonEncode({
          'enabled': true,
          'config': config.toJson(),
        }),
      );
    },
  );
}

Future<RtcEngine> _createEngine() async {
  return RtcEngine.create('123');
}
