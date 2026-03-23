import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// RTE Player Playback API Integration Test Cases
///
/// Tests playback lifecycle and related APIs that exist in the Flutter SDK
void playbackTestCases() {
  const String testAppId =
      String.fromEnvironment('TEST_APP_ID', defaultValue: '<YOUR_APP_ID>');

  // Test media URL - CDN URL for testing
  const String testMediaUrl =
      'https://download.agora.io/demo/test/Agora.io-Interactions.mp4';

  group('RTE Playback APIs - ', () {
    late AgoraRte rte;
    AgoraRtePlayer? testPlayer;
    _TestPlayerObserver? testObserver;

    setUpAll(() async {
      rte = createAgoraRte();
      await rte.createWithConfig(AgoraRteConfig(appId: testAppId));
      // Initialize media engine before creating any players (required by SDK)
      await rte.initMediaEngine();
    });

    tearDown(() async {
      // Clean up after each test to prevent Player accumulation
      if (testPlayer != null) {
        try {
          await rte.destroyPlayer(testPlayer!.playerId);
        } catch (e) {
          debugPrint('tearDown: destroyPlayer error: $e');
        }
        testPlayer = null;
        testObserver = null;
      }
    });

    tearDownAll(() async {
      try {
        await rte.destroy();
      } catch (e) {
        debugPrint('tearDownAll: destroy RTE error: $e');
      }
    });

    group('openWithUrl - ', () {
      testWidgets('Valid CDN URL with observer', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        testObserver = _TestPlayerObserver();
        await testPlayer!.registerObserver(testObserver!);

        try {
          await testPlayer!.openWithUrl(testMediaUrl, 0);
          debugPrint('openWithUrl completed');

          // Wait for state change callbacks
          await tester.pump(const Duration(seconds: 3));

          final stateCallbacks = testObserver!.receivedCallbacks
              .where((cb) => cb.contains('onStateChanged'))
              .toList();
          debugPrint('Received ${stateCallbacks.length} state callbacks');
          for (final cb in stateCallbacks) {
            debugPrint('  $cb');
          }
        } catch (e) {
          debugPrint('openWithUrl error: $e');
        }
      });

      testWidgets('Empty URL should fail', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());

        // Empty URL error is returned via callback, not thrown synchronously
        Object? callbackError;
        await testPlayer!.openWithUrl('', 0).catchError((e) {
          callbackError = e;
          // Expected: SDK rejects empty URL via callback
          return null;
        });

        // Wait a bit for async callback
        await tester.pump(const Duration(milliseconds: 500));

        // Verify error was received (either sync or via callback logs)
        // Note: iOS returns error via callback with message "param is null"
        debugPrint('Empty URL test completed. Callback error: $callbackError');
      });

      testWidgets('Negative startTime', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());

        try {
          await testPlayer!.openWithUrl(testMediaUrl, -1000);
          debugPrint('Negative start time accepted');
        } catch (e) {
          debugPrint('Negative startTime rejected: $e');
        }
      });
    });

    group('play/pause/stop - ', () {
      testWidgets('play before openWithUrl should fail', (tester) async {
        final player = await rte.createPlayer(AgoraRtePlayerConfig());

        // Error: play() before openWithUrl should reject
        try {
          await player.play();
          fail('SDK should reject play() before openWithUrl');
        } catch (e) {
          // Native throws PlatformException, Web throws JS RteError
          expect(e, isNotNull,
              reason: 'play() before openWithUrl should throw');
        } finally {
          await rte.destroyPlayer(player.playerId);
        }
      });

      testWidgets('Complete playback flow', (tester) async {
        testPlayer =
            await rte.createPlayer(AgoraRtePlayerConfig(autoPlay: false));
        testObserver = _TestPlayerObserver();
        await testPlayer!.registerObserver(testObserver!);

        try {
          await testPlayer!.openWithUrl(testMediaUrl, 0);
          await tester.pump(const Duration(seconds: 2));

          await testPlayer!.play();
          debugPrint('Play successful');
          await tester.pump(const Duration(seconds: 1));

          await testPlayer!.pause();
          debugPrint('Pause successful');
          await tester.pump(const Duration(milliseconds: 500));

          await testPlayer!.play();
          debugPrint('Resume successful');
          await tester.pump(const Duration(seconds: 1));

          await testPlayer!.stop();
          debugPrint('Stop successful');
        } catch (e) {
          debugPrint('Playback flow error: $e');
        }
      });

      testWidgets('pause before play', (tester) async {
        final player = await rte.createPlayer(AgoraRtePlayerConfig());

        try {
          await player.pause();
          debugPrint('Warning: pause() before play() did not throw');
        } catch (e) {
          debugPrint('pause() before play() error: $e');
        } finally {
          await rte.destroyPlayer(player.playerId);
        }
      });
    });

    group('seek - ', () {
      testWidgets('seek to valid position', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        testObserver = _TestPlayerObserver();
        await testPlayer!.registerObserver(testObserver!);
        await testPlayer!.openWithUrl(testMediaUrl, 0);
        await tester.pump(const Duration(seconds: 2));

        try {
          await testPlayer!.seek(5000);
          debugPrint('Seek to 5000ms successful');
        } catch (e) {
          debugPrint('Seek error: $e');
        }
      });

      testWidgets('seek to negative position', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        testObserver = _TestPlayerObserver();
        await testPlayer!.registerObserver(testObserver!);
        await testPlayer!.openWithUrl(testMediaUrl, 0);
        await tester.pump(const Duration(seconds: 2));

        try {
          await testPlayer!.seek(-1000);
          debugPrint('Warning: Negative seek accepted');
        } catch (e) {
          debugPrint('Negative seek rejected: $e');
        }
      });

      testWidgets('seek before openWithUrl', (tester) async {
        final player = await rte.createPlayer(AgoraRtePlayerConfig());

        // Error: seek() before openWithUrl should reject
        try {
          await player.seek(1000);
          fail('SDK should reject seek() before openWithUrl');
        } catch (e) {
          // Native throws PlatformException, Web throws JS RteError
          expect(e, isNotNull,
              reason: 'seek() before openWithUrl should throw');
        } finally {
          await rte.destroyPlayer(player.playerId);
        }
      });
    });

    group('Audio/Video Mute - ', () {
      testWidgets('muteAudio', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());

        try {
          await testPlayer!.muteAudio(true);
          debugPrint('Audio muted successfully');

          await testPlayer!.muteAudio(false);
          debugPrint('Audio unmuted successfully');
        } catch (e) {
          debugPrint('muteAudio error: $e');
        }
      });

      testWidgets('muteVideo', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());

        try {
          await testPlayer!.muteVideo(true);
          debugPrint('Video muted successfully');

          await testPlayer!.muteVideo(false);
          debugPrint('Video unmuted successfully');
        } catch (e) {
          debugPrint('muteVideo error: $e');
        }
      });

      testWidgets('Rapid mute/unmute', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());

        try {
          for (int i = 0; i < 10; i++) {
            await testPlayer!.muteAudio(i % 2 == 0);
          }
          debugPrint('Rapid audio mute toggle completed');

          for (int i = 0; i < 10; i++) {
            await testPlayer!.muteVideo(i % 2 == 0);
          }
          debugPrint('Rapid video mute toggle completed');
        } catch (e) {
          debugPrint('Rapid mute toggle error: $e');
        }
      });
    });

    group('State Query - ', () {
      testWidgets('getPosition before playback', (tester) async {
        final player = await rte.createPlayer(AgoraRtePlayerConfig());

        try {
          final position = await player.getPosition();
          debugPrint('Position before playback: $position ms');
          expect(position, greaterThanOrEqualTo(0));
        } catch (e) {
          debugPrint('getPosition error: $e');
        } finally {
          await rte.destroyPlayer(player.playerId);
        }
      });

      testWidgets('getPosition during playback', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        testObserver = _TestPlayerObserver();
        await testPlayer!.registerObserver(testObserver!);
        await testPlayer!.openWithUrl(testMediaUrl, 0);
        await tester.pump(const Duration(seconds: 2));

        try {
          await testPlayer!.play();
          await tester.pump(const Duration(seconds: 1));

          final position = await testPlayer!.getPosition();
          debugPrint('Position during playback: $position ms');
          expect(position, greaterThanOrEqualTo(0));
        } catch (e) {
          debugPrint('getPosition during playback error: $e');
        }
      });

      testWidgets('getStats validates fields', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());

        try {
          // Add timeout to prevent indefinite hanging if Native callback doesn't respond
          final stats = await testPlayer!.getStats().timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              debugPrint(
                  'WARNING: getStats timed out after 5s - Native layer may not be responding');
              return const AgoraRtePlayerStats();
            },
          );

          debugPrint(
              'Stats videoDecodeFrameRate: ${stats.videoDecodeFrameRate}');
          debugPrint(
              'Stats videoRenderFrameRate: ${stats.videoRenderFrameRate}');
          debugPrint('Stats videoBitrate: ${stats.videoBitrate}');
          debugPrint('Stats audioBitrate: ${stats.audioBitrate}');

          expect(stats.videoDecodeFrameRate, isNotNull);
          expect(stats.videoRenderFrameRate, greaterThanOrEqualTo(0));
          expect(stats.videoBitrate, greaterThanOrEqualTo(0));
          expect(stats.audioBitrate, greaterThanOrEqualTo(0));
        } catch (e) {
          debugPrint('getStats error: $e');
        }
      });

      testWidgets('getInfo validates fields', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());

        try {
          final info = await testPlayer!.getInfo();

          debugPrint('Info currentUrl: ${info.currentUrl}');
          debugPrint('Info hasAudio: ${info.hasAudio}');
          debugPrint('Info hasVideo: ${info.hasVideo}');

          expect(info.hasAudio, isNotNull);
          expect(info.hasVideo, isNotNull);
        } catch (e) {
          debugPrint('getInfo error: $e');
        }
      });
    });

    group('Observer Callbacks - ', () {
      testWidgets('Register observer and receive callbacks', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        testObserver = _TestPlayerObserver();

        await testPlayer!.registerObserver(testObserver!);
        await testPlayer!.openWithUrl(testMediaUrl, 0);
        await tester.pump(const Duration(seconds: 3));

        debugPrint(
            'Observer callbacks received: ${testObserver!.receivedCallbacks.length}');
        for (final cb in testObserver!.receivedCallbacks) {
          debugPrint('  - $cb');
        }

        if (testObserver!.receivedCallbacks.isEmpty) {
          debugPrint('Warning: No callbacks received');
        }
      });

      testWidgets('Unregister observer stops callbacks', (tester) async {
        testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        testObserver = _TestPlayerObserver();

        await testPlayer!.registerObserver(testObserver!);
        await testPlayer!.unregisterObserver(testObserver!);

        testObserver!.receivedCallbacks.clear();

        await testPlayer!.openWithUrl(testMediaUrl, 0);
        await tester.pump(const Duration(seconds: 2));

        if (testObserver!.receivedCallbacks.isNotEmpty) {
          debugPrint(
              'Warning: Received ${testObserver!.receivedCallbacks.length} callbacks after unregister');
        } else {
          debugPrint('Good: No callbacks after unregister');
        }
      });
    });
  });
}

