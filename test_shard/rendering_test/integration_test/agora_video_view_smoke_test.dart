import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'common/fake_camera_local_video_view.dart';
import 'common/fake_camera_remote_video_view.dart';
import 'common/screenshot_matcher_ext.dart';
import 'common/widget_tester_ext.dart';

const bool _useIosSimulatorScreenshot =
    bool.fromEnvironment('IOS_SIMULATOR_SCREENSHOT');
const String _webRenderingCase = String.fromEnvironment('WEB_RENDERING_CASE');
const String _iosSimulatorScreenshotReadyFile = 'agora-ios-screenshot-ready';
const String _iosSimulatorScreenshotDoneFile = 'agora-ios-screenshot-done';
const String _iosSimulatorTestCompleteFile = 'agora-ios-test-complete';
const String _iosSimulatorDriverDoneFile = 'agora-ios-driver-done';

Future<void> _waitForIosSimulatorScreenshot() async {
  final ready =
      File('${Directory.systemTemp.path}/$_iosSimulatorScreenshotReadyFile');
  final done =
      File('${Directory.systemTemp.path}/$_iosSimulatorScreenshotDoneFile');
  if (done.existsSync()) {
    done.deleteSync();
  }
  ready.writeAsStringSync('ready');

  final deadline = DateTime.now().add(const Duration(minutes: 5));
  try {
    while (!done.existsSync()) {
      if (DateTime.now().isAfter(deadline)) {
        throw TimeoutException(
            'Timed out waiting for the simulator screenshot');
      }
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  } finally {
    if (ready.existsSync()) {
      ready.deleteSync();
    }
    if (done.existsSync()) {
      done.deleteSync();
    }
  }
}

Future<void> _reportIosSimulatorTestComplete() async {
  final complete =
      File('${Directory.systemTemp.path}/$_iosSimulatorTestCompleteFile');
  final driverDone =
      File('${Directory.systemTemp.path}/$_iosSimulatorDriverDoneFile');
  complete.writeAsStringSync('passed');

  final deadline = DateTime.now().add(const Duration(minutes: 5));
  try {
    while (!driverDone.existsSync()) {
      if (DateTime.now().isAfter(deadline)) {
        throw TimeoutException('Timed out waiting for the simulator driver');
      }
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
  } finally {
    if (complete.existsSync()) {
      complete.deleteSync();
    }
    if (driverDone.existsSync()) {
      driverDone.deleteSync();
    }
  }
}

void main() {
  if (_useIosSimulatorScreenshot) {
    for (final name in <String>[
      _iosSimulatorScreenshotReadyFile,
      _iosSimulatorScreenshotDoneFile,
      _iosSimulatorTestCompleteFile,
      _iosSimulatorDriverDoneFile,
    ]) {
      final marker = File('${Directory.systemTemp.path}/$name');
      if (marker.existsSync()) {
        marker.deleteSync();
      }
    }
  }

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

            if (_useIosSimulatorScreenshot) {
              await _waitForIosSimulatorScreenshot();
            } else {
              await binding.takeScreenshot(
                  'ios.agora_video_view.platform_view.smoke_test.start_preview_after_enable_video');
            }

            if (_useIosSimulatorScreenshot) {
              await _reportIosSimulatorTestComplete();
            }
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
    skip: kIsWeb || !Platform.isIOS,
  );

  group(
    'AgoraVideoView Android',
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

            // This is required prior to taking the screenshot (Android only).
            await binding.convertFlutterSurfaceToImage();
            // Trigger a frame.
            await tester.pumpAndSettle();
            await binding.takeScreenshot(
                'android.agora_video_view.platform_view.smoke_test.start_preview_after_enable_video');

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

              // This is required prior to taking the screenshot (Android only).
              await binding.convertFlutterSurfaceToImage();
              // Trigger a frame.
              await tester.pumpAndSettle();
              await binding.takeScreenshot(
                  'android.agora_video_view.flutter_texture.smoke_test.start_preview_after_enable_video');

              await waitDisposed(tester, binding);
            },
          );
        },
      );
    },
    skip: kIsWeb || !Platform.isAndroid,
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

  group(
    'AgoraVideoView Web',
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
                'web.agora_video_view.platform_view.smoke_test.start_preview_after_enable_video');

            await waitDisposed(tester, binding);
          },
          skip: !kIsWeb ||
              (_webRenderingCase.isNotEmpty && _webRenderingCase != 'local'),
        );

        testWidgets(
          'can show remote preview',
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

            await binding.takeScreenshot(
                'web.agora_video_view.platform_view.smoke_test.show_remote_preview');

            await waitDisposed(tester, binding);
          },
          skip: !kIsWeb ||
              (_webRenderingCase.isNotEmpty && _webRenderingCase != 'remote'),
        );
      });
    },
    skip: !kIsWeb,
  );
}
