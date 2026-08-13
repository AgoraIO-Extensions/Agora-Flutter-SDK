import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'config/agora.config.dart' as config;

const _mainWindowChannel = MethodChannel('agora_multi_window_demo/main');
const _rtcWindowChannel = MethodChannel('agora_multi_window_demo/rtc_window');

void main() {
  runApp(const MacOSMultiWindowDemoApp());
}

@pragma('vm:entry-point')
void rtcWindowMain() {
  runApp(const RtcChildWindowApp());
}

class RtcWindowConfig {
  const RtcWindowConfig({
    required this.appId,
    required this.token,
    required this.channelId,
    required this.uid,
  });

  factory RtcWindowConfig.fromMap(Map<Object?, Object?> map) {
    return RtcWindowConfig(
      appId: map['appId']! as String,
      token: map['token']! as String,
      channelId: map['channelId']! as String,
      uid: map['uid']! as int,
    );
  }

  final String appId;
  final String token;
  final String channelId;
  final int uid;

  Map<String, Object> toMap() => <String, Object>{
        'appId': appId,
        'token': token,
        'channelId': channelId,
        'uid': uid,
      };
}

class MacOSMultiWindowDemoApp extends StatelessWidget {
  const MacOSMultiWindowDemoApp({
    super.key,
    this.openRtcWindow,
  });

  final Future<void> Function(RtcWindowConfig config)? openRtcWindow;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: _MainWindowPage(openRtcWindow: openRtcWindow),
    );
  }
}

class _MainWindowPage extends StatefulWidget {
  const _MainWindowPage({this.openRtcWindow});

  final Future<void> Function(RtcWindowConfig config)? openRtcWindow;

  @override
  State<_MainWindowPage> createState() => _MainWindowPageState();
}

class _MainWindowPageState extends State<_MainWindowPage> {
  late final TextEditingController _appIdController;
  late final TextEditingController _tokenController;
  late final TextEditingController _channelController;
  final _uidController = TextEditingController(text: '0');
  String? _error;

  @override
  void initState() {
    super.initState();
    _appIdController = TextEditingController(text: config.appId);
    _tokenController = TextEditingController(text: config.token);
    _channelController = TextEditingController(text: config.channelId);
  }

  @override
  void dispose() {
    _appIdController.dispose();
    _tokenController.dispose();
    _channelController.dispose();
    _uidController.dispose();
    super.dispose();
  }

