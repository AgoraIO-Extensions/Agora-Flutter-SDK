import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/src/event_handler_tester.dart';
import 'package:integration_test_app/src/fake_iris_rtc_engine.dart';
import 'package:integration_test_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late RtcEngine rtcEngine;
  late FakeIrisRtcEngine fakeIrisEngine;

  setUpAll(() async {
    fakeIrisEngine = FakeIrisRtcEngine();
    await fakeIrisEngine.initialize();
  });

  tearDown(() async {
    await rtcEngine.destroy();
  });

  tearDownAll(() {
    fakeIrisEngine.dispose();
  });

  Future<RtcEngine> _createRtcEngine() {
    return RtcEngine.create('123');
  }

  testWidgets('warning', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    WarningCode? code;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      warning: (WarningCode warn) {
        code = warn;
      },
    ));

    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onWarning', '{"warn":16,"msg":"warning"}');
    expect(code == WarningCode.InitVideo, isTrue);
  });

  testWidgets('error', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    ErrorCode? errorCode;
    rtcEngine.setEventHandler(RtcEngineEventHandler(error: (ErrorCode err) {
      errorCode = err;
    }));

    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onError', '{"err":11,"msg":"error"}');
    expect(errorCode == ErrorCode.Canceled, isTrue);
  });

  testWidgets('joinChannelSuccess', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String channelRet = '';
    int uidRet = 0;
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        channelRet = channel;
        uidRet = uid;
        elapsedRet = elapsed;
      },
    ));

    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onJoinChannelSuccess',
      '{"channel":"testapi","uid":10, "elapsed":100}',
    );
    expect(channelRet, 'testapi');
    expect(uidRet, 10);
    expect(elapsedRet, 100);
  });

  testWidgets('apiCallExecuted', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    ErrorCode? errorRet;
    String apiRet = '';
    String resultRet = '';
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      apiCallExecuted: (ErrorCode error, String api, String result) {
        errorRet = error;
        apiRet = api;
        resultRet = result;
      },
    ));

    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onApiCallExecuted',
      '{"err":1,"api":"joinChannel", "result":"failed"}',
    );
    expect(errorRet, ErrorCode.Failed);
    expect(apiRet, 'joinChannel');
    expect(resultRet, 'failed');
  });

  testWidgets('rejoinChannelSuccess', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String channelRet = '';
    int uidRet = 0;
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      rejoinChannelSuccess: (String channel, int uid, int elapsed) {
        channelRet = channel;
        uidRet = uid;
        elapsedRet = elapsed;
      },
    ));

    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onRejoinChannelSuccess',
      '{"channel":"testapi","uid":10, "elapsed":100}',
    );
    expect(channelRet, 'testapi');
    expect(uidRet, 10);
    expect(elapsedRet, 100);
  });

  testWidgets('leaveChannel', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    RtcStats? statsRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      leaveChannel: (RtcStats stats) {
        statsRet = stats;
      },
    ));

    final expectedStats = RtcStats(10, 20, 20, 100, 100, 200, 200, 10, 10, 20,
        20, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);

    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onLeaveChannel',
      '{"stats":${jsonEncode(expectedStats.toJson())}}',
    );
    expect(jsonEncode(statsRet), jsonEncode(expectedStats));
  });

  testWidgets('localUserRegistered', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    String userAccountRet = '';
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localUserRegistered: (int uid, String userAccount) {
        uidRet = uid;
        userAccountRet = userAccount;
      },
    ));

    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onLocalUserRegistered',
      '{"uid":10,"userAccount":"user1"}',
    );
    expect(uidRet, 10);
    expect(userAccountRet, 'user1');
  });

  testWidgets('userInfoUpdated', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    UserInfo? userInfoRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userInfoUpdated: (int uid, UserInfo userInfo) {
        uidRet = uid;
        userInfoRet = userInfo;
      },
    ));
    final expectedUserInfo = UserInfo(10, 'user1');
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onUserInfoUpdated',
      '{"uid":10,"info":${jsonEncode(expectedUserInfo.toJson())}}',
    );
    expect(uidRet, 10);
    expect(jsonEncode(userInfoRet), jsonEncode(expectedUserInfo));
  });

  testWidgets('clientRoleChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    ClientRole? oldRoleRet;
    ClientRole? newRoleRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      clientRoleChanged: (ClientRole oldRole, ClientRole newRole) {
        oldRoleRet = oldRole;
        newRoleRet = newRole;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onClientRoleChanged',
      '{"oldRole":1,"newRole":2}',
    );
    expect(oldRoleRet, ClientRole.Broadcaster);
    expect(newRoleRet, ClientRole.Audience);
  });

  testWidgets('userJoined', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userJoined: (int uid, int elapsed) {
        uidRet = uid;
        elapsedRet = elapsed;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onUserJoined',
      '{"uid":10,"elapsed":100}',
    );
    expect(uidRet, 10);
    expect(elapsedRet, 100);
  });

  testWidgets('userOffline', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    UserOfflineReason? reasonRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userOffline: (int uid, UserOfflineReason reason) {
        uidRet = uid;
        reasonRet = reason;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onUserOffline',
      '{"uid":10,"reason":2}',
    );
    expect(uidRet, 10);
    expect(reasonRet, UserOfflineReason.BecomeAudience);
  });

  testWidgets('connectionStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    ConnectionStateType? stateRet;
    ConnectionChangedReason? reasonRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      connectionStateChanged:
          (ConnectionStateType state, ConnectionChangedReason reason) {
        stateRet = state;
        reasonRet = reason;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onConnectionStateChanged',
      '{"state":3,"reason":1}',
    );
    expect(stateRet, ConnectionStateType.Connected);
    expect(reasonRet, ConnectionChangedReason.JoinSuccess);
  });

  testWidgets('networkTypeChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    NetworkType? typeRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      networkTypeChanged: (NetworkType type) {
        typeRet = type;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onNetworkTypeChanged', '{"type":2}');
    expect(typeRet, NetworkType.WIFI);
  });

  testWidgets('connectionLost', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    bool called = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      connectionLost: () {
        called = true;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(tester, 'onConnectionLost', '{}');
    expect(called, isTrue);
  });

  testWidgets('tokenPrivilegeWillExpire', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String tokenRet = '';
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      tokenPrivilegeWillExpire: (String token) {
        tokenRet = token;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onTokenPrivilegeWillExpire', '{"token":"t"}');
    expect(tokenRet, 't');
  });

  testWidgets('requestToken', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    bool called = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      requestToken: () {
        called = true;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(tester, 'onRequestToken', '{}');
    expect(called, isTrue);
  });

  testWidgets('audioVolumeIndication', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    List<AudioVolumeInfo> speakersRet = [];
    int totalVolumeRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioVolumeIndication: (
        List<AudioVolumeInfo> speakers,
        int totalVolume,
      ) {
        speakersRet = speakers;
        totalVolumeRet = totalVolume;
      },
    ));
    final expectedSpeakers = [AudioVolumeInfo(10, 100, 20, 'testapi')];
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onAudioVolumeIndication',
      '{"speakers":${jsonEncode(expectedSpeakers)},"speakerNumber":1,"totalVolume":10}',
    );
    expect(jsonEncode(speakersRet), jsonEncode(expectedSpeakers));
    expect(totalVolumeRet, 10);
  });

  testWidgets('activeSpeaker', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      activeSpeaker: (int uid) {
        uidRet = uid;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onActiveSpeaker',
      '{"uid":10}',
    );
    expect(uidRet, 10);
  });

  testWidgets('firstLocalAudioFrame', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstLocalAudioFrame: (int elapsed) {
        elapsedRet = elapsed;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onFirstLocalAudioFrame', '{"elapsed":100}');
    expect(elapsedRet, 100);
  });

  testWidgets('firstLocalVideoFrame', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int widthRet = 0;
    int heightRet = 0;
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstLocalVideoFrame: (int width, int height, int elapsed) {
        widthRet = width;
        heightRet = height;
        elapsedRet = elapsed;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onFirstLocalVideoFrame',
      '{"width":10,"height":10,"elapsed":100}',
    );
    expect(widthRet, 10);
    expect(heightRet, 10);
    expect(elapsedRet, 100);
  });

  testWidgets('videoSizeChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    int widthRet = 0;
    int heightRet = 0;
    int rotationRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      videoSizeChanged: (int uid, int width, int height, int rotation) {
        uidRet = uid;
        widthRet = width;
        heightRet = height;
        rotationRet = rotation;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onVideoSizeChanged',
      '{"uid":10,"width":20,"height":20,"rotation":30}',
    );
    expect(uidRet, 10);
    expect(widthRet, 20);
    expect(heightRet, 20);
    expect(rotationRet, 30);
  });

  testWidgets('remoteVideoStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    VideoRemoteState? stateRet;
    VideoRemoteStateReason? reasonRet;
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteVideoStateChanged: (int uid, VideoRemoteState state,
          VideoRemoteStateReason reason, int elapsed) {
        uidRet = uid;
        stateRet = state;
        reasonRet = reason;
        elapsedRet = elapsed;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onRemoteVideoStateChanged',
      '{"uid":10,"state":1,"reason":1,"elapsed":100}',
    );
    expect(uidRet, 10);
    expect(stateRet, VideoRemoteState.Starting);
    expect(reasonRet, VideoRemoteStateReason.NetworkCongestion);
    expect(elapsedRet, 100);
  });

  testWidgets('localVideoStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    LocalVideoStreamState? localVideoStateRet;
    LocalVideoStreamError? errorRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localVideoStateChanged:
          (LocalVideoStreamState localVideoState, LocalVideoStreamError error) {
        localVideoStateRet = localVideoState;
        errorRet = error;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onLocalVideoStateChanged',
      '{"localVideoState":1,"error":2}',
    );
    expect(localVideoStateRet, LocalVideoStreamState.Capturing);
    expect(errorRet, LocalVideoStreamError.DeviceNoPermission);
  });

  testWidgets('remoteAudioStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    AudioRemoteState? stateRet;
    AudioRemoteStateReason? reasonRet;
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteAudioStateChanged: (int uid, AudioRemoteState state,
          AudioRemoteStateReason reason, int elapsed) {
        uidRet = uid;
        stateRet = state;
        reasonRet = reason;
        elapsedRet = elapsed;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onRemoteAudioStateChanged',
      '{"uid":10,"state":1,"reason":2,"elapsed":100}',
    );

    expect(uidRet, 10);
    expect(stateRet, AudioRemoteState.Starting);
    expect(reasonRet, AudioRemoteStateReason.NetworkRecovery);
    expect(elapsedRet, 100);
  });

  testWidgets('localAudioStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    AudioLocalState? stateRet;
    AudioLocalError? errorRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localAudioStateChanged: (AudioLocalState state, AudioLocalError error) {
        stateRet = state;
        errorRet = error;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onLocalAudioStateChanged',
      '{"state":2,"error":8}',
    );

    expect(stateRet, AudioLocalState.Encoding);
    expect(errorRet, AudioLocalError.Interrupted);
  });

  testWidgets('onLocalPublishFallbackToAudioOnly', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    bool isFallbackOrRecoverRet = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localPublishFallbackToAudioOnly: (bool isFallbackOrRecover) {
        isFallbackOrRecoverRet = isFallbackOrRecover;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onLocalPublishFallbackToAudioOnly',
      '{"isFallbackOrRecover":true}',
    );

    expect(isFallbackOrRecoverRet, isTrue);
  });

  testWidgets('remoteSubscribeFallbackToAudioOnly',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    bool isFallbackOrRecoverRet = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteSubscribeFallbackToAudioOnly: (int uid, bool isFallbackOrRecover) {
        uidRet = uid;
        isFallbackOrRecoverRet = isFallbackOrRecover;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onRemoteSubscribeFallbackToAudioOnly',
      '{"uid":10,"isFallbackOrRecover":true}',
    );
    expect(uidRet, 10);
    expect(isFallbackOrRecoverRet, true);
  });

  testWidgets('audioRouteChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    AudioOutputRouting? routingRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioRouteChanged: (AudioOutputRouting routing) {
        routingRet = routing;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onAudioRouteChanged',
      '{"routing":7}',
    );
    expect(routingRet, AudioOutputRouting.HDMI);
  });

  testWidgets('cameraFocusAreaChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    Rect? rectRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      cameraFocusAreaChanged: (Rect rect) {
        rectRet = rect;
      },
    ));
    final expectedRect = Rect(
      x: 10,
      y: 10,
      width: 10,
      height: 10,
      left: 10,
      top: 10,
      right: 20,
      bottom: 20,
    );
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onCameraFocusAreaChanged',
      '{"x":10,"y":10,"width":10,"height":10}',
    );
    expect(jsonEncode(rectRet), jsonEncode(expectedRect));
  });

  testWidgets('cameraExposureAreaChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    Rect? rectRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      cameraExposureAreaChanged: (Rect rect) {
        rectRet = rect;
      },
    ));
    final expectedRect = Rect(
      x: 10,
      y: 10,
      width: 10,
      height: 10,
      left: 10,
      top: 10,
      right: 20,
      bottom: 20,
    );
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onCameraExposureAreaChanged',
      '{"x":10,"y":10,"width":10,"height":10}',
    );
    expect(jsonEncode(rectRet), jsonEncode(expectedRect));
  });

  testWidgets('facePositionChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int imageWidthRet = 0;
    int imageHeightRet = 0;
    List<FacePositionInfo>? facesRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      facePositionChanged:
          (int imageWidth, int imageHeight, List<FacePositionInfo> faces) {
        imageWidthRet = imageWidth;
        imageHeightRet = imageHeight;
        facesRet = faces;
      },
    ));
    final expectedFaces = [FacePositionInfo(10, 10, 10, 10, 10)];
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onFacePositionChanged',
      '{"imageWidth":10,"imageHeight":10,"vecRectangle":[{"x":10,"y":10,"width":10,"height":10}],"vecDistance":[10]}',
    );
    expect(imageWidthRet, 10);
    expect(imageHeightRet, 10);
    expect(jsonEncode(facesRet), jsonEncode(expectedFaces));
  });

  testWidgets('rtcStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    RtcStats? statsRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      rtcStats: (RtcStats stats) {
        statsRet = stats;
      },
    ));
    final expectedStats = RtcStats(10, 20, 20, 100, 100, 200, 200, 10, 10, 20,
        20, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onRtcStats',
      '{"stats":${jsonEncode(expectedStats.toJson())}}',
    );
    expect(jsonEncode(statsRet), jsonEncode(expectedStats));
  });

  testWidgets('networkQuality', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    NetworkQuality? txQualityRet;
    NetworkQuality? rxQualityRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      networkQuality:
          (int uid, NetworkQuality txQuality, NetworkQuality rxQuality) {
        uidRet = uid;
        txQualityRet = txQuality;
        rxQualityRet = rxQuality;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onNetworkQuality',
      '{"uid":10,"txQuality":2,"rxQuality":4}',
    );
    expect(uidRet, 10);
    expect(txQualityRet, NetworkQuality.Good);
    expect(rxQualityRet, NetworkQuality.Bad);
  });

  testWidgets('lastmileProbeResult', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    LastmileProbeResult? resultRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      lastmileProbeResult: (LastmileProbeResult result) {
        resultRet = result;
      },
    ));
    final expectLastmileProbeResult = LastmileProbeResult(
      LastmileProbeResultState.Complete,
      10,
      LastmileProbeOneWayResult(1, 2, 3),
      LastmileProbeOneWayResult(1, 2, 3),
    );
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onLastmileProbeResult',
      '{"result":${jsonEncode(expectLastmileProbeResult.toJson())}}',
    );
    expect(jsonEncode(resultRet), jsonEncode(expectLastmileProbeResult));
  });

  testWidgets('localVideoStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    LocalVideoStats? statsRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localVideoStats: (LocalVideoStats stats) {
        statsRet = stats;
      },
    ));
    final expectLocalVideoStats = LocalVideoStats(
      10,
      10,
      10,
      10,
      10,
      10,
      VideoQualityAdaptIndication.AdaptDownBandwidth,
      10,
      10,
      10,
      10,
      VideoCodecType.E264,
      10,
      10,
      CaptureBrightnessLevelType.Bright,
    );
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onLocalVideoStats',
      '{"stats":${jsonEncode(expectLocalVideoStats.toJson())}}',
    );
    expect(jsonEncode(statsRet), jsonEncode(expectLocalVideoStats));
  });

  testWidgets('localAudioStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    LocalAudioStats? statsRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      localAudioStats: (LocalAudioStats stats) {
        statsRet = stats;
      },
    ));
    final expectLocalAudioStats = LocalAudioStats(10, 10, 10, 10);
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onLocalAudioStats',
      '{"stats":${jsonEncode(expectLocalAudioStats.toJson())}}',
    );
    expect(jsonEncode(statsRet), jsonEncode(expectLocalAudioStats));
  });

  testWidgets('remoteVideoStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    RemoteVideoStats? statsRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteVideoStats: (RemoteVideoStats stats) {
        statsRet = stats;
      },
    ));
    final expectRemoteVideoStats = RemoteVideoStats(
        10, 10, 10, 10, 10, 10, 10, 10, VideoStreamType.High, 10, 10, 10, 10);
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onRemoteVideoStats',
      '{"stats":${jsonEncode(expectRemoteVideoStats.toJson())}}',
    );
    expect(jsonEncode(statsRet), jsonEncode(expectRemoteVideoStats));
  });

  testWidgets('remoteAudioStats', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    RemoteAudioStats? statsRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteAudioStats: (RemoteAudioStats stats) {
        statsRet = stats;
      },
    ));
    final expectRemoteAudioStats = RemoteAudioStats(
      10,
      NetworkQuality.Down,
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
      ExperienceQualityType.Bad,
      ExperiencePoorReason.LocalNetworkQualityPoor,
      10,
    );
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onRemoteAudioStats',
      '{"stats":${jsonEncode(expectRemoteAudioStats.toJson())}}',
    );
    expect(jsonEncode(statsRet), jsonEncode(expectRemoteAudioStats));
  });

  testWidgets('audioMixingFinished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    bool called = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioMixingFinished: () {
        called = true;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onAudioMixingFinished', '{}');
    expect(called, true);
  });

  testWidgets('audioMixingStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    AudioMixingStateCode? stateRet;
    AudioMixingReason? reasonRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioMixingStateChanged:
          (AudioMixingStateCode state, AudioMixingReason reason) {
        stateRet = state;
        reasonRet = reason;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onAudioMixingStateChanged',
      '{"state":711,"reason":725}',
    );
    expect(stateRet, AudioMixingStateCode.Paused);
    expect(reasonRet, AudioMixingReason.PausedByUser);
  });

  testWidgets('audioEffectFinished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int soundIdRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioEffectFinished: (int soundId) {
        soundIdRet = soundId;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onAudioEffectFinished',
      '{"soundId":10}',
    );
    expect(soundIdRet, 10);
  });

  testWidgets('rtmpStreamingStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String urlRet = '';
    RtmpStreamingState? stateRet;
    RtmpStreamingErrorCode? errCodeRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      rtmpStreamingStateChanged: (String url, RtmpStreamingState state,
          RtmpStreamingErrorCode errCode) {
        urlRet = url;
        stateRet = state;
        errCodeRet = errCode;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onRtmpStreamingStateChanged',
      '{"url":"https://example.com","state":3,"errCode":2}',
    );
    expect(urlRet, 'https://example.com');
    expect(stateRet, RtmpStreamingState.Recovering);
    expect(errCodeRet, RtmpStreamingErrorCode.EncryptedStreamNotAllowed);
  });

  testWidgets('transcodingUpdated', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    bool called = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      transcodingUpdated: () {
        called = true;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(tester, 'onTranscodingUpdated', '{}');
    expect(called, isTrue);
  });

  testWidgets('streamInjectedStatus', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String urlRet = '';
    int uidRet = 0;
    InjectStreamStatus? statusRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      streamInjectedStatus: (String url, int uid, InjectStreamStatus status) {
        urlRet = url;
        uidRet = uid;
        statusRet = status;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onStreamInjectedStatus',
      '{"url":"https://example.com","uid":10,"status":0}',
    );
    expect(urlRet, 'https://example.com');
    expect(uidRet, 10);
    expect(statusRet, InjectStreamStatus.StartSuccess);
  });

  testWidgets('streamMessage', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    int streamIdRet = 0;
    Uint8List? dataRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      streamMessage: (int uid, int streamId, Uint8List data) {
        uidRet = uid;
        streamIdRet = streamId;
        dataRet = data;
      },
    ));
    final buffer = Uint8List.fromList([1, 1]);
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onStreamMessage',
      '{"uid":10,"uid":10,"streamId":20,"length":2}',
      buffer: buffer,
      bufferSize: 2,
    );
    expect(uidRet, 10);
    expect(streamIdRet, 20);
    expect(dataRet, buffer);
  });

  testWidgets('streamMessageError', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    int streamIdRet = 0;
    ErrorCode? errorRet;
    int missedRet = 0;
    int cachedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      streamMessageError:
          (int uid, int streamId, ErrorCode error, int missed, int cached) {
        uidRet = uid;
        streamIdRet = streamId;
        errorRet = error;
        missedRet = missed;
        cachedRet = cached;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onStreamMessageError',
      '{"uid":10,"streamId":20,"code":1022,"missed":2,"cached":3}',
    );
    expect(uidRet, 10);
    expect(streamIdRet, 20);
    expect(errorRet, ErrorCode.AdmInitLoopback);
    expect(missedRet, 2);
    expect(cachedRet, 3);
  });

  testWidgets('mediaEngineLoadSuccess', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    bool called = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      mediaEngineLoadSuccess: () {
        called = true;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onMediaEngineLoadSuccess', '{}');
    expect(called, isTrue);
  });

  testWidgets('mediaEngineStartCallSuccess', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    bool called = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      mediaEngineStartCallSuccess: () {
        called = true;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onMediaEngineStartCallSuccess', '{}');
    expect(called, isTrue);
  });

  testWidgets('channelMediaRelayStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    ChannelMediaRelayState? stateRet;
    ChannelMediaRelayError? codeRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      channelMediaRelayStateChanged:
          (ChannelMediaRelayState state, ChannelMediaRelayError code) {
        stateRet = state;
        codeRet = code;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onChannelMediaRelayStateChanged',
      '{"state":1,"code":9}',
    );
    expect(stateRet, ChannelMediaRelayState.Connecting);
    expect(codeRet, ChannelMediaRelayError.InternalError);
  });

  testWidgets('channelMediaRelayEvent', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    ChannelMediaRelayEvent? codeRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      channelMediaRelayEvent: (ChannelMediaRelayEvent code) {
        codeRet = code;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onChannelMediaRelayEvent',
      '{"code":2}',
    );
    expect(codeRet, ChannelMediaRelayEvent.JoinedSourceChannel);
  });

  testWidgets('firstRemoteVideoFrame', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    int widthRet = 0;
    int heightRet = 0;
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstRemoteVideoFrame: (int uid, int width, int height, int elapsed) {
        uidRet = uid;
        widthRet = width;
        heightRet = height;
        elapsedRet = elapsed;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onFirstRemoteVideoFrame',
      '{"uid":10,"width":100,"height":100,"elapsed":50}',
    );
    expect(uidRet, 10);
    expect(widthRet, 100);
    expect(heightRet, 100);
    expect(elapsedRet, 50);
  });

  testWidgets('firstRemoteAudioFrame', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstRemoteAudioFrame: (int uid, int elapsed) {
        uidRet = uid;
        elapsedRet = elapsed;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onFirstRemoteAudioFrame',
      '{"uid":10,"elapsed":50}',
    );
    expect(uidRet, 10);
    expect(elapsedRet, 50);
  });

  testWidgets('firstRemoteAudioDecoded', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstRemoteAudioDecoded: (int uid, int elapsed) {
        uidRet = uid;
        elapsedRet = elapsed;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onFirstRemoteAudioDecoded',
      '{"uid":10,"elapsed":50}',
    );
    expect(uidRet, 10);
    expect(elapsedRet, 50);
  });

  testWidgets('userMuteAudio', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    bool mutedRet = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userMuteAudio: (int uid, bool muted) {
        uidRet = uid;
        mutedRet = muted;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onUserMuteAudio',
      '{"uid":10,"muted":true}',
    );
    expect(uidRet, 10);
    expect(mutedRet, true);
  });

  testWidgets('streamPublished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String urlRet = '';
    ErrorCode? errorRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      streamPublished: (String url, ErrorCode error) {
        urlRet = url;
        errorRet = error;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onStreamPublished',
      '{"url":"https://example.com","error":1027}',
    );
    expect(urlRet, 'https://example.com');
    expect(errorRet, ErrorCode.AdmNoPermission);
  });

  testWidgets('streamUnpublished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String urlRet = '';
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      streamUnpublished: (String url) {
        urlRet = url;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onStreamUnpublished',
      '{"url":"https://example.com"}',
    );
    expect(urlRet, 'https://example.com');
  });

  testWidgets('metadataReceived', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    Metadata? metadataRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      metadataReceived: (Metadata metadata) {
        metadataRet = metadata;
      },
    ));
    final buffer = Uint8List.fromList([1, 1]);
    final Metadata expectedMetadata = Metadata(10, 1000);
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onMetadataReceived',
      '{"metadata":${jsonEncode(expectedMetadata.toJson())}}',
      buffer: buffer,
      bufferSize: 2,
    );
    expect(metadataRet!.uid, expectedMetadata.uid);
    expect(metadataRet!.timeStampMs, expectedMetadata.timeStampMs);
    expect(metadataRet!.buffer, buffer);
  });

  testWidgets('firstLocalAudioFramePublished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstLocalAudioFramePublished: (int elapsed) {
        elapsedRet = elapsed;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onFirstLocalAudioFramePublished',
      '{"elapsed":100}',
    );
    expect(elapsedRet, 100);
  });

  testWidgets('firstLocalVideoFramePublished', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int elapsedRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      firstLocalVideoFramePublished: (int elapsed) {
        elapsedRet = elapsed;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onFirstLocalVideoFramePublished',
      '{"elapsed":100}',
    );
    expect(elapsedRet, 100);
  });

  testWidgets('audioPublishStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String channelRet = '';
    StreamPublishState? oldStateRet;
    StreamPublishState? newStateRet;
    int elapseSinceLastStateRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioPublishStateChanged: (String channel, StreamPublishState oldState,
          StreamPublishState newState, int elapseSinceLastState) {
        channelRet = channel;
        oldStateRet = oldState;
        newStateRet = newState;
        elapseSinceLastStateRet = elapseSinceLastState;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onAudioPublishStateChanged',
      '{"channel":"testapi","oldState":3,"newState":1,"elapseSinceLastState":10}',
    );
    expect(channelRet, 'testapi');
    expect(oldStateRet, StreamPublishState.Published);
    expect(newStateRet, StreamPublishState.NoPublished);
    expect(elapseSinceLastStateRet, 10);
  });

  testWidgets('videoPublishStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String channelRet = '';
    StreamPublishState? oldStateRet;
    StreamPublishState? newStateRet;
    int elapseSinceLastStateRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      videoPublishStateChanged: (String channel, StreamPublishState oldState,
          StreamPublishState newState, int elapseSinceLastState) {
        channelRet = channel;
        oldStateRet = oldState;
        newStateRet = newState;
        elapseSinceLastStateRet = elapseSinceLastState;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onVideoPublishStateChanged',
      '{"channel":"testapi","oldState":3,"newState":1,"elapseSinceLastState":10}',
    );
    expect(channelRet, 'testapi');
    expect(oldStateRet, StreamPublishState.Published);
    expect(newStateRet, StreamPublishState.NoPublished);
    expect(elapseSinceLastStateRet, 10);
  });

  testWidgets('audioSubscribeStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String channelRet = '';
    int uidRet = 0;
    StreamSubscribeState? oldStateRet;
    StreamSubscribeState? newStateRet;
    int elapseSinceLastStateRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioSubscribeStateChanged: (String channel,
          int uid,
          StreamSubscribeState oldState,
          StreamSubscribeState newState,
          int elapseSinceLastState) {
        channelRet = channel;
        uidRet = uid;
        oldStateRet = oldState;
        newStateRet = newState;
        elapseSinceLastStateRet = elapseSinceLastState;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onAudioSubscribeStateChanged',
      '{"channel":"testapi","uid":10,"oldState":1,"newState":2,"elapseSinceLastState":10}',
    );
    expect(channelRet, 'testapi');
    expect(uidRet, 10);
    expect(oldStateRet, StreamSubscribeState.NoSubscribed);
    expect(newStateRet, StreamSubscribeState.Subscribing);
    expect(elapseSinceLastStateRet, 10);
  });

  testWidgets('videoSubscribeStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String channelRet = '';
    int uidRet = 0;
    StreamSubscribeState? oldStateRet;
    StreamSubscribeState? newStateRet;
    int elapseSinceLastStateRet = 0;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      videoSubscribeStateChanged: (String channel,
          int uid,
          StreamSubscribeState oldState,
          StreamSubscribeState newState,
          int elapseSinceLastState) {
        channelRet = channel;
        uidRet = uid;
        oldStateRet = oldState;
        newStateRet = newState;
        elapseSinceLastStateRet = elapseSinceLastState;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onVideoSubscribeStateChanged',
      '{"channel":"testapi","uid":10,"oldState":1,"newState":2,"elapseSinceLastState":10}',
    );
    expect(channelRet, 'testapi');
    expect(uidRet, 10);
    expect(oldStateRet, StreamSubscribeState.NoSubscribed);
    expect(newStateRet, StreamSubscribeState.Subscribing);
    expect(elapseSinceLastStateRet, 10);
  });

  testWidgets('rtmpStreamingEvent', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String urlRet = '';
    RtmpStreamingEvent? eventCodeRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      rtmpStreamingEvent: (String url, RtmpStreamingEvent eventCode) {
        urlRet = url;
        eventCodeRet = eventCode;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onRtmpStreamingEvent',
      '{"url":"https://example.com","eventCode":1}',
    );
    expect(urlRet, 'https://example.com');
    expect(eventCodeRet, RtmpStreamingEvent.FailedLoadImage);
  });

  testWidgets('userSuperResolutionEnabled', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    int uidRet = 0;
    bool enabledRet = false;
    SuperResolutionStateReason? reasonRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      userSuperResolutionEnabled:
          (int uid, bool enabled, SuperResolutionStateReason reason) {
        uidRet = uid;
        enabledRet = enabled;
        reasonRet = reason;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onUserSuperResolutionEnabled',
      '{"uid":10,"enabled":true,"reason":1}',
    );
    expect(uidRet, 10);
    expect(enabledRet, isTrue);
    expect(reasonRet, SuperResolutionStateReason.StreamOverLimitation);
  });

  testWidgets('uploadLogResult', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String requestIdRet = '';
    bool successRet = false;
    UploadErrorReason? reasonRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      uploadLogResult:
          (String requestId, bool success, UploadErrorReason reason) {
        requestIdRet = requestId;
        successRet = success;
        reasonRet = reason;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onUploadLogResult',
      '{"requestId":"10","success":true,"reason":2}',
    );
    expect(requestIdRet, '10');
    expect(successRet, isTrue);
    expect(reasonRet, UploadErrorReason.ServerError);
  });

  testWidgets('videoDeviceStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String deviceIdRet = '';
    MediaDeviceType? deviceTypeRet;
    MediaDeviceStateType? deviceStateRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      videoDeviceStateChanged: (String deviceId, MediaDeviceType deviceType,
          MediaDeviceStateType deviceState) {
        deviceIdRet = deviceId;
        deviceTypeRet = deviceType;
        deviceStateRet = deviceState;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onVideoDeviceStateChanged',
      '{"deviceId":"10","deviceType":4,"deviceState":0}',
    );
    expect(deviceIdRet, '10');
    expect(deviceTypeRet, MediaDeviceType.AudioApplicationPlayoutDevice);
    expect(deviceStateRet, MediaDeviceStateType.MediaDeviceStateIdle);
  });

  testWidgets('audioDeviceVolumeChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    MediaDeviceType? deviceTypeRet;
    int volumeRet = 0;
    bool mutedRet = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioDeviceVolumeChanged:
          (MediaDeviceType deviceType, int volume, bool muted) {
        deviceTypeRet = deviceType;
        volumeRet = volume;
        mutedRet = muted;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onAudioDeviceVolumeChanged',
      '{"deviceType":3,"volume":20,"muted":true}',
    );
    expect(deviceTypeRet, MediaDeviceType.VideoCaptureDevice);
    expect(volumeRet, 20);
    expect(mutedRet, isTrue);
  });

  testWidgets('audioDeviceStateChanged', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    String deviceIdRet = '';
    MediaDeviceType? deviceTypeRet;
    MediaDeviceStateType? deviceStateRet;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      audioDeviceStateChanged: (String deviceId, MediaDeviceType deviceType,
          MediaDeviceStateType deviceState) {
        deviceIdRet = deviceId;
        deviceTypeRet = deviceType;
        deviceStateRet = deviceState;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onAudioDeviceStateChanged',
      '{"deviceId":"20","deviceType":1,"deviceState":8}',
    );
    expect(deviceIdRet, '20');
    expect(deviceTypeRet, MediaDeviceType.AudioRecordingDevice);
    expect(deviceStateRet, MediaDeviceStateType.MediaDeviceStateUnplugged);
  });

  testWidgets('remoteAudioMixingBegin', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    bool called = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteAudioMixingBegin: () {
        called = true;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onRemoteAudioMixingBegin', '{}');
    expect(called, true);
  });

  testWidgets('remoteAudioMixingEnd', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    bool called = false;
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      remoteAudioMixingEnd: () {
        called = true;
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
        tester, 'onRemoteAudioMixingEnd', '{}');
    expect(called, true);
  });

  testEventCall('snapshotTaken', (
    WidgetTester tester,
    EventHandlerTester eventHandlerTester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    rtcEngine = await _createRtcEngine();
    rtcEngine.setEventHandler(RtcEngineEventHandler(
      snapshotTaken: (String channel, int uid, String filePath, int width,
          int height, int errCode) {
        expectSync(channel, 'testapi');
        expectSync(uid, 10);
        expectSync(filePath, '/path');
        expectSync(width, 10);
        expectSync(height, 10);
        expectSync(errCode, 0);
      },
    ));
    await fakeIrisEngine.fireAndWaitEvent(
      tester,
      'onSnapshotTaken',
      '{"channel":"testapi","uid":10,"filePath":"/path","width":10,"height":10,"errCode":0}',
    );
  });
}
