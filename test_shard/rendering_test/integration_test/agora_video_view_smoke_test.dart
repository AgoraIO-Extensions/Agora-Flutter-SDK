import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'common/fake_camera_local_video_view.dart';
import 'common/screenshot_matcher_ext.dart';
import 'common/widget_tester_ext.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'AgoraVideoView iOS',
    () {
      group('Platform View', () {
        testWidgets(
          'can show local preview',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

            await tester.pumpWidget(FakeCameraLocalVideoView(
                rtcEngine: rtcEngine,
                builder: (context) {
                  return AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: rtcEngine,
                      canvas: const VideoCanvas(
                        uid: 0,
                        sourceType: VideoSourceType.videoSourceCustom,
                      ),
                    ),
                  );
                },
                onFirstFrame: () async {
                  if (!onFrameCompleter.isCompleted) {
                    await rtcEngine.startPreview(
                        sourceType: VideoSourceType.videoSourceCustom);
                    onFrameCompleter.complete(null);
                  }
                }));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await waitFrame(tester);

            await binding.takeScreenshot(
                'ios.agora_video_view.platform_view.smoke_test.start_preview_after_enable_video');

            await waitDisposed(tester, binding);
          },
        );
      });

      group(
        'Flutter Texture',
        () {
          testWidgets(
            'can show local preview',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraLocalVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context) {
                    return AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: rtcEngine,
                        canvas: const VideoCanvas(
                          uid: 0,
                          sourceType: VideoSourceType.videoSourceCustom,
                        ),
                        useFlutterTexture: true,
                      ),
                    );
                  },
                  onFirstFrame: () async {
                    if (!onFrameCompleter.isCompleted) {
                      await rtcEngine.startPreview(
                          sourceType: VideoSourceType.videoSourceCustom);
                      onFrameCompleter.complete(null);
                    }
                  }));

              await tester.pumpAndSettle(const Duration(seconds: 10));

              await onFrameCompleter.future;
              await waitFrame(tester);

              await binding.takeScreenshot(
                  'ios.agora_video_view.flutter_texture.smoke_test.start_preview_after_enable_video');

              await waitDisposed(tester, binding);
            },
          );
        },
        // TODO(littlegnal): Preview for `videoSourceCustom` fix after 6.1.0
        skip: true,
      );
    },
    skip: !Platform.isIOS,
  );

  group(
    'AgoraVideoView macOS',
    () {
      group('Flutter Texture', () {
        testWidgets(
          'can show local preview',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

            await tester.pumpWidget(FakeCameraLocalVideoView(
              rtcEngine: rtcEngine,
              onFirstFrame: () {
                if (!onFrameCompleter.isCompleted) {
                  onFrameCompleter.complete(null);
                }
              },
              builder: (context) {
                return AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: rtcEngine,
                    canvas: const VideoCanvas(
                      uid: 0,
                      sourceType: VideoSourceType.videoSourceCustom,
                    ),
                    useFlutterTexture: true,
                  ),
                );
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view.platform_view.smoke_test.start_preview_after_enable_video');

            await waitDisposed(tester, binding);
          },
        );
      });
    },
    // TODO(littlegnal): Preview for `videoSourceCustom` fix after 6.1.0
    skip: true,
  );
}
