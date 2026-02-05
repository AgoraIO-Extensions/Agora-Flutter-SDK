import 'dart:async';
import 'dart:typed_data';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;

import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/material.dart';

/// Empty implementation for registerObserver/unregisterObserver tests.
class _DummyPlayerObserver implements AgoraRtePlayerObserver {
  @override
  void onStateChanged(AgoraRtePlayerState oldState, AgoraRtePlayerState newState,
      AgoraRteErrorCode? error) {}

  @override
  void onPositionChanged(int currentTime, int utcTime) {}

  @override
  void onResolutionChanged(int width, int height) {}

  @override
  void onEvent(AgoraRtePlayerEvent event) {}

  @override
  void onMetadata(AgoraRtePlayerMetadataType type, Uint8List data) {}

  @override
  void onPlayerInfoUpdated(AgoraRtePlayerInfo info) {}

  @override
  void onAudioVolumeIndication(int volume) {}
}

/// RTE Automated Test Tab
///
/// Provides one-click testing for all RTE APIs.
/// Verifies parameter passing and return values between Dart and Native.
class RteTestTab extends StatefulWidget {
  const RteTestTab({Key? key}) : super(key: key);

  @override
  State<RteTestTab> createState() => _RteTestTabState();
}

class _RteTestTabState extends State<RteTestTab> {
  final List<String> _logs = [];
  final ScrollController _scrollController = ScrollController();

  late AgoraRte _rte;
  AgoraRtePlayer? _player;
  AgoraRteCanvas? _canvas;

  bool _isTesting = false;
  int _passedTests = 0;
  int _failedTests = 0;
  int _totalTests = 0;

