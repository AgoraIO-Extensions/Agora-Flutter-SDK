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
    bool hdr = false,
    bool flutterTexture = false,
  }) =>
      VideoViewController(
        rtcEngine: _FakeRtcEngine(),
        canvas: const VideoCanvas(uid: 0),
        useFlutterTexture: flutterTexture,
        useAndroidSurfaceView: surfaceView,
        useAndroidSurfaceViewHdr: hdr,
      );
  final android = TargetPlatformVariant.only(TargetPlatform.android);
  group('Android', () {
    testWidgets('default uses AndroidView with a TextureView', (tester) async {
      await pumpView(tester, local());
      expect(find.byType(AndroidView), findsOneWidget);
      expect(find.byType(PlatformViewLink), findsNothing);
      expect(createCalls.single['viewType'], 'AgoraTextureView');
      expect(createCalls.single.containsKey('hybrid'), isFalse);
      expect(createCalls.single.containsKey('hybridFallback'), isFalse);
    }, variant: android);
    testWidgets(
        'useAndroidSurfaceView only keeps AndroidView (initAndroidView)',
        (tester) async {
      await pumpView(tester, local(surfaceView: true));
      expect(find.byType(AndroidView), findsOneWidget);
      expect(find.byType(PlatformViewLink), findsNothing);
      expect(createCalls.single['viewType'], 'AgoraSurfaceView');
      expect(createCalls.single.containsKey('hybrid'), isFalse);
      expect(createCalls.single.containsKey('hybridFallback'), isFalse);
    }, variant: android);
    testWidgets('HDR + SurfaceView uses initSurfaceAndroidView',
        (tester) async {
      await pumpView(tester, local(surfaceView: true, hdr: true));
      expect(find.byType(PlatformViewLink), findsOneWidget);
      expect(find.byType(AndroidView), findsNothing);
      expect(createCalls, hasLength(1));
      expect(createCalls.single['viewType'], 'AgoraSurfaceView');
      // initSurfaceAndroidView: TLHC request that lets the embedder fall back to HC.
      expect(createCalls.single['hybridFallback'], isTrue);
      expect(createCalls.single.containsKey('hybrid'), isFalse);
    }, variant: android);
    testWidgets('HDR alone is treated as useAndroidSurfaceView = true',
        (tester) async {
      await pumpView(tester, local(hdr: true));
      expect(find.byType(PlatformViewLink), findsOneWidget);
      expect(createCalls.single['viewType'], 'AgoraSurfaceView');
      expect(createCalls.single['hybridFallback'], isTrue);
    }, variant: android);
    test('does not affect useFlutterTexture', () {
      // AgoraVideoView returns the Flutter Texture renderer as soon as `useFlutterTexture` is
      // set, before the platform view state (the only reader of the HDR option) exists. Mounting
      // the Texture renderer needs a real RtcEngineImpl, so the decision is asserted here.
      final controller = local(flutterTexture: true, hdr: true);
      expect(controller.useFlutterTexture, isTrue);
      expect(controller.shouldUseFlutterTexture, isTrue);
      expect(controller.useAndroidSurfaceViewHdr, isTrue);
      // The option is stored as given and does not turn Texture rendering off.
      expect(local(flutterTexture: true).shouldUseFlutterTexture, isTrue);
    });
    testWidgets('MediaPlayerController forwards the option', (tester) async {
      final controller = MediaPlayerController(
        rtcEngine: _FakeRtcEngine(),
        canvas: const VideoCanvas(uid: 0),
        useAndroidSurfaceViewHdr: true,
      );
      expect(controller.useAndroidSurfaceViewHdr, isTrue);
      await pumpView(tester, controller);
      expect(find.byType(PlatformViewLink), findsOneWidget);
      expect(createCalls.single['viewType'], 'AgoraSurfaceView');
      expect(createCalls.single['hybridFallback'], isTrue);
    }, variant: android);
  });
  testWidgets('iOS ignores the option', (tester) async {
    await pumpView(tester, local(surfaceView: true, hdr: true));
    expect(find.byType(UiKitView), findsOneWidget);
    expect(find.byType(PlatformViewLink), findsNothing);
  }, variant: TargetPlatformVariant.only(TargetPlatform.iOS));
  test('isSame distinguishes the option', () {
    final engine = _FakeRtcEngine();
    VideoViewController make(bool hdr) => VideoViewController(
          rtcEngine: engine,
          canvas: const VideoCanvas(uid: 0),
          useAndroidSurfaceView: true,
          useAndroidSurfaceViewHdr: hdr,
        );
    expect(make(false).isSame(make(false)), isTrue);
    expect(make(false).isSame(make(true)), isFalse);
  });
  test('defaults to false on every controller', () {
    final engine = _FakeRtcEngine();
    expect(
        VideoViewController(
                rtcEngine: engine, canvas: const VideoCanvas(uid: 0))
            .useAndroidSurfaceViewHdr,
        isFalse);
    expect(
        VideoViewController.remote(
          rtcEngine: engine,
          canvas: const VideoCanvas(uid: 1),
          connection: const RtcConnection(channelId: 'c'),
        ).useAndroidSurfaceViewHdr,
        isFalse);
    expect(
        MediaPlayerController(
          rtcEngine: engine,
          canvas: const VideoCanvas(uid: 0),
        ).useAndroidSurfaceViewHdr,
        isFalse);
  });
}
