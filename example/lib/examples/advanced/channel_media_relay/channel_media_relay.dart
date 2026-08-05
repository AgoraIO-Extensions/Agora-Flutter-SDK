import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// ChannelMediaRelay Example
class ChannelMediaRelay extends StatefulWidget {
  /// Construct the [ChannelMediaRelay]
  const ChannelMediaRelay({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ChannelMediaRelay> {
  RtcEngine? _engine;
  bool isJoined = false;
  int _myUid = 0;
  bool isRelaying = false;
  bool isRelayPaused = false;
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
    _channelMediaRelayController.dispose();
    _channelController.dispose();
    _engine?.destroy();
    super.dispose();
  }

  _initEngine() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Permission.microphone.request();
    }
    final engine =
        await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _engine = engine;
    _addListener();

    // make this room live broadcasting room
    await engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await engine.setClientRole(ClientRole.Broadcaster);

    // start joining channel
    // 1. Users can only see each other after they join the
    // same channel successfully using the same app id.
    // 2. If app certificate is turned on at dashboard, token is needed
    // when joining channel. The channel name and uid used to calculate
    // the token has to match the ones used for channel join
    await engine.joinChannel(
        config.token, _channelController.text, null, 0, null);
  }

  _addListener() {
    _engine!.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning $warningCode');
      },
      error: (errorCode) {
        logSink.log('error $errorCode');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess $channel $uid $elapsed');
        _myUid = uid;
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        logSink.log('userJoined $uid $elapsed');
      },
      userOffline: (uid, reason) {
        logSink.log('userOffline $uid $reason');
      },
      channelMediaRelayStateChanged:
          (ChannelMediaRelayState state, ChannelMediaRelayError code) {
        switch (state) {
          case ChannelMediaRelayState.Idle:
            logSink.log('ChannelMediaRelayState.Idle $code');
            setState(() {
              isRelaying = false;
              isRelayPaused = false;
            });
            break;
          case ChannelMediaRelayState.Connecting:
            logSink.log('ChannelMediaRelayState.Connecting $code)');
            break;
          case ChannelMediaRelayState.Running:
            logSink.log('ChannelMediaRelayState.Running $code)');
            setState(() {
              isRelaying = true;
              isRelayPaused = false;
            });
            break;
          case ChannelMediaRelayState.Failure:
            logSink.log('ChannelMediaRelayState.Failure $code)');
            setState(() {
              isRelaying = false;
              isRelayPaused = false;
            });
            break;
        }
      },
    ));
  }

  _onPressRelayOrStop() async {
    if (isRelaying) {
      await _engine!.stopChannelMediaRelay();
      return;
    }
    if (_channelMediaRelayController.text.isEmpty) {
      return;
    }

    await _engine!.startChannelMediaRelay(ChannelMediaRelayConfiguration(
        ChannelMediaInfo(_channelController.text, _myUid, token: config.token),
        [
          ChannelMediaInfo(_channelMediaRelayController.text, _myUid, token: '')
        ]));
  }

  Future<void> _toggleRelayPaused() async {
    if (isRelayPaused) {
      await _engine!.resumeAllChannelMediaRelay();
    } else {
      await _engine!.pauseAllChannelMediaRelay();
    }
    setState(() {
      isRelayPaused = !isRelayPaused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: _channelController,
              readOnly: isJoined,
            ),
            if (!isJoined)
              ElevatedButton(
                onPressed: _initEngine,
                child: const Text('Join channel'),
              ),
            if (isJoined) ...[
              TextField(
                controller: _channelMediaRelayController,
                decoration: const InputDecoration(
                  hintText: 'Enter target relay channel name',
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton(
                    onPressed: _onPressRelayOrStop,
                    child: Text(!isRelaying ? 'Relay' : 'Stop'),
                  ),
                  ElevatedButton(
                    onPressed: isRelaying ? _toggleRelayPaused : null,
                    child: Text(isRelayPaused ? 'Resume relay' : 'Pause relay'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ],
    );
  }
}