  @override
  void initState() {
    super.initState();
    _rte = createAgoraRte();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _log(String message, {bool isError = false}) {
    setState(() {
      final timestamp = DateTime.now().toString().substring(11, 19);
      final prefix = isError ? '❌' : '✅';
      _logs.add('[$timestamp] $prefix $message');
    });

    Timer(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _runTest(String name, Future<void> Function() test) async {
    _totalTests++;
    try {
      _log('Testing: $name');
      await test();
      _log('✓ PASS: $name');
      _passedTests++;
    } catch (e) {
      _log('✗ FAIL: $name - $e', isError: true);
      _failedTests++;
    }
  }

  Future<void> _runAllTests() async {
    setState(() {
      _isTesting = true;
      _logs.clear();
      _passedTests = 0;
      _failedTests = 0;
      _totalTests = 0;
    });

    String _appId = config.appId;
    _log('========== RTE Automated Test Started ==========');

    // === RTE Engine tests ===
    await _runTest('1. Create RTE with full config', () async {
      await _rte.createWithConfig(AgoraRteConfig(
        appId: _appId,
        logFolder: '/test/rte_logs',
        logFileSize: 10240,
        areaCode: 0x01,
        cloudProxy: '',
        jsonParameter: '{"test_key":"test_value"}',
        useStringUid: false,
      ));
    });

    await _runTest('2. Init media engine', () async {
      await _rte.initMediaEngine();
    });

    await _runTest('3. Get config - verify all params round-trip', () async {
      final config = await _rte.getConfigs();
      if (config.appId == null || config.appId!.isEmpty) {
        throw Exception('appId is empty');
      }
      if (config.logFolder != '/test/rte_logs') {
        throw Exception('logFolder mismatch: ${config.logFolder}');
      }
      if (config.logFileSize != 10240) {
        throw Exception('logFileSize mismatch: ${config.logFileSize}');
      }
      if (config.areaCode != 0x01) {
        throw Exception('areaCode mismatch: ${config.areaCode}');
      }
      if (config.useStringUid != false) {
        throw Exception('useStringUid mismatch: ${config.useStringUid}');
      }
      _log('   appId=${config.appId}, logFolder=${config.logFolder}, areaCode=${config.areaCode}');
    });

    await _runTest('4. Set config partial - verify update', () async {
      await _rte.setConfigs(AgoraRteConfig(
        logFileSize: 20480,
        areaCode: 0x02,
      ));
      final config = await _rte.getConfigs();
      if (config.appId != _appId) {
        throw Exception('appId should not change: ${config.appId}');
      }
      if (config.logFileSize != 20480) {
        throw Exception('logFileSize should be 20480: ${config.logFileSize}');
      }
      if (config.areaCode != 0x02) {
        throw Exception('areaCode should be 0x02: ${config.areaCode}');
      }
    });

    await _runTest('5. Config - cloudProxy/jsonParameter round-trip', () async {
      await _rte.setConfigs(AgoraRteConfig(
        appId: _appId,
        cloudProxy: 'proxy.example.com:8080',
        jsonParameter: '{"key":"value","nested":{"a":1}}',
      ));
      final config = await _rte.getConfigs();
      if (config.cloudProxy != 'proxy.example.com:8080') {
        throw Exception('cloudProxy mismatch: ${config.cloudProxy}');
      }
      if (config.jsonParameter != '{"key":"value","nested":{"a":1}}') {
        throw Exception('jsonParameter mismatch: ${config.jsonParameter}');
      }
    });

    await _runTest('6. Config - useStringUid true/false round-trip', () async {
      await _rte.setConfigs(AgoraRteConfig(appId: _appId, useStringUid: true));
      var config = await _rte.getConfigs();
      if (config.useStringUid != true) {
        throw Exception('useStringUid should be true: ${config.useStringUid}');
      }
      await _rte.setConfigs(AgoraRteConfig(appId: _appId, useStringUid: false));
      config = await _rte.getConfigs();
      if (config.useStringUid != false) {
        throw Exception('useStringUid should be false: ${config.useStringUid}');
      }
    });

    await _runTest('7. Config - logFolder path round-trip', () async {
      await _rte.setConfigs(AgoraRteConfig(
        appId: _appId,
        logFolder: '/sdcard/agora/rte_logs',
      ));
      final config = await _rte.getConfigs();
      if (config.logFolder != '/sdcard/agora/rte_logs') {
        throw Exception('logFolder mismatch: ${config.logFolder}');
      }
    });

    await _runTest('8. Config - logFileSize 0, areaCode 0', () async {
      await _rte.setConfigs(AgoraRteConfig(
        appId: _appId,
        logFileSize: 0,
        areaCode: 0,
      ));
      final config = await _rte.getConfigs();
      if (config.logFileSize != 0) throw Exception('logFileSize=0 mismatch: ${config.logFileSize}');
      if (config.areaCode != 0) throw Exception('areaCode=0 mismatch: ${config.areaCode}');
    });

    // === Player tests ===
    await _runTest('9. Create player', () async {
      _player = await _rte.createPlayer(AgoraRtePlayerConfig(
        playoutVolume: 50,
        playbackSpeed: 100,
      ));
      if (_player!.playerId.isEmpty) {
        throw Exception('playerId should not be empty');
      }
      _log('   Player ID: ${_player!.playerId}');
    });

    await _runTest('10. Player setConfigs/getConfigs round-trip', () async {
      await _player!.setConfigs(AgoraRtePlayerConfig(
        playoutVolume: 75,
        playbackSpeed: 150,
      ));
      final config = await _player!.getConfigs();
      if (config.playoutVolume != 75) {
        throw Exception('playoutVolume mismatch: ${config.playoutVolume}');
      }
      if (config.playbackSpeed != 150) {
        throw Exception('playbackSpeed mismatch: ${config.playbackSpeed}');
      }
      _log('   Volume=${config.playoutVolume}, Speed=${config.playbackSpeed}');
    });

    await _runTest('11. Player autoPlay true/false round-trip', () async {
      await _player!.setConfigs(AgoraRtePlayerConfig(autoPlay: true));
      var config = await _player!.getConfigs();
      if (config.autoPlay != true) throw Exception('autoPlay should be true: ${config.autoPlay}');
      await _player!.setConfigs(AgoraRtePlayerConfig(autoPlay: false));
      config = await _player!.getConfigs();
      if (config.autoPlay != false) throw Exception('autoPlay should be false: ${config.autoPlay}');
    });

    await _runTest('12. Player numeric bounds - loopCount/volume/speed', () async {
      await _player!.setConfigs(AgoraRtePlayerConfig(
        playoutVolume: 0,
        playbackSpeed: 400,
        loopCount: -1,
      ));
      final config = await _player!.getConfigs();
      if (config.playoutVolume != 0) throw Exception('playoutVolume=0: ${config.playoutVolume}');
      if (config.playbackSpeed != 400) throw Exception('playbackSpeed=400: ${config.playbackSpeed}');
      if (config.loopCount != -1) throw Exception('loopCount=-1: ${config.loopCount}');
    });

    await _runTest('13. Player jsonParameter round-trip', () async {
      const param = '{"abr":"high","quality":1}';
      await _player!.setConfigs(AgoraRtePlayerConfig(jsonParameter: param));
      final config = await _player!.getConfigs();
      if (config.jsonParameter != param) {
        throw Exception('jsonParameter mismatch: ${config.jsonParameter}');
      }
    });

    await _runTest('14. Player registerObserver/unregisterObserver', () async {
      final observer = _DummyPlayerObserver();
      await _player!.registerObserver(observer);
      await _player!.unregisterObserver(observer);
      await _player!.unregisterObserver(observer); // duplicate should not throw
    });

    await _runTest('15. Get player info - verify return types', () async {
      final info = await _player!.getInfo();
      if (info.state == null) throw Exception('state should not be null');
      if (info.duration is! int) throw Exception('duration should be int');
      if (info.hasAudio is! bool) throw Exception('hasAudio should be bool');
      if (info.hasVideo is! bool) throw Exception('hasVideo should be bool');
      _log('   State=${info.state}, hasAudio=${info.hasAudio}, hasVideo=${info.hasVideo}');
    });

    await _runTest('16. Get player stats - verify return types', () async {
      final stats = await _player!.getStats();
      if (stats.videoDecodeFrameRate is! int) throw Exception('videoDecodeFrameRate should be int');
      if (stats.videoRenderFrameRate is! int) throw Exception('videoRenderFrameRate should be int');
      if (stats.videoBitrate is! int) throw Exception('videoBitrate should be int');
      if (stats.audioBitrate is! int) throw Exception('audioBitrate should be int');
      _log('   FPS=${stats.videoRenderFrameRate}, Bitrate=${stats.videoBitrate}');
    });

    // === Player destroy + new ID ===
    await _runTest('17. destroyPlayer then create new - verify different playerId', () async {
      final oldId = _player!.playerId;
      await _rte.destroyPlayer(oldId);
      _player = null;
      final newPlayer = await _rte.createPlayer(AgoraRtePlayerConfig());
      if (newPlayer.playerId == oldId) {
        throw Exception('New playerId should differ from destroyed: $oldId');
      }
      _player = newPlayer;
      _log('   Old ID=$oldId, New ID=${_player!.playerId}');
    });

    // === Canvas tests ===
    await _runTest('18. Create Canvas', () async {
      _canvas = await _rte.createCanvas(AgoraRteCanvasConfig(
        videoRenderMode: AgoraRteVideoRenderMode.fit,
        videoMirrorMode: AgoraRteVideoMirrorMode.disabled,
      ));
      if (_canvas!.canvasId.isEmpty) {
        throw Exception('canvasId should not be empty');
      }
      _log('   Canvas ID: ${_canvas!.canvasId}');
    });

    await _runTest('19. Set Canvas config - videoRenderMode/videoMirrorMode', () async {
      await _canvas!.setConfigs(AgoraRteCanvasConfig(
        videoRenderMode: AgoraRteVideoRenderMode.hidden,
        videoMirrorMode: AgoraRteVideoMirrorMode.enabled,
        cropArea: const AgoraRteRect(x: 10, y: 10, width: 1920, height: 1080),
      ));
    });

    await _runTest('20. Get Canvas config - verify round-trip', () async {
      final config = await _canvas!.getConfigs();
      if (config.videoRenderMode != AgoraRteVideoRenderMode.hidden) {
        throw Exception('videoRenderMode mismatch: ${config.videoRenderMode}');
      }
      if (config.videoMirrorMode != AgoraRteVideoMirrorMode.enabled) {
        throw Exception('videoMirrorMode mismatch: ${config.videoMirrorMode}');
      }
      _log('   RenderMode=${config.videoRenderMode}, MirrorMode=${config.videoMirrorMode}');
    });

    await _runTest('21. Canvas - all VideoRenderMode values round-trip', () async {
      for (final mode in AgoraRteVideoRenderMode.values) {
        await _canvas!.setConfigs(AgoraRteCanvasConfig(videoRenderMode: mode));
        final config = await _canvas!.getConfigs();
        if (config.videoRenderMode != mode) {
          throw Exception('VideoRenderMode $mode round-trip mismatch: ${config.videoRenderMode}');
        }
      }
      _log('   All ${AgoraRteVideoRenderMode.values.length} VideoRenderMode values OK');
    });

    await _runTest('22. destroyCanvas then create new - verify different canvasId', () async {
      final oldId = _canvas!.canvasId;
      await _rte.destroyCanvas(oldId);
      _canvas = null;
      final newCanvas = await _rte.createCanvas(AgoraRteCanvasConfig());
      if (newCanvas.canvasId == oldId) {
        throw Exception('New canvasId should differ from destroyed: $oldId');
      }
      _canvas = newCanvas;
      _log('   Old ID=$oldId, New ID=${_canvas!.canvasId}');
    });

    // === Cleanup ===
    await _runTest('23. Destroy player', () async {
      if (_player != null) {
        await _rte.destroyPlayer(_player!.playerId);
        _player = null;
      }
    });

    await _runTest('24. Destroy Canvas', () async {
      if (_canvas != null) {
        await _rte.destroyCanvas(_canvas!.canvasId);
        _canvas = null;
      }
    });

    await _runTest('25. Destroy RTE', () async {
      await _rte.destroy();
    });

    _log('========== Test Completed ==========');
    _log('Total: $_totalTests, Passed: $_passedTests, Failed: $_failedTests');

    setState(() => _isTesting = false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Control buttons
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isTesting ? null : _runAllTests,
                  icon: _isTesting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.play_arrow),
                  label: Text(_isTesting ? 'Testing...' : 'Run All Tests'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () => setState(() => _logs.clear()),
                icon: const Icon(Icons.clear),
                label: const Text('Clear Log'),
              ),
            ],
          ),
        ),

        // Test result summary
        if (_totalTests > 0) ...[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStat('Total', _totalTests, Colors.blue),
                _buildStat('Passed', _passedTests, Colors.green),
                _buildStat('Failed', _failedTests, Colors.red),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],

        // Log output
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(8),
            ),
            child: _logs.isEmpty
                ? const Center(
                    child: Text(
                      'Click "Run All Tests" to start',
                      style: TextStyle(color: Colors.white54),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    itemCount: _logs.length,
                    itemBuilder: (context, index) {
                      final log = _logs[index];
                      final isError = log.contains('❌');
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text(
                          log,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12,
                            color:
                                isError ? Colors.red[300] : Colors.green[300],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildStat(String label, int value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
