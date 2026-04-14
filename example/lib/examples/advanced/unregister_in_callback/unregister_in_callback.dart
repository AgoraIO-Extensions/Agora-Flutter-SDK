import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

RtcEngineEventHandler buildSelfUnregisteringEventHandler({
  required RtcEngine engine,
  required VoidCallback onUnregistered,
  required void Function(int remoteUid) onRemoteJoined,
}) {
  late final RtcEngineEventHandler handler;
  handler = RtcEngineEventHandler(
    onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
      logSink.log(
          '[onUserJoined] connection: ${connection.toJson()} remoteUid: $remoteUid elapsed: $elapsed');
      onRemoteJoined(remoteUid);
      engine.unregisterEventHandler(handler);
      onUnregistered();
      logSink.log('[onUserJoined] unregisterEventHandler called in callback');
    },
  );
  return handler;
}

class UnregisterInCallbackExample extends StatefulWidget {
  const UnregisterInCallbackExample({Key? key}) : super(key: key);

  @override
  State<UnregisterInCallbackExample> createState() =>
      _UnregisterInCallbackExampleState();
}

class _UnregisterInCallbackExampleState
    extends State<UnregisterInCallbackExample> {
  late final RtcEngine _engine;
  late final RtcEngineEventHandler _rtcEngineEventHandler;
  final TextEditingController _channelController =
      TextEditingController(text: config.channelId);

  bool _joined = false;
  bool _unregisteredInCallback = false;
  int? _lastRemoteUid;

  @override
  void initState() {
    super.initState();
    _initEngine();
  }

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    if (_joined) {
      await _engine.leaveChannel();
    }
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: config.appId));

    _rtcEngineEventHandler = buildSelfUnregisteringEventHandler(
      engine: _engine,
      onUnregistered: () {
        if (!mounted) {
          return;
        }
        setState(() {
          _unregisteredInCallback = true;
        });
      },
      onRemoteJoined: (remoteUid) {
        if (!mounted) {
          return;
        }
        setState(() {
          _lastRemoteUid = remoteUid;
        });
      },
    );

    _engine.registerEventHandler(_rtcEngineEventHandler);
  }

  Future<void> _joinChannel() async {
    await [Permission.microphone, Permission.camera].request();

    await _engine.enableVideo();
    await _engine.setClientRole(
      role: ClientRoleType.clientRoleBroadcaster,
    );
    await _engine.joinChannel(
      token: config.token,
      channelId: _channelController.text,
      uid: config.uid,
      options: const ChannelMediaOptions(),
    );

    if (!mounted) {
      return;
    }
    setState(() {
      _joined = true;
    });
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
    if (!mounted) {
      return;
    }
    setState(() {
      _joined = false;
      _lastRemoteUid = null;
      _unregisteredInCallback = false;
    });
    _engine.registerEventHandler(_rtcEngineEventHandler);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'This example unregisters the RtcEngineEventHandler inside onUserJoined.',
          ),
          TextField(
            controller: _channelController,
            decoration: const InputDecoration(hintText: 'Channel ID'),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: [
              ElevatedButton(
                onPressed: _joined ? null : _joinChannel,
                child: const Text('Join'),
              ),
              ElevatedButton(
                onPressed: _joined ? _leaveChannel : null,
                child: const Text('Leave'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text('Joined: $_joined'),
          Text('Unregistered in callback: $_unregisteredInCallback'),
          Text('Last remote uid: ${_lastRemoteUid ?? '-'}'),
        ],
      ),
    );
  }
}
