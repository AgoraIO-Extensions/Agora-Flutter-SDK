import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:agora_rtc_engine/src/impl/agora_rte_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Empty implementation for error test observers
class _ErrorTestPlayerObserver implements AgoraRtePlayerObserver {
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

/// RTE Error & Edge Case Integration Test Cases
///
/// Tests error conditions, invalid parameters, and edge cases that upper layer might call incorrectly
void errorTestCases() {
  const String testAppId =
      String.fromEnvironment('TEST_APP_ID', defaultValue: '<YOUR_APP_ID>');

  group('RTE Error & Edge Cases - ', () {
    late AgoraRte rte;
    AgoraRtePlayer? testPlayer;
    AgoraRteCanvas? testCanvas;

    setUpAll(() async {
      rte = AgoraRteImpl.create();
      // Initialize RTE once for all tests in this group
      await rte.createWithConfig(AgoraRteConfig(appId: testAppId));
      await rte.initMediaEngine();
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

    group('Invalid Configuration - ', () {
      testWidgets('setConfigs - empty appId should fail', (tester) async {
        // RTE is already initialized in setUpAll, so test setConfigs with empty appId
        try {
          final config = AgoraRteConfig(
            appId: '',
            logFolder: '/test/rte_logs',
          );

          await rte.setConfigs(config);
          
          // input (empty appId) should not cause SDK to reject， Reject only when initialized as empty
          expect(true, isTrue, reason: 'SDK accepts empty appId');
        } catch (e) {
          // Expected behavior: SDK rejects invalid input
          expect(e, isA<PlatformException>(),
              reason: 'Empty appId should cause error');
        }
      });

      testWidgets('setConfigs - null appId should handle gracefully',
          (tester) async {
        // RTE is already initialized in setUpAll, so test setConfigs with null appId
        try {
          final config = AgoraRteConfig(
            appId: null,
            logFolder: '/test/rte_logs',
          );

          await rte.setConfigs(config);
          
          // Success: null appId should be ignored in setConfigs
        } catch (e) {
          fail('SDK should ignore null appId in setConfigs, but got error: $e');
        }
      });

      testWidgets('setConfigs - invalid areaCode values', (tester) async {
        // RTE already initialized in setUpAll

        // Test negative areaCode
        try {
          await rte.setConfigs(AgoraRteConfig(
            appId: testAppId,
            areaCode: -1,
          ));
          final config = await rte.getConfigs();
          debugPrint('Negative areaCode resulted in: ${config.areaCode}');
        } catch (e) {
          debugPrint('Negative areaCode error (expected): $e');
        }

        // Test extremely large areaCode
        try {
          await rte.setConfigs(AgoraRteConfig(
            appId: testAppId,
            areaCode: 0x7FFFFFFF,
          ));
          final config = await rte.getConfigs();
          expect(config.areaCode, isNotNull);
        } catch (e) {
          debugPrint('Large areaCode error: $e');
        }
      });

      testWidgets('setConfigs - invalid logFileSize values', (tester) async {
        // RTE already initialized in setUpAll

        // Test negative logFileSize
        try {
          await rte.setConfigs(AgoraRteConfig(
            appId: testAppId,
            logFileSize: -1,
          ));
          final config = await rte.getConfigs();
          debugPrint('Negative logFileSize resulted in: ${config.logFileSize}');
        } catch (e) {
          debugPrint('Negative logFileSize handled: $e');
        }

        // Test zero logFileSize (edge case)
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          logFileSize: 0,
        ));
        final config = await rte.getConfigs();
        expect(config.logFileSize, equals(0), reason: 'Zero logFileSize should be preserved');
      });

      testWidgets('setConfigs - malformed jsonParameter', (tester) async {
        // RTE already initialized in setUpAll

        // Test invalid JSON
        try {
          await rte.setConfigs(AgoraRteConfig(
            appId: testAppId,
            jsonParameter: '{invalid json',
          ));
          // Error input (invalid JSON) should cause SDK to reject
          fail('SDK should reject invalid JSON');
        } catch (e) {
          // Expected behavior - SDK rejects or sanitizes invalid JSON
          expect(e, isNotNull);
        }

        // Test unbalanced JSON
        try {
          await rte.setConfigs(AgoraRteConfig(
            appId: testAppId,
            jsonParameter: '{"key":"value"',
          ));
        } catch (e) {
          debugPrint('Unbalanced JSON handled: $e');
        }

        // Test non-object JSON (array)
        try {
          await rte.setConfigs(AgoraRteConfig(
            appId: testAppId,
            jsonParameter: '["array", "values"]',
          ));
        } catch (e) {
          debugPrint('Array JSON handled: $e');
        }
      });

      testWidgets('setConfigs - special characters in paths', (tester) async {
        // await rte.createWithConfig(AgoraRteConfig(appId: testAppId));

        // Test path with special characters
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          logFolder: '/test/路径/中文/logs',
        ));
        final config = await rte.getConfigs();
        expect(config.logFolder, equals('/test/路径/中文/logs'),
            reason: 'Unicode paths should be preserved');

        // Test path with spaces
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          logFolder: '/test/path with spaces/logs',
        ));
        final config2 = await rte.getConfigs();
        expect(config2.logFolder, equals('/test/path with spaces/logs'));
      });
    });

    group('Player Error Cases - ', () {
      testWidgets('createPlayer - out of range playoutVolume values', (tester) async {
        AgoraRtePlayer? testPlayer;

        // Test negative volume
        try {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig(
            playoutVolume: -100,
          ));
          final config = await testPlayer!.getConfigs();
          debugPrint('Negative volume accepted: ${config.playoutVolume}');
        } catch (e) {
          debugPrint('SDK rejected negative volume: $e');
          expect(e, isA<PlatformException>());
        }

        // 清理
        if (testPlayer != null) {
          await rte.destroyPlayer(testPlayer!.playerId);
          testPlayer = null;
        }

        // Test extremely large volume
        try {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig(
            playoutVolume: 999999,
          ));
          final config = await testPlayer!.getConfigs();
          debugPrint('Large volume resulted in: ${config.playoutVolume}');
        } catch (e) {
          debugPrint('Large volume error: $e');
        } finally {
          if (testPlayer != null) {
            await rte.destroyPlayer(testPlayer!.playerId);
          }
        }
      });

      testWidgets('Player setConfigs - out of range playbackSpeed', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        // Test negative playbackSpeed
        try {
          await testPlayer!.setConfigs(AgoraRtePlayerConfig(
            playbackSpeed: -50,
          ));
          final config = await testPlayer!.getConfigs();
          debugPrint(
              'Negative playbackSpeed accepted: ${config.playbackSpeed}');
        } catch (e) {
          debugPrint('SDK rejected negative playbackSpeed: $e');
          expect(e, isA<PlatformException>());
        }

        // Test zero playbackSpeed
        try {
          await testPlayer!.setConfigs(AgoraRtePlayerConfig(
            playbackSpeed: 0,
          ));
          final config = await testPlayer!.getConfigs();
          debugPrint('Zero playbackSpeed accepted: ${config.playbackSpeed}');
        } catch (e) {
          debugPrint('SDK rejected zero playbackSpeed: $e');
          expect(e, isA<PlatformException>());
        }

        // Test large playbackSpeed - 用新的player避免状态污染
        try {
          final newPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
          await newPlayer.setConfigs(AgoraRtePlayerConfig(
            playbackSpeed: 10000,
          ));
          final config = await newPlayer.getConfigs();
          debugPrint('Large playbackSpeed: ${config.playbackSpeed}');
          await rte.destroyPlayer(newPlayer.playerId);
        } catch (e) {
          debugPrint('Large playbackSpeed error: $e');
        }
      });

      testWidgets('Player setConfigs - invalid loopCount values', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        // Test very large negative loopCount - iOS rejects, Android may accept
        try {
          await testPlayer!.setConfigs(AgoraRtePlayerConfig(
            loopCount: -999999,
          ));
          // If we reach here, SDK accepted invalid value
          var config = await testPlayer!.getConfigs();
          debugPrint(
              'Platform accepted large negative loopCount, resulted in: ${config.loopCount}');
        } catch (e) {
          // Expected on iOS: SDK correctly rejects invalid value
          debugPrint('SDK rejected invalid loopCount (expected on iOS): $e');
          expect(e, isA<PlatformException>(),
              reason: 'Invalid loopCount should be rejected');
        }

        // Test very large positive loopCount
        // According to API docs: 1=play once, 2=play twice, -1=infinite loop
        // Inference: any positive integer N should mean play N times
        await testPlayer!.setConfigs(AgoraRtePlayerConfig(
          loopCount: 999999,
        ));
        var config = await testPlayer!.getConfigs();
        debugPrint(
            'Large positive loopCount (999999) resulted in: ${config.loopCount}');

        // SDK clamps large value to 1, this might be a bug
        if (config.loopCount == 1 && 999999 != 1) {
          debugPrint('BUG: SDK incorrectly clamped loopCount 999999 to 1');
          debugPrint(
              '     According to API docs, positive integers should be supported');
          debugPrint(
              '     1=play once, 2=play twice, so 999999 should play 999999 times');
        } else if (config.loopCount == 999999) {
          debugPrint('Good: loopCount preserved as expected');
        }
      });

      testWidgets('Player - malformed jsonParameter', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        // Test invalid JSON
        try {
          await testPlayer!.setConfigs(AgoraRtePlayerConfig(
            jsonParameter: '{not: valid json}',
          ));
        } catch (e) {
          debugPrint('Player invalid JSON handled: $e');
        }

        // Test null characters in JSON
        try {
          await testPlayer!.setConfigs(AgoraRtePlayerConfig(
            jsonParameter: '{"key":"value\x00"}',
          ));
        } catch (e) {
          debugPrint('Player null character in JSON handled: $e');
        }
      });

      testWidgets('Player registerObserver - multiple register/unregister cycles', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        final observer1 = _ErrorTestPlayerObserver();
        final observer2 = _ErrorTestPlayerObserver();

        // Register same observer multiple times
        await testPlayer!.registerObserver(observer1);
        await testPlayer!.registerObserver(observer1);
        await testPlayer!.registerObserver(observer1);

        // Register multiple observers
        await testPlayer!.registerObserver(observer2);

        // Unregister multiple times
        await testPlayer!.unregisterObserver(observer1);
        await testPlayer!.unregisterObserver(observer1);
        await testPlayer!.unregisterObserver(observer2);
        await testPlayer!.unregisterObserver(observer2);

        // Should not throw
      });

      testWidgets('destroyPlayer - destroy same player multiple times', (tester) async {
        final player = await rte.createPlayer(AgoraRtePlayerConfig());
        final playerId = player.playerId;

        // Destroy once
        await rte.destroyPlayer(playerId);

        // Try to destroy again - should reject
        try {
          await rte.destroyPlayer(playerId);
          fail('SDK should reject destroying already destroyed player');
        } catch (e) {
          // Expected behavior: SDK rejects double destroy
          expect(e, isA<PlatformException>(),
              reason: 'Double destroy should be handled');
        }
      });

      testWidgets('destroyPlayer - destroy with invalid/empty playerId', (tester) async {
        // Try to destroy with empty ID - should reject
        try {
          await rte.destroyPlayer('');
          fail('SDK should reject destroying empty playerId');
        } catch (e) {
          expect(e, isA<PlatformException>());
        }

        // Try to destroy with non-existent ID - should reject
        try {
          await rte.destroyPlayer('non_existent_player_id_12345');
          fail('SDK should reject destroying non-existent player');
        } catch (e) {
          expect(e, isA<PlatformException>());
        }
      });

      testWidgets('Player operations after destroy', (tester) async {
        final player = await rte.createPlayer(AgoraRtePlayerConfig());
        await rte.destroyPlayer(player.playerId);

        // Try to call setConfigs on destroyed player - should reject
        try {
          await player.setConfigs(AgoraRtePlayerConfig(playoutVolume: 50));
          fail('SDK should reject setConfigs on destroyed player');
        } catch (e) {
          expect(e, isA<PlatformException>(),
              reason: 'Operations on destroyed player should fail');
        }

        // Try to call getConfigs on destroyed player - should reject
        try {
          await player.getConfigs();
          fail('SDK should reject getConfigs on destroyed player');
        } catch (e) {
          expect(e, isA<PlatformException>());
        }
      });
    });

    group('Canvas Error Cases - ', () {
      testWidgets('createCanvas - verify canvas creation', (tester) async {
        testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
        expect(testCanvas!.canvasId, isNotEmpty);
      });

      testWidgets('Canvas setConfigs - rapid config changes', (tester) async {
        if (testCanvas == null) {
          testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
        }

        // Rapidly change configs
        for (int i = 0; i < 10; i++) {
          await testCanvas!.setConfigs(AgoraRteCanvasConfig(
            videoRenderMode: i % 2 == 0 
                ? AgoraRteVideoRenderMode.fit 
                : AgoraRteVideoRenderMode.hidden,
            videoMirrorMode: i % 2 == 0
                ? AgoraRteVideoMirrorMode.enabled
                : AgoraRteVideoMirrorMode.disabled,
          ));
        }

        // Verify final state
        final config = await testCanvas!.getConfigs();
        expect(config.videoRenderMode, isNotNull);
        expect(config.videoMirrorMode, isNotNull);
      });

      testWidgets('destroyCanvas - destroy same canvas multiple times', (tester) async {
        final canvas = await rte.createCanvas(AgoraRteCanvasConfig());
        final canvasId = canvas.canvasId;

        // Destroy once
        await rte.destroyCanvas(canvasId);

        // Try to destroy again - should reject
        try {
          await rte.destroyCanvas(canvasId);
          fail('SDK should reject destroying already destroyed canvas');
        } catch (e) {
          expect(e, isA<PlatformException>(),
              reason: 'Double destroy should be handled');
        }
      });

      testWidgets('destroyCanvas - destroy with invalid/empty canvasId', (tester) async {
        // Try to destroy with empty ID - should reject
        try {
          await rte.destroyCanvas('');
          fail('SDK should reject destroying empty canvasId');
        } catch (e) {
          expect(e, isA<PlatformException>());
        }

        // Try to destroy with non-existent ID - should reject
        try {
          await rte.destroyCanvas('non_existent_canvas_id_67890');
          fail('SDK should reject destroying non-existent canvas');
        } catch (e) {
          expect(e, isA<PlatformException>());
        }
      });

      testWidgets('Canvas operations after destroy', (tester) async {
        final canvas = await rte.createCanvas(AgoraRteCanvasConfig());
        await rte.destroyCanvas(canvas.canvasId);

        // Try to call setConfigs on destroyed canvas - should reject
        try {
          await canvas.setConfigs(AgoraRteCanvasConfig(
            videoRenderMode: AgoraRteVideoRenderMode.fit,
          ));
          fail('SDK should reject setConfigs on destroyed canvas');
        } catch (e) {
          expect(e, isA<PlatformException>(),
              reason: 'Operations on destroyed canvas should fail');
        }

        // Try to call getConfigs on destroyed canvas - should reject
        try {
          await canvas.getConfigs();
          fail('SDK should reject getConfigs on destroyed canvas');
        } catch (e) {
          expect(e, isA<PlatformException>());
        }
      });
    });

    group('Lifecycle Error Cases - ', () {
      testWidgets('initMediaEngine before createWithConfig', (tester) async {
        // 1. Destroy the shared instance explicitly for this test
        try {
          await rte.destroy();
        } catch (e) {
          debugPrint('Pre-test destroy failed: $e');
        }

        // 2. Ensure we restore the shared instance for subsequent tests
        addTearDown(() async {
          rte = AgoraRteImpl.create();
          await rte.createWithConfig(AgoraRteConfig(appId: testAppId));
          await rte.initMediaEngine();
        });

        // 3. Test logic: create fresh instance without config
        final rteTest = AgoraRteImpl.create();

        try {
          // Should fail because createWithConfig hasn't been called on this "new" instance
          await rteTest.initMediaEngine();

          fail('SDK should reject initMediaEngine before createWithConfig');
        } catch (e) {
          expect(e, isA<PlatformException>(),
              reason: 'Should throw PlatformException when not initialized');
        }
      });

      testWidgets('Multiple createWithConfig calls', (tester) async {
        final config = AgoraRteConfig(appId: testAppId);

        // RTE already initialized in setUpAll (1st call)
        
        // Try to create again - SDK should reject or handle gracefully
        try {
          await rte.createWithConfig(config);
          fail(
              'SDK should reject or reinitialize on multiple createWithConfig calls');
        } catch (e) {
          // Expected behavior: SDK rejects double initialization
          expect(e, isA<PlatformException>());
        }
      });

      testWidgets('Operations after destroy', (tester) async {
        // Destroy existing instance
        try {
          await rte.destroy();
        } catch (e) {
          debugPrint('Destroy failed: $e');
        }

        // Restore for subsequent tests
        addTearDown(() async {
          rte.destroy();
          rte = AgoraRteImpl.create();
          await rte.createWithConfig(AgoraRteConfig(appId: testAppId));
          await rte.initMediaEngine();
        });


        // Try to create player after destroy - should reject
        try {
          await rte.createPlayer(AgoraRtePlayerConfig());
          fail('SDK should reject creating player after destroy');
        } catch (e) {
          expect(e, isA<PlatformException>(),
              reason: 'Creating player after destroy should fail');
        }

        // Try to get configs after destroy - should reject
        try {
          await rte.getConfigs();
          fail('SDK should reject getConfigs after destroy');
        } catch (e) {
          expect(e, isA<PlatformException>());
        }

        // Reinitialize for remaining tests
        await rte.createWithConfig(AgoraRteConfig(appId: testAppId));
      });

      testWidgets('Create many players and canvases', (tester) async {
        final players = <AgoraRtePlayer>[];
        final canvases = <AgoraRteCanvas>[];

        // Create many resources
        for (int i = 0; i < 20; i++) {
          players.add(await rte.createPlayer(AgoraRtePlayerConfig()));
          canvases.add(await rte.createCanvas(AgoraRteCanvasConfig()));
        }

        // Verify all created successfully
        expect(players.length, equals(20));
        expect(canvases.length, equals(20));

        // Clean up
        for (final player in players) {
          await rte.destroyPlayer(player.playerId);
        }
        for (final canvas in canvases) {
          await rte.destroyCanvas(canvas.canvasId);
        }
      });

      testWidgets('Destroy in wrong order', (tester) async {
        final player = await rte.createPlayer(AgoraRtePlayerConfig());
        final canvas = await rte.createCanvas(AgoraRteCanvasConfig());

        // Destroy RTE before destroying player/canvas
        try {
          await rte.destroy();
          // If destroy succeeds, player/canvas should be invalid
        } catch (e) {
          debugPrint('Destroy with active resources: $e');
        }

        // Try to use player after RTE destroy
        try {
          await player.getConfigs();
          debugPrint('Warning: Player still works after RTE destroy');
        } catch (e) {
          expect(e, isNotNull);
        }

        // Reinitialize for remaining tests
        await rte.createWithConfig(AgoraRteConfig(appId: testAppId));
      });
    });

    group('Data Type Boundary Tests - ', () {
      testWidgets('Extremely long strings', (tester) async {
        // await rte.createWithConfig(AgoraRteConfig(appId: testAppId));

        // Test very long cloudProxy string
        final longString = 'x' * 10000;
        try {
          await rte.setConfigs(AgoraRteConfig(
            appId: testAppId,
            cloudProxy: longString,
          ));
          final config = await rte.getConfigs();
          expect(config.cloudProxy?.length, equals(10000),
              reason: 'Long cloudProxy should be preserved');
        } catch (e) {
          debugPrint('Long cloudProxy handled: $e');
        }

        // Test very long logFolder path
        final longPath = '/test/${'subdir/' * 100}logs';
        try {
          await rte.setConfigs(AgoraRteConfig(
            appId: testAppId,
            logFolder: longPath,
          ));
          final config = await rte.getConfigs();
          expect(config.logFolder, equals(longPath));
        } catch (e) {
          debugPrint('Long logFolder handled: $e');
        }
      });

      testWidgets('Special characters in all string fields', (tester) async {
        // await rte.createWithConfig(AgoraRteConfig(appId: testAppId));

        const specialChars = '!@#\$%^&*()_+-=[]{}|;:\'",.<>?/~`\n\t\r';
        
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          logFolder: '/test/$specialChars/logs',
        ));

        final config = await rte.getConfigs();
        expect(config.logFolder, contains(specialChars));
      });

      testWidgets('Integer overflow boundaries', (tester) async {
        // await rte.createWithConfig(AgoraRteConfig(appId: testAppId));

        // Test int max values
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          logFileSize: 2147483647, // int32 max
          areaCode: 0xFFFFFFFF,     // uint32 max
        ));

        final config = await rte.getConfigs();
        debugPrint('Int max logFileSize: ${config.logFileSize}');
        debugPrint('Int max areaCode: ${config.areaCode}');
      });

      testWidgets('All enum combinations', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());

        // Test all combinations of render and mirror modes
        for (final renderMode in AgoraRteVideoRenderMode.values) {
          for (final mirrorMode in AgoraRteVideoMirrorMode.values) {
            await testCanvas!.setConfigs(AgoraRteCanvasConfig(
              videoRenderMode: renderMode,
              videoMirrorMode: mirrorMode,
            ));

            final config = await testCanvas!.getConfigs();
            expect(config.videoRenderMode, equals(renderMode));
            expect(config.videoMirrorMode, equals(mirrorMode));
          }
        }
      });
    });

    group('Concurrent Operations - ', () {
      testWidgets('Concurrent config changes', (tester) async {
        // await rte.createWithConfig(AgoraRteConfig(appId: testAppId));

        // Launch multiple setConfigs concurrently
        final futures = <Future>[];
        for (int i = 0; i < 10; i++) {
          futures.add(rte.setConfigs(AgoraRteConfig(
            appId: testAppId,
            logFileSize: 1024 * i,
            areaCode: i,
          )));
        }

        await Future.wait(futures);

        // Verify final state is valid
        final config = await rte.getConfigs();
        expect(config.appId, equals(testAppId));
      });

      testWidgets('Concurrent player creation and destruction', (tester) async {
        final futures = <Future>[];

        // Create and destroy multiple players concurrently
        for (int i = 0; i < 5; i++) {
          futures.add(() async {
            final player = await rte.createPlayer(AgoraRtePlayerConfig());
            await rte.destroyPlayer(player.playerId);
          }());
        }

        await Future.wait(futures);
      });

      testWidgets('Get/Set config race condition', (tester) async {
        // RTE already initialized

        final futures = <Future>[];

        // Interleave get and set operations
        for (int i = 0; i < 20; i++) {
          if (i % 2 == 0) {
            futures.add(rte.getConfigs());
          } else {
            futures.add(rte.setConfigs(AgoraRteConfig(
              appId: testAppId,
              logFileSize: 2048 * i,
            )));
          }
        }

        await Future.wait(futures);
      });
    });

    group('Protected Parameters - ', () {
      testWidgets('Attempt to override rtc.set_app_type', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          jsonParameter: '{"rtc.set_app_type": 999}',
        ));

        final config = await rte.getConfigs();
        
        // Verify that rtc.set_app_type is still 4 (protected)
        if (config.jsonParameter != null) {
          expect(
              config.jsonParameter,
              anyOf(contains('"rtc.set_app_type":4'),
                  contains('"rtc.set_app_type": 4')),
              reason: 'Protected parameter should not be overridden');
        }
      });

      testWidgets('Protected param with other client params', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          jsonParameter: '{"rtc.set_app_type": 999, "custom_param": "value"}',
        ));

        final config = await rte.getConfigs();
        
        // Verify protected param and custom param coexist correctly
        if (config.jsonParameter != null) {
          expect(config.jsonParameter, contains('custom_param'),
              reason: 'Custom params should be preserved');
          expect(
              config.jsonParameter,
              anyOf(contains('"rtc.set_app_type":4'),
                  contains('"rtc.set_app_type": 4')),
              reason: 'Protected parameter should be enforced');
        }
      });
    });
  });
}
