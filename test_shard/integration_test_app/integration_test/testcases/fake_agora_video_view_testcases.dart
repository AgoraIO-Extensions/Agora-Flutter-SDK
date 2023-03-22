import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import '../fake/fake_iris_method_channel.dart';

class _RenderViewWidget extends StatefulWidget {
  const _RenderViewWidget({
    Key? key,
    required this.builder,
    required this.rtcEngine,
  }) : super(key: key);

  final Function(BuildContext context, RtcEngine engine) builder;

  final RtcEngine rtcEngine;

  @override
  State<_RenderViewWidget> createState() => _RenderViewWidgetState();
}

class _RenderViewWidgetState extends State<_RenderViewWidget> {
  late final RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
        defaultValue: '<YOUR_APP_ID>');

    _engine = widget.rtcEngine;
    await _engine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    try {
      await _engine.enableVideo();
      await _engine.startPreview();
    } catch (e) {}

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.builder(context, _engine),
      ),
    );
  }
}

void testCases() {
  group('Test with FakeIrisMethodChannel', () {
    final FakeIrisMethodChannel irisMethodChannel = FakeIrisMethodChannel();
    final RtcEngine rtcEngine =
        RtcEngineImpl.create(irisMethodChannel: irisMethodChannel);

    setUp(() {
      irisMethodChannel.reset();
    });

    tearDown(() {});
    testWidgets(
      'Show local AgoraVideoView after RtcEngine.initialize',
      (WidgetTester tester) async {
        final videoViewCreatedCompleter = Completer<void>();

        await tester.pumpWidget(_RenderViewWidget(
          rtcEngine: rtcEngine,
          builder: (context, engine) {
            return SizedBox(
              height: 100,
              width: 100,
              child: AgoraVideoView(
                controller: VideoViewController(
                  rtcEngine: engine,
                  canvas: const VideoCanvas(uid: 0),
                ),
                onAgoraVideoViewCreated: (viewId) {
                  if (!videoViewCreatedCompleter.isCompleted) {
                    videoViewCreatedCompleter.complete(null);
                  }
                },
              ),
            );
          },
        ));

        await tester.pumpAndSettle(const Duration(milliseconds: 5000));
        // pumpAndSettle again to ensure the `AgoraVideoView` shown
        await tester.pumpAndSettle(const Duration(milliseconds: 5000));

        await videoViewCreatedCompleter.future;

        final setupLocalVideoCalls = irisMethodChannel.methodCallQueue
            .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
            .toList();

        final jsonMap2 = jsonDecode(setupLocalVideoCalls[0].params);
        expect(jsonMap2['canvas']['view'] != 0, isTrue);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle(const Duration(milliseconds: 5000));

        // Delay 5 seconds to ensure that previous Widget.dipose call completed.
        await Future.delayed(const Duration(seconds: 5));

        expect(find.byType(AgoraVideoView), findsNothing);
      },
      skip: !(Platform.isAndroid || Platform.isIOS),
    );



    testWidgets(
      'Switch local/remote AgoraVideoView with RtcConnection',
      (WidgetTester tester) async {
        await tester.pumpWidget(_RenderViewWidget(
          rtcEngine: rtcEngine,
          builder: (context, engine) {
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: engine,
                      canvas: const VideoCanvas(uid: 1000),
                      connection: const RtcConnection(
                        channelId: 'switch_video_view',
                        localUid: 1000,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ));

        await tester.pumpAndSettle(const Duration(milliseconds: 5000));
        // pumpAndSettle again to ensure the `AgoraVideoView` shown
        await tester.pumpAndSettle(const Duration(milliseconds: 5000));

        if (defaultTargetPlatform == TargetPlatform.android) {
          expect(find.byType(AndroidView), findsNWidgets(2));
        }

        if (defaultTargetPlatform == TargetPlatform.iOS) {
          expect(find.byType(UiKitView), findsNWidgets(2));
        }

        // Clear the methodCall records
        irisMethodChannel.reset();

        await tester.pumpWidget(_RenderViewWidget(
          rtcEngine: rtcEngine,
          builder: (context, engine) {
            return Column(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: engine,
                      canvas: const VideoCanvas(uid: 1000),
                      connection: const RtcConnection(
                        channelId: 'switch_video_view',
                        localUid: 1000,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 100,
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  ),
                )
              ],
            );
          },
        ));

        await tester.pumpAndSettle(const Duration(milliseconds: 5000));
        if (defaultTargetPlatform == TargetPlatform.android) {
          expect(find.byType(AndroidView), findsNWidgets(2));
        }
        if (defaultTargetPlatform == TargetPlatform.iOS) {
          expect(find.byType(UiKitView), findsNWidgets(2));
        }

        final setupRemoteVideoExCalls = irisMethodChannel.methodCallQueue
            .where((e) => e.funcName == 'RtcEngineEx_setupRemoteVideoEx')
            .toList();

        final jsonMap1 = jsonDecode(setupRemoteVideoExCalls[0].params);
        expect(jsonMap1['canvas']['view'] == 0, isTrue);

        final jsonMap2 = jsonDecode(setupRemoteVideoExCalls[1].params);
        expect(jsonMap2['canvas']['view'] != 0, isTrue);

        await tester.pumpWidget(Container());
        await tester.pumpAndSettle(const Duration(milliseconds: 5000));
        await Future.delayed(const Duration(seconds: 5));
      },
      skip: !(Platform.isAndroid || Platform.isIOS),
    );
  });
}
