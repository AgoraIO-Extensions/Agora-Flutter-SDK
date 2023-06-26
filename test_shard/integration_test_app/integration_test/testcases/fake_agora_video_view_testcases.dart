import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';
import '../fake/fake_iris_method_channel.dart';

class _RenderViewWidget extends StatefulWidget {
  const _RenderViewWidget({
    Key? key,
    required this.builder,
    required this.rtcEngine,
    this.onRtcEngineInitialized,
  }) : super(key: key);

  final Function(BuildContext context, RtcEngine engine) builder;

  final RtcEngine rtcEngine;

  final VoidCallback? onRtcEngineInitialized;

  @override
  State<_RenderViewWidget> createState() => _RenderViewWidgetState();
}

class _RenderViewWidgetState extends State<_RenderViewWidget> {
  late final RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    String engineAppId = const String.fromEnvironment('TEST_APP_ID',
        defaultValue: '<YOUR_APP_ID>');

    _engine = widget.rtcEngine;
    await _engine.initialize(RtcEngineContext(
      appId: engineAppId,
      areaCode: AreaCode.areaCodeGlob.value(),
    ));

    widget.onRtcEngineInitialized?.call();

    try {
      await _engine.enableVideo();
      await _engine.startPreview();
    } catch (e) {}

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: widget.builder(context, _engine),
      ),
    );
  }
}

class FakeGlobalVideoViewController {
  FakeGlobalVideoViewController(
      this.rtcEngine, this.testDefaultBinaryMessenger) {
    testDefaultBinaryMessenger.setMockMethodCallHandler(
        rtcEngine.globalVideoViewController.methodChannel, ((message) async {
      methodCallQueue.add(message);

      if (message.method == 'createTextureRender') {
        return 1000;
      }

      return 0;
    }));
  }

  final RtcEngine rtcEngine;

  final TestDefaultBinaryMessenger testDefaultBinaryMessenger;

  final List<MethodCall> methodCallQueue = [];

  void reset() {
    methodCallQueue.clear();
  }

  void dispose() {
    testDefaultBinaryMessenger.setMockMethodCallHandler(
        rtcEngine.globalVideoViewController.methodChannel, null);
    reset();
  }
}

