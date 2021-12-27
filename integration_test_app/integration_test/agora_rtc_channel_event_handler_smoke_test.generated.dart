import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void rtcChannelEventHandlerSomkeTestCases() {
  testWidgets('onWarning', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      warning: (warn) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onWarning');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onError', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      error: (err) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onError');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onJoinChannelSuccess', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onJoinChannelSuccess');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onRejoinChannelSuccess', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      rejoinChannelSuccess: (channel, uid, elapsed) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onRejoinChannelSuccess');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onLeaveChannel', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      leaveChannel: (stats) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onLeaveChannel');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onClientRoleChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      clientRoleChanged: (oldRole, newRole) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onClientRoleChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onUserJoined', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      userJoined: (uid, elapsed) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onUserJoined');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onUserOffline', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      userOffline: (uid, reason) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onUserOffline');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onConnectionStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      connectionStateChanged: (state, reason) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onConnectionStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onConnectionLost', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      connectionLost: () {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onConnectionLost');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onTokenPrivilegeWillExpire', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      tokenPrivilegeWillExpire: (token) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onTokenPrivilegeWillExpire');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onRequestToken', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      requestToken: () {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onRequestToken');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onActiveSpeaker', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      activeSpeaker: (uid) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onActiveSpeaker');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onVideoSizeChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      videoSizeChanged: (uid, width, height, rotation) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onVideoSizeChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onRemoteVideoStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      remoteVideoStateChanged: (uid, state, reason, elapsed) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onRemoteVideoStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onRemoteAudioStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      remoteAudioStateChanged: (uid, state, reason, elapsed) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onRemoteAudioStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onLocalPublishFallbackToAudioOnly', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      localPublishFallbackToAudioOnly: (isFallbackOrRecover) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onLocalPublishFallbackToAudioOnly');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onRemoteSubscribeFallbackToAudioOnly',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      remoteSubscribeFallbackToAudioOnly: (uid, isFallbackOrRecover) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onRemoteSubscribeFallbackToAudioOnly');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onRtcStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      rtcStats: (stats) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onRtcStats');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onNetworkQuality', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      networkQuality: (uid, txQuality, rxQuality) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onNetworkQuality');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onRemoteVideoStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      remoteVideoStats: (stats) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onRemoteVideoStats');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onRemoteAudioStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      remoteAudioStats: (stats) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onRemoteAudioStats');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onRtmpStreamingStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      rtmpStreamingStateChanged: (url, state, errCode) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onRtmpStreamingStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onTranscodingUpdated', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      transcodingUpdated: () {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onTranscodingUpdated');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onStreamInjectedStatus', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      streamInjectedStatus: (url, uid, status) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onStreamInjectedStatus');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onStreamMessage', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      streamMessage: (uid, streamId, data) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onStreamMessage');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onStreamMessageError', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      streamMessageError: (uid, streamId, error, missed, cached) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onStreamMessageError');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onChannelMediaRelayStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      channelMediaRelayStateChanged: (state, code) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onChannelMediaRelayStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onChannelMediaRelayEvent', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      channelMediaRelayEvent: (code) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onChannelMediaRelayEvent');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onMetadataReceived', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      metadataReceived: (metadata) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onMetadataReceived');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onAudioPublishStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      audioPublishStateChanged:
          (channel, oldState, newState, elapseSinceLastState) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onAudioPublishStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onVideoPublishStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      videoPublishStateChanged:
          (channel, oldState, newState, elapseSinceLastState) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onVideoPublishStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onAudioSubscribeStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      audioSubscribeStateChanged:
          (channel, uid, oldState, newState, elapseSinceLastState) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onAudioSubscribeStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onVideoSubscribeStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      videoSubscribeStateChanged:
          (channel, uid, oldState, newState, elapseSinceLastState) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onVideoSubscribeStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onRtmpStreamingEvent', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      rtmpStreamingEvent: (url, eventCode) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onRtmpStreamingEvent');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
  testWidgets('onUserSuperResolutionEnabled', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    final rtcChannel = await RtcChannel.create('testapi');
    rtcChannel.setEventHandler(RtcChannelEventHandler(
      userSuperResolutionEnabled: (uid, enabled, reason) {},
    ));

    fakeIrisEngine.fireRtcChannelEvent('onUserSuperResolutionEnabled');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    await rtcChannel.destroy();
    await rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
}
