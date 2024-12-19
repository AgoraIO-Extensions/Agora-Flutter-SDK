// ignore_for_file: avoid_print

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:flutter/material.dart';

class RTCModel {
  static final shard = RTCModel._();
  late final RtcEngine engine;
  late RtcEngineEventHandler? _handler;
  late RtcEngineEventHandler _internal_handler;

  RTCModel._() {
    engine = createAgoraRtcEngine();
  }

  void setHandler(RtcEngineEventHandler handler) {
    _handler = handler;

    _internal_handler = RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        print('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        print('[onJoinChannelSuccess] connection: ${connection.toJson()}');
        _handler?.onJoinChannelSuccess!(connection, elapsed);
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        print(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid');
        _handler?.onUserJoined!(connection, rUid, elapsed);
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        print(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');

        _handler?.onUserOffline!(connection, rUid, reason);
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        print('[onLeaveChannel] connection: ${connection.toJson()}');
        _handler?.onLeaveChannel!(connection, stats);
      },
      onRemoteVideoStateChanged: (RtcConnection connection, int remoteUid,
          RemoteVideoState state, RemoteVideoStateReason reason, int elapsed) {
        print(
            '[onRemoteVideoStateChanged] connection: ${connection.toJson()} remoteUid: $remoteUid state: $state reason: $reason');
        _handler?.onRemoteVideoStateChanged!(
            connection, remoteUid, state, reason, elapsed);
      },
      onPipStateChanged: (state) {
        print('[onPipStateChanged] state: $state');
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
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  PIPVideoViewController? _pipVideoViewController;

  bool _isPipSupported = false;
  bool _hasVideo = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _initEngine();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive) {
      print("应用进入非活动状态");
      // 查看inactive定义，android和ios都会触发inactive，但场景不一样，ios
      // 这里不是全部的场景都允许调用startPictureInPicture，android可以
      // android现在设置autoEnter无效，底层实现没有去设置，所以需要这里主动调用
    } else if (state == AppLifecycleState.paused) {
      print("应用进入后台");

      // 重要, 这里不要调用startPictureInPicture, ios和android系统不允许在后台开启pip, android可以在 inactive 状态下调用
      // 尤其ios不能调用，可能会出触发相关的错误导致pip被reset 应该尽可能的保证pip view创建的足够早，这样在切换到后台时，pip view已经创建好，系统会自动开启pip
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
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {},
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        if (_pipVideoViewController?.canvas.uid == rUid) {
          // flutter会进行状态合并，view可能会被复用，就无法触发onAgoraVideoViewCreated, 但是之前可能在后台已经触发了destroyPip,
          // 所以需要手动调用setupPictureInPicture
          _pipVideoViewController?.setupPictureInPicture(const PipOptions(
              contentWidth: 150, contentHeight: 300, autoEnterPip: true));
          return;
        }

        var newPipVideoViewController = PIPVideoViewController.remote(
          rtcEngine: RTCModel.shard.engine,
          canvas: VideoCanvas(uid: rUid),
          connection: RtcConnection(channelId: config.channelId),
        );

        setState(() {
          _pipVideoViewController = newPipVideoViewController;
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        if (_hasVideo) {
          _pipVideoViewController?.destroyPictureInPicture();

          setState(() {
            _hasVideo = false;
          });
        }
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {},
      onRemoteVideoStateChanged:
          (connection, remoteUid, state, reason, elapsed) {
        var hasVideo = state == RemoteVideoState.remoteVideoStateStarting ||
            state == RemoteVideoState.remoteVideoStateDecoding;
        var hasVideoStateChanged = _hasVideo != hasVideo;

        if (hasVideoStateChanged && !hasVideo) {
          // call stopPictureInPicture to stop pip mode in background will not hide the pip view
          // _pipVideoViewController?.stopPictureInPicture();
          _pipVideoViewController?.destroyPictureInPicture();
        }

        if (hasVideoStateChanged && hasVideo) {
          // call setupPictureInPicture to setup pip view in background will not show the pip view
          // we just want to reset the internal binding of the pip view and the video stream, coz
          // the sdk will not rebind the video stream to the pip view when the internal binding is broken
          // flutter会进行状态合并，view可能会被复用，就无法触发onAgoraVideoViewCreated, 所以需要手动调用setupPictureInPicture
          _pipVideoViewController?.setupPictureInPicture(const PipOptions(
              contentWidth: 150, contentHeight: 300, autoEnterPip: true));
        }

        setState(() {
          _hasVideo = hasVideo;
        });
      },
      onPipStateChanged: (state) {
        if (state == PipState.pipStateFailed) {
          // call setup again will reset the pip state, even you have the same options
          _pipVideoViewController?.setupPictureInPicture(const PipOptions(
              contentWidth: 150, contentHeight: 300, autoEnterPip: true));
        }
      },
    );

    RTCModel.shard.setHandler(_rtcEngineEventHandler);

    await RTCModel.shard.engine.enableVideo();
    var isPipSupported = await RTCModel.shard.engine.isPipSupported();
    setState(() {
      _isPipSupported = isPipSupported;
    });
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
    await _pipVideoViewController?.dispose();

    await RTCModel.shard.engine.leaveChannel();
  }

  Widget _videoViewStack(Size size) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // 因为无法控制AgoraVideoView的创建时机，以及因为中间状态的合并
        // 要尽可能早的创建AgoraVideoView获取native view实例，并且尽可能的复用
        if (_hasVideo && _pipVideoViewController != null)
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
    if (_isPipSupported == false) {
      return const Center(
        child: Text('The picture-in-picture is not supported on this device.'),
      );
    }
    final size = MediaQuery.sizeOf(context);

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
