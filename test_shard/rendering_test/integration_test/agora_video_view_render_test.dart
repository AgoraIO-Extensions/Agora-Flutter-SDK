import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/media_player_controller_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'common/screenshot_matcher_ext.dart';
import 'common/widget_tester_ext.dart';
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
          await waitFrame(tester);

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
    'AgoraVideoView iOS screenshot test',
    () {
      group('platform view', () {
        testWidgets(
          'local rendering',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();

            await tester.pumpWidget(LocalVideoView(
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
              onRendered: (RtcEngineEx rtcEngine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }

                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await waitFrame(tester);

            await tester.pumpAndSettle();

            await binding.takeScreenshot(
                'ios.agora_video_view_render.platformview.local');

            await waitDisposed(tester, binding);
          },
        );

        testWidgets(
          'remote rendering',
          (WidgetTester tester) async {
            final onFrameCompleter = Completer();

            await tester.pumpWidget(RemoteVideoView(
              renderModeType: RenderModeType.renderModeFit,
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
              onRendered: (RtcEngineEx rtcEngine) async {
                if (onFrameCompleter.isCompleted) {
                  return;
                }

                onFrameCompleter.complete();
              },
            ));

            await tester.pumpAndSettle(const Duration(seconds: 10));

            await onFrameCompleter.future;
            await waitFrame(tester);

            await binding.takeScreenshot(
                'ios.agora_video_view_render.platformview.remote');

            await waitDisposed(tester, binding);
          },
        );
      });

      group(
        'flutter texture',
        () {
          group('local rendering', () {
            testWidgets(
              'do not handle render mode',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(LocalVideoView(
                  useFlutterTexture: true,
                  isRenderModeTest: false,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }

                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.local.donot_handle_rendermode');

                await waitDisposed(tester, binding);
              },
            );

            testWidgets(
              'render mode default',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(LocalVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }

                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.local.with_default_rendermode');

                await waitDisposed(tester, binding);
              },
            );

            testWidgets(
              'render mode renderModeHidden',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(LocalVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  renderModeType: RenderModeType.renderModeHidden,
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }

                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.local.with_rendermodehidden');

                await waitDisposed(tester, binding);
              },
            );

            testWidgets(
              'render mode renderModeFit',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(LocalVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  renderModeType: RenderModeType.renderModeFit,
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }

                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.local.with_rendermodefit');

                await waitDisposed(tester, binding);
              },
            );

            testWidgets(
              'render mode renderModeAdaptive',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(LocalVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  renderModeType: RenderModeType.renderModeAdaptive,
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }

                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.local.with_rendermodeadaptive');

                await waitDisposed(tester, binding);
              },
            );

            testWidgets(
              'render mode default and videoMirrorModeDisabled',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(LocalVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  mirrorModeType: VideoMirrorModeType.videoMirrorModeDisabled,
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }

                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.local.with_default_rendermode.with_videomirrormodedisabled');

                await waitDisposed(tester, binding);
              },
            );
          });

          group('remote rendering', () {
            testWidgets(
              'do not handle render mode',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(RemoteVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }

                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.remote.donot_handle_rendermode');

                await waitDisposed(tester, binding);
              },
            );

            testWidgets(
              'render mode default',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(RemoteVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }

                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.remote.with_default_rendermode');

                await waitDisposed(tester, binding);
              },
            );

            testWidgets(
              'render mode renderModeHidden',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(RemoteVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  renderModeType: RenderModeType.renderModeHidden,
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }
                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.remote.with_rendermodehidden');

                await waitDisposed(tester, binding);
              },
            );

            testWidgets(
              'render mode renderModeFit',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(RemoteVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  renderModeType: RenderModeType.renderModeFit,
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }
                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.remote.with_rendermodefit');

                await waitDisposed(tester, binding);
              },
            );

            testWidgets(
              'render mode renderModeAdaptive',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(RemoteVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  renderModeType: RenderModeType.renderModeAdaptive,
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }
                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.remote.with_rendermodeadaptive');

                await waitDisposed(tester, binding);
              },
            );

            testWidgets(
              'render mode default and videoMirrorModeDisabled',
              (WidgetTester tester) async {
                final onFrameCompleter = Completer();

                await tester.pumpWidget(RemoteVideoView(
                  useFlutterTexture: true,
                  url:
                      'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
                  mirrorModeType: VideoMirrorModeType.videoMirrorModeEnabled,
                  onRendered: (RtcEngineEx engine) async {
                    if (onFrameCompleter.isCompleted) {
                      return;
                    }
                    onFrameCompleter.complete();
                  },
                ));

                await tester.pumpAndSettle(const Duration(seconds: 10));

                await onFrameCompleter.future;
                await waitFrame(tester);

                await binding.takeScreenshot(
                    'ios.agora_video_view_render.texture.remote.with_default_rendermodede.with_videoMirrorModeEnabled');

                await waitDisposed(tester, binding);
              },
            );
          });
        },
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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

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
    'AgoraVideoView Windows screenshot test',
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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.local.donot_handle_rendermode');

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.local.with_default_rendermode');

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.local.with_rendermodehidden');

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.local.with_rendermodefit');

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.local.with_rendermodeadaptive');

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.local.with_default_rendermode.with_videomirrormodedisabled');

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
              isRenderModeTest: false,
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.remote.donot_handle_rendermode');

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.remote.with_default_rendermode');

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.remote.with_rendermodehidden');

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.remote.with_rendermodefit');

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.remote.with_rendermodeadaptive');

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
              url:
                  'https://download.agora.io/demo/test/agoravideoview_rendering_test_solid_spilt_asymmetrical.mp4',
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
            await waitFrame(tester);

            await matchScreenShotDesktop(rtcEngine,
                'windows.agora_video_view_render.texture.remote.with_default_rendermodede.with_videoMirrorModeEnabled');

            await waitDisposed(tester, binding);
          },
        );
      });
    },
    skip: !Platform.isWindows,
  );
}