  Future<void> _openWindow() async {
    final uid = int.tryParse(_uidController.text.trim());
    if (_appIdController.text.trim().isEmpty ||
        _channelController.text.trim().isEmpty ||
        uid == null) {
      setState(() => _error = 'App ID、Channel ID 和数字 UID 为必填项');
      return;
    }

    final rtcConfig = RtcWindowConfig(
      appId: _appIdController.text.trim(),
      token: _tokenController.text.trim(),
      channelId: _channelController.text.trim(),
      uid: uid,
    );

    try {
      final open = widget.openRtcWindow ??
          (value) => _mainWindowChannel.invokeMethod<void>(
                'openRtcWindow',
                value.toMap(),
              );
      await open(rtcConfig);
      if (mounted) setState(() => _error = null);
    } on PlatformException catch (error) {
      if (mounted) setState(() => _error = error.message ?? error.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agora macOS Multi-Window Demo')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: ListView(
            padding: const EdgeInsets.all(24),
            shrinkWrap: true,
            children: [
              TextField(
                key: const ValueKey('appId'),
                controller: _appIdController,
                decoration: const InputDecoration(labelText: 'App ID'),
              ),
              const SizedBox(height: 12),
              TextField(
                key: const ValueKey('token'),
                controller: _tokenController,
                decoration: const InputDecoration(labelText: 'Token（可为空）'),
              ),
              const SizedBox(height: 12),
              TextField(
                key: const ValueKey('channelId'),
                controller: _channelController,
                decoration: const InputDecoration(labelText: 'Channel ID'),
              ),
              const SizedBox(height: 12),
              TextField(
                key: const ValueKey('uid'),
                controller: _uidController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'UID'),
              ),
              if (_error != null) ...[
                const SizedBox(height: 12),
                Text(_error!,
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.error)),
              ],
              const SizedBox(height: 20),
              FilledButton.icon(
                key: const ValueKey('openRtcWindow'),
                onPressed: _openWindow,
                icon: const Icon(Icons.open_in_new),
                label: const Text('打开 RTC 子窗口'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RtcChildWindowApp extends StatelessWidget {
  const RtcChildWindowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const _RtcChildWindowPage(),
    );
  }
}

class _RtcChildWindowPage extends StatefulWidget {
  const _RtcChildWindowPage();

  @override
  State<_RtcChildWindowPage> createState() => _RtcChildWindowPageState();
}

class _RtcChildWindowPageState extends State<_RtcChildWindowPage> {
  RtcEngine? _engine;
  RtcEngineEventHandler? _eventHandler;
  RtcWindowConfig? _config;
  int? _remoteUid;
  String _status = '正在初始化';
  Future<void>? _initializeFuture;
  Future<void>? _shutdownFuture;

  @override
  void initState() {
    super.initState();
    _rtcWindowChannel.setMethodCallHandler((call) async {
      if (call.method == 'requestClose') await _shutdown();
    });
    _initializeFuture = _initialize();
  }

  Future<void> _initialize() async {
    try {
      final values = await _rtcWindowChannel
          .invokeMapMethod<Object?, Object?>('getLaunchConfig');
      if (values == null) throw StateError('Missing launch config');
      final rtcConfig = RtcWindowConfig.fromMap(values);
      final engine = createAgoraRtcEngine();
      _config = rtcConfig;
      _engine = engine;

      await engine.initialize(RtcEngineContext(appId: rtcConfig.appId));
      final eventHandler = RtcEngineEventHandler(
        onJoinChannelSuccess: (connection, elapsed) {
          _setStatus('已加入频道 ${connection.channelId}');
        },
        onUserJoined: (connection, remoteUid, elapsed) {
          if (mounted) setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (connection, remoteUid, reason) {
          if (mounted && _remoteUid == remoteUid) {
            setState(() => _remoteUid = null);
          }
        },
        onError: (error, message) => _setStatus('$error: $message'),
      );
      _eventHandler = eventHandler;
      engine.registerEventHandler(eventHandler);
      await engine.enableVideo();
      await engine.startPreview();
      _setStatus('正在加入频道 ${rtcConfig.channelId}');
      await engine.joinChannel(
        token: rtcConfig.token,
        channelId: rtcConfig.channelId,
        uid: rtcConfig.uid,
        options: const ChannelMediaOptions(
          channelProfile: ChannelProfileType.channelProfileCommunication,
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
        ),
      );
    } catch (error) {
      _setStatus('初始化失败: $error');
    }
  }

  void _setStatus(String value) {
    if (mounted) setState(() => _status = value);
  }

  Future<void> _shutdown() {
    return _shutdownFuture ??= () async {
      await _initializeFuture;
      final engine = _engine;
      final eventHandler = _eventHandler;
      _engine = null;
      _eventHandler = null;
      if (engine == null) return;
      if (eventHandler != null) engine.unregisterEventHandler(eventHandler);
      await engine.leaveChannel();
      await engine.release(sync: true);
    }();
  }

  @override
  void dispose() {
    _rtcWindowChannel.setMethodCallHandler(null);
    unawaited(_shutdown());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final engine = _engine;
    final rtcConfig = _config;
    return Scaffold(
      appBar: AppBar(
        title: const Text('RTC 子窗口'),
        actions: [
          IconButton(
            tooltip: '关闭子窗口',
            onPressed: () =>
                _rtcWindowChannel.invokeMethod<void>('requestNativeClose'),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(_status),
          ),
          Expanded(
            child: engine == null || rtcConfig == null
                ? const Center(child: CircularProgressIndicator())
                : Row(
                    children: [
                      Expanded(
                        child: _VideoPane(
                          label: '本地 ${rtcConfig.uid}',
                          child: AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: engine,
                              canvas: const VideoCanvas(uid: 0),
                              useFlutterTexture: true,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _remoteUid == null
                            ? const _VideoPane(
                                label: '等待远端用户',
                                child: Center(
                                    child: Icon(Icons.person_off, size: 64)),
                              )
                            : _VideoPane(
                                label: '远端 $_remoteUid',
                                child: AgoraVideoView(
                                  controller: VideoViewController.remote(
                                    rtcEngine: engine,
                                    canvas: VideoCanvas(uid: _remoteUid),
                                    connection: RtcConnection(
                                      channelId: rtcConfig.channelId,
                                    ),
                                    useFlutterTexture: true,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _VideoPane extends StatelessWidget {
  const _VideoPane({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(color: Colors.black, child: child),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            color: Colors.black54,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(label, style: const TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
