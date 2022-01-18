import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

class _RenderViewWidget extends StatefulWidget {
  const _RenderViewWidget({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;

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

    _rtcEngine = await RtcEngine.createWithContext(RtcEngineContext(
      engineAppId,
      areaCode: [AreaCode.NA, AreaCode.GLOB],
    ));

    await _rtcEngine.enableVideo();
    await _rtcEngine.startPreview();
    await _rtcEngine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _rtcEngine.setClientRole(ClientRole.Broadcaster);

    setState(() {
      _isInit = true;
    });
  }

  @override
  void dispose() {
    _destroy();
    super.dispose();
  }

  Future<void> _destroy() async {
    await _rtcEngine.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _isInit ? widget.builder(context) : Container(),
      ),
    );
  }
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Show Local SurfaceView', (WidgetTester tester) async {
    runApp(_RenderViewWidget(
      builder: (context) {
        return SizedBox(
          height: 100,
          width: 100,
          child: SurfaceView(),
        );
      },
    ));

    await tester.pumpAndSettle();

    expect(find.byType(SurfaceView), findsOneWidget);
  });

  testWidgets('Show Local TextureView', (WidgetTester tester) async {
    runApp(_RenderViewWidget(
      builder: (context) {
        return SizedBox(
          height: 100,
          width: 100,
          child: TextureView(),
        );
      },
    ));

    await tester.pumpAndSettle();

    expect(find.byType(TextureView), findsOneWidget);
  });
}
