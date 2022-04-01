import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/api_types.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late RtcEngine rtcEngine;
  late RtcChannel rtcChannel;
  late FakeIrisRtcEngine fakeIrisEngine;

  Future<RtcChannel> _createChannel() async {
    rtcEngine = await RtcEngine.create('123');
    return RtcChannel.create('testapi');
  }

  tearDown(() async {
    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('create', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelCreateChannel.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
    );
  });

  group('setClientRole', () {
    testWidgets('with `role`', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
      await fakeIrisEngine.initialize();

      rtcChannel = await _createChannel();
      await rtcChannel.setClientRole(ClientRole.Broadcaster);
      fakeIrisEngine.expectCalledApi(
        ApiTypeChannel.kChannelSetClientRole.index,
        jsonEncode({
          'channelId': 'testapi',
          'role': 1,
          'options': null,
        }),
      );
    });

    testWidgets('with `role`, `options`', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
      await fakeIrisEngine.initialize();

      rtcChannel = await _createChannel();
      final ClientRoleOptions options = ClientRoleOptions(
          audienceLatencyLevel: AudienceLatencyLevelType.LowLatency);
      await rtcChannel.setClientRole(ClientRole.Broadcaster, options);
      fakeIrisEngine.expectCalledApi(
        ApiTypeChannel.kChannelSetClientRole.index,
        jsonEncode({
          'channelId': 'testapi',
          'role': 1,
          'options': options.toJson(),
        }),
      );
    });
  });

  testWidgets('joinChannel', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    final ChannelMediaOptions options =
        ChannelMediaOptions(autoSubscribeAudio: true);
    await rtcChannel.joinChannel(null, null, 10, options);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelJoinChannel.index,
      jsonEncode({
        'channelId': 'testapi',
        'token': null,
        'info': null,
        'uid': 10,
        'options': options.toJson(),
      }),
    );
  });

  testWidgets('joinChannelWithUserAccount', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    final ChannelMediaOptions options =
        ChannelMediaOptions(autoSubscribeAudio: true);
    await rtcChannel.joinChannelWithUserAccount(null, 'user1', options);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelJoinChannelWithUserAccount.index,
      jsonEncode({
        'channelId': 'testapi',
        'token': null,
        'userAccount': 'user1',
        'options': options.toJson(),
      }),
    );
  });

  testWidgets('leaveChannel', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.leaveChannel();
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelLeaveChannel.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
    );
  });

  testWidgets('renewToken', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.renewToken('t');
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelRenewToken.index,
      jsonEncode({
        'channelId': 'testapi',
        'token': 't',
      }),
    );
  });

  testWidgets('getConnectionState', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    fakeIrisEngine.mockCallApiReturnCode(
      ApiTypeChannel.kChannelGetConnectionState.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
      2,
    );
    rtcChannel = await _createChannel();
    final ret = await rtcChannel.getConnectionState();
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelGetConnectionState.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
    );

    expect(ret, ConnectionStateType.Connecting);
  });

  testWidgets('publish', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    // ignore: deprecated_member_use
    await rtcChannel.publish();
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelPublish.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
    );
  });

  testWidgets('unpublish', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    // ignore: deprecated_member_use
    await rtcChannel.unpublish();
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelUnPublish.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
    );
  });

  testWidgets('getCallId', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    fakeIrisEngine.mockCallApiResult(
      ApiTypeChannel.kChannelGetCallId.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
      '10',
    );
    rtcChannel = await _createChannel();
    final ret = await rtcChannel.getCallId();
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelGetCallId.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
    );

    expect(ret, '10');
  });

  testWidgets('adjustUserPlaybackSignalVolume', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.adjustUserPlaybackSignalVolume(10, 20);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelAdjustUserPlaybackSignalVolume.index,
      jsonEncode({
        'channelId': 'testapi',
        'uid': 10,
        'volume': 20,
      }),
    );
  });

  testWidgets('muteAllRemoteAudioStreams', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.muteAllRemoteAudioStreams(true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelMuteAllRemoteAudioStreams.index,
      jsonEncode({
        'channelId': 'testapi',
        'mute': true,
      }),
    );
  });

  testWidgets('muteRemoteAudioStream', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.muteRemoteAudioStream(10, true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelMuteRemoteAudioStream.index,
      jsonEncode({
        'channelId': 'testapi',
        'userId': 10,
        'mute': true,
      }),
    );
  });

  testWidgets('setDefaultMuteAllRemoteAudioStreams',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    // ignore: deprecated_member_use
    await rtcChannel.setDefaultMuteAllRemoteAudioStreams(true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSetDefaultMuteAllRemoteAudioStreams.index,
      jsonEncode({
        'channelId': 'testapi',
        'mute': true,
      }),
    );
  });

  testWidgets('muteAllRemoteVideoStreams', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    // ignore: deprecated_member_use
    await rtcChannel.muteAllRemoteVideoStreams(true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelMuteAllRemoteVideoStreams.index,
      jsonEncode({
        'channelId': 'testapi',
        'mute': true,
      }),
    );
  });

  testWidgets('muteRemoteVideoStream', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();

    await rtcChannel.muteRemoteVideoStream(10, true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelMuteRemoteVideoStream.index,
      jsonEncode({
        'channelId': 'testapi',
        'userId': 10,
        'mute': true,
      }),
    );
  });

  testWidgets('setDefaultMuteAllRemoteVideoStreams',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    // ignore: deprecated_member_use
    await rtcChannel.setDefaultMuteAllRemoteVideoStreams(true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSetDefaultMuteAllRemoteVideoStreams.index,
      jsonEncode({
        'channelId': 'testapi',
        'mute': true,
      }),
    );
  });

  testWidgets('addInjectStreamUrl', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    final LiveInjectStreamConfig config =
        LiveInjectStreamConfig(width: 10, height: 10);
    await rtcChannel.addInjectStreamUrl('https://example.com', config);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelAddInjectStreamUrl.index,
      jsonEncode({
        'channelId': 'testapi',
        'url': 'https://example.com',
        'config': config.toJson(),
      }),
    );
  });

  testWidgets('addPublishStreamUrl', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.addPublishStreamUrl('https://example.com', true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelAddPublishStreamUrl.index,
      jsonEncode({
        'channelId': 'testapi',
        'url': 'https://example.com',
        'transcodingEnabled': true,
      }),
    );
  });

  testWidgets('createDataStream', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    // ignore: deprecated_member_use
    await rtcChannel.createDataStream(true, true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelCreateDataStream.index,
      jsonEncode({
        'channelId': 'testapi',
        'reliable': true,
        'ordered': true,
      }),
    );
  });

  testWidgets('registerMediaMetadataObserver', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.registerMediaMetadataObserver();
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelRegisterMediaMetadataObserver.index,
      jsonEncode({
        'channelId': 'testapi',
        'type': 0,
      }),
    );
  });

  testWidgets('removeInjectStreamUrl', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.removeInjectStreamUrl('https://example.com');
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelRemoveInjectStreamUrl.index,
      jsonEncode({
        'channelId': 'testapi',
        'url': 'https://example.com',
      }),
    );
  });

  testWidgets('removePublishStreamUrl', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.removePublishStreamUrl('https://example.com');
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelRemovePublishStreamUrl.index,
      jsonEncode({
        'channelId': 'testapi',
        'url': 'https://example.com',
      }),
    );
  });

  testWidgets('sendMetadata', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    final Uint8List metadata = Uint8List.fromList([1, 1]);
    fakeIrisEngine.setExplicitBufferSize(
      ApiTypeChannel.kChannelSendMetadata.index,
      jsonEncode({
        'channelId': 'testapi',
        'metadata': {
          'size': metadata.length,
        },
      }),
      metadata.length,
    );

    rtcChannel = await _createChannel();

    await rtcChannel.registerMediaMetadataObserver();
    await rtcChannel.sendMetadata(metadata);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSendMetadata.index,
      jsonEncode({
        'channelId': 'testapi',
        'metadata': {
          'size': metadata.length,
        },
      }),
      buffer: metadata,
      bufferSize: metadata.length,
    );
  });

  testWidgets('sendStreamMessage', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    final Uint8List message = Uint8List.fromList([1, 1]);
    fakeIrisEngine.setExplicitBufferSize(
      ApiTypeChannel.kChannelSendStreamMessage.index,
      jsonEncode({
        'channelId': 'testapi',
        'streamId': 10,
        'length': message.length,
      }),
      message.length,
    );

    rtcChannel = await _createChannel();

    await rtcChannel.sendStreamMessage(10, message);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSendStreamMessage.index,
      jsonEncode({
        'channelId': 'testapi',
        'streamId': 10,
        'length': message.length,
      }),
      buffer: message,
      bufferSize: message.length,
    );
  });

  // TODO(littlegnal): Check if change the encryptionMode from int -> string is ok or not
  testWidgets(
    'setEncryptionMode',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
      await fakeIrisEngine.initialize();

      rtcChannel = await _createChannel();
      // ignore: deprecated_member_use
      await rtcChannel.setEncryptionMode(EncryptionMode.AES128GCM);
      fakeIrisEngine.expectCalledApi(
        ApiTypeChannel.kChannelSetEncryptionMode.index,
        jsonEncode({
          'channelId': 'testapi',
          'encryptionMode': 5,
        }),
      );
    },
    skip:
        true, // TODO(littlegnal): [MS-99372] Need comfirm how to deal with this function
  );

  testWidgets('setEncryptionSecret', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    // ignore: deprecated_member_use
    await rtcChannel.setEncryptionSecret('s');
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSetEncryptionSecret.index,
      jsonEncode({
        'channelId': 'testapi',
        'secret': 's',
      }),
    );
  });

  testWidgets('setLiveTranscoding', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    final LiveTranscoding transcoding = LiveTranscoding([TranscodingUser(10)]);
    await rtcChannel.setLiveTranscoding(transcoding);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSetLiveTranscoding.index,
      jsonEncode({
        'channelId': 'testapi',
        'transcoding': transcoding.toJson(),
      }),
    );
  });

  testWidgets('setMaxMetadataSize', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.setMaxMetadataSize(10);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSetMaxMetadataSize.index,
      jsonEncode({
        'channelId': 'testapi',
        'size': 10,
      }),
    );
  });

  testWidgets('setRemoteDefaultVideoStreamType', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.setRemoteDefaultVideoStreamType(VideoStreamType.High);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSetRemoteDefaultVideoStreamType.index,
      jsonEncode({
        'channelId': 'testapi',
        'streamType': 0,
      }),
    );
  });

  testWidgets('setRemoteUserPriority', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.setRemoteUserPriority(10, UserPriority.High);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSetRemoteUserPriority.index,
      jsonEncode({
        'channelId': 'testapi',
        'uid': 10,
        'userPriority': 50,
      }),
    );
  });

  testWidgets('setRemoteVideoStreamType', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.setRemoteVideoStreamType(10, VideoStreamType.Low);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSetRemoteVideoStreamType.index,
      jsonEncode({
        'channelId': 'testapi',
        'userId': 10,
        'streamType': 1,
      }),
    );
  });

  testWidgets('setRemoteVoicePosition', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.setRemoteVoicePosition(10, 1.0, 2.0);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelSetRemoteVoicePosition.index,
      jsonEncode({
        'channelId': 'testapi',
        'uid': 10,
        'pan': 1.0,
        'gain': 2.0,
      }),
    );
  });

  testWidgets('startChannelMediaRelay', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    final ChannelMediaRelayConfiguration config =
        ChannelMediaRelayConfiguration(
      ChannelMediaInfo('testapi', 10),
      [ChannelMediaInfo('testapi', 10)],
    );
    await rtcChannel.startChannelMediaRelay(config);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelStartChannelMediaRelay.index,
      jsonEncode({
        'channelId': 'testapi',
        'configuration': config.toJson(),
      }),
    );
  });

  testWidgets('stopChannelMediaRelay', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.stopChannelMediaRelay();
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelStopChannelMediaRelay.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
    );
  });

  testWidgets(
    'unregisterMediaMetadataObserver',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
      await fakeIrisEngine.initialize();

      rtcChannel = await _createChannel();
      await rtcChannel.unregisterMediaMetadataObserver();
      fakeIrisEngine.expectCalledApi(
        ApiTypeChannel.kChannelUnRegisterMediaMetadataObserver.index,
        jsonEncode({
          'channelId': 'testapi',
        }),
      );
    },
    skip: true, // TODO(littlegnal): [MS-99374] Enable after iris fixed
  );

  testWidgets('updateChannelMediaRelay', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    final ChannelMediaRelayConfiguration config =
        ChannelMediaRelayConfiguration(
      ChannelMediaInfo('testapi', 10),
      [ChannelMediaInfo('testapi', 10)],
    );
    await rtcChannel.updateChannelMediaRelay(config);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelUpdateChannelMediaRelay.index,
      jsonEncode({
        'channelId': 'testapi',
        'configuration': config.toJson(),
      }),
    );
  });

  testWidgets('enableEncryption', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    final EncryptionConfig config = EncryptionConfig(
      encryptionMode: EncryptionMode.AES128GCM2,
    );
    await rtcChannel.enableEncryption(true, config);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelEnableEncryption.index,
      jsonEncode({
        'channelId': 'testapi',
        'enabled': true,
        'config': config.toJson(),
      }),
    );
  });

  testWidgets('createDataStreamWithConfig', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    final DataStreamConfig config = DataStreamConfig(true, true);
    await rtcChannel.createDataStreamWithConfig(config);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelCreateDataStream.index,
      jsonEncode({
        'channelId': 'testapi',
        'config': config.toJson(),
      }),
    );
  });

  testWidgets('enableRemoteSuperResolution', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.enableRemoteSuperResolution(10, true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelEnableRemoteSuperResolution.index,
      jsonEncode({
        'channelId': 'testapi',
        'userId': 10,
        'enable': true,
      }),
    );
  });

  testWidgets('muteLocalAudioStream', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.muteLocalAudioStream(true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelMuteLocalAudioStream.index,
      jsonEncode({
        'channelId': 'testapi',
        'mute': true,
      }),
    );
  });

  testWidgets('muteLocalVideoStream', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.muteLocalVideoStream(true);
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelMuteLocalVideoStream.index,
      jsonEncode({
        'channelId': 'testapi',
        'mute': true,
      }),
    );
  });

  testWidgets('pauseAllChannelMediaRelay', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.pauseAllChannelMediaRelay();
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelPauseAllChannelMediaRelay.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
    );
  });

  testWidgets('resumeAllChannelMediaRelay', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisEngine.initialize();

    rtcChannel = await _createChannel();
    await rtcChannel.resumeAllChannelMediaRelay();
    fakeIrisEngine.expectCalledApi(
      ApiTypeChannel.kChannelResumeAllChannelMediaRelay.index,
      jsonEncode({
        'channelId': 'testapi',
      }),
    );
  });
}
