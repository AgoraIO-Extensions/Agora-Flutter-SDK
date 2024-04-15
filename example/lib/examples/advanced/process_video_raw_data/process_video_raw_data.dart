import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// ProcessVideoRawData Example
///
/// This example demonstrates how to create a `RtcEngine` (Android)/`AgoraRtcEngineKit` (iOS)
/// and share the native handle with the Flutter side. By doing so, the `agora_rtc_engine`
/// acts as a proxy, allowing you to invoke the functions of the `RtcEngine` (Android)/`AgoraRtcEngineKit` (iOS).
///
/// The key point of how to use it:
/// * Initializes the `RtcEngine` (Android)/`AgoraRtcEngineKit` (iOS) on the native side.
/// * Retrieves the native handle through the `RtcEngine.getNativeHandle`(Android)/`AgoraRtcEngineKit.getNativeHandle`(iOS)
///   function on the native side, and passes it to the Flutter side through the Flutter `MethodChannel`.
/// * Passes the native handle to the `createAgoraRtcEngine`(Flutter) on the Flutter side,
///   then the `RtcEngine`(Flutter) can call the functions through the shared native handle.
///
/// This example creates a `RtcEngine` (Android)/`AgoraRtcEngineKit` (iOS) on the native side
/// and registers the video frame observer to modify the video raw data. It makes the local
/// preview appear in gray for demonstration purposes.
///
/// The native side implementation can be found at:
/// - Android: `example/android/app/src/main/kotlin/io/agora/agora_rtc_flutter_example/VideoRawDataController.kt`
/// - iOS: `example/ios/Runner/VideoRawDataController.m`
class ProcessVideoRawData extends StatefulWidget {
  /// Construct the [ProcessVideoRawData]
  const ProcessVideoRawData({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ProcessVideoRawData> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;
  bool _isUseFlutterTexture = false;
  ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;

  final MethodChannel _sharedNativeHandleChannel =
      const MethodChannel('agora_rtc_engine_example/shared_native_handle');

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);

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
    // Destroys the `RtcEngine`(Android)/`AgoraRtcEngineKit`(iOS) on native side.
    // Note that this should be called after the Flutter side `RtcEngine.release` function.
    //
    // See native side implementation:
    // Android: `example/android/app/src/main/kotlin/io/agora/agora_rtc_flutter_example/MainActivity.kt`
    // iOS: `example/ios/Runner/AppDelegate.m`
    await _sharedNativeHandleChannel.invokeMethod('native_dispose');
  }

  Future<void> _initEngine() async {
    // Initializes the `RtcEngine`(Android)/`AgoraRtcEngineKit`(iOS) on native side,
    // and retrieves the native handle of `RtcEngine`(Android)/`AgoraRtcEngineKit`(iOS).
    //
    // See native side implementation:
    // Android: `example/android/app/src/main/kotlin/io/agora/agora_rtc_flutter_example/MainActivity.kt`
    // iOS: `example/ios/Runner/AppDelegate.m`
    final sharedNativeHandle = await _sharedNativeHandleChannel.invokeMethod(
      'native_init',
      {'appId': config.appId},
    );
    // Passes the native handle from `RtcEngine`(Android)/`AgoraRtcEngineKit`(iOS) on native side.
    _engine = createAgoraRtcEngine(sharedNativeHandle: sharedNativeHandle);
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    await _engine.setLogFilter(LogFilterType.logFilterInfo);

    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        setState(() {
          remoteUid.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));

    await _engine.enableVideo();
    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      uid: config.uid,
      options: ChannelMediaOptions(
        channelProfile: _channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Stack(
          children: [
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
                useFlutterTexture: _isUseFlutterTexture,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.of(remoteUid.map(
                    (e) => SizedBox(
                      width: 120,
                      height: 120,
                      child: AgoraVideoView(
                        controller: VideoViewController.remote(
                          rtcEngine: _engine,
                          canvas: VideoCanvas(uid: e),
                          connection:
                              RtcConnection(channelId: _controller.text),
                          useFlutterTexture: _isUseFlutterTexture,
                        ),
                      ),
                    ),
                  )),
                ),
              ),
            )
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        final channelProfileType = [
          ChannelProfileType.channelProfileLiveBroadcasting,
          ChannelProfileType.channelProfileCommunication,
        ];
        final items = channelProfileType
            .map((e) => DropdownMenuItem(
                  child: Text(
                    e.toString().split('.')[1],
                  ),
                  value: e,
                ))
            .toList();

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
            if (!kIsWeb &&
                (defaultTargetPlatform == TargetPlatform.android ||
                    defaultTargetPlatform == TargetPlatform.iOS))
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                      'Rendered by SurfaceView \n(default TextureView): '),
                  Switch(
                    value: _isUseFlutterTexture,
                    onChanged: isJoined
                        ? null
                        : (changed) {
                            setState(() {
                              _isUseFlutterTexture = changed;
                            });
                          },
                  )
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            const Text('Channel Profile: '),
            DropdownButton<ChannelProfileType>(
              items: items,
              value: _channelProfileType,
              onChanged: isJoined
                  ? null
                  : (v) {
                      setState(() {
                        _channelProfileType = v!;
                      });
                    },
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: isJoined ? _leaveChannel : _joinChannel,
                    child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                )
              ],
            ),
            if (defaultTargetPlatform == TargetPlatform.android ||
                defaultTargetPlatform == TargetPlatform.iOS) ...[
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: _switchCamera,
                child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
              ),
            ],
          ],
        );
      },
    );
  }
}
