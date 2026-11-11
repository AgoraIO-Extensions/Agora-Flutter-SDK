import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:image/image.dart' as img;

import '../integration_test/common/screenshot_matcher_ext.dart';
import '../integration_test/common/widget_tester_ext.dart';

class _EmptyScreenEngine extends Fake implements RtcEngineEx {
  int captures = 0;

  @override
  Future<List<ScreenCaptureSourceInfo>> getScreenCaptureSources({
    required SIZE thumbSize,
    required SIZE iconSize,
    required bool includeScreen,
  }) async {
    captures++;
    return [];
  }
}

class _DisposableView extends StatefulWidget {
  const _DisposableView(this.cleanup);

  final Future<void> cleanup;

  @override
  State<_DisposableView> createState() => _DisposableViewState();
}

class _DisposableViewState extends State<_DisposableView>
    implements AsyncTestDisposal {
  final Completer<void> _disposed = Completer<void>();

  @override
  Future<void> get disposed => _disposed.future;

  @override
  Widget build(BuildContext context) => const SizedBox();

  @override
  void dispose() {
    _disposed.complete(widget.cleanup);
    super.dispose();
  }
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('waitDisposed waits for cleanup instead of a fixed delay',
      (tester) async {
    final cleanup = Completer<void>();
    await tester.pumpWidget(_DisposableView(cleanup.future));

    bool completed = false;
    final waiting = waitDisposed(tester, binding).then((_) => completed = true);
    await Future<void>.delayed(const Duration(milliseconds: 100));
    expect(completed, isFalse);

    cleanup.complete();
    await waiting;
    expect(completed, isTrue);
  });

  testWidgets('waitDisposed propagates cleanup failures', (tester) async {
    final cleanup = Completer<void>();
    await tester.pumpWidget(_DisposableView(cleanup.future));

    Object? error;
    final waiting = waitDisposed(tester, binding).then<void>((_) {},
        onError: (Object caught) {
      error = caught;
    });
    await Future<void>.delayed(const Duration(milliseconds: 100));
    cleanup.completeError(StateError('cleanup failed'));
    await waiting;
    expect(error, isA<StateError>());
  });

  test('a missing screenshot window fails instead of passing silently',
      () async {
    final engine = _EmptyScreenEngine();
    await expectLater(
      matchScreenShotDesktop(engine, 'missing-window',
          timeout: const Duration(milliseconds: 50)),
      throwsA(isA<TestFailure>()),
    );
    expect(engine.captures, greaterThan(0));
  });

  test('golden readiness rejects blank frames and accepts the rendered frame',
      () async {
    final golden = img.decodePng(File(
            'screenshot/macos.agora_video_view_render.texture.local.with_default_rendermode.png')
        .readAsBytesSync())!;
    final blank = img.Image(400, 400);
    img.fill(blank, img.getColor(255, 255, 255));
    expect(await matchesDesktopGolden(golden, blank), isFalse);
    expect(await matchesDesktopGolden(golden, golden), isTrue);
  });
}