void testCases() {
  group('Test with FakeIrisMethodChannel', () {
    final FakeIrisMethodChannel irisMethodChannel = FakeIrisMethodChannel();
    final RtcEngine rtcEngine =
        RtcEngineImpl.create(irisMethodChannel: irisMethodChannel);

    setUp(() {
      irisMethodChannel.reset();
    });

    group(
      'PlatformView rendering',
      () {
        testWidgets(
          'Show local AgoraVideoView after RtcEngine.initialize',
          (WidgetTester tester) async {
            final videoViewCreatedCompleter = Completer<void>();

            await tester.pumpWidget(_RenderViewWidget(
              rtcEngine: rtcEngine,
              builder: (context, engine) {
                return SizedBox(
                  height: 100,
                  width: 100,
                  child: AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                    onAgoraVideoViewCreated: (viewId) {
                      if (!videoViewCreatedCompleter.isCompleted) {
                        videoViewCreatedCompleter.complete(null);
                      }
                    },
                  ),
                );
              },
            ));

            await tester.pumpAndSettle(const Duration(milliseconds: 5000));
            // pumpAndSettle again to ensure the `AgoraVideoView` shown
            await tester.pumpAndSettle(const Duration(milliseconds: 5000));

            await videoViewCreatedCompleter.future;

            final setupLocalVideoCalls = irisMethodChannel.methodCallQueue
                .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
                .toList();

            final jsonMap2 = jsonDecode(setupLocalVideoCalls[0].params);
            expect(jsonMap2['canvas']['view'] != 0, isTrue);

            await tester.pumpWidget(Container());
            await tester.pumpAndSettle(const Duration(milliseconds: 5000));

            // Delay 5 seconds to ensure that previous Widget.dipose call completed.
            await Future.delayed(const Duration(seconds: 5));

            expect(find.byType(AgoraVideoView), findsNothing);

            // Check `VideoViewControllerBaseMixin`'s `disposeRender` called
            final disposeLocalVideoCalls = irisMethodChannel.methodCallQueue
                .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
                .toList();

            final disposeLocalVideoCallsJsonMap =
                jsonDecode(disposeLocalVideoCalls[1].params);
            expect(
                disposeLocalVideoCallsJsonMap['canvas']['view'] == 0, isTrue);
          },
        );

        testWidgets(
          'Show/Dispose local AgoraVideoView multiple times with a reused VideoViewController',
          (WidgetTester tester) async {
            VideoViewController videoViewController = VideoViewController(
              rtcEngine: rtcEngine,
              canvas: const VideoCanvas(uid: 0),
            );

            for (int i = 0; i < 5; i++) {
              irisMethodChannel.reset();
              expect(irisMethodChannel.methodCallQueue.isEmpty, isTrue);

              final videoViewCreatedCompleter = Completer<void>();

              await tester.pumpWidget(_RenderViewWidget(
                rtcEngine: rtcEngine,
                builder: (context, engine) {
                  return SizedBox(
                    height: 100,
                    width: 100,
                    child: AgoraVideoView(
                      controller: videoViewController,
                      onAgoraVideoViewCreated: (viewId) {
                        if (!videoViewCreatedCompleter.isCompleted) {
                          videoViewCreatedCompleter.complete(null);
                        }
                      },
                    ),
                  );
                },
              ));

              await tester.pumpAndSettle(const Duration(milliseconds: 5000));
              // pumpAndSettle again to ensure the `AgoraVideoView` shown
              await tester.pumpAndSettle(const Duration(milliseconds: 5000));

              await videoViewCreatedCompleter.future;

              final setupLocalVideoCalls = irisMethodChannel.methodCallQueue
                  .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
                  .toList();

              final jsonMap2 = jsonDecode(setupLocalVideoCalls[0].params);
              expect(jsonMap2['canvas']['view'] != 0, isTrue);

              await tester.pumpWidget(Container());
              await tester.pumpAndSettle(const Duration(milliseconds: 5000));

              // Delay 5 seconds to ensure that previous Widget.dipose call completed.
              await Future.delayed(const Duration(seconds: 5));

              expect(find.byType(AgoraVideoView), findsNothing);

              // Check `VideoViewControllerBaseMixin`'s `disposeRender` called
              final disposeLocalVideoCalls = irisMethodChannel.methodCallQueue
                  .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
                  .toList();

              final disposeLocalVideoCallsJsonMap =
                  jsonDecode(disposeLocalVideoCalls[1].params);
              expect(
                  disposeLocalVideoCallsJsonMap['canvas']['view'] == 0, isTrue);
            }
          },
        );

        testWidgets(
          'Switch local/remote AgoraVideoView with RtcConnection',
          (WidgetTester tester) async {
            // This case run this following steps:
            // 1. Show a local `AgoraVideoView`.
            // 2. Show local and remote `AgoraVideoView`, this step will trigger the `State.didUpdateWidget`.
            // 3. Switch the local and remote `AgoraVideoView`.

            await tester.pumpWidget(_RenderViewWidget(
              rtcEngine: rtcEngine,
              builder: (context, engine) {
                return Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      ),
                    )
                  ],
                );
              },
            ));

            await tester.pumpAndSettle(const Duration(milliseconds: 5000));
            // pumpAndSettle again to ensure the `AgoraVideoView` shown
            await tester.pumpAndSettle(const Duration(milliseconds: 5000));

            // Check `setupLocalVideo` calls
            {
              final setupLocalVideoCalls = irisMethodChannel.methodCallQueue
                  .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
                  .toList();

              final jsonMap2 = jsonDecode(setupLocalVideoCalls[0].params);
              expect(jsonMap2['canvas']['view'] != 0, isTrue);
            }

            // Clear the methodCall records
            irisMethodChannel.reset();

            // This step will call `didUpdateWidget`
            await tester.pumpWidget(_RenderViewWidget(
              rtcEngine: rtcEngine,
              builder: (context, engine) {
                return Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: engine,
                          canvas: const VideoCanvas(uid: 1000),
                          connection: const RtcConnection(
                            channelId: 'switch_video_view',
                            localUid: 1000,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ));

            await tester.pumpAndSettle(const Duration(milliseconds: 5000));
            // pumpAndSettle again to ensure the `AgoraVideoView` shown
            await tester.pumpAndSettle(const Duration(milliseconds: 5000));

            if (defaultTargetPlatform == TargetPlatform.android) {
              expect(find.byType(AndroidView), findsNWidgets(2));
            }

            if (defaultTargetPlatform == TargetPlatform.iOS) {
              expect(find.byType(UiKitView), findsNWidgets(2));
            }

            // Check `setupRemoteVideoEx` calls
            {
              final setupRemoteVideoExCalls = irisMethodChannel.methodCallQueue
                  .where((e) => e.funcName == 'RtcEngineEx_setupRemoteVideoEx')
                  .toList();

              final jsonMap1 = jsonDecode(setupRemoteVideoExCalls[0].params);
              expect(jsonMap1['canvas']['view'] != 0, isTrue);
            }

            // Clear the methodCall records
            irisMethodChannel.reset();

            await tester.pumpWidget(_RenderViewWidget(
              rtcEngine: rtcEngine,
              builder: (context, engine) {
                return Column(
                  children: [
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: engine,
                          canvas: const VideoCanvas(uid: 1000),
                          connection: const RtcConnection(
                            channelId: 'switch_video_view',
                            localUid: 1000,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      ),
                    )
                  ],
                );
              },
            ));

            await tester.pumpAndSettle(const Duration(milliseconds: 5000));
            if (defaultTargetPlatform == TargetPlatform.android) {
              expect(find.byType(AndroidView), findsNWidgets(2));
            }
            if (defaultTargetPlatform == TargetPlatform.iOS) {
              expect(find.byType(UiKitView), findsNWidgets(2));
            }

            // Check `setupLocalVideo` calls
            {
              final setupLocalVideoCalls = irisMethodChannel.methodCallQueue
                  .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
                  .toList();

              final jsonMap1 = jsonDecode(setupLocalVideoCalls[0].params);
              expect(jsonMap1['canvas']['view'] == 0, isTrue);

              final jsonMap2 = jsonDecode(setupLocalVideoCalls[1].params);
              expect(jsonMap2['canvas']['view'] != 0, isTrue);
            }

            // Check `setupRemoteVideoEx` calls
            {
              final setupRemoteVideoExCalls = irisMethodChannel.methodCallQueue
                  .where((e) => e.funcName == 'RtcEngineEx_setupRemoteVideoEx')
                  .toList();

              final jsonMap1 = jsonDecode(setupRemoteVideoExCalls[0].params);
              expect(jsonMap1['canvas']['view'] == 0, isTrue);

              final jsonMap2 = jsonDecode(setupRemoteVideoExCalls[1].params);
              expect(jsonMap2['canvas']['view'] != 0, isTrue);
            }

            await tester.pumpWidget(Container());
            await tester.pumpAndSettle(const Duration(milliseconds: 5000));
            await Future.delayed(const Duration(seconds: 5));
          },
        );
        expect(find.byType(AgoraVideoView), findsNothing);

        // Check `VideoViewControllerBaseMixin`'s `disposeRender` called
        final disposeLocalVideoCalls = irisMethodChannel.methodCallQueue
            .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
            .toList();

        final disposeLocalVideoCallsJsonMap =
            jsonDecode(disposeLocalVideoCalls[1].params);
        expect(disposeLocalVideoCallsJsonMap['canvas']['view'] == 0, isTrue);
      },
      skip: !(Platform.isAndroid || Platform.isIOS),
    );

    testWidgets(
      'Show/Dispose local AgoraVideoView multiple times with a reused VideoViewController',
      (WidgetTester tester) async {
        VideoViewController videoViewController = VideoViewController(
          rtcEngine: rtcEngine,
          canvas: const VideoCanvas(uid: 0),
        );

        for (int i = 0; i < 5; i++) {
          irisMethodChannel.reset();
          expect(irisMethodChannel.methodCallQueue.isEmpty, isTrue);

          final videoViewCreatedCompleter = Completer<void>();

          await tester.pumpWidget(_RenderViewWidget(
            rtcEngine: rtcEngine,
            builder: (context, engine) {
              return SizedBox(
                height: 100,
                width: 100,
                child: AgoraVideoView(
                  controller: videoViewController,
                  onAgoraVideoViewCreated: (viewId) {
                    if (!videoViewCreatedCompleter.isCompleted) {
                      videoViewCreatedCompleter.complete(null);
                    }
                  },
                ),
              );
            },
          ));

          await tester.pumpAndSettle(const Duration(milliseconds: 5000));
          // pumpAndSettle again to ensure the `AgoraVideoView` shown
          await tester.pumpAndSettle(const Duration(milliseconds: 5000));

          await videoViewCreatedCompleter.future;

          final setupLocalVideoCalls = irisMethodChannel.methodCallQueue
              .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
              .toList();

          final jsonMap2 = jsonDecode(setupLocalVideoCalls[0].params);
          expect(jsonMap2['canvas']['view'] != 0, isTrue);

          await tester.pumpWidget(Container());
          await tester.pumpAndSettle(const Duration(milliseconds: 5000));

          // Delay 5 seconds to ensure that previous Widget.dipose call completed.
          await Future.delayed(const Duration(seconds: 5));

          expect(find.byType(AgoraVideoView), findsNothing);

          // Check `VideoViewControllerBaseMixin`'s `disposeRender` called
          final disposeLocalVideoCalls = irisMethodChannel.methodCallQueue
              .where((e) => e.funcName == 'RtcEngine_setupLocalVideo')
              .toList();

          final disposeLocalVideoCallsJsonMap =
              jsonDecode(disposeLocalVideoCalls[1].params);
          expect(disposeLocalVideoCallsJsonMap['canvas']['view'] == 0, isTrue);
        }
      },
      skip: !(Platform.isAndroid || Platform.isIOS),
    );

    // TODO(littlegnal): The texture rendering test case are crash, since it need to call the 
    // real `IrisMethodChannel` implementation, but not just implement a fake `GlobalVideoViewController`. 
    // Need figure it out how to re-enable these test cases it the future.
    //
    // group(
    //   'Texture Rendering',
    //   () {
    //     testWidgets(
    //       'Show local AgoraVideoView after RtcEngine.initialize',
    //       (WidgetTester tester) async {
    //         late FakeGlobalVideoViewController fakeGlobalVideoViewController;

    //         final videoViewCreatedCompleter = Completer<void>();

    //         print('1111');

    //         await tester.pumpWidget(_RenderViewWidget(
    //           rtcEngine: rtcEngine,
    //           onRtcEngineInitialized: () {
    //             fakeGlobalVideoViewController = FakeGlobalVideoViewController(
    //               rtcEngine,
    //               tester.binding.defaultBinaryMessenger,
    //             );
    //           },
    //           builder: (context, engine) {
    //             return SizedBox(
    //               height: 100,
    //               width: 100,
    //               child: AgoraVideoView(
    //                 controller: VideoViewController(
    //                   rtcEngine: engine,
    //                   canvas: const VideoCanvas(uid: 0),
    //                   useFlutterTexture: true,
    //                 ),
    //                 onAgoraVideoViewCreated: (viewId) {
    //                   if (!videoViewCreatedCompleter.isCompleted) {
    //                     videoViewCreatedCompleter.complete(null);
    //                   }
    //                 },
    //               ),
    //             );
    //           },
    //         ));

    //         await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    //         // pumpAndSettle again to ensure the `AgoraVideoView` shown
    //         await tester.pumpAndSettle(const Duration(milliseconds: 5000));

    //         await videoViewCreatedCompleter.future;

    //         print('videoViewCreatedCompleter.future completed');

    //         {
    //           final createTextureRenderCalls = fakeGlobalVideoViewController
    //               .methodCallQueue
    //               .where((e) => e.method == 'createTextureRender')
    //               .toList();

    //           final createTextureRenderArg = Map<String, Object>.from(
    //               createTextureRenderCalls[0].arguments);

    //           expect(createTextureRenderArg['uid'] == 0, isTrue);
    //         }

    //         fakeGlobalVideoViewController.reset();

    //         await tester.pumpWidget(Container());
    //         await tester.pumpAndSettle(const Duration(milliseconds: 5000));

    //         // Delay 5 seconds to ensure that previous Widget.dipose call completed.
    //         await Future.delayed(const Duration(seconds: 5));

    //         {
    //           final disposeTextureRenderCalls = fakeGlobalVideoViewController
    //               .methodCallQueue
    //               .where((e) => e.method == 'destroyTextureRender')
    //               .toList();

    //           // texture id
    //           final disposeTextureRenderTextureId =
    //               disposeTextureRenderCalls[0].arguments as int;

    //           expect(disposeTextureRenderTextureId != 0, isTrue);
    //         }

    //         fakeGlobalVideoViewController.dispose();
    //       },
    //     );

    //     testWidgets(
    //       'Switch local/remote AgoraVideoView with RtcConnection',
    //       (WidgetTester tester) async {
    //         // This case run this following steps:
    //         // 1. Show a local `AgoraVideoView`.
    //         // 2. Show local and remote `AgoraVideoView`, this step will trigger the `State.didUpdateWidget`.
    //         // 3. Switch the local and remote `AgoraVideoView`.

    //         late FakeGlobalVideoViewController fakeGlobalVideoViewController;

    //         await tester.pumpWidget(_RenderViewWidget(
    //           rtcEngine: rtcEngine,
    //           onRtcEngineInitialized: () {
    //             fakeGlobalVideoViewController = FakeGlobalVideoViewController(
    //               rtcEngine,
    //               tester.binding.defaultBinaryMessenger,
    //             );
    //           },
    //           builder: (context, engine) {
    //             return Column(
    //               children: [
    //                 SizedBox(
    //                   height: 100,
    //                   width: 100,
    //                   child: AgoraVideoView(
    //                     controller: VideoViewController(
    //                       rtcEngine: engine,
    //                       canvas: const VideoCanvas(uid: 0),
    //                       useFlutterTexture: true,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             );
    //           },
    //         ));

    //         await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    //         // pumpAndSettle again to ensure the `AgoraVideoView` shown
    //         await tester.pumpAndSettle(const Duration(milliseconds: 5000));

    //         // Check `GlobalVideoViewController.createTextureRender` calls
    //         {
    //           final createTextureRenderCalls = fakeGlobalVideoViewController
    //               .methodCallQueue
    //               .where((e) => e.method == 'createTextureRender')
    //               .toList();

    //           final createTextureRenderArg = Map<String, Object>.from(
    //               createTextureRenderCalls[0].arguments);

    //           expect(createTextureRenderArg['uid'] == 0, isTrue);
    //         }

    //         // Clear the methodCall records
    //         fakeGlobalVideoViewController.reset();

    //         // This step will call `didUpdateWidget`
    //         await tester.pumpWidget(_RenderViewWidget(
    //           rtcEngine: rtcEngine,
    //           builder: (context, engine) {
    //             return Column(
    //               children: [
    //                 SizedBox(
    //                   height: 100,
    //                   width: 100,
    //                   child: AgoraVideoView(
    //                     controller: VideoViewController(
    //                       rtcEngine: engine,
    //                       canvas: const VideoCanvas(uid: 0),
    //                       useFlutterTexture: true,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 100,
    //                   width: 100,
    //                   child: AgoraVideoView(
    //                     controller: VideoViewController.remote(
    //                       rtcEngine: engine,
    //                       canvas: const VideoCanvas(uid: 1000),
    //                       connection: const RtcConnection(
    //                         channelId: 'switch_video_view',
    //                         localUid: 1000,
    //                       ),
    //                       useFlutterTexture: true,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             );
    //           },
    //         ));

    //         await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    //         // pumpAndSettle again to ensure the `AgoraVideoView` shown
    //         await tester.pumpAndSettle(const Duration(milliseconds: 5000));

    //         // Check `GlobalVideoViewController.createTextureRender` calls for remote `AgoraVideoView`
    //         {
    //           final createTextureRenderCalls = fakeGlobalVideoViewController
    //               .methodCallQueue
    //               .where((e) => e.method == 'createTextureRender')
    //               .toList();

    //           final createTextureRenderArg = Map<String, Object>.from(
    //               createTextureRenderCalls[0].arguments);

    //           expect(createTextureRenderArg['uid'] != 0, isTrue);
    //         }

    //         // Clear the methodCall records
    //         fakeGlobalVideoViewController.reset();

    //         await tester.pumpWidget(_RenderViewWidget(
    //           rtcEngine: rtcEngine,
    //           builder: (context, engine) {
    //             return Column(
    //               children: [
    //                 SizedBox(
    //                   height: 100,
    //                   width: 100,
    //                   child: AgoraVideoView(
    //                     controller: VideoViewController.remote(
    //                       rtcEngine: engine,
    //                       canvas: const VideoCanvas(uid: 1000),
    //                       connection: const RtcConnection(
    //                         channelId: 'switch_video_view',
    //                         localUid: 1000,
    //                       ),
    //                       useFlutterTexture: true,
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 100,
    //                   width: 100,
    //                   child: AgoraVideoView(
    //                     controller: VideoViewController(
    //                       rtcEngine: engine,
    //                       canvas: const VideoCanvas(uid: 0),
    //                       useFlutterTexture: true,
    //                     ),
    //                   ),
    //                 )
    //               ],
    //             );
    //           },
    //         ));

    //         await tester.pumpAndSettle(const Duration(milliseconds: 5000));

    //         // When switch the local and remote `AgoraVideoView`, which will trigger the
    //         // `State.didUpdateWidget`, so there're no method call records here.
    //         expect(
    //             fakeGlobalVideoViewController.methodCallQueue.isEmpty, isTrue);

    //         fakeGlobalVideoViewController.dispose();

    //         await tester.pumpWidget(Container());
    //         await tester.pumpAndSettle(const Duration(milliseconds: 5000));
    //         await Future.delayed(const Duration(seconds: 5));
    //       },
    //     );
    //   },
    //   skip: Platform.isAndroid,
    // );
  });
}
