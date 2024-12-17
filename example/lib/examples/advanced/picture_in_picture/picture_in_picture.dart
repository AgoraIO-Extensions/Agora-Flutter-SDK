import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RTCModel {
  static final shard = RTCModel._();
  late final RtcEngine engine;
  late final RtcEngineEventHandler? _handler;
  late final RtcEngineEventHandler _internal_handler;

  RTCModel._() {
    engine = createAgoraRtcEngine();
  }

  void setHandler(RtcEngineEventHandler handler) {
    _handler = handler;

    _internal_handler = RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        print('[onError] err: $err, msg: $msg');
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print('[onJoinChannelSuccess] connection: ${connection.toJson()}');
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        _handler?.onJoinChannelSuccess!(connection, elapsed);
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        print(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid');
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
        _handler?.onUserJoined!(connection, rUid, elapsed);
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');

        _handler?.onUserOffline!(connection, rUid, reason);
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        print('[onLeaveChannel] connection: ${connection.toJson()}');
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        _handler?.onLeaveChannel!(connection, stats);
      },
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
          RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
        print(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason');
        logSink.log(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason elapsed: $elapsed');
        _handler?.onRemoteVideoStateChanged!(
            connection, remoteUid, state, reason, elapsed);
      },
      onPipStateChanged: (state) {
        print('[onPipStateChanged] state: $state');
        logSink.log('[onPipStateChanged] state: $state');
        _handler?.onPipStateChanged!(state);
      },
    );
    engine.registerEventHandler(_internal_handler);
  }

  void unsetHandler() {
    _handler = null;
  }
}

///=============================================
/// PictureInPicture Example
class PictureInPicture extends StatefulWidget {
  /// Construct the [PictureInPicture]
  const PictureInPicture({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PictureInPicture> with WidgetsBindingObserver {
  bool isJoined = false;

  late final RtcEngineEventHandler _rtcEngineEventHandler;

  PIPVideoViewController? _pipVideoViewController = null;

  bool _isInPipMode = false;
  bool? _isPipSupported;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _initEngine();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print("应用进入后台");

      // 重要, 这里不要调用，
      // 系统不允许在后台开启pip，不能调用，可能会出触发相关的错误导致pip被reset
      // 应该尽可能的保证pip view创建的足够早，这样在切换到后台时，pip view已经创建好，系统会自动开启pip
      // await _pipVideoViewController?.startPictureInPicture();
    } else if (state == AppLifecycleState.resumed) {
      print("应用从后台返回前台");
      await _pipVideoViewController?.stopPictureInPicture();
    }
  }

  @override
  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future<void> _initEngine() async {
    await RTCModel.shard.engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    _rtcEngineEventHandler = RtcEngineEventHandler(
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        setState(() {
          isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        setState(() {
          if (_pipVideoViewController?.canvas.uid == rUid) {
            return;
          }

          _pipVideoViewController = PIPVideoViewController.remote(
            rtcEngine: RTCModel.shard.engine,
            canvas: VideoCanvas(uid: rUid),
            connection: RtcConnection(channelId: config.channelId),
          );
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        setState(() {
          if (_pipVideoViewController?.canvas.uid == rUid) {
            _pipVideoViewController = null;
          }
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        setState(() async {
          isJoined = false;
        });
      },
      onRemoteVideoStateChanged:
          (connection, remoteUid, state, reason, elapsed) {
        if (state == RemoteVideoState.remoteVideoStateStopped) {
          setState(() {
            if (_pipVideoViewController?.canvas.uid == remoteUid) {
              _pipVideoViewController?.dispose();
              _pipVideoViewController = null;
            }
          });
        } else if (state == RemoteVideoState.remoteVideoStateStarting) {
          setState(() {
            if (_pipVideoViewController != null) {
              return;
            }

            _pipVideoViewController = PIPVideoViewController.remote(
              rtcEngine: RTCModel.shard.engine,
              canvas: VideoCanvas(uid: remoteUid),
              connection: RtcConnection(channelId: config.channelId),
            );
          });
        }
      },
      onPipStateChanged: (state) {
        setState(() async {
          _isInPipMode = state == PipState.pipStateStarted;
          if (state == PipState.pipStateFailed) {
            // destroy the pip state
            await _pipVideoViewController?.destroyPictureInPicture();
            // reset the pip state
            await _pipVideoViewController?.setupPictureInPicture(
                const PipOptions(
                    contentWidth: 150, contentHeight: 300, autoEnterPip: true));
          }
        });
      },
    );

    RTCModel.shard.setHandler(_rtcEngineEventHandler);

    await RTCModel.shard.engine.enableVideo();
    _isPipSupported = await RTCModel.shard.engine.isPipSupported();
    setState(() {});
  }

  Future<void> _joinChannel() async {
    await RTCModel.shard.engine.joinChannel(
      token: config.token,
      channelId: config.channelId,
      uid: config.uid,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    setState(() {
      _pipVideoViewController?.dispose();
      _pipVideoViewController = null;
    });

    await RTCModel.shard.engine.leaveChannel();

    RTCModel.shard.unsetHandler();

    Navigator.maybePop(context);
  }

  Widget _videoViewStack(Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (_pipVideoViewController != null)
          SizedBox(
            width: size.width,
            height: size.height,
            child: AgoraVideoView(
              controller: _pipVideoViewController!,
              onAgoraVideoViewCreated: (viewId) async {
                // autoEnterPip 很重要
                // 如果希望是通过进入后台开启，务必设置为true, 因为flutter后台事件和对sdk的调用是异步的，调用时机不可靠的，这时候如果通过startPip接口调用有概率失败，所以需要设置为true
                // 当然失败的话会有回调，但苹果不允许已经进入后台的应用再调用startPip，所以失败后不回到前台无法再次开启
                //
                // 如果希望完全手动控制，比如应用内的页面切换时显示pip窗口，那么可以设置true也可以设置false，这时候可以通过startPip手动开启
                await _pipVideoViewController?.setupPictureInPicture(
                    const PipOptions(
                        contentWidth: 150,
                        contentHeight: 300,
                        autoEnterPip: true));
              },
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isPipSupported == null) {
      return Container();
    }

    if (_isPipSupported == false) {
      return const Center(
        child: Text('The picture-in-picture is not supported on this device.'),
      );
    }
    final size = MediaQuery.sizeOf(context);

    // We only need to adjust the UI on Android in pip mode.
    if (_isInPipMode &&
        (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)) {
      return _videoViewStack(size);
    }

    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        return Container(
          width: size.width,
          height: size.height,
          alignment: Alignment.center,
          child: _videoViewStack(size),
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _joinChannel,
                    child: Text('Join channel'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _leaveChannel,
                    child: Text('Leave channel'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
