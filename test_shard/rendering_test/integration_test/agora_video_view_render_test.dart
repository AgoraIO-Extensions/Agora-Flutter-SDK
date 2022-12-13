import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/media_player_controller_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart';
import 'package:image_compare/image_compare.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart' as path;
import 'package:image/image.dart' as img;

import 'local_video_view.dart';
import 'remote_video_view.dart';

class TestMediaPlayerController extends MediaPlayerControllerImpl {
  TestMediaPlayerController(
      {required RtcEngine rtcEngine,
      required VideoCanvas canvas,
      RtcConnection? connection,
      bool useFlutterTexture = false,
      bool useAndroidSurfaceView = false})
      : super(rtcEngine, canvas, connection, useFlutterTexture,
            useAndroidSurfaceView);

  @override
  bool get shouldHandlerRenderMode => true;
}

Future<void> waitDisposed(
  WidgetTester tester,
  IntegrationTestWidgetsFlutterBinding binding,
) async {
  // Force pump an empty Widget to trigger the dispose() for RemoteVideoView,
  // so that the previous RtcEngine can be released before the next test case start.
  await tester.pumpWidget(Container());
  await binding.delayed(const Duration(seconds: 1));
}

Future<void> matchScreenShotDesktop(
    RtcEngineEx rtcEngine, String screenshotName) async {
  String updateGolden =
      const String.fromEnvironment('UPDATE_GOLDEN', defaultValue: 'false');

  final executableFile = File(Platform.resolvedExecutable);
  late String testPath;
  if (Platform.isMacOS) {
    testPath = executableFile
        .parent.parent.parent.parent.parent.parent.parent.parent.parent.path;
  } else {
    testPath = executableFile.parent.parent.parent.parent.parent.path;
  }

  SIZE thumbSize = const SIZE(width: 1000, height: 1000);
  SIZE iconSize = const SIZE(width: 100, height: 100);
  List<ScreenCaptureSourceInfo> sourceInfos =
      await rtcEngine.getScreenCaptureSources(
    thumbSize: thumbSize,
    iconSize: iconSize,
    includeScreen: false,
  );

  img.Image? dstImage;

  for (final info in sourceInfos) {
    if (info.sourceName == 'rendering_test' &&
        info.sourceTitle == 'rendering_test') {
      final thumbImage = info.thumbImage!;
      late img.Image srcImage;
      if (Platform.isWindows) {
        // On windows, the thumbImage.buffer format is bgra
        srcImage = img.Image.fromBytes(
            thumbImage.width!, thumbImage.height!, thumbImage.buffer!,
            format: Format.bgra);
      } else {
        srcImage = img.Image.fromBytes(
            thumbImage.width!, thumbImage.height!, thumbImage.buffer!);
      }

      final srcWidth = srcImage.width;
      final srcHeight = srcImage.height;
      const dstWidth = 400;
      const dstHeight = 400;
      final x = srcWidth / 2.0 - dstWidth / 2.0;
      final y = srcHeight / 2.0 - dstHeight / 2.0;

      dstImage = copyCrop(srcImage, x.toInt(), y.toInt(), dstWidth, dstHeight);

      final imageBytes = encodePng(dstImage);

      final File imageFile =
          File(path.join(testPath, 'screenshot', '$screenshotName.png'));
      if (updateGolden == 'true') {
        imageFile.writeAsBytesSync(imageBytes);
      } else {
        final expectedImage = decodePng(imageFile.readAsBytesSync());

        double tolerance = 0.3;

        final result = await compareImages(
          src1: expectedImage,
          src2: dstImage,
          algorithm: PixelMatching(tolerance: tolerance),
        );
        debugPrint('compareImages result: $result');

        if (Platform.isWindows) {
          // Need more tolerance on Windows
          expect(result < 0.01, isTrue);
        } else {
          expect(result, 0.0);
        }
      }

      return;
    }
  }
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'AgoraVideoView Android',
    () {
      testWidgets(
        'AgoraVideoView local rendering screenshot test',
        (WidgetTester tester) async {
          final onFrameCompleter = Completer();

          await tester.pumpWidget(LocalVideoView(
            onRendered: (RtcEngineEx rtcEngine) async {
              if (onFrameCompleter.isCompleted) {
                return;
              }

              onFrameCompleter.complete();
            },
          ));

          await tester.pumpAndSettle(const Duration(seconds: 10));

          await onFrameCompleter.future;
          await tester.pumpAndSettle(const Duration(seconds: 10));

          await binding.convertFlutterSurfaceToImage();
          await tester.pumpAndSettle();

          await binding.takeScreenshot('android.agora_video_view_render.local');

          await waitDisposed(tester, binding);
        },
      );
    },
    skip: !Platform.isAndroid,
  );

  group(
    'AgoraVideoView iOS',
    () {
      group('platform view', () {
        testWidgets(
          'local rendering screenshot test',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();

            await tester.pumpWidget(LocalVideoView(
              onRendered: (RtcEngineEx rtcEngine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }

                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await tester.pumpAndSettle();

            await binding.takeScreenshot(
                'ios.agora_video_view_render.platformview.local');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'remote rendering screenshot test',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();

            await tester.pumpWidget(RemoteVideoView(
              onRendered: (RtcEngineEx rtcEngine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }

                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await binding.takeScreenshot(
                'ios.agora_video_view_render.platformview.remote');

            await waitDisposed(tester, binding);
          },
        );
      });

      group(
        'flutter texture',
        () {
          testWidgets(
            'local rendering screenshot test',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();

              await tester.pumpWidget(LocalVideoView(
                useFlutterTexture: true,
                onRendered: (RtcEngineEx rtcEngine) async {
                  if (onFrameCompleter.isCompleted) {
                    return;
                  }

                  onFrameCompleter.complete();
                },
              ));

              await tester.pumpAndSettle(const Duration(seconds: 10));

              await onFrameCompleter.future;
              await tester.pumpAndSettle(const Duration(seconds: 10));

              await tester.pumpAndSettle();

              await binding
                  .takeScreenshot('ios.agora_video_view_render.texture.local');

              await waitDisposed(tester, binding);
            },
            // TODO(littlegnal): Flutter texture with software rendering on simulator is not supported.
            // The log like below:
            // Flutter: Attempted to composite external texture sources using the software backend.
            // This backend is only used on simulators. This feature is only available
            // on actual devices where OpenGL or Metal is used for rendering.
            //
            // Temporily skip flutter texture rendering test on ios at this time.
            skip: true,
          );

          testWidgets(
            'remote rendering screenshot test',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();

              await tester.pumpWidget(RemoteVideoView(
                useFlutterTexture: true,
                onRendered: (RtcEngineEx rtcEngine) async {
                  if (onFrameCompleter.isCompleted) {
                    return;
                  }

                  onFrameCompleter.complete();
                },
              ));

              await tester.pumpAndSettle(const Duration(seconds: 10));

              await onFrameCompleter.future;
              await tester.pumpAndSettle(const Duration(seconds: 10));

              await binding
                  .takeScreenshot('ios.agora_video_view_render.texture.remote');

              await waitDisposed(tester, binding);
            },
          );
        },
        // TODO(littlegnal): Flutter texture with software rendering on simulator is not supported.
        // The log like below:
        // Flutter: Attempted to composite external texture sources using the software backend.
        // This backend is only used on simulators. This feature is only available
        // on actual devices where OpenGL or Metal is used for rendering.
        //
        // Temporily skip flutter texture rendering test on ios at this time.
        skip: true,
      );
    },
    skip: !Platform.isIOS,
  );

  group(
    'AgoraVideoView macOS screenshot test',
    () {
      group('local rendering', () {
        testWidgets(
          'do not handle render mode',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(LocalVideoView(
              useFlutterTexture: true,
              isRenderModeTest: false,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }

                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.local.donot_handle_rendermode');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'render mode default',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(LocalVideoView(
              useFlutterTexture: true,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }

                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.local.with_default_rendermode');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'render mode renderModeHidden',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(LocalVideoView(
              useFlutterTexture: true,
              renderModeType: RenderModeType.renderModeHidden,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }

                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.local.with_rendermodehidden');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'render mode renderModeFit',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(LocalVideoView(
              useFlutterTexture: true,
              renderModeType: RenderModeType.renderModeFit,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }

                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.local.with_rendermodefit');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'render mode renderModeAdaptive',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(LocalVideoView(
              useFlutterTexture: true,
              renderModeType: RenderModeType.renderModeAdaptive,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }

                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.local.with_rendermodeadaptive');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'render mode default and videoMirrorModeDisabled',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(LocalVideoView(
              useFlutterTexture: true,
              mirrorModeType: VideoMirrorModeType.videoMirrorModeDisabled,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }

                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.local.with_default_rendermode.with_videomirrormodedisabled');

            await waitDisposed(tester, binding);
          },
        );
      });

      group('remote rendering', () {
        testWidgets(
          'do not handle render mode',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(RemoteVideoView(
              useFlutterTexture: true,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }
                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.remote.donot_handle_rendermode');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'render mode default',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(RemoteVideoView(
              useFlutterTexture: true,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }
                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.remote.with_default_rendermode');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'render mode renderModeHidden',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(RemoteVideoView(
              useFlutterTexture: true,
              renderModeType: RenderModeType.renderModeHidden,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }
                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.remote.with_rendermodehidden');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'render mode renderModeFit',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(RemoteVideoView(
              useFlutterTexture: true,
              renderModeType: RenderModeType.renderModeFit,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }
                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.remote.with_rendermodefit');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'render mode renderModeAdaptive',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(RemoteVideoView(
              useFlutterTexture: true,
              renderModeType: RenderModeType.renderModeAdaptive,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }
                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.remote.with_rendermodeadaptive');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'render mode default and videoMirrorModeDisabled',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();
            late RtcEngineEx rtcEngine;

            await tester.pumpWidget(RemoteVideoView(
              useFlutterTexture: true,
              mirrorModeType: VideoMirrorModeType.videoMirrorModeEnabled,
              onRendered: (RtcEngineEx engine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }
                rtcEngine = engine;
                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await tester.pumpAndSettle(const Duration(seconds: 10));

            await matchScreenShotDesktop(rtcEngine,
                'macos.agora_video_view_render.texture.remote.with_default_rendermodede.with_videoMirrorModeEnabled');

            await waitDisposed(tester, binding);
          },
        );
      });
    },
    skip: !Platform.isMacOS,
  );

  group(
    'AgoraVideoView Windows',
    () {
      testWidgets(
        'local rendering screenshot test',
        (WidgetTester tester) async {
          final onFrameCompleter = Completer();
          late RtcEngineEx rtcEngine;

          await tester.pumpWidget(LocalVideoView(
            useFlutterTexture: true,
            onRendered: (RtcEngineEx engine) async {
              if (onFrameCompleter.isCompleted) {
                return;
              }

              rtcEngine = engine;
              onFrameCompleter.complete();
            },
          ));

          await tester.pumpAndSettle(const Duration(seconds: 10));

          await onFrameCompleter.future;
          await tester.pumpAndSettle(const Duration(seconds: 10));

          await matchScreenShotDesktop(
              rtcEngine, 'windows.agora_video_view_render.texture.local');

          await waitDisposed(tester, binding);
        },
      );

      testWidgets(
        'remote rendering screenshot test',
        (WidgetTester tester) async {
          final onFrameCompleter = Completer();
          late RtcEngineEx rtcEngine;

          await tester.pumpWidget(RemoteVideoView(
            useFlutterTexture: true,
            onRendered: (RtcEngineEx engine) async {
              if (onFrameCompleter.isCompleted) {
                return;
              }
              rtcEngine = engine;
              onFrameCompleter.complete();
            },
          ));

          await tester.pumpAndSettle(const Duration(seconds: 10));

          await onFrameCompleter.future;
          await tester.pumpAndSettle(const Duration(seconds: 10));

          await matchScreenShotDesktop(
              rtcEngine, 'windows.agora_video_view_render.texture.remote');

          await waitDisposed(tester, binding);
        },
      );
    },
    skip: !Platform.isWindows,
  );
}
