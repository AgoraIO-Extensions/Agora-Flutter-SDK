import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/event_handler_tester.dart';
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late RtcEngine rtcEngine;
  late RtcChannel rtcChannel;
  late FakeIrisRtcEngine fakeIrisRtcEngine;

  Future<RtcChannel> _createChannel() async {
    rtcEngine = await RtcEngine.create('123');
    return RtcChannel.create('testapi');
  }

  tearDown(() async {
    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisRtcEngine.dispose();
  });

  testEventCall('warning', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      warning: (WarningCode warn) {
        expectSync(warn, WarningCode.AdmInterruption);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onChannelWarning',
      '{"channelId":"testapi","warn":1025,"msg":"warning"}',
    );
  });

  testEventCall('error', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      error: (ErrorCode err) {
        expectSync(err, ErrorCode.AdmInitPlayout);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onChannelError',
      '{"channelId":"testapi","err":1008,"msg":"error"}',
    );
  });

  testEventCall('joinChannelSuccess', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        expectSync(channel, 'testapi');
        expectSync(uid, 10);
        expectSync(elapsed, 100);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onJoinChannelSuccess',
      '{"channelId":"testapi","channel":"testapi","uid":10,"elapsed":100}',
    );
  });

  testEventCall('rejoinChannelSuccess', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      rejoinChannelSuccess: (String channel, int uid, int elapsed) {
        expectSync(channel, 'testapi');
        expectSync(uid, 10);
        expectSync(elapsed, 100);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onRejoinChannelSuccess',
      '{"channelId":"testapi","channel":"testapi","uid":10,"elapsed":100}',
    );
  });

  testEventCall('leaveChannel', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    final expectSyncedStats = RtcStats(10, 20, 20, 100, 100, 200, 200, 10, 10,
        20, 20, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      leaveChannel: (RtcStats stats) {
        expectSync(jsonEncode(stats), jsonEncode(expectSyncedStats));

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onLeaveChannel',
      '{"channelId":"testapi","stats":${jsonEncode(expectSyncedStats.toJson())}}',
    );
  });

  testEventCall('clientRoleChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      clientRoleChanged: (ClientRole oldRole, ClientRole newRole) {
        expectSync(oldRole, ClientRole.Broadcaster);
        expectSync(newRole, ClientRole.Audience);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onClientRoleChanged',
      '{"channelId":"testapi","oldRole":1,"newRole":2}',
    );
  });

  testEventCall('userJoined', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      userJoined: (int uid, int elapsed) {
        expectSync(uid, 10);
        expectSync(elapsed, 100);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onUserJoined',
      '{"channelId":"testapi","uid":10,"elapsed":100}',
    );
  });

  testEventCall('userOffline', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      userOffline: (int uid, UserOfflineReason reason) {
        expectSync(uid, 10);
        expectSync(reason, UserOfflineReason.Dropped);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onUserOffline',
      '{"channelId":"testapi","uid":10,"reason":1}',
    );
  });

  testEventCall('connectionStateChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      connectionStateChanged:
          (ConnectionStateType state, ConnectionChangedReason reason) {
        expectSync(state, ConnectionStateType.Connecting);
        expectSync(reason, ConnectionChangedReason.Interrupted);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onConnectionStateChanged',
      '{"channelId":"testapi","state":2,"reason":2}',
    );
  });

  testEventCall('connectionLost', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      connectionLost: () {
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onConnectionLost',
      '{"channelId":"testapi"}',
    );
  });

  testEventCall('tokenPrivilegeWillExpire', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      tokenPrivilegeWillExpire: (String token) {
        expectSync(token, 't');
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onTokenPrivilegeWillExpire',
      '{"channelId":"testapi","token":"t"}',
    );
  });

  testEventCall('requestToken', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      requestToken: () {
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onRequestToken',
      '{"channelId":"testapi"}',
    );
  });

  testEventCall('activeSpeaker', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      activeSpeaker: (int uid) {
        expectSync(uid, 10);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onActiveSpeaker',
      '{"channelId":"testapi","uid":10}',
    );
  });

  testEventCall('videoSizeChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      videoSizeChanged: (int uid, int width, int height, int rotation) {
        expectSync(uid, 10);
        expectSync(width, 100);
        expectSync(height, 100);
        expectSync(rotation, 30);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onVideoSizeChanged',
      '{"channelId":"testapi","uid":10,"width":100,"height":100,"rotation":30}',
    );
  });

  testEventCall('remoteVideoStateChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      remoteVideoStateChanged: (
        int uid,
        VideoRemoteState state,
        VideoRemoteStateReason reason,
        int elapsed,
      ) {
        expectSync(uid, 10);
        expectSync(state, VideoRemoteState.Frozen);
        expectSync(reason, VideoRemoteStateReason.LocalMuted);
        expectSync(elapsed, 100);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onRemoteVideoStateChanged',
      '{"channelId":"testapi","uid":10,"state":3,"reason":3,"elapsed":100}',
    );
  });

  testEventCall('remoteAudioStateChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      remoteAudioStateChanged: (
        int uid,
        AudioRemoteState state,
        AudioRemoteStateReason reason,
        int elapsed,
      ) {
        expectSync(uid, 10);
        expectSync(state, AudioRemoteState.Frozen);
        expectSync(reason, AudioRemoteStateReason.LocalMuted);
        expectSync(elapsed, 100);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onRemoteAudioStateChanged',
      '{"channelId":"testapi","uid":10,"state":3,"reason":3,"elapsed":100}',
    );
  });

  testEventCall('localPublishFallbackToAudioOnly', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      localPublishFallbackToAudioOnly: (bool isFallbackOrRecover) {
        expectSync(isFallbackOrRecover, true);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onLocalPublishFallbackToAudioOnly',
      '{"channelId":"testapi","isFallbackOrRecover":true}',
    );
  });

  testEventCall('remoteSubscribeFallbackToAudioOnly', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      remoteSubscribeFallbackToAudioOnly: (int uid, bool isFallbackOrRecover) {
        expectSync(uid, 10);
        expectSync(isFallbackOrRecover, true);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onRemoteSubscribeFallbackToAudioOnly',
      '{"channelId":"testapi","uid":10,"isFallbackOrRecover":true}',
    );
  });

  testEventCall('rtcStats', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    final expectSyncedStats = RtcStats(10, 20, 20, 100, 100, 200, 200, 10, 10,
        20, 20, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      rtcStats: (RtcStats stats) {
        expectSync(jsonEncode(stats), jsonEncode(expectSyncedStats.toJson()));

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onRtcStats',
      '{"channelId":"testapi","stats":${jsonEncode(expectSyncedStats.toJson())}}',
    );
  });

  testEventCall('networkQuality', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      networkQuality:
          (int uid, NetworkQuality txQuality, NetworkQuality rxQuality) {
        expectSync(uid, 10);
        expectSync(txQuality, NetworkQuality.Detecting);
        expectSync(rxQuality, NetworkQuality.Excellent);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onNetworkQuality',
      '{"channelId":"testapi","uid":10,"txQuality":8,"rxQuality":1}',
    );
  });

  testEventCall('remoteVideoStats', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    final expectSyncedRemoteVideoStats = RemoteVideoStats(
        10, 10, 10, 10, 10, 10, 10, 10, VideoStreamType.High, 10, 10, 10, 10);
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      remoteVideoStats: (RemoteVideoStats stats) {
        expectSync(jsonEncode(stats), jsonEncode(expectSyncedRemoteVideoStats));

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onRemoteVideoStats',
      '{"channelId":"testapi","stats":${jsonEncode(expectSyncedRemoteVideoStats.toJson())}}',
    );
  });

  testEventCall('remoteAudioStats', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    final expectSyncedRemoteAudioStats = RemoteAudioStats(
      10,
      NetworkQuality.Excellent,
      10,
      10,
      10,
      10,
      10,
      10,
      10,
      10,
      10,
      10,
      ExperienceQualityType.Good,
      ExperiencePoorReason.RemoteNetworkQualityPoor,
      10,
    );
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      remoteAudioStats: (RemoteAudioStats stats) {
        expectSync(jsonEncode(stats), jsonEncode(expectSyncedRemoteAudioStats));

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onRemoteAudioStats',
      '{"channelId":"testapi","stats":${jsonEncode(expectSyncedRemoteAudioStats.toJson())}}',
    );
  });

  testEventCall('rtmpStreamingStateChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      rtmpStreamingStateChanged: (String url, RtmpStreamingState state,
          RtmpStreamingErrorCode errCode) {
        expectSync(url, 'https://example.com');
        expectSync(state, RtmpStreamingState.Recovering);
        expectSync(errCode, RtmpStreamingErrorCode.FormatNotSupported);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onRtmpStreamingStateChanged',
      '{"channelId":"testapi","url":"https://example.com","state":3,"errCode":10}',
    );
  });

  testEventCall('transcodingUpdated', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      transcodingUpdated: () {
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onTranscodingUpdated',
      '{"channelId":"testapi"}',
    );
  });

  testEventCall('streamInjectedStatus', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      streamInjectedStatus: (String url, int uid, InjectStreamStatus status) {
        expectSync(url, 'https://example.com');
        expectSync(uid, 10);
        expectSync(status, InjectStreamStatus.StartTimedout);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onStreamInjectedStatus',
      '{"channelId":"testapi","url":"https://example.com","uid":10,"status":3}',
    );
  });

  testEventCall('streamMessage', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();
    final buffer = Uint8List.fromList([1, 1]);

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      streamMessage: (int uid, int streamId, Uint8List data) {
        expectSync(uid, 10);
        expectSync(streamId, 20);
        expectSync(data, buffer);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onStreamMessage',
      '{"channelId":"testapi","uid":10,"streamId":20,"length":2}',
      buffer: buffer,
      bufferSize: 2,
    );
  });

  testEventCall('streamMessageError', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      streamMessageError:
          (int uid, int streamId, ErrorCode error, int missed, int cached) {
        expectSync(uid, 10);
        expectSync(streamId, 20);
        expectSync(error, ErrorCode.AdmInitPlayout);
        expectSync(missed, 10);
        expectSync(cached, 20);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onStreamMessageError',
      '{"channelId":"testapi","uid":10,"streamId":20,"code":1008,"missed":10,"cached":20}',
    );
  });

  testEventCall('channelMediaRelayStateChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      channelMediaRelayStateChanged:
          (ChannelMediaRelayState state, ChannelMediaRelayError code) {
        expectSync(state, ChannelMediaRelayState.Running);
        expectSync(code, ChannelMediaRelayError.FailedPacketReceivedFromSource);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onChannelMediaRelayStateChanged',
      '{"channelId":"testapi","state":2,"code":6}',
    );
  });

  testEventCall('channelMediaRelayEvent', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      channelMediaRelayEvent: (ChannelMediaRelayEvent code) {
        expectSync(code, ChannelMediaRelayEvent.JoinedDestinationChannel);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onChannelMediaRelayEvent',
      '{"channelId":"testapi","code":3}',
    );
  });

  testEventCall('metadataReceived', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();

    final buffer = Uint8List.fromList([1, 1]);
    final Metadata expectSyncedMetadata = Metadata(10, 1000);

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      metadataReceived: (Metadata metadata) {
        expectSync(metadata.uid, expectSyncedMetadata.uid);
        expectSync(metadata.timeStampMs, expectSyncedMetadata.timeStampMs);
        expectSync(metadata.buffer, buffer);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onMetadataReceived',
      '{"channelId":"testapi","metadata":${jsonEncode(expectSyncedMetadata.toJson())}}',
      buffer: buffer,
      bufferSize: 2,
    );
  });

  testEventCall('audioPublishStateChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      audioPublishStateChanged: (String channel, StreamPublishState oldState,
          StreamPublishState newState, int elapseSinceLastState) {
        expectSync(channel, 'testapi');
        expectSync(oldState, StreamPublishState.NoPublished);
        expectSync(newState, StreamPublishState.Published);
        expectSync(elapseSinceLastState, 100);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onAudioPublishStateChanged',
      '{"channelId":"testapi","oldState":1,"newState":3,"elapseSinceLastState":100}',
    );
  });

  testEventCall('videoPublishStateChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      videoPublishStateChanged: (String channel, StreamPublishState oldState,
          StreamPublishState newState, int elapseSinceLastState) {
        expectSync(channel, 'testapi');
        expectSync(oldState, StreamPublishState.NoPublished);
        expectSync(newState, StreamPublishState.Published);
        expectSync(elapseSinceLastState, 100);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onVideoPublishStateChanged',
      '{"channelId":"testapi","oldState":1,"newState":3,"elapseSinceLastState":100}',
    );
  });

  testEventCall('audioSubscribeStateChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      audioSubscribeStateChanged: (
        String channel,
        int uid,
        StreamSubscribeState oldState,
        StreamSubscribeState newState,
        int elapseSinceLastState,
      ) {
        expectSync(channel, 'testapi');
        expectSync(uid, 10);
        expectSync(oldState, StreamSubscribeState.NoSubscribed);
        expectSync(newState, StreamSubscribeState.Subscribing);
        expectSync(elapseSinceLastState, 100);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onAudioSubscribeStateChanged',
      '{"channelId":"testapi","uid":10,"oldState":1,"newState":2,"elapseSinceLastState":100}',
    );
  });

  testEventCall('videoSubscribeStateChanged', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      videoSubscribeStateChanged: (
        String channel,
        int uid,
        StreamSubscribeState oldState,
        StreamSubscribeState newState,
        int elapseSinceLastState,
      ) {
        expectSync(channel, 'testapi');
        expectSync(uid, 10);
        expectSync(oldState, StreamSubscribeState.Subscribing);
        expectSync(newState, StreamSubscribeState.Idle);
        expectSync(elapseSinceLastState, 100);
        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onVideoSubscribeStateChanged',
      '{"channelId":"testapi","uid":10,"oldState":2,"newState":0,"elapseSinceLastState":100}',
    );
  });

  testEventCall('rtmpStreamingEvent', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      rtmpStreamingEvent: (String url, RtmpStreamingEvent eventCode) {
        expectSync(url, 'https://example.com');
        expectSync(eventCode, RtmpStreamingEvent.UrlAlreadyInUse);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onRtmpStreamingEvent',
      '{"channelId":"testapi","url":"https://example.com","eventCode":2}',
    );
  });

  testEventCall('userSuperResolutionEnabled', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    fakeIrisRtcEngine = FakeIrisRtcEngine(isMockChannel: true);
    await fakeIrisRtcEngine.initialize();
    rtcChannel = await _createChannel();

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      userSuperResolutionEnabled:
          (int uid, bool enabled, SuperResolutionStateReason reason) {
        expectSync(uid, 10);
        expectSync(enabled, true);
        expectSync(reason, SuperResolutionStateReason.StreamOverLimitation);

        eventHandlerTester.markEventCalled();
      },
    ));

    await fakeIrisRtcEngine.fireAndWaitEvent(
      tester,
      'onUserSuperResolutionEnabled',
      '{"channelId":"testapi","uid":10,"enabled":true,"reason":1}',
    );
  });
}
