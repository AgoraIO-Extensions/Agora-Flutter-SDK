import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;

import 'package:integration_test_app/fake_remote_user.dart';

void testCases() {
  testWidgets('registerAudioFrameObserver smoke test',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
        defaultValue: '<YOUR_APP_ID>');

    RtcEngineEx rtcEngine = createAgoraRtcEngineEx();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final mediaEngine = rtcEngine.getMediaEngine();
    Completer<bool> eventCalledCompleter = Completer();
    final AudioFrameObserver observer = AudioFrameObserver(
      onRecordAudioFrame: (String channelId, AudioFrame audioFrame) {
        debugPrint('onRecordAudioFrame');
        if (eventCalledCompleter.isCompleted) return;
        eventCalledCompleter.complete(true);
      },
      onPlaybackAudioFrame: (String channelId, AudioFrame audioFrame) {
        debugPrint('onPlaybackAudioFrame');
        if (eventCalledCompleter.isCompleted) return;
        eventCalledCompleter.complete(true);
      },
      onMixedAudioFrame: (String channelId, AudioFrame audioFrame) {
        debugPrint('onMixedAudioFrame');
        if (eventCalledCompleter.isCompleted) return;
        eventCalledCompleter.complete(true);
      },
      onPlaybackAudioFrameBeforeMixing:
          (String channelId, int uid, AudioFrame audioFrame) {
        debugPrint('onPlaybackAudioFrameBeforeMixing');
        if (eventCalledCompleter.isCompleted) return;
        eventCalledCompleter.complete(true);
      },
    );
    mediaEngine.registerAudioFrameObserver(
      observer,
    );
    await rtcEngine.setPlaybackAudioFrameParameters(
        sampleRate: 32000,
        channel: 1,
        mode: RawAudioFrameOpModeType.rawAudioFrameOpModeReadOnly,
        samplesPerCall: 1024);
    await rtcEngine.setRecordingAudioFrameParameters(
        sampleRate: 32000,
        channel: 1,
        mode: RawAudioFrameOpModeType.rawAudioFrameOpModeReadOnly,
        samplesPerCall: 1024);

    await rtcEngine.enableVideo();

    await rtcEngine.joinChannel(
      token: '',
      channelId: 'testonaction',
      uid: 0,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );

    final remoteUser = FakeRemoteUser(rtcEngine);

    await remoteUser.joinChannel();

    final eventCalled = await eventCalledCompleter.future;
    expect(eventCalled, isTrue);

    mediaEngine.unregisterAudioFrameObserver(observer);
    await remoteUser.leaveChannel();
    await rtcEngine.leaveChannel();

    await mediaEngine.release();
    await rtcEngine.release();
  },
      // TODO(littlegnal): This case not work on windows/macos on github action, skip it temporarily
      skip: Platform.isWindows || Platform.isMacOS);

  testWidgets('registerVideoFrameObserver smoke test',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
        defaultValue: '<YOUR_APP_ID>');

    RtcEngineEx rtcEngine = createAgoraRtcEngineEx();
    await rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    final mediaEngine = rtcEngine.getMediaEngine();
    Completer<bool> eventCalledCompleter = Completer();

    Completer<bool> onRenderVideoFrameCalledCompleter = Completer();
    Completer<bool> onPreEncodeVideoFrameCalledCompleter = Completer();

    final VideoFrameObserver observer = VideoFrameObserver(
      onCaptureVideoFrame: (sourceType, videoFrame) {
        debugPrint('[onCaptureVideoFrame] videoFrame: ${videoFrame.toJson()}');
        if (eventCalledCompleter.isCompleted) return;
        eventCalledCompleter.complete(true);
      },
      onRenderVideoFrame:
          (String channelId, int remoteUid, VideoFrame videoFrame) {
        // logSink.log(
        //     '[onRenderVideoFrame] channelId: $channelId, remoteUid: $remoteUid, videoFrame: ${videoFrame.toJson()}');
        debugPrint(
            '[onRenderVideoFrame] channelId: $channelId, remoteUid: $remoteUid, videoFrame: ${videoFrame.toJson()}');
        if (onRenderVideoFrameCalledCompleter.isCompleted) return;
        onRenderVideoFrameCalledCompleter.complete(true);
      },
      onPreEncodeVideoFrame: (sourceType, VideoFrame videoFrame) {
        debugPrint(
            '[onPreEncodeVideoFrame] videoFrame: ${videoFrame.toJson()}');
        if (onPreEncodeVideoFrameCalledCompleter.isCompleted) return;
        onPreEncodeVideoFrameCalledCompleter.complete(true);
      },
    );

    mediaEngine.registerVideoFrameObserver(
      observer,
    );

    await rtcEngine.enableVideo();

    await rtcEngine.joinChannel(
      token: '',
      channelId: 'testonaction',
      uid: 0,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );

    final remoteUser = FakeRemoteUser(rtcEngine);

    await remoteUser.joinChannel();

    expect(await onRenderVideoFrameCalledCompleter.future, isTrue);

    mediaEngine.unregisterVideoFrameObserver(observer);
    await remoteUser.leaveChannel();
    await rtcEngine.leaveChannel();

    await mediaEngine.release();
    await rtcEngine.release();
  },
      // TODO(littlegnal): This case not work on windows on github action, skip it temporarily
      skip: Platform.isWindows);
}