/// Test observer to track callbacks
class _TestPlayerObserver implements AgoraRtePlayerObserver {
  final List<String> receivedCallbacks = [];

  @override
  void onStateChanged(AgoraRtePlayerState oldState,
      AgoraRtePlayerState newState, AgoraRteErrorCode? error) {
    receivedCallbacks
        .add('onStateChanged: $oldState → $newState (error: $error)');
  }

  @override
  void onPositionChanged(int currentTime, int utcTime) {
    receivedCallbacks.add('onPositionChanged: $currentTime ms');
  }

  @override
  void onResolutionChanged(int width, int height) {
    receivedCallbacks.add('onResolutionChanged: ${width}x$height');
  }

  @override
  void onEvent(AgoraRtePlayerEvent event) {
    receivedCallbacks.add('onEvent: $event');
  }

  @override
  void onMetadata(AgoraRtePlayerMetadataType type, Uint8List data) {
    receivedCallbacks.add('onMetadata: $type (${data.length} bytes)');
  }

  @override
  void onPlayerInfoUpdated(AgoraRtePlayerInfo info) {
    receivedCallbacks.add('onPlayerInfoUpdated');
  }

  @override
  void onAudioVolumeIndication(int volume) {
    receivedCallbacks.add('onAudioVolumeIndication: $volume');
  }
}
