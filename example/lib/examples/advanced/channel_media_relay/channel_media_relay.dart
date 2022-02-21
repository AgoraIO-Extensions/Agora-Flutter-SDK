import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// ChannelMediaRelay Example
class ChannelMediaRelay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ChannelMediaRelay> {
  late final RtcEngine _engine;
  bool isJoined = false;
  int? remoteUid;
  bool isRelaying = false;
  late final TextEditingController _channelMediaRelayController;
  late final TextEditingController _channelController;

  @override
  void initState() {
    _channelMediaRelayController = TextEditingController();
    _channelController = TextEditingController(text: config.channelId);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    this._addListener();

    // enable video module and set up video encoding configs
    await _engine.enableVideo();

    // make this room live broadcasting room
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);

    // start joining channel
    // 1. Users can only see each other after they join the
    // same channel successfully using the same app id.
    // 2. If app certificate is turned on at dashboard, token is needed
    // when joining channel. The channel name and uid used to calculate
    // the token has to match the ones used for channel join
    await _engine.joinChannel(
        config.token, _channelController.text, null, 0, null);
  }

  _addListener() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning ${warningCode}');
      },
      error: (errorCode) {
        logSink.log('error ${errorCode}');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        logSink.log('userJoined $uid $elapsed');
        this.setState(() {
          remoteUid = uid;
        });
      },
      userOffline: (uid, reason) {
        logSink.log('userOffline $uid $reason');
        this.setState(() {
          remoteUid = null;
        });
      },
      channelMediaRelayStateChanged:
          (ChannelMediaRelayState state, ChannelMediaRelayError code) {
        switch (state) {
          case ChannelMediaRelayState.Idle:
            logSink.log('ChannelMediaRelayState.Idle $code');
            this.setState(() {
              isRelaying = false;
            });
            break;
          case ChannelMediaRelayState.Connecting:
            logSink.log('ChannelMediaRelayState.Connecting $code)');
            break;
          case ChannelMediaRelayState.Running:
            logSink.log('ChannelMediaRelayState.Running $code)');
            this.setState(() {
              isRelaying = true;
            });
            break;
          case ChannelMediaRelayState.Failure:
            logSink.log('ChannelMediaRelayState.Failure $code)');
            this.setState(() {
              isRelaying = false;
            });
            break;
          default:
            logSink.log('default $code)');
            break;
        }
      },
    ));
  }

  _onPressRelayOrStop() async {
    if (isRelaying) {
      await _engine.stopChannelMediaRelay();
      return;
    }
    if (_channelMediaRelayController.text.length == 0) {
      return;
    }

    await _engine.startChannelMediaRelay(ChannelMediaRelayConfiguration(
        ChannelMediaInfo(_channelController.text, 0, token: config.token),
        [ChannelMediaInfo(_channelMediaRelayController.text, 0, token: '')]));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            !isJoined
                ? Column(
                    children: [
                      TextField(
                        controller: _channelController,
                        readOnly: isJoined,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              onPressed: _initEngine,
                              child: Text('Join channel'),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                : _renderVideo(),
            if (isJoined)
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: TextField(
                          controller: _channelMediaRelayController,
                          decoration: InputDecoration(
                            hintText: 'Enter target relay channel name',
                          ))),
                  ElevatedButton(
                    onPressed: _onPressRelayOrStop,
                    child: Text(!isRelaying ? 'Relay' : 'Stop'),
                  ),
                ],
              )
          ],
        ),
      ],
    );
  }

  _renderVideo() {
    return Row(children: [
      Expanded(
        child: AspectRatio(
          aspectRatio: 1,
          child:
              kIsWeb ? RtcLocalView.SurfaceView() : RtcLocalView.TextureView(),
        ),
      ),
      Expanded(
        child: AspectRatio(
          aspectRatio: 1,
          child: remoteUid != null
              ? (kIsWeb
                  ? RtcRemoteView.SurfaceView(
                      uid: remoteUid!,
                      channelId: _channelController.text,
                    )
                  : RtcRemoteView.TextureView(
                      uid: remoteUid!,
                      channelId: _channelController.text,
                    ))
              : Container(
                  color: Colors.grey[200],
                ),
        ),
      )
    ]);
  }
}
