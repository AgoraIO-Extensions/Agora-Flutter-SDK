import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:integration_test_app/main.dart' as app;

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
  late RtcEngine _rtcEngine;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
        defaultValue: '<YOUR_APP_ID>');

    _rtcEngine = createAgoraRtcEngine();
    await _rtcEngine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    try {
      await _rtcEngine.enableVideo();
    } catch (e) {
      debugPrint(e.toString());
    }

    if (mounted) {
      setState(() {
        _isInit = true;
      });
    }
  }

  @override
  void dispose() {
    _destroy();
    super.dispose();
  }

  Future<void> _destroy() async {
    await _rtcEngine.release(sync: true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _isInit ? widget.builder(context, _rtcEngine) : Container(),
      ),
    );
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Show Local AgoraVideoView pressure test',
      (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    for (int i = 0; i < 50; i++) {
      // await rtcEngine.enableVideo();
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

      await tester.pumpWidget(Container());
      await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    }

    expect(find.byType(AgoraVideoView), findsNothing);
  });
}
