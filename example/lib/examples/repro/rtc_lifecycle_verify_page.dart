import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/material.dart';

class RtcLifecycleVerifyPage extends StatefulWidget {
  const RtcLifecycleVerifyPage({Key? key}) : super(key: key);

  @override
  State<RtcLifecycleVerifyPage> createState() => _RtcLifecycleVerifyPageState();
}

class _RtcLifecycleVerifyPageState extends State<RtcLifecycleVerifyPage> {
  late final RtcEngine _engine;
  late final TextEditingController _channelController;
  late final RtcEngineEventHandler _eventHandler;

  bool _engineReady = false;
  bool _joining = false;
  bool _joined = false;

  int _round = 1;
  bool _roundJoinInvoked = false;
  bool _roundJoinSuccess = false;
  bool _roundConnected = false;
  bool _roundUserJoined = false;

  final Set<int> _remoteUids = <int>{};

  @override
  void initState() {
    super.initState();
    _channelController = TextEditingController(text: config.channelId);
    logSink.log('[RtcLifecycleVerifyPage] initState');
    _initEngine();
  }

  @override
  void dispose() {
    logSink.log('[RtcLifecycleVerifyPage] dispose');
    super.dispose();
    _disposeAsync();
  }

  Future<void> _disposeAsync() async {
    logSink.log('[RtcLifecycleVerifyPage] async dispose start');
    if (_engineReady) {
      _engine.unregisterEventHandler(_eventHandler);
      await _engine.leaveChannel();
      await _engine.release();
    }
    _channelController.dispose();
    logSink.log('[RtcLifecycleVerifyPage] async dispose end');
  }

  Future<void> _initEngine() async {
    logSink.log('[RtcLifecycleVerifyPage] init engine start');
    _engine = createAgoraRtcEngine();
    _eventHandler = RtcEngineEventHandler(
      onError: (err, msg) {
        logSink.log('[RtcLifecycleVerifyPage][onError] err=$err msg=$msg');
      },
      onJoinChannelSuccess: (connection, elapsed) {
        logSink.log(
            '[RtcLifecycleVerifyPage][onJoinChannelSuccess] ${connection.toJson()} elapsed=$elapsed');
        if (!mounted) return;
        setState(() {
          _joined = true;
          _joining = false;
          _roundJoinSuccess = true;
        });
      },
      onConnectionStateChanged: (connection, state, reason) {
        logSink.log(
            '[RtcLifecycleVerifyPage][onConnectionStateChanged] ${connection.toJson()} state=$state reason=$reason');
        if (!mounted) return;
        setState(() {
          if (state == ConnectionStateType.connectionStateConnected) {
            _roundConnected = true;
          }
        });
      },
      onUserJoined: (connection, remoteUid, elapsed) {
        logSink.log(
            '[RtcLifecycleVerifyPage][onUserJoined] ${connection.toJson()} remoteUid=$remoteUid elapsed=$elapsed');
        if (!mounted) return;
        setState(() {
          _remoteUids.add(remoteUid);
          _roundUserJoined = true;
        });
      },
      onUserOffline: (connection, remoteUid, reason) {
        logSink.log(
            '[RtcLifecycleVerifyPage][onUserOffline] ${connection.toJson()} remoteUid=$remoteUid reason=$reason');
        if (!mounted) return;
        setState(() {
          _remoteUids.remove(remoteUid);
        });
      },
      onLeaveChannel: (connection, stats) {
        logSink.log(
            '[RtcLifecycleVerifyPage][onLeaveChannel] ${connection.toJson()} stats=${stats.toJson()}');
        if (!mounted) return;
        setState(() {
          _joined = false;
          _joining = false;
          _remoteUids.clear();
        });
      },
    );

    await _engine.initialize(RtcEngineContext(appId: config.appId));
    _engine.registerEventHandler(_eventHandler);
    await _engine.enableVideo();
    await _engine.startPreview();

    if (!mounted) return;
    setState(() {
      _engineReady = true;
    });
    logSink.log('[RtcLifecycleVerifyPage] init engine end');
  }

  void _resetRoundState() {
    _remoteUids.clear();
    _roundJoinInvoked = false;
    _roundJoinSuccess = false;
    _roundConnected = false;
    _roundUserJoined = false;
  }

  Future<void> _join() async {
    setState(() {
      _joining = true;
      _joined = false;
      _round += 1;
      _resetRoundState();
      _roundJoinInvoked = true;
    });
    logSink.log('[RtcLifecycleVerifyPage] round=$_round join start');
    await _engine.joinChannel(
      token: config.token,
      channelId: _channelController.text,
      uid: config.uid,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
    logSink.log('[RtcLifecycleVerifyPage] round=$_round join invoke end');
  }

  Future<void> _leave() async {
    logSink.log('[RtcLifecycleVerifyPage] round=$_round leave start');
    await _engine.leaveChannel();
    logSink.log('[RtcLifecycleVerifyPage] round=$_round leave end');
  }

  Widget _buildCheckRow(String label, bool value) {
    return Row(
      children: [
        Icon(
          value ? Icons.check_circle : Icons.radio_button_unchecked,
          color: value ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(label)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RTC Lifecycle Verify'),
        actions: const [LogActionWidget()],
      ),
      body: Column(
        children: [
          Expanded(
            child: _engineReady
                ? Stack(
                    children: [
                      AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _engine,
                          canvas: const VideoCanvas(uid: 0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _remoteUids
                                .map(
                                  (uid) => SizedBox(
                                    width: 140,
                                    height: 140,
                                    child: AgoraVideoView(
                                      controller: VideoViewController.remote(
                                        rtcEngine: _engine,
                                        canvas: VideoCanvas(uid: uid),
                                        connection: RtcConnection(
                                          channelId: _channelController.text,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _channelController,
                  decoration: const InputDecoration(labelText: 'Channel ID'),
                ),
                const SizedBox(height: 12),
                Text(
                  'Current round: $_round\n'
                  'engineReady=$_engineReady joining=$_joining joined=$_joined\n'
                  'remoteUids=${_remoteUids.join(",")}',
                ),
                const SizedBox(height: 12),
                _buildCheckRow('Join invoked', _roundJoinInvoked),
                _buildCheckRow('onJoinChannelSuccess received',
                    _roundJoinSuccess),
                _buildCheckRow('Connected callback received', _roundConnected),
                _buildCheckRow('Remote user callback received', _roundUserJoined),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: !_engineReady || _joining ? null : _join,
                        child: const Text('Join'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: !_engineReady || !_joined ? null : _leave,
                        child: const Text('Leave'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'QA steps: Join once, press Android physical back to launcher, '
                  'reopen app, then Join again. Verify all four checks become true again.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
