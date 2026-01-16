import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class RtePlayerExample extends StatefulWidget {
  const RtePlayerExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RtePlayerExampleState();
}

class _RtePlayerExampleState extends State<RtePlayerExample>
    with SingleTickerProviderStateMixin
    implements AgoraRtePlayerObserver {
  late final AgoraRteImpl _rte;
  AgoraRtePlayerImpl? _player;
  AgoraRteCanvasImpl? _canvas;
  bool _isReady = false;
  String _infoText = 'Initializing...';
  late TabController _tabController;
  
  // PlatformView 相关
  int? _platformViewId;
  int? _viewPtr;
  MethodChannel? _platformViewChannel;

  // URL 输入
  final TextEditingController _urlController =
      TextEditingController(text: 'https://rtc-fallback-test.agoramdn.com/857c6564e7db469387eb44205f287b9a/zzytest.m3u8?token=857c6564e7db469387eb44205f287b9a&userUid=7788');
  final TextEditingController _switchUrlController =
      TextEditingController(text: 'rte://your_channel_id_2?token=xxx&uid=xxx');
  final TextEditingController _preloadUrlController =
      TextEditingController(text: 'rte://your_channel_id?token=xxx&uid=xxx');

  // 播放状态
  int _currentPosition = 0;
  int _duration = 0;
  int _playbackSpeed = 100;
  int _volume = 100;
  bool _isAudioMuted = false;
  bool _isVideoMuted = false;

  // 播放器信息
  AgoraRtePlayerInfo? _playerInfo;
  AgoraRtePlayerStats? _stats;
  int _width = 0;
  int _height = 0;
  int _audioVolume = 0;

  // RTE 配置
  String _appId = '';
  String _logFolder = '';
  int _logFileSize = 0;
  int _areaCode = 0;
  String _cloudProxy = '';
  String _jsonParameter = '';

  // Player 配置
  bool _autoPlay = false;
  int _playoutAudioTrackIdx = 0;
  int _publishAudioTrackIdx = 0;
  int _audioTrackIdx = 0;
  int _subtitleTrackIdx = 0;
  int _externalSubtitleTrackIdx = 0;
  int _audioPitch = 0;
  int _audioPlaybackDelay = 0;
  int _audioDualMonoMode = 0;
  int _publishVolume = 100;
  int _loopCount = 0;
  String _playerJsonParameter = '';
  AgoraRteAbrSubscriptionLayer _abrSubscriptionLayer =
      AgoraRteAbrSubscriptionLayer.high;
  AgoraRteAbrFallbackLayer _abrFallbackLayer =
      AgoraRteAbrFallbackLayer.disabled;

  // Canvas 配置
  AgoraRteVideoRenderMode _videoRenderMode = AgoraRteVideoRenderMode.fit;
  AgoraRteVideoMirrorMode _videoMirrorMode = AgoraRteVideoMirrorMode.auto;
  AgoraRteRect _cropArea = const AgoraRteRect();

  // 事件日志
  final List<String> _eventLogs = [];
  Timer? _positionTimer;
  Timer? _statsTimer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _initRte();
  }

  Future<void> _initRte() async {
    _rte = AgoraRteImpl();
    try {
      await _rte.createWithConfig(AgoraRteConfig(appId: config.appId));
      await _rte.initMediaEngine();

      // 加载 RTE 配置
      await _loadRteConfig();

      final player = await _rte.createPlayer(
          const AgoraRtePlayerConfig(autoPlay: true));
      _player = player as AgoraRtePlayerImpl;
      await _player!.registerObserver(this);

      // 加载 Player 配置
      await _loadPlayerConfig();

      final canvas = await _rte.createCanvas(
          const AgoraRteCanvasConfig(videoRenderMode: AgoraRteVideoRenderMode.fit));
      _canvas = canvas as AgoraRteCanvasImpl;

      // 加载 Canvas 配置
      await _loadCanvasConfig();

      await _player!.setCanvas(_canvas!);
      logSink.log('Player canvas set: ${_canvas!.canvasId}');

      setState(() {
        _isReady = true;
        _infoText = 'RTE Ready';
      });
      
      // 如果 PlatformView 已经创建，添加视图到画布
      if (_viewPtr != null && _canvas != null) {
        logSink.log('PlatformView already created, adding view to canvas');
        await _addViewToCanvas();
      } else {
        logSink.log('PlatformView not yet created, will add view when PlatformView is ready');
      }
    } catch (e) {
      logSink.log('Error: $e');
      setState(() {
        _infoText = 'Error: $e';
      });
    }
  }

  Future<void> _loadRteConfig() async {
    try {
      final appId = await _rte.appId();
      final logFolder = await _rte.logFolder();
      final logFileSize = await _rte.logFileSize();
      final areaCode = await _rte.areaCode();
      final cloudProxy = await _rte.cloudProxy();
      final jsonParameter = await _rte.jsonParameter();
      setState(() {
        _appId = appId;
        _logFolder = logFolder;
        _logFileSize = logFileSize;
        _areaCode = areaCode;
        _cloudProxy = cloudProxy;
        _jsonParameter = jsonParameter;
      });
    } catch (e) {
      _addLog('Load RTE config error: $e');
    }
  }

  Future<void> _loadPlayerConfig() async {
    if (_player == null) return;
    try {
      final autoPlay = await _player!.getAutoPlay();
      final playbackSpeed = await _player!.getPlaybackSpeed();
      final playoutVolume = await _player!.getPlayoutVolume();
      final loopCount = await _player!.getLoopCount();
      final playoutAudioTrackIdx = await _player!.getPlayoutAudioTrackIdx();
      final publishAudioTrackIdx = await _player!.getPublishAudioTrackIdx();
      final audioTrackIdx = await _player!.getAudioTrackIdx();
      final subtitleTrackIdx = await _player!.getSubtitleTrackIdx();
      final externalSubtitleTrackIdx =
          await _player!.getExternalSubtitleTrackIdx();
      final audioPitch = await _player!.getAudioPitch();
      final audioPlaybackDelay = await _player!.getAudioPlaybackDelay();
      final audioDualMonoMode = await _player!.getAudioDualMonoMode();
      final publishVolume = await _player!.getPublishVolume();
      final jsonParameter = await _player!.getJsonParameter();
      final abrSubscriptionLayer = await _player!.getAbrSubscriptionLayer();
      final abrFallbackLayer = await _player!.getAbrFallbackLayer();
      setState(() {
        _autoPlay = autoPlay;
        _playbackSpeed = playbackSpeed;
        _volume = playoutVolume;
        _loopCount = loopCount;
        _playoutAudioTrackIdx = playoutAudioTrackIdx;
        _publishAudioTrackIdx = publishAudioTrackIdx;
        _audioTrackIdx = audioTrackIdx;
        _subtitleTrackIdx = subtitleTrackIdx;
        _externalSubtitleTrackIdx = externalSubtitleTrackIdx;
        _audioPitch = audioPitch;
        _audioPlaybackDelay = audioPlaybackDelay;
        _audioDualMonoMode = audioDualMonoMode;
        _publishVolume = publishVolume;
        _playerJsonParameter = jsonParameter;
        _abrSubscriptionLayer = abrSubscriptionLayer;
        _abrFallbackLayer = abrFallbackLayer;
      });
    } catch (e) {
      _addLog('Load Player config error: $e');
    }
  }

  Future<void> _loadCanvasConfig() async {
    if (_canvas == null) return;
    try {
      final videoRenderMode = await _canvas!.getVideoRenderMode();
      final videoMirrorMode = await _canvas!.getVideoMirrorMode();
      final cropArea = await _canvas!.getCropArea();
      setState(() {
        _videoRenderMode = videoRenderMode;
        _videoMirrorMode = videoMirrorMode;
        _cropArea = cropArea;
      });
    } catch (e) {
      _addLog('Load Canvas config error: $e');
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _positionTimer?.cancel();
    _statsTimer?.cancel();
    _player?.unregisterObserver(this);
    if (_viewPtr != null && _canvas != null) {
      _canvas!.removeView(_viewPtr!);
    }
    _rte.destroy();
    super.dispose();
  }
  
  // 构建 PlatformView
  Widget _buildPlatformView() {
    if (kIsWeb) {
      return const Center(child: Text('Web platform not supported for RTE video view'));
    }
    
    final String viewType = defaultTargetPlatform == TargetPlatform.iOS
        ? 'AgoraSurfaceView'
        : 'AgoraTextureView';
    
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return UiKitView(
        viewType: viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
        hitTestBehavior: PlatformViewHitTestBehavior.transparent,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return AndroidView(
        viewType: viewType,
        onPlatformViewCreated: _onPlatformViewCreated,
        hitTestBehavior: PlatformViewHitTestBehavior.transparent,
      );
    } else {
      return const Center(child: Text('Platform not supported'));
    }
  }
  
  // PlatformView 创建回调
  void _onPlatformViewCreated(int id) {
    _platformViewId = id;
    final String viewType = defaultTargetPlatform == TargetPlatform.iOS
        ? 'AgoraSurfaceView'
        : 'AgoraTextureView';
    _platformViewChannel = MethodChannel('agora_rtc_ng/${viewType}_$id');
    logSink.log('PlatformView created: id=$id, type=$viewType');
    _getNativeViewPtr();
  }
  
  // 获取原生视图指针
  Future<void> _getNativeViewPtr() async {
    if (_platformViewChannel == null) {
      logSink.log('PlatformView channel is null');
      return;
    }
    
    try {
      logSink.log('Getting native view ptr from channel: agora_rtc_ng/${defaultTargetPlatform == TargetPlatform.iOS ? "AgoraSurfaceView" : "AgoraTextureView"}_$_platformViewId');
      final viewPtr = await _platformViewChannel!.invokeMethod<int>('getNativeViewPtr');
      logSink.log('Got viewPtr: $viewPtr');
      if (viewPtr != null && viewPtr != 0) {
        _viewPtr = viewPtr;
        logSink.log('ViewPtr set to: $_viewPtr');
        await _addViewToCanvas();
      } else {
        logSink.log('Invalid viewPtr: $viewPtr');
      }
    } catch (e) {
      logSink.log('Get native view ptr error: $e');
    }
  }
  
  // 添加视图到画布
  Future<void> _addViewToCanvas() async {
    if (_viewPtr == null || _canvas == null) return;
    
    try {
      // 不设置 cropArea，让 SDK 自动处理
      await _canvas!.addView(_viewPtr!);
      logSink.log('View added to canvas successfully, viewPtr: $_viewPtr');
      
      // 如果 Player 已经设置了 Canvas，可能需要重新关联
      if (_player != null) {
        await _player!.setCanvas(_canvas!);
        logSink.log('Canvas re-associated with player');
      }
    } catch (e) {
      logSink.log('Add view to canvas error: $e');
    }
  }

  Future<void> _onOpen() async {
    if (_player == null) return;

    final url = _urlController.text.trim();
    if (url.isEmpty) {
      setState(() {
        _infoText = 'Error: URL 不能为空';
      });
      _addLog('Error: URL is empty');
      return;
    }

    // if (!url.startsWith('rte://')) {
    //   setState(() {
    //     _infoText = 'Error: URL 必须以 rte:// 开头';
    //   });
    //   _addLog('Error: URL must start with rte://');
    //   return;
    // }

    try {
      setState(() {
        _infoText = 'Opening...';
        _eventLogs.clear();
      });
      _addLog('Opening URL: $url');
      
      // 确保视图已添加到画布
      if (_viewPtr != null && _canvas != null) {
        await _addViewToCanvas();
      }
      
      await _player!.openWithUrl(url, 0);
      
      // 显式调用 play（即使设置了 autoPlay）
      // await _player!.play();
      
      _startPositionTimer();
      _startStatsTimer();
    } catch (e) {
      setState(() {
        _infoText = 'Open Error: $e';
      });
      _addLog('Open error: $e');
    }
  }

  void _startPositionTimer() {
    _positionTimer?.cancel();
    _positionTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_player != null) {
        try {
          final position = await _player!.getPosition();
          setState(() {
            _currentPosition = position;
          });
        } catch (e) {
          debugPrint('Get position error: $e');
        }
      }
    });
  }

  void _startStatsTimer() {
    _statsTimer?.cancel();
    _statsTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
      if (_player != null) {
        try {
          final stats = await _player!.getStats();
          final info = await _player!.getInfo();
          setState(() {
            _stats = stats;
            _playerInfo = info;
            _duration = info.duration;
          });
        } catch (e) {
          debugPrint('Get stats/info error: $e');
        }
      }
    });
  }

  void _addLog(String message) {
    setState(() {
      _eventLogs.insert(
          0, '${DateTime.now().toString().substring(11, 19)}: $message');
      if (_eventLogs.length > 50) {
        _eventLogs.removeLast();
      }
    });
  }

  String _formatTime(int milliseconds) {
    final seconds = milliseconds ~/ 1000;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // ========== RTE 配置方法 ==========
  Future<void> _setRteAppId(String appId) async {
    try {
      await _rte.config.setAppId(appId);
      await _loadRteConfig();
      _addLog('Set RTE AppId: $appId');
    } catch (e) {
      _addLog('Set AppId error: $e');
    }
  }

  Future<void> _setRteLogFolder(String folder) async {
    try {
      await _rte.config.setLogFolder(folder);
      await _loadRteConfig();
      _addLog('Set RTE LogFolder: $folder');
    } catch (e) {
      _addLog('Set LogFolder error: $e');
    }
  }

  Future<void> _setRteLogFileSize(int size) async {
    try {
      await _rte.config.setLogFileSize(size);
      await _loadRteConfig();
      _addLog('Set RTE LogFileSize: $size');
    } catch (e) {
      _addLog('Set LogFileSize error: $e');
    }
  }

  Future<void> _setRteAreaCode(int code) async {
    try {
      await _rte.config.setAreaCode(code);
      await _loadRteConfig();
      _addLog('Set RTE AreaCode: $code');
    } catch (e) {
      _addLog('Set AreaCode error: $e');
    }
  }

  Future<void> _setRteCloudProxy(String proxy) async {
    try {
      await _rte.config.setCloudProxy(proxy);
      await _loadRteConfig();
      _addLog('Set RTE CloudProxy: $proxy');
    } catch (e) {
      _addLog('Set CloudProxy error: $e');
    }
  }

  Future<void> _setRteJsonParameter(String param) async {
    try {
      await _rte.config.setJsonParameter(param);
      await _loadRteConfig();
      _addLog('Set RTE JsonParameter: $param');
    } catch (e) {
      _addLog('Set JsonParameter error: $e');
    }
  }

  // ========== Player 配置方法 ==========
  Future<void> _setPlayerAutoPlay(bool value) async {
    if (_player == null) return;
    try {
      await _player!.setAutoPlay(value);
      await _loadPlayerConfig();
      _addLog('Set AutoPlay: $value');
    } catch (e) {
      _addLog('Set AutoPlay error: $e');
    }
  }

  Future<void> _setPlayerPlaybackSpeed(int speed) async {
    if (_player == null) return;
    try {
      await _player!.setPlaybackSpeed(speed);
      setState(() {
        _playbackSpeed = speed;
      });
      _addLog('Set PlaybackSpeed: ${speed / 100.0}x');
    } catch (e) {
      _addLog('Set PlaybackSpeed error: $e');
    }
  }

  Future<void> _setPlayerPlayoutVolume(int volume) async {
    if (_player == null) return;
    try {
      await _player!.setPlayoutVolume(volume);
      setState(() {
        _volume = volume;
      });
      _addLog('Set PlayoutVolume: $volume');
    } catch (e) {
      _addLog('Set PlayoutVolume error: $e');
    }
  }

  Future<void> _setPlayerLoopCount(int count) async {
    if (_player == null) return;
    try {
      await _player!.setLoopCount(count);
      setState(() {
        _loopCount = count;
      });
      _addLog('Set LoopCount: $count');
    } catch (e) {
      _addLog('Set LoopCount error: $e');
    }
  }

  Future<void> _setPlayerPlayoutAudioTrackIdx(int idx) async {
    if (_player == null) return;
    try {
      await _player!.setPlayoutAudioTrackIdx(idx);
      await _loadPlayerConfig();
      _addLog('Set PlayoutAudioTrackIdx: $idx');
    } catch (e) {
      _addLog('Set PlayoutAudioTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerPublishAudioTrackIdx(int idx) async {
    if (_player == null) return;
    try {
      await _player!.setPublishAudioTrackIdx(idx);
      await _loadPlayerConfig();
      _addLog('Set PublishAudioTrackIdx: $idx');
    } catch (e) {
      _addLog('Set PublishAudioTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerAudioTrackIdx(int idx) async {
    if (_player == null) return;
    try {
      await _player!.setAudioTrackIdx(idx);
      await _loadPlayerConfig();
      _addLog('Set AudioTrackIdx: $idx');
    } catch (e) {
      _addLog('Set AudioTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerSubtitleTrackIdx(int idx) async {
    if (_player == null) return;
    try {
      await _player!.setSubtitleTrackIdx(idx);
      await _loadPlayerConfig();
      _addLog('Set SubtitleTrackIdx: $idx');
    } catch (e) {
      _addLog('Set SubtitleTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerExternalSubtitleTrackIdx(int idx) async {
    if (_player == null) return;
    try {
      await _player!.setExternalSubtitleTrackIdx(idx);
      await _loadPlayerConfig();
      _addLog('Set ExternalSubtitleTrackIdx: $idx');
    } catch (e) {
      _addLog('Set ExternalSubtitleTrackIdx error: $e');
    }
  }

  Future<void> _setPlayerAudioPitch(int pitch) async {
    if (_player == null) return;
    try {
      await _player!.setAudioPitch(pitch);
      await _loadPlayerConfig();
      _addLog('Set AudioPitch: $pitch');
    } catch (e) {
      _addLog('Set AudioPitch error: $e');
    }
  }

  Future<void> _setPlayerAudioPlaybackDelay(int delay) async {
    if (_player == null) return;
    try {
      await _player!.setAudioPlaybackDelay(delay);
      await _loadPlayerConfig();
      _addLog('Set AudioPlaybackDelay: $delay');
    } catch (e) {
      _addLog('Set AudioPlaybackDelay error: $e');
    }
  }

  Future<void> _setPlayerAudioDualMonoMode(int mode) async {
    if (_player == null) return;
    try {
      await _player!.setAudioDualMonoMode(mode);
      await _loadPlayerConfig();
      _addLog('Set AudioDualMonoMode: $mode');
    } catch (e) {
      _addLog('Set AudioDualMonoMode error: $e');
    }
  }

  Future<void> _setPlayerPublishVolume(int volume) async {
    if (_player == null) return;
    try {
      await _player!.setPublishVolume(volume);
      await _loadPlayerConfig();
      _addLog('Set PublishVolume: $volume');
    } catch (e) {
      _addLog('Set PublishVolume error: $e');
    }
  }

  Future<void> _setPlayerJsonParameter(String param) async {
    if (_player == null) return;
    try {
      await _player!.setJsonParameter(param);
      await _loadPlayerConfig();
      _addLog('Set Player JsonParameter: $param');
    } catch (e) {
      _addLog('Set Player JsonParameter error: $e');
    }
  }

  Future<void> _setPlayerAbrSubscriptionLayer(
      AgoraRteAbrSubscriptionLayer layer) async {
    if (_player == null) return;
    try {
      await _player!.setAbrSubscriptionLayer(layer);
      await _loadPlayerConfig();
      _addLog('Set AbrSubscriptionLayer: ${layer.name}');
    } catch (e) {
      _addLog('Set AbrSubscriptionLayer error: $e');
    }
  }

  Future<void> _setPlayerAbrFallbackLayer(
      AgoraRteAbrFallbackLayer layer) async {
    if (_player == null) return;
    try {
      await _player!.setAbrFallbackLayer(layer);
      await _loadPlayerConfig();
      _addLog('Set AbrFallbackLayer: ${layer.name}');
    } catch (e) {
      _addLog('Set AbrFallbackLayer error: $e');
    }
  }

  // ========== Canvas 配置方法 ==========
  Future<void> _setCanvasVideoRenderMode(
      AgoraRteVideoRenderMode mode) async {
    if (_canvas == null) return;
    try {
      await _canvas!.setVideoRenderMode(mode);
      setState(() {
        _videoRenderMode = mode;
      });
      _addLog('Set VideoRenderMode: ${mode.name}');
    } catch (e) {
      _addLog('Set VideoRenderMode error: $e');
    }
  }

  Future<void> _setCanvasVideoMirrorMode(
      AgoraRteVideoMirrorMode mode) async {
    if (_canvas == null) return;
    try {
      await _canvas!.setVideoMirrorMode(mode);
      setState(() {
        _videoMirrorMode = mode;
      });
      _addLog('Set VideoMirrorMode: ${mode.name}');
    } catch (e) {
      _addLog('Set VideoMirrorMode error: $e');
    }
  }

  Future<void> _setCanvasCropArea(AgoraRteRect rect) async {
    if (_canvas == null) return;
    try {
      await _canvas!.setCropArea(rect);
      setState(() {
        _cropArea = rect;
      });
      _addLog('Set CropArea: ${rect.x}, ${rect.y}, ${rect.width}x${rect.height}');
    } catch (e) {
      _addLog('Set CropArea error: $e');
    }
  }

  // ========== 其他功能 ==========
  Future<void> _onPreloadUrl() async {
    final url = _preloadUrlController.text.trim();
    if (url.isEmpty || !url.startsWith('rte://')) {
      _addLog('Error: Invalid preload URL');
      return;
    }
    try {
      await AgoraRteImpl.preloadWithUrl(url);
      _addLog('Preload URL: $url');
    } catch (e) {
      _addLog('Preload URL error: $e');
    }
  }

  Future<void> _onSwitchUrl() async {
    if (_player == null) return;
    try {
      await _player!.switchWithUrl(_switchUrlController.text, true);
      _addLog('Switch URL to ${_switchUrlController.text}');
    } catch (e) {
      _addLog('Switch URL error: $e');
    }
  }

  Future<void> _onSeek(double value) async {
    if (_player == null) return;
    try {
      await _player!.seek(value.toInt());
      _addLog('Seek to ${value.toInt()}ms');
    } catch (e) {
      _addLog('Seek error: $e');
    }
  }

  Future<void> _onMuteAudio() async {
    if (_player == null) return;
    try {
      await _player!.muteAudio(!_isAudioMuted);
      setState(() {
        _isAudioMuted = !_isAudioMuted;
      });
      _addLog('Audio ${_isAudioMuted ? 'muted' : 'unmuted'}');
    } catch (e) {
      _addLog('Mute audio error: $e');
    }
  }

  Future<void> _onMuteVideo() async {
    if (_player == null) return;
    try {
      await _player!.muteVideo(!_isVideoMuted);
      setState(() {
        _isVideoMuted = !_isVideoMuted;
      });
      _addLog('Video ${_isVideoMuted ? 'muted' : 'unmuted'}');
    } catch (e) {
      _addLog('Mute video error: $e');
    }
  }

  // ========== Observer 回调 ==========
  @override
  void onStateChanged(AgoraRtePlayerState oldState,
      AgoraRtePlayerState newState, AgoraRteErrorCode? error) {
    debugPrint('RTE State: $oldState -> $newState, error: $error');
    _addLog('State: $oldState -> $newState${error != null ? ' (Error: $error)' : ''}');
    setState(() {
      _infoText =
          'State: ${newState.name}${error != null ? ' (Error: $error)' : ''}';
    });
  }

  @override
  void onPositionChanged(int currentTime, int utcTime) {
    setState(() {
      _currentPosition = currentTime;
    });
  }

  @override
  void onResolutionChanged(int width, int height) {
    debugPrint('RTE Resolution: $width x $height');
    _addLog('Resolution changed: ${width}x$height');
    setState(() {
      _width = width;
      _height = height;
    });
    
    // 分辨率改变后，可能需要更新视图配置
    if (_viewPtr != null && _canvas != null && width > 0 && height > 0) {
      // 可以在这里更新 cropArea 或其他配置
      // 但通常不需要，SDK 会自动处理
      logSink.log('Resolution changed: $width x $height, viewPtr: $_viewPtr');
    }
  }

  @override
  void onEvent(AgoraRtePlayerEvent event) {
    debugPrint('RTE Event: $event');
    _addLog('Event: ${event.name}');
  }

  @override
  void onMetadata(AgoraRtePlayerMetadataType type, dynamic data) {
    debugPrint('RTE Metadata: $type');
    _addLog('Metadata: ${type.name}');
  }

  @override
  void onPlayerInfoUpdated(AgoraRtePlayerInfo info) {
    debugPrint('RTE Info Updated: ${info.currentUrl}');
    _addLog('Info updated: ${info.currentUrl}');
    setState(() {
      _playerInfo = info;
      _duration = info.duration;
    });
  }

  @override
  void onAudioVolumeIndication(int volume) {
    setState(() {
      _audioVolume = volume;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            tabs: const [
              Tab(text: '播放控制'),
              Tab(text: 'RTE配置'),
              Tab(text: 'Player配置'),
              Tab(text: 'Canvas配置'),
              Tab(text: '信息日志'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPlaybackTab(),
                _buildRteConfigTab(),
                _buildPlayerConfigTab(),
                _buildCanvasConfigTab(),
                _buildInfoLogTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaybackTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // URL 输入
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _urlController,
                  decoration: const InputDecoration(
                    labelText: 'RTE URL',
                    hintText: 'rte://your_channel_id?token=xxx&uid=xxx',
                    border: OutlineInputBorder(),
                    helperText: '仅支持 rte:// 协议',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '注意：RTE Player 目前仅支持 rte:// 协议的 URL。',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _isReady ? _onOpen : null,
            child: const Text('Open & Play'),
          ),

          // 视频显示区域
          Container(
            height: 200,
            color: Colors.black,
            child: Stack(
              children: [
                // PlatformView 用于显示视频
                if (_isReady)
                  _buildPlatformView()
                else
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "infoText:$_infoText, width:$_width, height:$_height",
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        if (_width > 0 && _height > 0)
                          Text(
                            '${_width}x$_height',
                            style: const TextStyle(color: Colors.white70, fontSize: 12),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // 播放进度
          if (_duration > 0) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Slider(
                    value: _currentPosition.toDouble(),
                    min: 0,
                    max: _duration.toDouble(),
                    onChanged: _onSeek,
                    label: _formatTime(_currentPosition),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatTime(_currentPosition)),
                      Text(_formatTime(_duration)),
                    ],
                  ),
                ],
              ),
            ),
          ],

          // 基本控制按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  _player?.play();
                  _addLog('Play');
                },
                icon: const Icon(Icons.play_arrow),
                tooltip: 'Play',
              ),
              IconButton(
                onPressed: () {
                  _player?.pause();
                  _addLog('Pause');
                },
                icon: const Icon(Icons.pause),
                tooltip: 'Pause',
              ),
              IconButton(
                onPressed: () {
                  _player?.stop();
                  _addLog('Stop');
                  _positionTimer?.cancel();
                  _statsTimer?.cancel();
                },
                icon: const Icon(Icons.stop),
                tooltip: 'Stop',
              ),
              IconButton(
                onPressed: _onMuteAudio,
                icon: Icon(_isAudioMuted ? Icons.volume_off : Icons.volume_up),
                tooltip: _isAudioMuted ? 'Unmute Audio' : 'Mute Audio',
              ),
              IconButton(
                onPressed: _onMuteVideo,
                icon: Icon(_isVideoMuted ? Icons.videocam_off : Icons.videocam),
                tooltip: _isVideoMuted ? 'Unmute Video' : 'Mute Video',
              ),
            ],
          ),

          // 播放速度控制
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Playback Speed: ${_playbackSpeed / 100.0}x'),
                Wrap(
                  spacing: 8.0,
                  children: [
                    TextButton(
                      onPressed: () => _setPlayerPlaybackSpeed(50),
                      child: const Text('0.5x'),
                    ),
                    TextButton(
                      onPressed: () => _setPlayerPlaybackSpeed(100),
                      child: const Text('1.0x'),
                    ),
                    TextButton(
                      onPressed: () => _setPlayerPlaybackSpeed(150),
                      child: const Text('1.5x'),
                    ),
                    TextButton(
                      onPressed: () => _setPlayerPlaybackSpeed(200),
                      child: const Text('2.0x'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 音量控制
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Volume: $_volume'),
                Slider(
                  value: _volume.toDouble(),
                  min: 0,
                  max: 100,
                  divisions: 10,
                  label: '$_volume',
                  onChanged: (value) => _setPlayerPlayoutVolume(value.toInt()),
                ),
                if (_audioVolume > 0)
                  Text('Audio Volume Indication: $_audioVolume',
                      style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),

          // 预加载 URL
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _preloadUrlController,
                        decoration: const InputDecoration(
                          labelText: 'Preload URL',
                          hintText: 'rte://channel_id?token=xxx&uid=xxx',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _onPreloadUrl,
                      child: const Text('Preload'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 切换 URL
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _switchUrlController,
                        decoration: const InputDecoration(
                          labelText: 'Switch URL',
                          hintText: 'rte://channel_id?token=xxx&uid=xxx',
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _onSwitchUrl,
                      child: const Text('Switch'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRteConfigTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildConfigItem('App ID', _appId, (value) => _setRteAppId(value)),
            _buildConfigItem('Log Folder', _logFolder,
                (value) => _setRteLogFolder(value)),
            _buildConfigItem('Log File Size', '$_logFileSize',
                (value) => _setRteLogFileSize(int.tryParse(value) ?? 0)),
            _buildConfigItem('Area Code', '$_areaCode',
                (value) => _setRteAreaCode(int.tryParse(value) ?? 0)),
            _buildConfigItem('Cloud Proxy', _cloudProxy,
                (value) => _setRteCloudProxy(value)),
            _buildConfigItem('JSON Parameter', _jsonParameter,
                (value) => _setRteJsonParameter(value)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadRteConfig,
              child: const Text('刷新配置'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerConfigTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text('Auto Play'),
              value: _autoPlay,
              onChanged: _setPlayerAutoPlay,
            ),
            _buildConfigItem('Playback Speed', '$_playbackSpeed',
                (value) => _setPlayerPlaybackSpeed(int.tryParse(value) ?? 100)),
            _buildConfigItem('Playout Volume', '$_volume',
                (value) => _setPlayerPlayoutVolume(int.tryParse(value) ?? 100)),
            _buildConfigItem('Loop Count', '$_loopCount',
                (value) => _setPlayerLoopCount(int.tryParse(value) ?? 0)),
            _buildConfigItem('Playout Audio Track Idx', '$_playoutAudioTrackIdx',
                (value) => _setPlayerPlayoutAudioTrackIdx(int.tryParse(value) ?? 0)),
            _buildConfigItem('Publish Audio Track Idx', '$_publishAudioTrackIdx',
                (value) => _setPlayerPublishAudioTrackIdx(int.tryParse(value) ?? 0)),
            _buildConfigItem('Audio Track Idx', '$_audioTrackIdx',
                (value) => _setPlayerAudioTrackIdx(int.tryParse(value) ?? 0)),
            _buildConfigItem('Subtitle Track Idx', '$_subtitleTrackIdx',
                (value) => _setPlayerSubtitleTrackIdx(int.tryParse(value) ?? 0)),
            _buildConfigItem('External Subtitle Track Idx',
                '$_externalSubtitleTrackIdx',
                (value) => _setPlayerExternalSubtitleTrackIdx(int.tryParse(value) ?? 0)),
            _buildConfigItem('Audio Pitch', '$_audioPitch',
                (value) => _setPlayerAudioPitch(int.tryParse(value) ?? 0)),
            _buildConfigItem('Audio Playback Delay', '$_audioPlaybackDelay',
                (value) => _setPlayerAudioPlaybackDelay(int.tryParse(value) ?? 0)),
            _buildConfigItem('Audio Dual Mono Mode', '$_audioDualMonoMode',
                (value) => _setPlayerAudioDualMonoMode(int.tryParse(value) ?? 0)),
            _buildConfigItem('Publish Volume', '$_publishVolume',
                (value) => _setPlayerPublishVolume(int.tryParse(value) ?? 100)),
            _buildConfigItem('JSON Parameter', _playerJsonParameter,
                (value) => _setPlayerJsonParameter(value)),
            const SizedBox(height: 8),
            const Text('ABR Subscription Layer:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: AgoraRteAbrSubscriptionLayer.values.map((layer) {
                return ChoiceChip(
                  label: Text(layer.name),
                  selected: _abrSubscriptionLayer == layer,
                  onSelected: (selected) {
                    if (selected) _setPlayerAbrSubscriptionLayer(layer);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 8),
            const Text('ABR Fallback Layer:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: AgoraRteAbrFallbackLayer.values.map((layer) {
                return ChoiceChip(
                  label: Text(layer.name),
                  selected: _abrFallbackLayer == layer,
                  onSelected: (selected) {
                    if (selected) _setPlayerAbrFallbackLayer(layer);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadPlayerConfig,
              child: const Text('刷新配置'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCanvasConfigTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Video Render Mode:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: AgoraRteVideoRenderMode.values.map((mode) {
                return ChoiceChip(
                  label: Text(mode.name),
                  selected: _videoRenderMode == mode,
                  onSelected: (selected) {
                    if (selected) _setCanvasVideoRenderMode(mode);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Video Mirror Mode:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            Wrap(
              spacing: 8.0,
              children: AgoraRteVideoMirrorMode.values.map((mode) {
                return ChoiceChip(
                  label: Text(mode.name),
                  selected: _videoMirrorMode == mode,
                  onSelected: (selected) {
                    if (selected) _setCanvasVideoMirrorMode(mode);
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text('Crop Area:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('X: ${_cropArea.x}, Y: ${_cropArea.y}'),
            Text('Width: ${_cropArea.width}, Height: ${_cropArea.height}'),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'X'),
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) {
                      final x = int.tryParse(value) ?? 0;
                      _setCanvasCropArea(AgoraRteRect(
                        x: x,
                        y: _cropArea.y,
                        width: _cropArea.width,
                        height: _cropArea.height,
                      ));
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Y'),
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) {
                      final y = int.tryParse(value) ?? 0;
                      _setCanvasCropArea(AgoraRteRect(
                        x: _cropArea.x,
                        y: y,
                        width: _cropArea.width,
                        height: _cropArea.height,
                      ));
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Width'),
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) {
                      final width = int.tryParse(value) ?? 0;
                      _setCanvasCropArea(AgoraRteRect(
                        x: _cropArea.x,
                        y: _cropArea.y,
                        width: width,
                        height: _cropArea.height,
                      ));
                    },
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(labelText: 'Height'),
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) {
                      final height = int.tryParse(value) ?? 0;
                      _setCanvasCropArea(AgoraRteRect(
                        x: _cropArea.x,
                        y: _cropArea.y,
                        width: _cropArea.width,
                        height: height,
                      ));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadCanvasConfig,
              child: const Text('刷新配置'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoLogTab() {
    return SingleChildScrollView(
      child: Column(
        children: [
          // 统计信息
          if (_stats != null)
            Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Statistics:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Video Decode FPS: ${_stats!.videoDecodeFrameRate}'),
                    Text('Video Render FPS: ${_stats!.videoRenderFrameRate}'),
                    Text('Video Bitrate: ${_stats!.videoBitrate} bps'),
                    Text('Audio Bitrate: ${_stats!.audioBitrate} bps'),
                  ],
                ),
              ),
            ),

          // 播放器信息
          if (_playerInfo != null)
            Card(
              margin: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Player Info:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(
                        'State: ${AgoraRtePlayerState.values[_playerInfo!.state].name}'),
                    Text('Duration: ${_formatTime(_playerInfo!.duration)}'),
                    Text('Stream Count: ${_playerInfo!.streamCount}'),
                    Text('Has Audio: ${_playerInfo!.hasAudio}'),
                    Text('Has Video: ${_playerInfo!.hasVideo}'),
                    Text('Audio Muted: ${_playerInfo!.isAudioMuted}'),
                    Text('Video Muted: ${_playerInfo!.isVideoMuted}'),
                    if (_playerInfo!.videoWidth > 0 && _playerInfo!.videoHeight > 0)
                      Text(
                          'Video Size: ${_playerInfo!.videoWidth}x${_playerInfo!.videoHeight}'),
                    if (_playerInfo!.currentUrl.isNotEmpty)
                      Text('Current URL: ${_playerInfo!.currentUrl}'),
                  ],
                ),
              ),
            ),

          // 事件日志
          Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Event Logs:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _eventLogs.clear();
                          });
                        },
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    reverse: true,
                    itemCount: _eventLogs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          _eventLogs[index],
                          style: const TextStyle(
                              fontSize: 12, fontFamily: 'monospace'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConfigItem(String label, String value, Function(String) onSave) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(label),
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onSubmitted: onSave,
            ),
          ),
        ],
      ),
    );
  }
}
