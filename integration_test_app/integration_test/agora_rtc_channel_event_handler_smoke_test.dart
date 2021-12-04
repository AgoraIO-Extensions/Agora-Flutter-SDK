import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // late RtcEngine rtcEngine;
  late FakeIrisRtcEngine fakeIrisEngine;

  setUpAll(() async {
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
  });

  testWidgets('RtcChannelEventHander smoke test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final rtcEngine = await RtcEngine.create('123');

    final rtcChannel = await RtcChannel.create('testapi');

    rtcChannel.setEventHandler(RtcChannelEventHandler(
      warning: (warn) {},
      error: (err) {},
      joinChannelSuccess: (channel, uid, elapsed) {},
      rejoinChannelSuccess: (channel, uid, elapsed) {},
      leaveChannel: (stats) {},
      clientRoleChanged: (oldRole, newRole) {},
      userJoined: (uid, elapsed) {},
      userOffline: (uid, reason) {},
      connectionStateChanged: (state, reason) {},
      connectionLost: () {},
      tokenPrivilegeWillExpire: (token) {},
      requestToken: () {},
      activeSpeaker: (uid) {},
      videoSizeChanged: (uid, width, height, rotation) {},
      remoteVideoStateChanged: (uid, state, reason, elapsed) {},
      remoteAudioStateChanged: (uid, state, reason, elapsed) {},
      localPublishFallbackToAudioOnly: (isFallbackOrRecover) {},
      remoteSubscribeFallbackToAudioOnly: (uid, isFallbackOrRecover) {},
      rtcStats: (stats) {},
      networkQuality: (uid, txQuality, rxQuality) {},
      remoteVideoStats: (stats) {},
      remoteAudioStats: (stats) {},
      rtmpStreamingStateChanged: (url, state, errCode) {},
      transcodingUpdated: () {},
      streamInjectedStatus: (url, uid, status) {},
      streamMessage: (uid, streamId, data) {},
      streamMessageError: (uid, streamId, error, missed, cached) {},
      channelMediaRelayStateChanged: (state, code) {},
      channelMediaRelayEvent: (code) {},
      metadataReceived: (metadata) {},
      audioPublishStateChanged:
          (channel, oldState, newState, elapseSinceLastState) {},
      videoPublishStateChanged:
          (channel, oldState, newState, elapseSinceLastState) {},
      audioSubscribeStateChanged:
          (channel, uid, oldState, newState, elapseSinceLastState) {},
      videoSubscribeStateChanged:
          (channel, uid, oldState, newState, elapseSinceLastState) {},
      userSuperResolutionEnabled: (uid, enabled, reason) {},
    ));

    fakeIrisEngine.fireAllChannelEvents();

    await rtcChannel.destroy();
    await rtcEngine.destroy();
  });
}
