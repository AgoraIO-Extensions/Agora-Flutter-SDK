import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/media_player_controller_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'common/fake_camera_local_video_view.dart';
import 'common/fake_camera_remote_video_view.dart';
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
/// 辅助函数：执行截图操作并延迟dispose
Future<String> takeScreenshotAndDelayDispose(
  IntegrationTestWidgetsFlutterBinding binding,
  WidgetTester tester,
  String screenshotName,
) async {
  await binding.takeScreenshot(screenshotName);
  
  // 构建截图文件路径
  final screenshotPath = 'screenshot/$screenshotName.png';
  debugPrint('Screenshot saved to: $screenshotPath');

  // 延迟一段时间再执行dispose，确保截图操作完成
  await Future.delayed(const Duration(seconds: 2));

  return screenshotPath;
}
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group(
    'AgoraVideoView Android',
    () {
      group('flutter texture', () {
        group('local rendering', () {
          testWidgets(
            'render mode default',
            (WidgetTester tester) async {
          debugPrint(
            'Test started: Android flutter texture local rendering with default render mode',
          ); // 新增：测试开始日志

              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraLocalVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context) {
                    return AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: rtcEngine,
                        useFlutterTexture: true,
                        canvas: const VideoCanvas(
                          uid: 0,
                          sourceType: VideoSourceType.videoSourceCustom,
                        ),
                      ),
                    );
                  },
                  onFirstFrame: () async {
                debugPrint(
                  'onFirstFrame triggered at ${DateTime.now()}',
                ); // 新增：onFirstFrame 回调触发日志
                    if (!onFrameCompleter.isCompleted) {
                      await rtcEngine.startPreview(
                          sourceType: VideoSourceType.videoSourceCustom);
                      onFrameCompleter.complete(null);
                    }
                  }));

              await tester.pumpAndSettle(const Duration(seconds: 10));

              await onFrameCompleter.future;
              await waitFrame(tester);

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();

          debugPrint(
            'Taking screenshot: android.agora_video_view_render.texture.local.with_default_rendermode',
          ); // 新增：截图前日志

          final screenshotPath = await takeScreenshotAndDelayDispose(
            binding,
            tester,
            'android.agora_video_view_render.texture.local.with_default_rendermode',
          );
          debugPrint('Screenshot saved to: $screenshotPath');
          debugPrint('waitDisposed start');
              await waitDisposed(tester, binding);
          debugPrint('waitDisposed end');

          debugPrint(
            'Test ended: Android flutter texture local rendering with default render mode',
          ); // 新增：测试结束日志
            },
          );

          testWidgets(
            'render mode renderModeHidden',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraLocalVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context) {
                    return AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: rtcEngine,
                        useFlutterTexture: true,
                        canvas: const VideoCanvas(
                          uid: 0,
                          sourceType: VideoSourceType.videoSourceCustom,
                          renderMode: RenderModeType.renderModeHidden,
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

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();

          final screenshotPath = await takeScreenshotAndDelayDispose(
            binding,
            tester,
            'android.agora_video_view_render.texture.local.with_rendermodehidden',
          );

              await waitDisposed(tester, binding);
            },
          );

          testWidgets(
            'render mode renderModeFit',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraLocalVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context) {
                    return AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: rtcEngine,
                        useFlutterTexture: true,
                        canvas: const VideoCanvas(
                          uid: 0,
                          sourceType: VideoSourceType.videoSourceCustom,
                          renderMode: RenderModeType.renderModeFit,
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

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();

          final screenshotPath = await takeScreenshotAndDelayDispose(
            binding,
            tester,
            'android.agora_video_view_render.texture.local.with_rendermodefit',
          );

              await waitDisposed(tester, binding);
            },
          );

          testWidgets(
            'render mode renderModeAdaptive',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraLocalVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context) {
                    return AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: rtcEngine,
                        useFlutterTexture: true,
                        canvas: const VideoCanvas(
                          uid: 0,
                          sourceType: VideoSourceType.videoSourceCustom,
                          renderMode: RenderModeType.renderModeAdaptive,
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

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();

          final screenshotPath = await takeScreenshotAndDelayDispose(
            binding,
            tester,
            'android.agora_video_view_render.texture.local.with_rendermodeadaptive',
          );

              await waitDisposed(tester, binding);
            },
          );

          testWidgets(
            'render mode default and videoMirrorModeDisabled',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraLocalVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context) {
                    return AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: rtcEngine,
                        useFlutterTexture: true,
                        canvas: const VideoCanvas(
                            uid: 0,
                            sourceType: VideoSourceType.videoSourceCustom,
                            mirrorMode:
                                VideoMirrorModeType.videoMirrorModeDisabled),
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

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();

          final screenshotPath = await takeScreenshotAndDelayDispose(
            binding,
            tester,
            'android.agora_video_view_render.texture.local.with_default_rendermode.with_videomirrormodedisabled',
          );

              await waitDisposed(tester, binding);
            },
          );
        });

        group('remote rendering', () {
          testWidgets(
            'render mode default',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraRemoteVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context, channelId, localUid, remoteUid) {
                    return AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: rtcEngine,
                        useFlutterTexture: true,
                        connection: RtcConnection(
                            channelId: channelId, localUid: localUid),
                        canvas: VideoCanvas(
                          uid: remoteUid,
                        ),
                      ),
                    );
                  },
                  onFirstFrame: () async {
                    if (!onFrameCompleter.isCompleted) {
                      onFrameCompleter.complete(null);
                    }
                  }));

              await tester.pumpAndSettle(const Duration(seconds: 10));

              await onFrameCompleter.future;
              await waitFrame(tester);

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();

          final screenshotPath = await takeScreenshotAndDelayDispose(
            binding,
            tester,
            'android.agora_video_view_render.texture.remote.with_default_rendermode',
          );

              await waitDisposed(tester, binding);
            },
          );

          testWidgets(
            'render mode renderModeHidden',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraRemoteVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context, channelId, localUid, remoteUid) {
                    return AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: rtcEngine,
                        useFlutterTexture: true,
                        connection: RtcConnection(
                            channelId: channelId, localUid: localUid),
                        canvas: VideoCanvas(
                          uid: remoteUid,
                          renderMode: RenderModeType.renderModeHidden,
                        ),
                      ),
                    );
                  },
                  onFirstFrame: () async {
                    if (!onFrameCompleter.isCompleted) {
                      onFrameCompleter.complete(null);
                    }
                  }));

              await tester.pumpAndSettle(const Duration(seconds: 10));

              await onFrameCompleter.future;
              await waitFrame(tester);

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();

          final screenshotPath = await takeScreenshotAndDelayDispose(
            binding,
            tester,
            'android.agora_video_view_render.texture.remote.with_rendermodehidden',
          );

              await waitDisposed(tester, binding);
            },
          );

          testWidgets(
            'render mode renderModeFit',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraRemoteVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context, channelId, localUid, remoteUid) {
                    return AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: rtcEngine,
                        useFlutterTexture: true,
                        connection: RtcConnection(
                            channelId: channelId, localUid: localUid),
                        canvas: VideoCanvas(
                          uid: remoteUid,
                          renderMode: RenderModeType.renderModeFit,
                        ),
                      ),
                    );
                  },
                  onFirstFrame: () async {
                    if (!onFrameCompleter.isCompleted) {
                      onFrameCompleter.complete(null);
                    }
                  }));

              await tester.pumpAndSettle(const Duration(seconds: 10));

              await onFrameCompleter.future;
              await waitFrame(tester);

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();

          final screenshotPath = await takeScreenshotAndDelayDispose(
            binding,
            tester,
            'android.agora_video_view_render.texture.remote.with_rendermodefit',
          );

              await waitDisposed(tester, binding);
            },
          );

          testWidgets(
            'render mode renderModeAdaptive',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraRemoteVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context, channelId, localUid, remoteUid) {
                    return AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: rtcEngine,
                        useFlutterTexture: true,
                        connection: RtcConnection(
                            channelId: channelId, localUid: localUid),
                        canvas: VideoCanvas(
                          uid: remoteUid,
                          renderMode: RenderModeType.renderModeAdaptive,
                        ),
                      ),
                    );
                  },
                  onFirstFrame: () async {
                    if (!onFrameCompleter.isCompleted) {
                      onFrameCompleter.complete(null);
                    }
                  }));

              await tester.pumpAndSettle(const Duration(seconds: 10));

              await onFrameCompleter.future;
              await waitFrame(tester);

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();

          final screenshotPath = await takeScreenshotAndDelayDispose(
            binding,
            tester,
            'android.agora_video_view_render.texture.remote.with_rendermodeadaptive',
          );

              await waitDisposed(tester, binding);
            },
          );

          testWidgets(
            'render mode default and videoMirrorModeDisabled',
            (WidgetTester tester) async {
              final onFrameCompleter = Completer();
              final RtcEngineEx rtcEngine = createAgoraRtcEngineEx();

              await tester.pumpWidget(FakeCameraRemoteVideoView(
                  rtcEngine: rtcEngine,
                  builder: (context, channelId, localUid, remoteUid) {
                    return AgoraVideoView(
                      controller: VideoViewController.remote(
                        rtcEngine: rtcEngine,
                        useFlutterTexture: true,
                        connection: RtcConnection(
                            channelId: channelId, localUid: localUid),
                        canvas: VideoCanvas(
                          uid: remoteUid,
                          mirrorMode:
                              VideoMirrorModeType.videoMirrorModeEnabled,
                        ),
                      ),
                    );
                  },
                  onFirstFrame: () async {
                    if (!onFrameCompleter.isCompleted) {
                      onFrameCompleter.complete(null);
                    }
                  }));

              await tester.pumpAndSettle(const Duration(seconds: 10));

              await onFrameCompleter.future;
              await waitFrame(tester);

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();

          final screenshotPath = await takeScreenshotAndDelayDispose(
            binding,
            tester,
            'android.agora_video_view_render.texture.remote.with_default_rendermodede.with_videoMirrorModeEnabled',
          );

              await waitDisposed(tester, binding);
            },
          );
        });
      });
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
