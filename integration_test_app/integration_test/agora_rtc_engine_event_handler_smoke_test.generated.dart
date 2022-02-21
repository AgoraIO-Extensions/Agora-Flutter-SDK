import 'dart:io';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test_app/main.dart' as app;
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';

void rtcEngineEventHandlerSomkeTestCases() {
  testWidgets(
    'onWarning',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool warningCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        warning: (warn) {
          warningCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onWarning');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(warningCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onError',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool errorCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        error: (err) {
          errorCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onError');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(errorCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onApiCallExecuted',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool apiCallExecutedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        apiCallExecuted: (error, api, result) {
          apiCallExecutedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onApiCallExecuted');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(apiCallExecutedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onJoinChannelSuccess',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool joinChannelSuccessCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (channel, uid, elapsed) {
          joinChannelSuccessCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onJoinChannelSuccess');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(joinChannelSuccessCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRejoinChannelSuccess',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool rejoinChannelSuccessCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        rejoinChannelSuccess: (channel, uid, elapsed) {
          rejoinChannelSuccessCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRejoinChannelSuccess');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(rejoinChannelSuccessCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onLeaveChannel',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool leaveChannelCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        leaveChannel: (stats) {
          leaveChannelCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onLeaveChannel');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(leaveChannelCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onLocalUserRegistered',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool localUserRegisteredCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        localUserRegistered: (uid, userAccount) {
          localUserRegisteredCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onLocalUserRegistered');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(localUserRegisteredCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onUserInfoUpdated',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool userInfoUpdatedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        userInfoUpdated: (uid, userInfo) {
          userInfoUpdatedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onUserInfoUpdated');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(userInfoUpdatedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onClientRoleChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool clientRoleChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        clientRoleChanged: (oldRole, newRole) {
          clientRoleChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onClientRoleChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(clientRoleChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onUserJoined',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool userJoinedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        userJoined: (uid, elapsed) {
          userJoinedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onUserJoined');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(userJoinedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onUserOffline',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool userOfflineCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        userOffline: (uid, reason) {
          userOfflineCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onUserOffline');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(userOfflineCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onConnectionStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool connectionStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        connectionStateChanged: (state, reason) {
          connectionStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onConnectionStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(connectionStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onNetworkTypeChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool networkTypeChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        networkTypeChanged: (type) {
          networkTypeChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onNetworkTypeChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(networkTypeChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onConnectionLost',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool connectionLostCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        connectionLost: () {
          connectionLostCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onConnectionLost');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(connectionLostCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onTokenPrivilegeWillExpire',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool tokenPrivilegeWillExpireCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        tokenPrivilegeWillExpire: (token) {
          tokenPrivilegeWillExpireCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onTokenPrivilegeWillExpire');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(tokenPrivilegeWillExpireCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRequestToken',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool requestTokenCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        requestToken: () {
          requestTokenCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRequestToken');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(requestTokenCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAudioVolumeIndication',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool audioVolumeIndicationCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        audioVolumeIndication: (speakers, totalVolume) {
          audioVolumeIndicationCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAudioVolumeIndication');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(audioVolumeIndicationCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onActiveSpeaker',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool activeSpeakerCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        activeSpeaker: (uid) {
          activeSpeakerCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onActiveSpeaker');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(activeSpeakerCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onFirstLocalAudioFrame',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool firstLocalAudioFrameCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        firstLocalAudioFrame: (elapsed) {
          firstLocalAudioFrameCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onFirstLocalAudioFrame');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(firstLocalAudioFrameCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onFirstLocalVideoFrame',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool firstLocalVideoFrameCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        firstLocalVideoFrame: (width, height, elapsed) {
          firstLocalVideoFrameCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onFirstLocalVideoFrame');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(firstLocalVideoFrameCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onUserMuteVideo',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool userMuteVideoCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        userMuteVideo: (uid, muted) {
          userMuteVideoCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onUserMuteVideo');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(userMuteVideoCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onVideoSizeChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool videoSizeChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        videoSizeChanged: (uid, width, height, rotation) {
          videoSizeChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onVideoSizeChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(videoSizeChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRemoteVideoStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool remoteVideoStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        remoteVideoStateChanged: (uid, state, reason, elapsed) {
          remoteVideoStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRemoteVideoStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(remoteVideoStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onLocalVideoStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool localVideoStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        localVideoStateChanged: (localVideoState, error) {
          localVideoStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onLocalVideoStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(localVideoStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRemoteAudioStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool remoteAudioStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        remoteAudioStateChanged: (uid, state, reason, elapsed) {
          remoteAudioStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRemoteAudioStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(remoteAudioStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onLocalAudioStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool localAudioStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        localAudioStateChanged: (state, error) {
          localAudioStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onLocalAudioStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(localAudioStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRequestAudioFileInfo',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool requestAudioFileInfoCallbackCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        requestAudioFileInfoCallback: (info, error) {
          requestAudioFileInfoCallbackCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRequestAudioFileInfo');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(requestAudioFileInfoCallbackCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRequestAudioFileInfo',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool requestAudioFileInfoCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        requestAudioFileInfo: (info, error) {
          requestAudioFileInfoCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRequestAudioFileInfo');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(requestAudioFileInfoCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onLocalPublishFallbackToAudioOnly',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool localPublishFallbackToAudioOnlyCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        localPublishFallbackToAudioOnly: (isFallbackOrRecover) {
          localPublishFallbackToAudioOnlyCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onLocalPublishFallbackToAudioOnly');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(localPublishFallbackToAudioOnlyCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRemoteSubscribeFallbackToAudioOnly',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool remoteSubscribeFallbackToAudioOnlyCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        remoteSubscribeFallbackToAudioOnly: (uid, isFallbackOrRecover) {
          remoteSubscribeFallbackToAudioOnlyCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRemoteSubscribeFallbackToAudioOnly');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(remoteSubscribeFallbackToAudioOnlyCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAudioRouteChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool audioRouteChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        audioRouteChanged: (routing) {
          audioRouteChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAudioRouteChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(audioRouteChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onCameraFocusAreaChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool cameraFocusAreaChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        cameraFocusAreaChanged: (rect) {
          cameraFocusAreaChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onCameraFocusAreaChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(cameraFocusAreaChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onCameraExposureAreaChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool cameraExposureAreaChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        cameraExposureAreaChanged: (rect) {
          cameraExposureAreaChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onCameraExposureAreaChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(cameraExposureAreaChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onFacePositionChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool facePositionChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        facePositionChanged: (imageWidth, imageHeight, faces) {
          facePositionChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onFacePositionChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(facePositionChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );

  testWidgets(
    'onRtcStats',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool rtcStatsCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        rtcStats: (stats) {
          rtcStatsCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRtcStats');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(rtcStatsCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onLastmileQuality',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool lastmileQualityCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        lastmileQuality: (quality) {
          lastmileQualityCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onLastmileQuality');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(lastmileQualityCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onNetworkQuality',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool networkQualityCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        networkQuality: (uid, txQuality, rxQuality) {
          networkQualityCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onNetworkQuality');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(networkQualityCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onLastmileProbeResult',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool lastmileProbeResultCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        lastmileProbeResult: (result) {
          lastmileProbeResultCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onLastmileProbeResult');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(lastmileProbeResultCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onLocalVideoStats',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool localVideoStatsCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        localVideoStats: (stats) {
          localVideoStatsCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onLocalVideoStats');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(localVideoStatsCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onLocalAudioStats',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool localAudioStatsCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        localAudioStats: (stats) {
          localAudioStatsCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onLocalAudioStats');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(localAudioStatsCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRemoteVideoStats',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool remoteVideoStatsCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        remoteVideoStats: (stats) {
          remoteVideoStatsCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRemoteVideoStats');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(remoteVideoStatsCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRemoteAudioStats',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool remoteAudioStatsCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        remoteAudioStats: (stats) {
          remoteAudioStatsCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRemoteAudioStats');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(remoteAudioStatsCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAudioMixingFinished',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool audioMixingFinishedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        audioMixingFinished: () {
          audioMixingFinishedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAudioMixingFinished');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(audioMixingFinishedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAudioMixingStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool audioMixingStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        audioMixingStateChanged: (state, reason) {
          audioMixingStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAudioMixingStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(audioMixingStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAudioEffectFinished',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool audioEffectFinishedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        audioEffectFinished: (soundId) {
          audioEffectFinishedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAudioEffectFinished');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(audioEffectFinishedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRtmpStreamingStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool rtmpStreamingStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        rtmpStreamingStateChanged: (url, state, errCode) {
          rtmpStreamingStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRtmpStreamingStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(rtmpStreamingStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onTranscodingUpdated',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool transcodingUpdatedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        transcodingUpdated: () {
          transcodingUpdatedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onTranscodingUpdated');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(transcodingUpdatedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onStreamInjectedStatus',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool streamInjectedStatusCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        streamInjectedStatus: (url, uid, status) {
          streamInjectedStatusCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onStreamInjectedStatus');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(streamInjectedStatusCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onStreamMessage',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool streamMessageCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        streamMessage: (uid, streamId, data) {
          streamMessageCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onStreamMessage');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(streamMessageCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onStreamMessageError',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool streamMessageErrorCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        streamMessageError: (uid, streamId, error, missed, cached) {
          streamMessageErrorCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onStreamMessageError');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(streamMessageErrorCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onMediaEngineLoadSuccess',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool mediaEngineLoadSuccessCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        mediaEngineLoadSuccess: () {
          mediaEngineLoadSuccessCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onMediaEngineLoadSuccess');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(mediaEngineLoadSuccessCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onMediaEngineStartCallSuccess',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool mediaEngineStartCallSuccessCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        mediaEngineStartCallSuccess: () {
          mediaEngineStartCallSuccessCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onMediaEngineStartCallSuccess');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(mediaEngineStartCallSuccessCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onChannelMediaRelayStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool channelMediaRelayStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        channelMediaRelayStateChanged: (state, code) {
          channelMediaRelayStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onChannelMediaRelayStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(channelMediaRelayStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onChannelMediaRelayEvent',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool channelMediaRelayEventCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        channelMediaRelayEvent: (code) {
          channelMediaRelayEventCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onChannelMediaRelayEvent');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(channelMediaRelayEventCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onFirstRemoteVideoFrame',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool firstRemoteVideoFrameCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        firstRemoteVideoFrame: (uid, width, height, elapsed) {
          firstRemoteVideoFrameCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onFirstRemoteVideoFrame');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(firstRemoteVideoFrameCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onFirstRemoteAudioFrame',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool firstRemoteAudioFrameCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        firstRemoteAudioFrame: (uid, elapsed) {
          firstRemoteAudioFrameCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onFirstRemoteAudioFrame');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(firstRemoteAudioFrameCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onFirstRemoteAudioDecoded',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool firstRemoteAudioDecodedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        firstRemoteAudioDecoded: (uid, elapsed) {
          firstRemoteAudioDecodedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onFirstRemoteAudioDecoded');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(firstRemoteAudioDecodedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onUserMuteAudio',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool userMuteAudioCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        userMuteAudio: (uid, muted) {
          userMuteAudioCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onUserMuteAudio');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(userMuteAudioCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onStreamPublished',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool streamPublishedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        streamPublished: (url, error) {
          streamPublishedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onStreamPublished');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(streamPublishedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onStreamUnpublished',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool streamUnpublishedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        streamUnpublished: (url) {
          streamUnpublishedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onStreamUnpublished');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(streamUnpublishedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRemoteAudioTransportStats',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool remoteAudioTransportStatsCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        remoteAudioTransportStats: (uid, delay, lost, rxKBitRate) {
          remoteAudioTransportStatsCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRemoteAudioTransportStats');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(remoteAudioTransportStatsCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRemoteVideoTransportStats',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool remoteVideoTransportStatsCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        remoteVideoTransportStats: (uid, delay, lost, rxKBitRate) {
          remoteVideoTransportStatsCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRemoteVideoTransportStats');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(remoteVideoTransportStatsCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onUserEnableVideo',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool userEnableVideoCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        userEnableVideo: (uid, enabled) {
          userEnableVideoCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onUserEnableVideo');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(userEnableVideoCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onUserEnableLocalVideo',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool userEnableLocalVideoCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        userEnableLocalVideo: (uid, enabled) {
          userEnableLocalVideoCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onUserEnableLocalVideo');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(userEnableLocalVideoCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onFirstRemoteVideoDecoded',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool firstRemoteVideoDecodedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        firstRemoteVideoDecoded: (uid, width, height, elapsed) {
          firstRemoteVideoDecodedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onFirstRemoteVideoDecoded');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(firstRemoteVideoDecodedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onMicrophoneEnabled',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool microphoneEnabledCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        microphoneEnabled: (enabled) {
          microphoneEnabledCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onMicrophoneEnabled');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(microphoneEnabledCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onConnectionInterrupted',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool connectionInterruptedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        connectionInterrupted: () {
          connectionInterruptedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onConnectionInterrupted');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(connectionInterruptedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onConnectionBanned',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool connectionBannedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        connectionBanned: () {
          connectionBannedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onConnectionBanned');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(connectionBannedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAudioQuality',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool audioQualityCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        audioQuality: (uid, quality, delay, lost) {
          audioQualityCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAudioQuality');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(audioQualityCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onCameraReady',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool cameraReadyCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        cameraReady: () {
          cameraReadyCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onCameraReady');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(cameraReadyCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onVideoStopped',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool videoStoppedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        videoStopped: () {
          videoStoppedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onVideoStopped');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(videoStoppedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onFirstLocalAudioFramePublished',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool firstLocalAudioFramePublishedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        firstLocalAudioFramePublished: (elapsed) {
          firstLocalAudioFramePublishedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onFirstLocalAudioFramePublished');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(firstLocalAudioFramePublishedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onFirstLocalVideoFramePublished',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool firstLocalVideoFramePublishedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        firstLocalVideoFramePublished: (elapsed) {
          firstLocalVideoFramePublishedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onFirstLocalVideoFramePublished');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(firstLocalVideoFramePublishedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAudioPublishStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool audioPublishStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        audioPublishStateChanged:
            (channel, oldState, newState, elapseSinceLastState) {
          audioPublishStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAudioPublishStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(audioPublishStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onVideoPublishStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool videoPublishStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        videoPublishStateChanged:
            (channel, oldState, newState, elapseSinceLastState) {
          videoPublishStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onVideoPublishStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(videoPublishStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAudioSubscribeStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool audioSubscribeStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        audioSubscribeStateChanged:
            (channel, uid, oldState, newState, elapseSinceLastState) {
          audioSubscribeStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAudioSubscribeStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(audioSubscribeStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onVideoSubscribeStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool videoSubscribeStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        videoSubscribeStateChanged:
            (channel, uid, oldState, newState, elapseSinceLastState) {
          videoSubscribeStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onVideoSubscribeStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(videoSubscribeStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRtmpStreamingEvent',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool rtmpStreamingEventCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        rtmpStreamingEvent: (url, eventCode) {
          rtmpStreamingEventCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRtmpStreamingEvent');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(rtmpStreamingEventCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onUserSuperResolutionEnabled',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool userSuperResolutionEnabledCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        userSuperResolutionEnabled: (uid, enabled, reason) {
          userSuperResolutionEnabledCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onUserSuperResolutionEnabled');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(userSuperResolutionEnabledCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onUploadLogResult',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool uploadLogResultCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        uploadLogResult: (requestId, success, reason) {
          uploadLogResultCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onUploadLogResult');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(uploadLogResultCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAirPlayConnected',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool airPlayIsConnectedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        airPlayIsConnected: () {
          airPlayIsConnectedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAirPlayConnected');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(airPlayIsConnectedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAirPlayConnected',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool airPlayConnectedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        airPlayConnected: () {
          airPlayConnectedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAirPlayConnected');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(airPlayConnectedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onVirtualBackgroundSourceEnabled',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool virtualBackgroundSourceEnabledCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        virtualBackgroundSourceEnabled: (enabled, reason) {
          virtualBackgroundSourceEnabledCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onVirtualBackgroundSourceEnabled');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(virtualBackgroundSourceEnabledCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onVideoDeviceStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool videoDeviceStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        videoDeviceStateChanged: (deviceId, deviceType, deviceState) {
          videoDeviceStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onVideoDeviceStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(videoDeviceStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAudioDeviceVolumeChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool audioDeviceVolumeChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        audioDeviceVolumeChanged: (deviceType, volume, muted) {
          audioDeviceVolumeChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAudioDeviceVolumeChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(audioDeviceVolumeChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onAudioDeviceStateChanged',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool audioDeviceStateChangedCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        audioDeviceStateChanged: (deviceId, deviceType, deviceState) {
          audioDeviceStateChangedCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onAudioDeviceStateChanged');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(audioDeviceStateChangedCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRemoteAudioMixingBegin',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool remoteAudioMixingBeginCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        remoteAudioMixingBegin: () {
          remoteAudioMixingBeginCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRemoteAudioMixingBegin');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(remoteAudioMixingBeginCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onRemoteAudioMixingEnd',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool remoteAudioMixingEndCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        remoteAudioMixingEnd: () {
          remoteAudioMixingEndCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onRemoteAudioMixingEnd');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(remoteAudioMixingEndCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );

  testWidgets(
    'onSnapshotTaken',
    (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      FakeIrisRtcEngine fakeIrisEngine = FakeIrisRtcEngine();
      await fakeIrisEngine.initialize();
      final rtcEngine = await RtcEngine.create('123');
      bool snapshotTakenCalled = false;
      rtcEngine.setEventHandler(RtcEngineEventHandler(
        snapshotTaken: (channel, uid, filePath, width, height, errCode) {
          snapshotTakenCalled = true;
        },
      ));

      fakeIrisEngine.fireRtcEngineEvent('onSnapshotTaken');
// Wait for the `EventChannel` event be sent from Android/iOS side
      await tester.pump(const Duration(milliseconds: 500));
      expect(snapshotTakenCalled, isTrue);

      rtcEngine.destroy();
      fakeIrisEngine.dispose();
    },
  );
}
