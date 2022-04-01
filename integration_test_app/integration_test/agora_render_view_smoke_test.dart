import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
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

  group('SurfaceView', () {
    testWidgets('Show Local SurfaceView', (WidgetTester tester) async {
      runApp(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_local_view.SurfaceView(),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(rtc_local_view.SurfaceView), findsOneWidget);

      // Pump a empty Container to trigger dispose() of the SurfaceView/TextureView
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('Change uid', (WidgetTester tester) async {
      runApp(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.SurfaceView(
              uid: 10,
              channelId: '100',
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(rtc_remote_view.SurfaceView), findsOneWidget);

      await tester.pumpWidget(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.SurfaceView(
              uid: 100,
              channelId: '100',
            ),
          );
        },
      ));

      await tester.pumpAndSettle();

      expect(find.byType(rtc_remote_view.SurfaceView), findsOneWidget);

      // Pump a empty Container to trigger dispose() of the SurfaceView/TextureView
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('Change channel id', (WidgetTester tester) async {
      runApp(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.SurfaceView(
              uid: 10,
              channelId: '100',
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(rtc_remote_view.SurfaceView), findsOneWidget);

      await tester.pumpWidget(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.SurfaceView(
              uid: 10,
              channelId: '10',
            ),
          );
        },
      ));

      await tester.pumpAndSettle();

      expect(find.byType(rtc_remote_view.SurfaceView), findsOneWidget);

      // Pump a empty Container to trigger dispose() of the SurfaceView/TextureView
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('Change renderMode', (WidgetTester tester) async {
      runApp(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.SurfaceView(
              uid: 10,
              channelId: '100',
              renderMode: VideoRenderMode.Hidden,
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(rtc_remote_view.SurfaceView), findsOneWidget);

      await tester.pumpWidget(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.SurfaceView(
              uid: 10,
              channelId: '100',
              renderMode: VideoRenderMode.FILL,
            ),
          );
        },
      ));

      await tester.pumpAndSettle();

      expect(find.byType(rtc_remote_view.SurfaceView), findsOneWidget);

      // Pump a empty Container to trigger dispose() of the SurfaceView/TextureView
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('Change mirrorMode', (WidgetTester tester) async {
      runApp(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.SurfaceView(
              uid: 10,
              channelId: '100',
              mirrorMode: VideoMirrorMode.Auto,
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(rtc_remote_view.SurfaceView), findsOneWidget);

      final w = _RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.SurfaceView(
              uid: 10,
              channelId: '100',
              mirrorMode: VideoMirrorMode.Enabled,
            ),
          );
        },
      );
      await tester.pumpWidget(w);

      expect(find.byType(rtc_remote_view.SurfaceView), findsOneWidget);

      // Pump a empty Container to trigger dispose() of the SurfaceView/TextureView
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });

  group('TextureView', () {
    testWidgets('Show Local TextureView', (WidgetTester tester) async {
      runApp(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_local_view.TextureView(),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(rtc_local_view.TextureView), findsOneWidget);

      // Pump a empty Container to trigger dispose() of the SurfaceView/TextureView
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('Change uid', (WidgetTester tester) async {
      runApp(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.TextureView(
              uid: 10,
              channelId: '100',
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(rtc_remote_view.TextureView), findsOneWidget);

      await tester.pumpWidget(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.TextureView(
              uid: 100,
              channelId: '100',
            ),
          );
        },
      ));

      await tester.pumpAndSettle();

      expect(find.byType(rtc_remote_view.TextureView), findsOneWidget);

      // Pump a empty Container to trigger dispose() of the SurfaceView/TextureView
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('Change channel id', (WidgetTester tester) async {
      runApp(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.TextureView(
              uid: 10,
              channelId: '100',
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(rtc_remote_view.TextureView), findsOneWidget);

      await tester.pumpWidget(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.TextureView(
              uid: 10,
              channelId: '10',
            ),
          );
        },
      ));

      await tester.pumpAndSettle();

      expect(find.byType(rtc_remote_view.TextureView), findsOneWidget);

      // Pump a empty Container to trigger dispose() of the SurfaceView/TextureView
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('Change renderMode', (WidgetTester tester) async {
      runApp(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.TextureView(
              uid: 10,
              channelId: '100',
              renderMode: VideoRenderMode.Hidden,
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(rtc_remote_view.TextureView), findsOneWidget);

      await tester.pumpWidget(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.TextureView(
              uid: 10,
              channelId: '100',
              renderMode: VideoRenderMode.FILL,
            ),
          );
        },
      ));

      await tester.pumpAndSettle();

      expect(find.byType(rtc_remote_view.TextureView), findsOneWidget);

      // Pump a empty Container to trigger dispose() of the SurfaceView/TextureView
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });

    testWidgets('Change mirrorMode', (WidgetTester tester) async {
      runApp(_RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.TextureView(
              uid: 10,
              channelId: '100',
              mirrorMode: VideoMirrorMode.Auto,
            ),
          );
        },
      ));

      await tester.pumpAndSettle(const Duration(milliseconds: 5000));

      expect(find.byType(rtc_remote_view.TextureView), findsOneWidget);

      final w = _RenderViewWidget(
        builder: (context) {
          return const SizedBox(
            height: 100,
            width: 100,
            child: rtc_remote_view.TextureView(
              uid: 10,
              channelId: '100',
              mirrorMode: VideoMirrorMode.Enabled,
            ),
          );
        },
      );
      await tester.pumpWidget(w);

      expect(find.byType(rtc_remote_view.TextureView), findsOneWidget);

      // Pump a empty Container to trigger dispose() of the SurfaceView/TextureView
      await tester.pumpWidget(Container());
      await tester.pumpAndSettle();
    });
  });
}
