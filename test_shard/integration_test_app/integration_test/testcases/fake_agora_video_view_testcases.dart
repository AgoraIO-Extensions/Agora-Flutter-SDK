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
import 'package:agora_rtc_engine/src/impl/platform/io/global_video_view_controller_platform_io.dart';
import 'package:agora_rtc_engine/src/impl/platform/io/native_iris_api_engine_binding_delegate.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

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
        (rtcEngine.globalVideoViewController! as GlobalVideoViewControllerIO)
            .methodChannel, ((message) async {
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
        (rtcEngine.globalVideoViewController! as GlobalVideoViewControllerIO)
            .methodChannel,
        null);
    reset();
  }
}

class FakeMethodChannelController {
  FakeMethodChannelController(this.rtcEngine, this.testDefaultBinaryMessenger) {
    const videoViewControllerChannel =
        MethodChannel('agora_rtc_ng/video_view_controller');
    mockedMethodChannels.add(videoViewControllerChannel);
    testDefaultBinaryMessenger
        .setMockMethodCallHandler(videoViewControllerChannel, ((message) async {
      methodCallQueue.add(message);

      if (message.method == 'createTextureRender') {
        final t = ++textrueId;
        final channelId = 'agora_rtc_engine/texture_render_$t';
        final c = MethodChannel(channelId);
        testDefaultBinaryMessenger.setMockMethodCallHandler(c, (message) async {
          return 0;
        });

        mockedMethodChannels.add(c);
        // Need a delay to ensure the channel `agora_rtc_engine/texture_render_xx` is registered.
        Future.delayed(const Duration(milliseconds: 100), () {
          triggerPlatformMessage(channelId,
              const MethodCall('onSizeChanged', {'width': 50, 'height': 50}));
        });
        return t;
      } else if (message.method == 'destroyTextureRender') {
        return true;
      }

      return 0;
    }));
  }

  final RtcEngine rtcEngine;

  final TestDefaultBinaryMessenger testDefaultBinaryMessenger;

  final List<MethodCall> methodCallQueue = [];

  final List<MethodChannel> mockedMethodChannels = [];

  int textrueId = 0;

  void reset() {
    methodCallQueue.clear();
    textrueId = 0;
  }

  void triggerPlatformMessage(String channelId, MethodCall methodCall) async {
    const StandardMethodCodec codec = StandardMethodCodec();
    final ByteData data = codec.encodeMethodCall(methodCall);
    await testDefaultBinaryMessenger.handlePlatformMessage(
      channelId,
      data,
      (ByteData? data) {},
    );
  }
}

