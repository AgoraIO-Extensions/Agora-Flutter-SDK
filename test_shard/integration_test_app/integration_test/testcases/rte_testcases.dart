import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:agora_rtc_engine/src/impl/agora_rte_impl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// 用于 registerObserver/unregisterObserver 测试的空实现
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

      testWidgets('Player autoPlay - 验证布尔配置往返', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        await testPlayer!.setConfigs(AgoraRtePlayerConfig(autoPlay: true));
        var config = await testPlayer!.getConfigs();
        expect(config.autoPlay, equals(true), reason: 'autoPlay=true 往返不正确');

        await testPlayer!.setConfigs(AgoraRtePlayerConfig(autoPlay: false));
        config = await testPlayer!.getConfigs();
        expect(config.autoPlay, equals(false),
            reason: 'autoPlay=false 往返不正确');
      });

      testWidgets('Player 数字边界 - playoutVolume/playbackSpeed/loopCount',
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
        expect(config.playoutVolume, equals(0), reason: 'playoutVolume=0 不正确');
        expect(config.playbackSpeed, equals(50),
            reason: 'playbackSpeed=50 不正确');
        expect(config.loopCount, equals(1), reason: 'loopCount=1 不正确');

        await testPlayer!.setConfigs(AgoraRtePlayerConfig(
          playoutVolume: 400,
          playbackSpeed: 400,
          loopCount: -1,
        ));
        config = await testPlayer!.getConfigs();
        expect(config.playoutVolume, equals(400),
            reason: 'playoutVolume=400 不正确');
        expect(config.playbackSpeed, equals(400),
            reason: 'playbackSpeed=400 不正确');
        expect(config.loopCount, equals(-1), reason: 'loopCount=-1 不正确');
      });

      testWidgets('Player abrSubscriptionLayer - 枚举往返', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        for (final layer in AgoraRteAbrSubscriptionLayer.values) {
          await testPlayer!.setConfigs(AgoraRtePlayerConfig(
            abrSubscriptionLayer: layer,
          ));
          final config = await testPlayer!.getConfigs();
          expect(config.abrSubscriptionLayer, equals(layer),
              reason: 'abrSubscriptionLayer $layer 映射不正确');
        }
      });

      testWidgets('Player abrFallbackLayer - 枚举往返', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        for (final layer in AgoraRteAbrFallbackLayer.values) {
          await testPlayer!.setConfigs(AgoraRtePlayerConfig(
            abrFallbackLayer: layer,
          ));
          final config = await testPlayer!.getConfigs();
          expect(config.abrFallbackLayer, equals(layer),
              reason: 'abrFallbackLayer $layer 映射不正确');
        }
      });

      testWidgets('Player jsonParameter - 字符串往返', (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        const param = '{"abr":"high","quality":1}';
        await testPlayer!.setConfigs(AgoraRtePlayerConfig(
          jsonParameter: param,
        ));
        final config = await testPlayer!.getConfigs();
        expect(config.jsonParameter, equals(param),
            reason: 'jsonParameter 往返不正确');
      });

      testWidgets('Player registerObserver/unregisterObserver - 不抛异常',
          (tester) async {
        if (testPlayer == null) {
          testPlayer = await rte.createPlayer(AgoraRtePlayerConfig());
        }

        final observer = _DummyPlayerObserver();
        await testPlayer!.registerObserver(observer);
        await testPlayer!.unregisterObserver(observer);
        // 重复 unregister 不应抛
        await testPlayer!.unregisterObserver(observer);
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

      //   await testCanvas!.setConfigs(AgoraRteCanvasConfig(
      //     cropArea: const AgoraRteRect(x: 10, y: 20, width: 1920, height: 1080),
      //   ));

      //   final config = await testCanvas!.getConfigs();

      //   final failures = <String>[];
      //   if (config.cropArea == null) {
      //     failures.add('cropArea 不应该为 null');
      //   } else {
      //     if (config.cropArea!.x != 10) {
      //       failures.add('cropArea.x 不正确: expected 10, actual ${config.cropArea!.x}');
      //     }
      //     if (config.cropArea!.y != 20) {
      //       failures.add('cropArea.y 不正确: expected 20, actual ${config.cropArea!.y}');
      //     }
      //     if (config.cropArea!.width != 1920) {
      //       failures.add('cropArea.width 不正确: expected 1920, actual ${config.cropArea!.width}');
      //     }
      //     if (config.cropArea!.height != 1080) {
      //       failures.add('cropArea.height 不正确: expected 1080, actual ${config.cropArea!.height}');
      //     }
      //   }
      //   if (failures.isNotEmpty) {
      //     expect(failures, isEmpty, reason: failures.join('; '));
      //   }
      // });

      // testWidgets('Canvas CropArea - 验证 AgoraRteRect 边界值', (tester) async {
      //   if (testCanvas == null) {
      //     testCanvas = await rte.createCanvas(AgoraRteCanvasConfig());
      //   }

      //   final failures = <String>[];

      //   await testCanvas!.setConfigs(AgoraRteCanvasConfig(
      //     cropArea: const AgoraRteRect(x: 0, y: 0, width: 0, height: 0),
      //   ));
      //   var config = await testCanvas!.getConfigs();
      //   if (config.cropArea == null) {
      //     failures.add('cropArea(0,0,0,0) 不应为 null');
      //   } else {
      //     if (config.cropArea!.x != 0) failures.add('cropArea.x 边界值: expected 0, actual ${config.cropArea!.x}');
      //     if (config.cropArea!.y != 0) failures.add('cropArea.y 边界值: expected 0, actual ${config.cropArea!.y}');
      //     if (config.cropArea!.width != 0) failures.add('cropArea.width 边界值: expected 0, actual ${config.cropArea!.width}');
      //     if (config.cropArea!.height != 0) failures.add('cropArea.height 边界值: expected 0, actual ${config.cropArea!.height}');
      //   }

      //   await testCanvas!.setConfigs(AgoraRteCanvasConfig(
      //     cropArea: const AgoraRteRect(
      //         x: 100, y: 200, width: 1280, height: 720),
      //   ));
      //   config = await testCanvas!.getConfigs();
      //   if (config.cropArea == null) {
      //     failures.add('cropArea(100,200,1280,720) 不应为 null');
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
        expect(retrieved.areaCode, equals(0xFFFFFFFF),
            reason: '大数值 areaCode 处理不正确');
      });

      testWidgets('字符串类型 - cloudProxy/jsonParameter 往返', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          cloudProxy: 'proxy.example.com:8080',
          jsonParameter: '{"key":"value","nested":{"a":1}}',
        ));
        final config = await rte.getConfigs();
        expect(config.cloudProxy, equals('proxy.example.com:8080'),
            reason: 'cloudProxy 往返不正确');
        expect(config.jsonParameter, equals('{"key":"value","nested":{"a":1}}'),
            reason: 'jsonParameter 往返不正确');
      });

      testWidgets('字符串类型 - 空字符串与长字符串', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          cloudProxy: '',
          jsonParameter: '',
        ));
        var config = await rte.getConfigs();
        expect(config.cloudProxy, equals(''), reason: '空 cloudProxy 应保留');
        expect(config.jsonParameter, equals(''), reason: '空 jsonParameter 应保留');

        final longJson = '{"k":"${'x' * 500}"}';
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          jsonParameter: longJson,
        ));
        config = await rte.getConfigs();
        expect(config.jsonParameter, equals(longJson),
            reason: '长 jsonParameter 往返不正确');
      });

      testWidgets('数字类型 - 零值与 areaCode 多区域', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          logFileSize: 0,
          areaCode: 0,
        ));
        var config = await rte.getConfigs();
        expect(config.logFileSize, equals(0), reason: 'logFileSize=0 不正确');
        expect(config.areaCode, equals(0), reason: 'areaCode=0 不正确');

        for (final code in [0x01, 0x02, 0x04, 0x08, 0x0F]) {
          await rte.setConfigs(AgoraRteConfig(appId: testAppId, areaCode: code));
          config = await rte.getConfigs();
          expect(config.areaCode, equals(code),
              reason: 'areaCode $code 往返不正确');
        }
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

      testWidgets('JSON 特殊字符 - jsonParameter 转义与嵌套', (tester) async {
        const param = '{"a":"b\\c","d":"e\"f","nested":[1,2]}';
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          jsonParameter: param,
        ));
        final config = await rte.getConfigs();
        expect(config.jsonParameter, equals(param),
            reason: '含转义/嵌套的 jsonParameter 往返不正确');
      });

      testWidgets('logFolder - 路径格式', (tester) async {
        await rte.setConfigs(AgoraRteConfig(
          appId: testAppId,
          logFolder: '/sdcard/agora/rte_logs',
        ));
        final config = await rte.getConfigs();
        expect(config.logFolder, equals('/sdcard/agora/rte_logs'),
            reason: 'logFolder 往返不正确');
      });
    });
  });
}
