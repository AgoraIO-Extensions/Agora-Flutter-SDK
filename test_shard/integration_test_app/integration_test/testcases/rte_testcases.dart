import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:agora_rtc_engine/src/impl/agora_rte_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// RTE Integration Test Cases
///
/// 测试 RTE 所有接口的完整调用链路，验证 Dart ↔ Native 参数传递的正确性
void testCases() {
  // 从环境变量获取 APP_ID
  const String testAppId =
      String.fromEnvironment('TEST_APP_ID', defaultValue: '<YOUR_APP_ID>');

  group('RTE Integration Test', () {
    late AgoraRte rte;
    AgoraRtePlayer? testPlayer;
    AgoraRteCanvas? testCanvas;

    setUpAll(() {
      rte = AgoraRteImpl.create();
    });

    tearDownAll(() async {
      // 清理所有资源
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
      testWidgets('createWithConfig - 验证所有配置参数往返传递', (tester) async {
        // 设置完整的配置
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

        // 获取配置并验证每个字段
        final retrievedConfig = await rte.getConfigs();

        expect(retrievedConfig.appId, equals(testAppId),
            reason: 'Native 返回的 appId 不正确');
        expect(retrievedConfig.logFolder, equals('/test/rte_logs'),
            reason: 'Native 返回的 logFolder 不正确');
        expect(retrievedConfig.logFileSize, equals(10240),
            reason: 'Native 返回的 logFileSize 不正确');
        expect(retrievedConfig.areaCode, equals(0x01),
            reason: 'Native 返回的 areaCode 不正确');
        expect(retrievedConfig.useStringUid, equals(false),
            reason: 'Native 返回的 useStringUid 不正确');
      });

      testWidgets('initMediaEngine - 验证初始化成功', (tester) async {
        // 初始化媒体引擎
        await rte.initMediaEngine();

        // 如果成功，不应该抛出异常
        // initMediaEngine 是异步的，成功完成即表示通过测试
      });

      testWidgets('setConfigs/getConfigs - 验证配置更新', (tester) async {
        // 更新部分配置
        final updateConfig = AgoraRteConfig(
          logFileSize: 20480,
          areaCode: 0x02,
        );

        await rte.setConfigs(updateConfig);

        // 获取配置验证
        final config = await rte.getConfigs();

        // appId 不应该改变
        expect(config.appId, equals(testAppId), reason: 'appId 不应该被改变');

        // 更新的字段应该生效
        expect(config.logFileSize, equals(20480),
            reason: 'logFileSize 应该已更新为 20480');
        expect(config.areaCode, equals(0x02), reason: 'areaCode 应该已更新为 0x02');
      });
    });

    group('RTE Player - APIs', () {
      testWidgets('createPlayer - 验证播放器创建和配置', (tester) async {
        final playerConfig = AgoraRtePlayerConfig(
          playoutVolume: 75,
          playbackSpeed: 150,
        );

        testPlayer = await rte.createPlayer(playerConfig);

        // 验证播放器 ID 不为空
        expect(testPlayer!.playerId, isNotEmpty,
            reason: 'Native 返回的 playerId 不应该为空');
        expect(testPlayer!.playerId.length, greaterThan(0),
            reason: 'playerId 应该有合理的长度');
      });

      testWidgets('Player setConfigs/getConfigs - 验证配置往返', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        // 设置配置
        await testPlayer!.setConfigs(AgoraRtePlayerConfig(
          playoutVolume: 80,
          playbackSpeed: 200,
        ));

        // 获取配置验证
        final config = await testPlayer!.getConfigs();

        expect(config.playoutVolume, equals(80),
            reason: 'Native 返回的 playoutVolume 不正确');
        expect(config.playbackSpeed, equals(200),
            reason: 'Native 返回的 playbackSpeed 不正确');
      });

      testWidgets('Player getInfo - 验证返回数据结构', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        // 获取播放器信息
        final info = await testPlayer!.getInfo();

        // 验证返回的字段类型
        expect(info.state, isNotNull, reason: 'state 不应该为 null');
        expect(info.duration, isA<int>(), reason: 'duration 应该是 int 类型');
        expect(info.hasAudio, isA<bool>(), reason: 'hasAudio 应该是 bool 类型');
        expect(info.hasVideo, isA<bool>(), reason: 'hasVideo 应该是 bool 类型');
        expect(info.isAudioMuted, isA<bool>(),
            reason: 'isAudioMuted 应该是 bool 类型');
        expect(info.isVideoMuted, isA<bool>(),
            reason: 'isVideoMuted 应该是 bool 类型');

        // 验证可选字段的类型
        if (info.videoWidth != null) {
          expect(info.videoWidth, isA<int>(), reason: 'videoWidth 应该是 int 类型');
        }
        if (info.videoHeight != null) {
          expect(info.videoHeight, isA<int>(),
              reason: 'videoHeight 应该是 int 类型');
        }
      });

      testWidgets('Player getStats - 验证统计信息返回格式', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        // 获取统计信息
        final stats = await testPlayer!.getStats();

        // 验证返回的字段类型
        expect(stats.videoDecodeFrameRate, isA<int>(),
            reason: 'videoDecodeFrameRate 应该是 int 类型');
        expect(stats.videoRenderFrameRate, isA<int>(),
            reason: 'videoRenderFrameRate 应该是 int 类型');
        expect(stats.videoBitrate, isA<int>(),
            reason: 'videoBitrate 应该是 int 类型');
        expect(stats.audioBitrate, isA<int>(),
            reason: 'audioBitrate 应该是 int 类型');
      });

      testWidgets('destroyPlayer - 验证播放器销毁', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        final playerId = testPlayer!.playerId;

        // 销毁播放器
        await rte.destroyPlayer(playerId);
        testPlayer = null;

        // 销毁后尝试获取配置应该失败
        final newPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        expect(newPlayer.playerId, isNot(equals(playerId)),
            reason: '新创建的播放器 ID 应该与已销毁的不同');

        testPlayer = newPlayer; // 保存以便 tearDown 清理
      });
    });

    group('RTE Canvas - APIs', () {
      testWidgets('createCanvas - 验证 Canvas 创建', (tester) async {
        final canvasConfig = AgoraRteCanvasConfig(
          videoRenderMode: AgoraRteVideoRenderMode.fit,
          videoMirrorMode: AgoraRteVideoMirrorMode.disabled,
        );

        testCanvas = await rte.createCanvas(canvasConfig);

        // 验证 Canvas ID 不为空
        expect(testCanvas!.canvasId, isNotEmpty,
            reason: 'Native 返回的 canvasId 不应该为空');
        expect(testCanvas!.canvasId.length, greaterThan(0),
            reason: 'canvasId 应该有合理的长度');
      });

      testWidgets('Canvas setConfigs/getConfigs - 验证配置往返', (tester) async {
        if (testCanvas == null) {
          testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
        }

        // 设置配置
        await testCanvas!.setConfigs(AgoraRteCanvasConfig(
          videoRenderMode: AgoraRteVideoRenderMode.hidden,
          videoMirrorMode: AgoraRteVideoMirrorMode.enabled,
        ));

        // 获取配置验证
        final config = await testCanvas!.getConfigs();

        expect(config.videoRenderMode, equals(AgoraRteVideoRenderMode.hidden),
            reason: 'Native 返回的 videoRenderMode 不正确');
        expect(config.videoMirrorMode, equals(AgoraRteVideoMirrorMode.enabled),
            reason: 'Native 返回的 videoMirrorMode 不正确');
      });

      // testWidgets('Canvas CropArea - 验证复杂对象序列化', (tester) async {
      //   if (testCanvas == null) {
      //     testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
      //   }

      //   // 设置包含 cropArea 的配置
      //   await testCanvas!.setConfigs(AgoraRteCanvasConfig(
      //     cropArea: const AgoraRteRect(x: 10, y: 20, width: 1920, height: 1080),
      //   ));

      //   // 获取配置验证嵌套对象
      //   final config = await testCanvas!.getConfigs();

      //   expect(config.cropArea, isNotNull, reason: 'cropArea 不应该为 null');
      //   expect(config.cropArea!.x, equals(10), reason: 'cropArea.x 不正确');
      //   expect(config.cropArea!.y, equals(20), reason: 'cropArea.y 不正确');
      //   expect(config.cropArea!.width, equals(1920),
      //       reason: 'cropArea.width 不正确');
      //   expect(config.cropArea!.height, equals(1080),
      //       reason: 'cropArea.height 不正确');
      // });

      testWidgets('destroyCanvas - 验证 Canvas 销毁', (tester) async {
        if (testCanvas == null) {
          testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
        }

        final canvasId = testCanvas!.canvasId;

        // 销毁 Canvas
        await rte.destroyCanvas(canvasId);
        testCanvas = null;

        // 销毁后创建新的 Canvas，ID 应该不同
        final newCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
        expect(newCanvas.canvasId, isNot(equals(canvasId)),
            reason: '新创建的 Canvas ID 应该与已销毁的不同');

        testCanvas = newCanvas; // 保存以便 tearDown 清理
      });
    });

    group('RTE Data Types - Verification', () {
      testWidgets('枚举类型 - 验证正确映射', (tester) async {
        if (testCanvas == null) {
          testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
        }

        // 测试所有 VideoRenderMode 枚举值
        for (final mode in AgoraRteVideoRenderMode.values) {
          await testCanvas!.setConfigs(AgoraRteCanvasConfig(
            videoRenderMode: mode,
          ));

          final config = await testCanvas!.getConfigs();
          expect(config.videoRenderMode, equals(mode),
              reason: 'VideoRenderMode $mode 映射不正确');
        }

        // 测试所有 VideoMirrorMode 枚举值
        for (final mode in AgoraRteVideoMirrorMode.values) {
          await testCanvas!.setConfigs(AgoraRteCanvasConfig(
            videoMirrorMode: mode,
          ));

          final config = await testCanvas!.getConfigs();
          expect(config.videoMirrorMode, equals(mode),
              reason: 'VideoMirrorMode $mode 映射不正确');
        }
      });

      testWidgets('数字类型 - 验证大数值处理', (tester) async {
        // 测试大数值
        final config = AgoraRteConfig(
          appId: testAppId,
          logFileSize: 4294967295, // uint32 最大值
          areaCode: 0xFFFFFFFF,
        );

        await rte.setConfigs(config);
        final retrieved = await rte.getConfigs();

        expect(retrieved.logFileSize, equals(4294967295),
            reason: '大数值 logFileSize 处理不正确');
      });

      testWidgets('布尔类型 - 验证 true/false 传递', (tester) async {
        // 测试 true
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          useStringUid: true,
        ));

        var config = await rte.getConfigs();
        expect(config.useStringUid, equals(true),
            reason: 'useStringUid=true 传递不正确');

        // 测试 false
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          useStringUid: false,
        ));

        config = await rte.getConfigs();
        expect(config.useStringUid, equals(false),
            reason: 'useStringUid=false 传递不正确');
      });
    });
  });
}
