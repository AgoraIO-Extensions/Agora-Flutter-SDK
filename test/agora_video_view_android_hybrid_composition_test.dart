import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/video_view_controller_impl.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

/// The platform-view path never touches the engine until the native view is created, so a fake
/// is enough. The `create` call is captured and never answered, which keeps the view from
/// reaching `setupView`.
class _FakeRtcEngine extends Fake implements RtcEngine {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late List<Map<Object?, Object?>> createCalls;

  setUp(() {
    createCalls = <Map<Object?, Object?>>[];
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform_views,
            (MethodCall call) {
      if (call.method == 'create') {
        createCalls.add(call.arguments as Map<Object?, Object?>);
        return Completer<Object?>().future;
      }
      return Future<Object?>.value();
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform_views, null);
  });

  Future<void> pumpView(
      WidgetTester tester, VideoViewControllerBase controller) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child: SizedBox(
        width: 320,
        height: 240,
        child: AgoraVideoView(controller: controller),
      ),
    ));
    await tester.pump();
  }

  VideoViewController local({
    bool surfaceView = false,
    bool hybrid = false,
  }) =>
      VideoViewController(
        rtcEngine: _FakeRtcEngine(),
        canvas: const VideoCanvas(uid: 0),
        useAndroidSurfaceView: surfaceView,
        useAndroidHybridComposition: hybrid,
      );

  final android = TargetPlatformVariant.only(TargetPlatform.android);

  group('Android', () {
    testWidgets('default keeps AndroidView (initAndroidView)', (tester) async {
      await pumpView(tester, local(surfaceView: true));
      expect(find.byType(AndroidView), findsOneWidget);
      expect(find.byType(PlatformViewLink), findsNothing);
      expect(createCalls, hasLength(1));
      expect(createCalls.single['viewType'], 'AgoraSurfaceView');
      expect(createCalls.single.containsKey('hybrid'), isFalse);
      expect(createCalls.single.containsKey('hybridFallback'), isFalse);
    }, variant: android);

    testWidgets('hybrid + SurfaceView uses initSurfaceAndroidView',
        (tester) async {
      await pumpView(tester, local(surfaceView: true, hybrid: true));
      expect(find.byType(PlatformViewLink), findsOneWidget);
      expect(find.byType(AndroidView), findsNothing);
      expect(createCalls, hasLength(1));
      expect(createCalls.single['viewType'], 'AgoraSurfaceView');
      // initSurfaceAndroidView: TLHC request that lets the embedder fall back to HC.
      expect(createCalls.single['hybridFallback'], isTrue);
      expect(createCalls.single.containsKey('hybrid'), isFalse);
    }, variant: android);

    testWidgets('hybrid + TextureView also uses initSurfaceAndroidView',
        (tester) async {
      await pumpView(tester, local(hybrid: true));
      expect(find.byType(PlatformViewLink), findsOneWidget);
      expect(createCalls.single['viewType'], 'AgoraTextureView');
      expect(createCalls.single['hybridFallback'], isTrue);
    }, variant: android);

    testWidgets('MediaPlayerController forwards the flag', (tester) async {
      final controller = MediaPlayerController(
        rtcEngine: _FakeRtcEngine(),
        canvas: const VideoCanvas(uid: 0),
        useAndroidSurfaceView: true,
        useAndroidHybridComposition: true,
      );
      expect(controller.useAndroidHybridComposition, isTrue);
      await pumpView(tester, controller);
      expect(find.byType(PlatformViewLink), findsOneWidget);
      expect(createCalls.single['hybridFallback'], isTrue);
    }, variant: android);
  });

  testWidgets('iOS ignores the flag', (tester) async {
    await pumpView(tester, local(surfaceView: true, hybrid: true));
    expect(find.byType(UiKitView), findsOneWidget);
    expect(find.byType(PlatformViewLink), findsNothing);
  }, variant: TargetPlatformVariant.only(TargetPlatform.iOS));

  test('isSame distinguishes the flag', () {
    final engine = _FakeRtcEngine();
    VideoViewController make(bool hybrid) => VideoViewController(
          rtcEngine: engine,
          canvas: const VideoCanvas(uid: 0),
          useAndroidSurfaceView: true,
          useAndroidHybridComposition: hybrid,
        );
    expect(make(false).isSame(make(false)), isTrue);
    expect(make(false).isSame(make(true)), isFalse);
  });

  test('defaults to false on every controller', () {
    final engine = _FakeRtcEngine();
    expect(
        VideoViewController(
                rtcEngine: engine, canvas: const VideoCanvas(uid: 0))
            .useAndroidHybridComposition,
        isFalse);
    expect(
        VideoViewController.remote(
          rtcEngine: engine,
          canvas: const VideoCanvas(uid: 1),
          connection: const RtcConnection(channelId: 'c'),
        ).useAndroidHybridComposition,
        isFalse);
    expect(
        MediaPlayerController(
          rtcEngine: engine,
          canvas: const VideoCanvas(uid: 0),
        ).useAndroidHybridComposition,
        isFalse);
  });
}
