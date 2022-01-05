import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void rtcEngineEventHandlerSomkeTestCases() {
  testWidgets('onWarning', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      warning: (warn) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onWarning');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onError', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      error: (err) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onError');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onApiCallExecuted', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      apiCallExecuted: (error, api, result) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onApiCallExecuted');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onJoinChannelSuccess', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (channel, uid, elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onJoinChannelSuccess');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRejoinChannelSuccess', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      rejoinChannelSuccess: (channel, uid, elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRejoinChannelSuccess');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onLeaveChannel', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      leaveChannel: (stats) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onLeaveChannel');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onLocalUserRegistered', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localUserRegistered: (uid, userAccount) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onLocalUserRegistered');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onUserInfoUpdated', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userInfoUpdated: (uid, userInfo) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onUserInfoUpdated');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onClientRoleChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      clientRoleChanged: (oldRole, newRole) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onClientRoleChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onUserJoined', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userJoined: (uid, elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onUserJoined');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onUserOffline', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userOffline: (uid, reason) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onUserOffline');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onConnectionStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      connectionStateChanged: (state, reason) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onConnectionStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onNetworkTypeChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      networkTypeChanged: (type) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onNetworkTypeChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onConnectionLost', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      connectionLost: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onConnectionLost');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onTokenPrivilegeWillExpire', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      tokenPrivilegeWillExpire: (token) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onTokenPrivilegeWillExpire');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRequestToken', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      requestToken: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRequestToken');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAudioVolumeIndication', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioVolumeIndication: (speakers, totalVolume) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAudioVolumeIndication');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onActiveSpeaker', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      activeSpeaker: (uid) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onActiveSpeaker');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onFirstLocalAudioFrame', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstLocalAudioFrame: (elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onFirstLocalAudioFrame');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onFirstLocalVideoFrame', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstLocalVideoFrame: (width, height, elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onFirstLocalVideoFrame');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onUserMuteVideo', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userMuteVideo: (uid, muted) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onUserMuteVideo');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onVideoSizeChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      videoSizeChanged: (uid, width, height, rotation) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onVideoSizeChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRemoteVideoStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteVideoStateChanged: (uid, state, reason, elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRemoteVideoStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onLocalVideoStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localVideoStateChanged: (localVideoState, error) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onLocalVideoStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRemoteAudioStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteAudioStateChanged: (uid, state, reason, elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRemoteAudioStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onLocalAudioStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localAudioStateChanged: (state, error) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onLocalAudioStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRequestAudioFileInfoCallback', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      requestAudioFileInfoCallback: (info, error) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRequestAudioFileInfoCallback');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onLocalPublishFallbackToAudioOnly', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localPublishFallbackToAudioOnly: (isFallbackOrRecover) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onLocalPublishFallbackToAudioOnly');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRemoteSubscribeFallbackToAudioOnly',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteSubscribeFallbackToAudioOnly: (uid, isFallbackOrRecover) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRemoteSubscribeFallbackToAudioOnly');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAudioRouteChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioRouteChanged: (routing) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAudioRouteChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onCameraFocusAreaChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      cameraFocusAreaChanged: (rect) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onCameraFocusAreaChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onCameraExposureAreaChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      cameraExposureAreaChanged: (rect) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onCameraExposureAreaChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onFacePositionChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      facePositionChanged: (imageWidth, imageHeight, faces) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onFacePositionChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRtcStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      rtcStats: (stats) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRtcStats');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onLastmileQuality', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      lastmileQuality: (quality) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onLastmileQuality');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onNetworkQuality', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      networkQuality: (uid, txQuality, rxQuality) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onNetworkQuality');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onLastmileProbeResult', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      lastmileProbeResult: (result) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onLastmileProbeResult');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onLocalVideoStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localVideoStats: (stats) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onLocalVideoStats');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onLocalAudioStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localAudioStats: (stats) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onLocalAudioStats');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRemoteVideoStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteVideoStats: (stats) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRemoteVideoStats');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRemoteAudioStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteAudioStats: (stats) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRemoteAudioStats');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAudioMixingFinished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioMixingFinished: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAudioMixingFinished');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAudioMixingStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioMixingStateChanged: (state, reason) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAudioMixingStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAudioEffectFinished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioEffectFinished: (soundId) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAudioEffectFinished');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRtmpStreamingStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      rtmpStreamingStateChanged: (url, state, errCode) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRtmpStreamingStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onTranscodingUpdated', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      transcodingUpdated: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onTranscodingUpdated');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onStreamInjectedStatus', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      streamInjectedStatus: (url, uid, status) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onStreamInjectedStatus');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onStreamMessage', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      streamMessage: (uid, streamId, data) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onStreamMessage');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onStreamMessageError', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      streamMessageError: (uid, streamId, error, missed, cached) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onStreamMessageError');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onMediaEngineLoadSuccess', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      mediaEngineLoadSuccess: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onMediaEngineLoadSuccess');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onMediaEngineStartCallSuccess', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      mediaEngineStartCallSuccess: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onMediaEngineStartCallSuccess');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onChannelMediaRelayStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      channelMediaRelayStateChanged: (state, code) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onChannelMediaRelayStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onChannelMediaRelayEvent', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      channelMediaRelayEvent: (code) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onChannelMediaRelayEvent');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onFirstRemoteVideoFrame', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstRemoteVideoFrame: (uid, width, height, elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onFirstRemoteVideoFrame');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onFirstRemoteAudioFrame', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstRemoteAudioFrame: (uid, elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onFirstRemoteAudioFrame');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onFirstRemoteAudioDecoded', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstRemoteAudioDecoded: (uid, elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onFirstRemoteAudioDecoded');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onUserMuteAudio', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userMuteAudio: (uid, muted) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onUserMuteAudio');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onStreamPublished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      streamPublished: (url, error) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onStreamPublished');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onStreamUnpublished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      streamUnpublished: (url) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onStreamUnpublished');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRemoteAudioTransportStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteAudioTransportStats: (uid, delay, lost, rxKBitRate) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRemoteAudioTransportStats');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRemoteVideoTransportStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteVideoTransportStats: (uid, delay, lost, rxKBitRate) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRemoteVideoTransportStats');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onUserEnableVideo', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userEnableVideo: (uid, enabled) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onUserEnableVideo');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onUserEnableLocalVideo', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userEnableLocalVideo: (uid, enabled) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onUserEnableLocalVideo');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onFirstRemoteVideoDecoded', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstRemoteVideoDecoded: (uid, width, height, elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onFirstRemoteVideoDecoded');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onMicrophoneEnabled', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      microphoneEnabled: (enabled) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onMicrophoneEnabled');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onConnectionInterrupted', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      connectionInterrupted: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onConnectionInterrupted');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onConnectionBanned', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      connectionBanned: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onConnectionBanned');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAudioQuality', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioQuality: (uid, quality, delay, lost) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAudioQuality');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onCameraReady', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      cameraReady: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onCameraReady');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onVideoStopped', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      videoStopped: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onVideoStopped');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onMetadataReceived', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      metadataReceived: (metadata) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onMetadataReceived');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onFirstLocalAudioFramePublished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstLocalAudioFramePublished: (elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onFirstLocalAudioFramePublished');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onFirstLocalVideoFramePublished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstLocalVideoFramePublished: (elapsed) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onFirstLocalVideoFramePublished');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAudioPublishStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioPublishStateChanged:
          (channel, oldState, newState, elapseSinceLastState) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAudioPublishStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onVideoPublishStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      videoPublishStateChanged:
          (channel, oldState, newState, elapseSinceLastState) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onVideoPublishStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAudioSubscribeStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioSubscribeStateChanged:
          (channel, uid, oldState, newState, elapseSinceLastState) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAudioSubscribeStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onVideoSubscribeStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      videoSubscribeStateChanged:
          (channel, uid, oldState, newState, elapseSinceLastState) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onVideoSubscribeStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRtmpStreamingEvent', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      rtmpStreamingEvent: (url, eventCode) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRtmpStreamingEvent');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onUserSuperResolutionEnabled', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userSuperResolutionEnabled: (uid, enabled, reason) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onUserSuperResolutionEnabled');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onUploadLogResult', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      uploadLogResult: (requestId, success, reason) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onUploadLogResult');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAirPlayIsConnected', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      airPlayIsConnected: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAirPlayIsConnected');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onVirtualBackgroundSourceEnabled', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      virtualBackgroundSourceEnabled: (enabled, reason) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onVirtualBackgroundSourceEnabled');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onVideoDeviceStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      videoDeviceStateChanged: (deviceId, deviceType, deviceState) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onVideoDeviceStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAudioDeviceVolumeChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioDeviceVolumeChanged: (deviceType, volume, muted) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAudioDeviceVolumeChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onAudioDeviceStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioDeviceStateChanged: (deviceId, deviceType, deviceState) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onAudioDeviceStateChanged');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRemoteAudioMixingBegin', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteAudioMixingBegin: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRemoteAudioMixingBegin');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onRemoteAudioMixingEnd', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteAudioMixingEnd: () {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onRemoteAudioMixingEnd');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });

  testWidgets('onSnapshotTaken', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
    final rtcEngine = await RtcEngine.create('123');
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      snapshotTaken: (channel, uid, filePath, width, height, errCode) {},
    ));

    fakeIrisEngine.fireRtcEngineEvent('onSnapshotTaken');

    // Wait for the `EventChannel` event be sent from Android/iOS side
    await tester.pump(const Duration(milliseconds: 500));

    rtcEngine.destroy();
    fakeIrisEngine.dispose();
  });
}
