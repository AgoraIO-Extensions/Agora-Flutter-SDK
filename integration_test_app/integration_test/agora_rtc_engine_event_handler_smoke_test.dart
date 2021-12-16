// TODO(littlegnal): Temporary disable somke test for iOS/macOS, because it is not stable
// to run somke test on CI at this time
// @Skip('currently failing')

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late FakeIrisRtcEngine fakeIrisEngine;

  setUp(() async {
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
  });

  tearDown(() {
    fakeIrisEngine.dispose();
  });

  testWidgets('RtcEngineEventHander smoke test', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      warning: (warn) {},
      error: (err) {},
      apiCallExecuted: (error, api, result) {},
      joinChannelSuccess: (channel, uid, elapsed) {},
      rejoinChannelSuccess: (channel, uid, elapsed) {},
      leaveChannel: (stats) {},
      localUserRegistered: (uid, userAccount) {},
      userInfoUpdated: (uid, userInfo) {},
      clientRoleChanged: (oldRole, newRole) {},
      userJoined: (uid, elapsed) {},
      userOffline: (uid, reason) {},
      connectionStateChanged: (state, reason) {},
      networkTypeChanged: (type) {},
      connectionLost: () {},
      tokenPrivilegeWillExpire: (token) {},
      requestToken: () {},
      audioVolumeIndication: (speakers, totalVolume) {},
      activeSpeaker: (uid) {},
      firstLocalAudioFrame: (elapsed) {},
      firstLocalVideoFrame: (width, height, elapsed) {},
      userMuteVideo: (uid, muted) {},
      videoSizeChanged: (uid, width, height, rotation) {},
      remoteVideoStateChanged: (uid, state, reason, elapsed) {},
      localVideoStateChanged: (localVideoState, error) {},
      remoteAudioStateChanged: (uid, state, reason, elapsed) {},
      localAudioStateChanged: (state, error) {},
      requestAudioFileInfoCallback: (info, error) {},
      localPublishFallbackToAudioOnly: (isFallbackOrRecover) {},
      remoteSubscribeFallbackToAudioOnly: (uid, isFallbackOrRecover) {},
      audioRouteChanged: (routing) {},
      cameraFocusAreaChanged: (rect) {},
      cameraExposureAreaChanged: (rect) {},
      facePositionChanged: (imageWidth, imageHeight, faces) {},
      lastmileQuality: (quality) {},
      networkQuality: (uid, txQuality, rxQuality) {},
      lastmileProbeResult: (result) {},
      localVideoStats: (stats) {},
      localAudioStats: (stats) {},
      remoteVideoStats: (stats) {},
      remoteAudioStats: (stats) {},
      audioMixingFinished: () {},
      audioMixingStateChanged: (state, reason) {},
      audioEffectFinished: (soundId) {},
      rtmpStreamingStateChanged: (url, state, errCode) {},
      transcodingUpdated: () {},
      streamInjectedStatus: (url, uid, status) {},
      streamMessage: (uid, streamId, data) {},
      streamMessageError: (uid, streamId, error, missed, cached) {},
      mediaEngineLoadSuccess: () {},
      mediaEngineStartCallSuccess: () {},
      channelMediaRelayStateChanged: (state, code) {},
      channelMediaRelayEvent: (code) {},
      firstRemoteVideoFrame: (uid, width, height, elapsed) {},
      firstRemoteAudioFrame: (uid, elapsed) {},
      firstRemoteAudioDecoded: (uid, elapsed) {},
      userMuteAudio: (uid, muted) {},
      streamPublished: (url, error) {},
      streamUnpublished: (url) {},
      remoteAudioTransportStats: (uid, delay, lost, rxKBitRate) {},
      remoteVideoTransportStats: (uid, delay, lost, rxKBitRate) {},
      userEnableVideo: (uid, enabled) {},
      userEnableLocalVideo: (uid, enabled) {},
      firstRemoteVideoDecoded: (uid, width, height, elapsed) {},
      microphoneEnabled: (enabled) {},
      connectionInterrupted: () {},
      connectionBanned: () {},
      audioQuality: (uid, quality, delay, lost) {},
      cameraReady: () {},
      videoStopped: () {},
      metadataReceived: (metadata) {},
      firstLocalAudioFramePublished: (elapsed) {},
      firstLocalVideoFramePublished: (elapsed) {},
      audioPublishStateChanged:
          (channel, oldState, newState, elapseSinceLastState) {},
      videoPublishStateChanged:
          (channel, oldState, newState, elapseSinceLastState) {},
      audioSubscribeStateChanged:
          (channel, uid, oldState, newState, elapseSinceLastState) {},
      videoSubscribeStateChanged:
          (channel, uid, oldState, newState, elapseSinceLastState) {},
      rtmpStreamingEvent: (url, eventCode) {},
      userSuperResolutionEnabled: (uid, enabled, reason) {},
      uploadLogResult: (requestId, success, reason) {},
      airPlayIsConnected: () {},
      virtualBackgroundSourceEnabled: (enabled, reason) {},
      videoDeviceStateChanged: (deviceId, deviceType, deviceState) {},
      audioDeviceVolumeChanged: (deviceType, volume, muted) {},
      audioDeviceStateChanged: (deviceId, deviceType, deviceState) {},
      remoteAudioMixingBegin: () {},
      remoteAudioMixingEnd: () {},
    ));

    fakeIrisEngine.fireAllEngineEvents();

    rtcEngine.destroy();
  });
}
