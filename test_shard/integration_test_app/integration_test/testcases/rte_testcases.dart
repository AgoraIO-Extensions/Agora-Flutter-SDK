import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// Empty implementation for registerObserver/unregisterObserver tests
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

/// RTE Integration Test Cases
///
/// Tests full call chain of all RTE APIs and verifies Dart ↔ Native parameter passing.
void testCases() {
  // Get APP_ID from environment variable
  const String testAppId =
      String.fromEnvironment('TEST_APP_ID', defaultValue: '<YOUR_APP_ID>');

  group('RTE Integration Test', () {
    late AgoraRte rte;
    AgoraRtePlayer? testPlayer;
    AgoraRteCanvas? testCanvas;

    setUpAll(() {
      rte = createAgoraRte();
    });

    tearDownAll(() async {
      // Clean up all resources
      if (testPlayer != null) {
        try {
          await rte.destroyPlayer(testPlayer!.playerId);
        } catch (e) {
          debugPrint('tearDownAll: destroyPlayer error: $e');
        }
        testPlayer = null;
      }

      if (testCanvas != null) {
        try {
          await rte.destroyCanvas(testCanvas!.canvasId);
        } catch (e) {
          debugPrint('tearDownAll: destroyCanvas error: $e');
        }
        testCanvas = null;
      }

      try {
        await rte.destroy();
      } catch (e) {
        debugPrint('tearDownAll: destroy RTE error: $e');
      }
    });

    group('RTE Engine - Main APIs', () {
      testWidgets('createWithConfig - verify all config params round-trip', (tester) async {
        // Set full config
        final config = AgoraRteConfig(
          appId: testAppId,
          logFolder: '/test/rte_logs',
          logFileSize: 10240,
          areaCode: 0x01,
          cloudProxy: '',
          jsonParameter: '{"test_key":"test_value"}',
          useStringUid: false,
        );

        await rte.createWithConfig(config);

        // Get config and verify each field
        final retrievedConfig = await rte.getConfigs();

        expect(retrievedConfig.appId, equals(testAppId),
            reason: 'Native appId mismatch');
        expect(retrievedConfig.logFolder, equals('/test/rte_logs'),
            reason: 'Native logFolder mismatch');
        expect(retrievedConfig.logFileSize, equals(10240),
            reason: 'Native logFileSize mismatch');
        expect(retrievedConfig.areaCode, equals(0x01),
            reason: 'Native areaCode mismatch');
        expect(retrievedConfig.useStringUid, equals(false),
            reason: 'Native useStringUid mismatch');
      });

      testWidgets('initMediaEngine - verify init success', (tester) async {
        // Init media engine
        await rte.initMediaEngine();

        // Should not throw on success
      });

      testWidgets('setConfigs/getConfigs - verify config update', (tester) async {
        // Update partial config
        final updateConfig = AgoraRteConfig(
          logFileSize: 20480,
          areaCode: 0x02,
        );

        await rte.setConfigs(updateConfig);

        // Get config and verify
        final config = await rte.getConfigs();

        // appId should not change
        expect(config.appId, equals(testAppId), reason: 'appId should not be changed');

        // Updated fields should take effect
        expect(config.logFileSize, equals(20480),
            reason: 'logFileSize should be 20480');
        expect(config.areaCode, equals(0x02), reason: 'areaCode should be 0x02');
      });
    });

    group('RTE Player - APIs', () {
      setUpAll(() async {
        // Ensure RTE is properly initialized before player tests
        try {
          await rte.createWithConfig(AgoraRteConfig(appId: testAppId));
        } catch (e) {
          // Already created, ignore
        }
        try {
          await rte.initMediaEngine();
        } catch (e) {
          // Already initialized, ignore
        }
      });

      testWidgets('createPlayer - verify player creation and config', (tester) async {
        final playerConfig = AgoraRtePlayerConfig(
          playoutVolume: 75,
          playbackSpeed: 150,
        );

        testPlayer = await rte.createPlayer(playerConfig);

        // Verify player ID is not empty
        expect(testPlayer!.playerId, isNotEmpty,
            reason: 'Native playerId should not be empty');
        expect(testPlayer!.playerId.length, greaterThan(0),
            reason: 'playerId should have valid length');
      });

      testWidgets('Player setConfigs/getConfigs - verify config round-trip', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        // Set config
        await testPlayer!.setConfigs(AgoraRtePlayerConfig(
          playoutVolume: 80,
          playbackSpeed: 200,
        ));

        // Get config and verify
        final config = await testPlayer!.getConfigs();

        expect(config.playoutVolume, equals(80),
            reason: 'Native playoutVolume mismatch');
        expect(config.playbackSpeed, equals(200),
            reason: 'Native playbackSpeed mismatch');
      });

      testWidgets('Player autoPlay - verify bool config round-trip', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        await testPlayer!.setConfigs(AgoraRtePlayerConfig(autoPlay: true));
        var config = await testPlayer!.getConfigs();
        expect(config.autoPlay, equals(true), reason: 'autoPlay=true round-trip mismatch');

        await testPlayer!.setConfigs(AgoraRtePlayerConfig(autoPlay: false));
        config = await testPlayer!.getConfigs();
        expect(config.autoPlay, equals(false),
            reason: 'autoPlay=false round-trip mismatch');
      });

      testWidgets('Player numeric bounds - playoutVolume/playbackSpeed/loopCount',
          (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        await testPlayer!.setConfigs(AgoraRtePlayerConfig(
          playoutVolume: 0,
          playbackSpeed: 50,
          loopCount: 1,
        ));
        var config = await testPlayer!.getConfigs();
        expect(config.playoutVolume, equals(0), reason: 'playoutVolume=0 mismatch');
        expect(config.playbackSpeed, equals(50),
            reason: 'playbackSpeed=50 mismatch');
        expect(config.loopCount, equals(1), reason: 'loopCount=1 mismatch');

        await testPlayer!.setConfigs(AgoraRtePlayerConfig(
          playoutVolume: 400,
          playbackSpeed: 400,
          loopCount: -1,
        ));
        config = await testPlayer!.getConfigs();
        expect(config.playoutVolume, equals(400),
            reason: 'playoutVolume=400 mismatch');
        expect(config.playbackSpeed, equals(400),
            reason: 'playbackSpeed=400 mismatch');
        expect(config.loopCount, equals(-1), reason: 'loopCount=-1 mismatch');
      });

      testWidgets('Player abrSubscriptionLayer - enum round-trip', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        for (final layer in AgoraRteAbrSubscriptionLayer.values) {
          await testPlayer!.setConfigs(AgoraRtePlayerConfig(
            abrSubscriptionLayer: layer,
          ));
          final config = await testPlayer!.getConfigs();
          expect(config.abrSubscriptionLayer, equals(layer),
              reason: 'abrSubscriptionLayer $layer mapping mismatch');
        }
      });

      testWidgets('Player abrFallbackLayer - enum round-trip', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        for (final layer in AgoraRteAbrFallbackLayer.values) {
          await testPlayer!.setConfigs(AgoraRtePlayerConfig(
            abrFallbackLayer: layer,
          ));
          final config = await testPlayer!.getConfigs();
          expect(config.abrFallbackLayer, equals(layer),
              reason: 'abrFallbackLayer $layer mapping mismatch');
        }
      });

      testWidgets('Player jsonParameter - string round-trip', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        const param = '{"abr":"high","quality":1}';
        await testPlayer!.setConfigs(AgoraRtePlayerConfig(
          jsonParameter: param,
        ));
        final config = await testPlayer!.getConfigs();
        expect(config.jsonParameter, equals(param),
            reason: 'jsonParameter round-trip mismatch');
      });

      testWidgets('Player registerObserver/unregisterObserver - no exception',
          (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        final observer = _DummyPlayerObserver();
        await testPlayer!.registerObserver(observer);
        await testPlayer!.unregisterObserver(observer);
        // Duplicate unregister should not throw
        await testPlayer!.unregisterObserver(observer);
      });

      testWidgets('Player getInfo - verify return data structure', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        // Get player info
        final info = await testPlayer!.getInfo();

        // Verify field types
        expect(info.state, isNotNull, reason: 'state should not be null');
        expect(info.duration, isA<int>(), reason: 'duration should be int');
        expect(info.hasAudio, isA<bool>(), reason: 'hasAudio should be bool');
        expect(info.hasVideo, isA<bool>(), reason: 'hasVideo should be bool');
        expect(info.isAudioMuted, isA<bool>(),
            reason: 'isAudioMuted should be bool');
        expect(info.isVideoMuted, isA<bool>(),
            reason: 'isVideoMuted should be bool');

        if (info.videoWidth != null) {
          expect(info.videoWidth, isA<int>(), reason: 'videoWidth should be int');
        }
        if (info.videoHeight != null) {
          expect(info.videoHeight, isA<int>(),
              reason: 'videoHeight should be int');
        }
      });

      testWidgets('Player getStats - verify stats return format', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        // Get stats
        final stats = await testPlayer!.getStats();

        // On Web, stats fields may be null when no media is playing.
        // On native, they default to 0.
        if (kIsWeb) {
          // Just verify the call doesn't throw and returns valid object
          debugPrint('Web stats: decode=${stats.videoDecodeFrameRate}, '
              'render=${stats.videoRenderFrameRate}, '
              'vBitrate=${stats.videoBitrate}, '
              'aBitrate=${stats.audioBitrate}');
        } else {
          expect(stats.videoDecodeFrameRate, isA<int>(),
              reason: 'videoDecodeFrameRate should be int');
          expect(stats.videoRenderFrameRate, isA<int>(),
              reason: 'videoRenderFrameRate should be int');
          expect(stats.videoBitrate, isA<int>(),
              reason: 'videoBitrate should be int');
          expect(stats.audioBitrate, isA<int>(),
              reason: 'audioBitrate should be int');
        }
      });

      testWidgets('destroyPlayer - verify player destroyed', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        final playerId = testPlayer!.playerId;

        // Destroy player
        await rte.destroyPlayer(playerId);
        testPlayer = null;

        final newPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        expect(newPlayer.playerId, isNot(equals(playerId)),
            reason: 'New player ID should differ from destroyed one');

        testPlayer = newPlayer;
      });
    });

    group('RTE Canvas - APIs', () {
      testWidgets('createCanvas - verify Canvas creation', (tester) async {
        final canvasConfig = AgoraRteCanvasConfig(
          videoRenderMode: AgoraRteVideoRenderMode.fit,
          videoMirrorMode: AgoraRteVideoMirrorMode.disabled,
        );

        testCanvas = await rte.createCanvas(canvasConfig);

        // Verify Canvas ID is not empty
        expect(testCanvas!.canvasId, isNotEmpty,
            reason: 'Native canvasId should not be empty');
        expect(testCanvas!.canvasId.length, greaterThan(0),
            reason: 'canvasId should have valid length');
      });

      testWidgets('Canvas setConfigs/getConfigs - verify config round-trip', (tester) async {
        if (testCanvas == null) {
          testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
        }

        await testCanvas!.setConfigs(AgoraRteCanvasConfig(
          videoRenderMode: AgoraRteVideoRenderMode.hidden,
          videoMirrorMode: AgoraRteVideoMirrorMode.enabled,
        ));

        final config = await testCanvas!.getConfigs();

        expect(config.videoRenderMode, equals(AgoraRteVideoRenderMode.hidden),
            reason: 'Native videoRenderMode mismatch');
        expect(config.videoMirrorMode, equals(AgoraRteVideoMirrorMode.enabled),
            reason: 'Native videoMirrorMode mismatch');
      });

      // testWidgets('Canvas CropArea - verify complex object serialization', (tester) async {
      //   if (testCanvas == null) {
      //     testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
      //   }

      //   await testCanvas!.setConfigs(AgoraRteCanvasConfig(
      //     cropArea: const AgoraRteRect(x: 10, y: 20, width: 1920, height: 1080),
      //   ));

      //   final config = await testCanvas!.getConfigs();

      //   final failures = <String>[];
      //   if (config.cropArea == null) {
      //     failures.add('cropArea should not be null');
      //   } else {
      //     if (config.cropArea!.x != 10) {
      //       failures.add('cropArea.x mismatch: expected 10, actual ${config.cropArea!.x}');
      //     }
      //     if (config.cropArea!.y != 20) {
      //       failures.add('cropArea.y mismatch: expected 20, actual ${config.cropArea!.y}');
      //     }
      //     if (config.cropArea!.width != 1920) {
      //       failures.add('cropArea.width mismatch: expected 1920, actual ${config.cropArea!.width}');
      //     }
      //     if (config.cropArea!.height != 1080) {
      //       failures.add('cropArea.height mismatch: expected 1080, actual ${config.cropArea!.height}');
      //     }
      //   }
      //   if (failures.isNotEmpty) {
      //     expect(failures, isEmpty, reason: failures.join('; '));
      //   }
      // });

      // testWidgets('Canvas CropArea - verify AgoraRteRect bounds', (tester) async {
      //   if (testCanvas == null) {
      //     testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
      //   }

      //   final failures = <String>[];

      //   await testCanvas!.setConfigs(AgoraRteCanvasConfig(
      //     cropArea: const AgoraRteRect(x: 0, y: 0, width: 0, height: 0),
      //   ));
      //   var config = await testCanvas!.getConfigs();
      //   if (config.cropArea == null) {
      //     failures.add('cropArea(0,0,0,0) should not be null');
      //   } else {
      //     if (config.cropArea!.x != 0) failures.add('cropArea.x: expected 0, actual ${config.cropArea!.x}');
      //     if (config.cropArea!.y != 0) failures.add('cropArea.y: expected 0, actual ${config.cropArea!.y}');
      //     if (config.cropArea!.width != 0) failures.add('cropArea.width: expected 0, actual ${config.cropArea!.width}');
      //     if (config.cropArea!.height != 0) failures.add('cropArea.height: expected 0, actual ${config.cropArea!.height}');
      //   }

      //   await testCanvas!.setConfigs(AgoraRteCanvasConfig(
      //     cropArea: const AgoraRteRect(
      //         x: 100, y: 200, width: 1280, height: 720),
      //   ));
      //   config = await testCanvas!.getConfigs();
      //   if (config.cropArea == null) {
      //     failures.add('cropArea(100,200,1280,720) should not be null');
      //   } else {
      //     if (config.cropArea!.x != 100) failures.add('cropArea.x: expected 100, actual ${config.cropArea!.x}');
      //     if (config.cropArea!.y != 200) failures.add('cropArea.y: expected 200, actual ${config.cropArea!.y}');
      //     if (config.cropArea!.width != 1280) failures.add('cropArea.width: expected 1280, actual ${config.cropArea!.width}');
      //     if (config.cropArea!.height != 720) failures.add('cropArea.height: expected 720, actual ${config.cropArea!.height}');
      //   }

      //   if (failures.isNotEmpty) {
      //     expect(failures, isEmpty, reason: failures.join('; '));
      //   }
      // });

      testWidgets('destroyCanvas - verify Canvas destroyed', (tester) async {
        if (testCanvas == null) {
          testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
        }

        final canvasId = testCanvas!.canvasId;

        await rte.destroyCanvas(canvasId);
        testCanvas = null;

        final newCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
        expect(newCanvas.canvasId, isNot(equals(canvasId)),
            reason: 'New Canvas ID should differ from destroyed one');

        testCanvas = newCanvas;
      });
    });

    group('RTE Data Types - Verification', () {
      testWidgets('Enum types - verify mapping', (tester) async {
        if (testCanvas == null) {
          testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
        }

        for (final mode in AgoraRteVideoRenderMode.values) {
          await testCanvas!.setConfigs(AgoraRteCanvasConfig(
            videoRenderMode: mode,
          ));

          final config = await testCanvas!.getConfigs();
          expect(config.videoRenderMode, equals(mode),
              reason: 'VideoRenderMode $mode mapping mismatch');
        }

        for (final mode in AgoraRteVideoMirrorMode.values) {
          await testCanvas!.setConfigs(AgoraRteCanvasConfig(
            videoMirrorMode: mode,
          ));

          final config = await testCanvas!.getConfigs();
          expect(config.videoMirrorMode, equals(mode),
              reason: 'VideoMirrorMode $mode mapping mismatch');
        }
      });

      testWidgets('Numeric types - verify large value handling', (tester) async {
        final config = AgoraRteConfig(
          appId: testAppId,
          logFileSize: 4294967295, // uint32 max
          areaCode: 0xFFFFFFFF,
        );

        await rte.setConfigs(config);
        final retrieved = await rte.getConfigs();

        expect(retrieved.logFileSize, equals(4294967295),
            reason: 'Large logFileSize handling mismatch');
        expect(retrieved.areaCode, equals(0xFFFFFFFF),
            reason: 'Large areaCode handling mismatch');
      });

      testWidgets('String types - cloudProxy/jsonParameter round-trip', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          cloudProxy: 'proxy.example.com:8080',
          jsonParameter: '{"key":"value","nested":{"a":1}}',
        ));
        final config = await rte.getConfigs();
        expect(config.cloudProxy, equals('proxy.example.com:8080'),
            reason: 'cloudProxy round-trip mismatch');
        // SDK automatically adds protected param rtc.set_app_type, so only check for client params
        expect(config.jsonParameter, contains('"key":"value"'),
            reason: 'jsonParameter should contain client params');
        expect(config.jsonParameter, contains('"nested":{"a":1}'),
            reason: 'jsonParameter should contain nested params');
        debugPrint(
            'jsonParameter with protected params: ${config.jsonParameter}');
      });

      testWidgets('String types - empty and long string', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          cloudProxy: '',
          jsonParameter: '',
        ));
        var config = await rte.getConfigs();
        expect(config.cloudProxy, equals(''), reason: 'Empty cloudProxy should be preserved');
        // SDK automatically adds protected params even when client passes empty string
        if (config.jsonParameter != '') {
          debugPrint(
              'Note: Empty jsonParameter was replaced with: ${config.jsonParameter}');
          expect(config.jsonParameter, contains('rtc.set_app_type'),
              reason:
                  'SDK should add protected params even when client params are empty');
        }

        final longJson = '{"k":"${'x' * 500}"}';
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          jsonParameter: longJson,
        ));
        config = await rte.getConfigs();
        // SDK automatically injects protected params, so check client params are preserved
        expect(config.jsonParameter, contains('\"k\":\"${'x' * 500}\"'),
            reason: 'Long jsonParameter client data should be preserved');
        expect(config.jsonParameter, contains('rtc.set_app_type'),
            reason: 'SDK should add protected params to long jsonParameter');
        debugPrint(
            'Long jsonParameter with protected params (length: ${config.jsonParameter!.length})');
      });

      testWidgets('Numeric types - zero and areaCode multi-region', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          logFileSize: 0,
          areaCode: 0,
        ));
        var config = await rte.getConfigs();
        expect(config.logFileSize, equals(0), reason: 'logFileSize=0 mismatch');
        expect(config.areaCode, equals(0), reason: 'areaCode=0 mismatch');

        for (final code in [0x01, 0x02, 0x04, 0x08, 0x0F]) {
          await rte.setConfigs(AgoraRteConfig(appId: testAppId, areaCode: code));
          config = await rte.getConfigs();
          expect(config.areaCode, equals(code),
              reason: 'areaCode $code round-trip mismatch');
        }
      });

      testWidgets('Bool types - verify true/false passing', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          useStringUid: true,
        ));

        var config = await rte.getConfigs();
        expect(config.useStringUid, equals(true),
            reason: 'useStringUid=true passing mismatch');

        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          useStringUid: false,
        ));

        config = await rte.getConfigs();
        expect(config.useStringUid, equals(false),
            reason: 'useStringUid=false passing mismatch');
      });

      testWidgets('JSON special chars - jsonParameter escape and nesting', (tester) async {
        const param = '{"a":"b\\c","d":"e\"f","nested":[1,2]}';
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          jsonParameter: param,
        ));
        final config = await rte.getConfigs();
        // If JSON parsing fails, SDK replaces with default value, this is expected behavior
        if (config.jsonParameter == param) {
          debugPrint('Good: Special chars JSON preserved: $param');
        } else {
          debugPrint('Note: Special chars JSON was sanitized or replaced');
          debugPrint('  Original: $param');
          debugPrint('  Actual:   ${config.jsonParameter}');
          // SDK should at least add protected params
          expect(config.jsonParameter, contains('rtc.set_app_type'));
        }
      });

      testWidgets('logFolder - path format', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          logFolder: '/sdcard/agora/rte_logs',
        ));
        final config = await rte.getConfigs();
        expect(config.logFolder, equals('/sdcard/agora/rte_logs'),
            reason: 'logFolder round-trip mismatch');
      });
    });
  });
}