void testCases() {
  group('Test with FakeIrisMethodChannel', () {
    final FakeIrisMethodChannel irisMethodChannel =
        FakeIrisMethodChannel(IrisApiEngineNativeBindingDelegateProvider());
    final RtcEngine rtcEngine =
        RtcEngineImpl.create(irisMethodChannel: irisMethodChannel);

    setUp(() {
      irisMethodChannel.reset();
      irisMethodChannel.config =
          FakeIrisMethodChannelConfig(fakeInvokeMethods: {
        'CreateIrisRtcRendering': CallApiResult(
            data: {'irisRtcRenderingHandle': 100}, irisReturnCode: 0)
      });
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
      },
      skip: !(Platform.isAndroid || Platform.isIOS),
    );

    group(
      'Texture Rendering',
      () {
        testWidgets(
          'Show local AgoraVideoView after RtcEngine.initialize',
          (WidgetTester tester) async {
            late FakeMethodChannelController fakeMethodChannelController;
            fakeMethodChannelController = FakeMethodChannelController(
              rtcEngine,
              tester.binding.defaultBinaryMessenger,
            );

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
                      useFlutterTexture: true,
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

            {
              final createTextureRenderCalls = fakeMethodChannelController
                  .methodCallQueue
                  .where((e) => e.method == 'createTextureRender')
                  .toList();

              final createTextureRenderArg = Map<String, Object>.from(
                  createTextureRenderCalls[0].arguments);

              expect(createTextureRenderArg['uid'] == 0, isTrue);

              int textureId = -1;
              expect(find.byWidgetPredicate((widget) {
                final found = widget is Texture;
                if (found) {
                  textureId = (widget as Texture).textureId;
                }
                return found;
              }), findsOneWidget);
              // The first textureId is 0
              expect(textureId == 0, isTrue);
            }

            fakeMethodChannelController.reset();

            await tester.pumpWidget(Container());
            await tester.pumpAndSettle(const Duration(milliseconds: 5000));

            // Delay 5 seconds to ensure that previous Widget.dipose call completed.
            await Future.delayed(const Duration(seconds: 5));

            {
              final disposeTextureRenderCalls = fakeMethodChannelController
                  .methodCallQueue
                  .where((e) => e.method == 'destroyTextureRender')
                  .toList();

              // texture id
              final disposeTextureRenderTextureId =
                  disposeTextureRenderCalls[0].arguments as int;

              expect(disposeTextureRenderTextureId != -1, isTrue);
            }

            fakeMethodChannelController.dispose();
          },
        );

        testWidgets(
          'Show local AgoraVideoView after udpate the widget multiple times',
          (WidgetTester tester) async {
            final fakeMethodChannelController = FakeMethodChannelController(
              rtcEngine,
              tester.binding.defaultBinaryMessenger,
            );

            Completer<void> videoViewCreatedCompleter = Completer<void>();

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
                      useFlutterTexture: true,
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

            {
              int textureId = -1;
              expect(find.byWidgetPredicate((widget) {
                final found = widget is Texture;
                if (found) {
                  textureId = (widget as Texture).textureId;
                }
                return found;
              }), findsOneWidget);
              // The first textureId is 0
              expect(textureId == 0, isTrue);
            }

            videoViewCreatedCompleter = Completer<void>();
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
                      useFlutterTexture: true,
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

            {
              final createTextureRenderCalls = fakeMethodChannelController
                  .methodCallQueue
                  .where((e) => e.method == 'createTextureRender')
                  .toList();
              expect(createTextureRenderCalls.length == 1, isTrue);

              int textureId = -1;
              expect(find.byWidgetPredicate((widget) {
                final found = widget is Texture;
                if (found) {
                  textureId = (widget as Texture).textureId;
                }
                return found;
              }), findsOneWidget);
              // The first textureId is 0
              expect(textureId == 0, isTrue);
            }

            fakeMethodChannelController.dispose();
          },
        );

        testWidgets(
          'Switch local/remote AgoraVideoView with RtcConnection',
          (WidgetTester tester) async {
            // This case run this following steps:
            // 1. Show a local `AgoraVideoView`.
            // 2. Show local and remote `AgoraVideoView`, this step will trigger the `State.didUpdateWidget`.
            // 3. Switch the local and remote `AgoraVideoView`.

            final fakeMethodChannelController = FakeMethodChannelController(
              rtcEngine,
              tester.binding.defaultBinaryMessenger,
            );

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
                          useFlutterTexture: true,
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

            // Check `GlobalVideoViewController.createTextureRender` calls
            {
              final createTextureRenderCalls = fakeMethodChannelController
                  .methodCallQueue
                  .where((e) => e.method == 'createTextureRender')
                  .toList();

              final createTextureRenderArg = Map<String, Object>.from(
                  createTextureRenderCalls[0].arguments);

              expect(createTextureRenderArg['uid'] == 0, isTrue);
            }

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
                          useFlutterTexture: true,
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
                          useFlutterTexture: true,
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

            // Check `GlobalVideoViewController.createTextureRender` calls for remote `AgoraVideoView`
            {
              final createTextureRenderCalls = fakeMethodChannelController
                  .methodCallQueue
                  .where((e) => e.method == 'createTextureRender')
                  .toList();

              expect(createTextureRenderCalls.length == 2, isTrue);

              final createTextureRenderArg = Map<String, Object>.from(
                  createTextureRenderCalls[1].arguments);

              expect(createTextureRenderArg['uid'] != 0, isTrue);

              {
                List<int> textureIds = [];
                expect(find.byWidgetPredicate((widget) {
                  final found = widget is Texture;
                  if (found) {
                    // textureId = (widget as Texture).textureId;
                    textureIds.add((widget as Texture).textureId);
                  }
                  return found;
                }), findsNWidgets(2));
                // The first textureId is 0
                expect(textureIds[0] == 0, isTrue);
                // The second textureId is 0
                expect(textureIds[1] == 1, isTrue);
              }
            }

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
                          useFlutterTexture: true,
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
                          useFlutterTexture: true,
                        ),
                      ),
                    )
                  ],
                );
              },
            ));

            await tester.pumpAndSettle(const Duration(milliseconds: 5000));

            {
              final createTextureRenderCalls = fakeMethodChannelController
                  .methodCallQueue
                  .where((e) => e.method == 'createTextureRender')
                  .toList();

              // After `didUpdateWidget` called, the texture renderer will be re-created,
              // so there're another 2 times' `createTextureRender` are called.
              // So the value of `createTextureRenderCalls.length` is 4
              expect(createTextureRenderCalls.length == 4, isTrue);

              final createTextureRenderArg = Map<String, Object>.from(
                  createTextureRenderCalls[2].arguments);

              expect(createTextureRenderArg['uid'] != 0, isTrue);

              {
                List<int> textureIds = [];
                expect(find.byWidgetPredicate((widget) {
                  final found = widget is Texture;
                  if (found) {
                    // textureId = (widget as Texture).textureId;
                    textureIds.add((widget as Texture).textureId);
                  }
                  return found;
                }), findsNWidgets(2));
                // The third textureId is 2
                expect(textureIds[0] == 2, isTrue);
                // The fourth textureId is 3
                expect(textureIds[1] == 3, isTrue);
              }
            }

            fakeMethodChannelController.dispose();

            await tester.pumpWidget(Container());
            await tester.pumpAndSettle(const Duration(milliseconds: 5000));
            await Future.delayed(const Duration(seconds: 5));
          },
        );
      },
    );

    testWidgets(
      'dispose AgoraVideoView not crash before setupLocalVideo/setupRemoteVideo[Ex] call is completed',
      (WidgetTester tester) async {
        // This case simulate the `AgoraVideoView` is disposed before setupLocalVideo/setupRemoteVideo[Ex]
        // is completed.

        irisMethodChannel.config = irisMethodChannel.config.copyWith(
          isFakeInitilize: false,
          isFakeInvokeMethod: false,
          isFakeGetNativeHandle: false,
          isFakeAddHotRestartListener: false,
          isFakeRemoveHotRestartListener: false,
          isFakeDispose: false,
          delayInvokeMethod: {
            'RtcEngine_setupLocalVideo': 5000
          }, // delay the `RtcEngine_setupLocalVideo` to 5s, make it complete after `Widget.dispose` more easier
        );

        await tester.pumpWidget(MaterialApp(
          home: Scaffold(
              body: SizedBox(
            height: 100,
            width: 100,
            child: AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: rtcEngine,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
          )),
        ));

        await tester.pumpAndSettle();

        String engineAppId = const String.fromEnvironment('TEST_APP_ID',
            defaultValue: '<YOUR_APP_ID>');

        await rtcEngine.initialize(RtcEngineContext(
          appId: engineAppId,
          areaCode: AreaCode.areaCodeGlob.value(),
        ));

        // The `AgoraVideoView` will call the `RtcEngine.setupLocalVideo` after `RtcEngine.initialize`,
        // pump a `Container` to trigger the `dispose` of `AgoraVideoView`. We have blocked the `RtcEngine.setupLocalVideo`
        // with 5s, the `AgoraVideoView.dipose` should be called before the `RtcEngine.setupLocalVideo`.
        await tester.pumpWidget(Container());
        await tester.pumpAndSettle();
        // pumpAndSettle again to ensure the flutter PlatformView's `dispose` called that inside `AgoraVideoView`
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(seconds: 5));

        expect(find.byType(AgoraVideoView), findsNothing);

        await rtcEngine.release();
      },
      skip: !(Platform.isAndroid || Platform.isIOS),
    );
  });
}
