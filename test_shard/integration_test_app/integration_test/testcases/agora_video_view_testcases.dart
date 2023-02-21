import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _RenderViewWidget extends StatefulWidget {
  const _RenderViewWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Function(BuildContext context, RtcEngine engine) builder;

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

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    try {
      await _engine.enableVideo();
      await _engine.startPreview();
    } catch (e) {
      debugPrint(e.toString());
    }

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
  testWidgets(
    'Show local AgoraVideoView after RtcEngine.initialize',
    (WidgetTester tester) async {
      await tester.pumpWidget(_RenderViewWidget(
        builder: (context, engine) {
          return SizedBox(
            height: 100,
            width: 100,
            child: AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      if (defaultTargetPlatform == TargetPlatform.android) {
        expect(find.byType(AndroidView), findsOneWidget);
      }

      if (defaultTargetPlatform == TargetPlatform.iOS) {
        expect(find.byType(UiKitView), findsOneWidget);
      }

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(AgoraVideoView), findsNothing);
    },
    skip: !(Platform.isAndroid || Platform.isIOS),
  );
}
