import 'dart:async';
import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:image_compare/image_compare.dart';
import 'package:integration_test/integration_test_driver_extended.dart';
import 'package:image/image.dart';

/// export UPDATE_GOLDEN="true"
const _udpateGoldenKey = 'UPDATE_GOLDEN';

/// export SAVE_DEBUG_GOLDEN="true"
const _saveDebugGoldenKey = 'SAVE_DEBUG_GOLDEN';
const _iosSimulatorScreenshotKey = 'IOS_SIMULATOR_SCREENSHOT';
const _iosSimulatorBundleId = 'com.example.renderingTest';
const _iosSimulatorScreenshotReadyFile = 'agora-ios-screenshot-ready';
const _iosSimulatorScreenshotDoneFile = 'agora-ios-screenshot-done';
const _iosSimulatorTestCompleteFile = 'agora-ios-test-complete';
const _iosSimulatorDriverDoneFile = 'agora-ios-driver-done';
const _iosScreenshotName =
    'ios.agora_video_view.platform_view.smoke_test.start_preview_after_enable_video';

Future<void> main() async {
  if (Platform.environment[_iosSimulatorScreenshotKey] == 'true') {
    // Flutter 3.47.1 exits during integration_test's native iOS screenshot.
    // Synchronize through the simulator data container and capture from host.
    final driver = await FlutterDriver.connect();
    final simulatorTmp = await _waitForIosSimulatorScreenshotReady();
    final screenshotDone =
        File('${simulatorTmp.path}/$_iosSimulatorScreenshotDoneFile');

    var screenshotMatches = false;
    try {
      screenshotMatches = await _compareScreenshot(
        _iosScreenshotName,
        await _takeIosSimulatorScreenshot(),
      );
    } finally {
      screenshotDone.writeAsStringSync('done');
    }

    final testComplete =
        File('${simulatorTmp.path}/$_iosSimulatorTestCompleteFile');
    await _waitForFile(testComplete, 'the simulator test to complete');
    final appTestPassed = testComplete.readAsStringSync().trim() == 'passed';

    try {
      await driver.close();
    } finally {
      File('${simulatorTmp.path}/$_iosSimulatorDriverDoneFile')
          .writeAsStringSync('done');
    }
    exit(screenshotMatches && appTestPassed ? 0 : 1);
  }

  await integrationDriver(
    onScreenshot: _compareScreenshot,
  );
}

Future<Directory> _waitForIosSimulatorScreenshotReady() async {
  final result = await Process.run(
    'xcrun',
    [
      'simctl',
      'get_app_container',
      'booted',
      _iosSimulatorBundleId,
      'data',
    ],
  );
  if (result.exitCode != 0) {
    throw ProcessException(
      'xcrun',
      [
        'simctl',
        'get_app_container',
        'booted',
        _iosSimulatorBundleId,
        'data',
      ],
      result.stderr.toString(),
      result.exitCode,
    );
  }

  final dataPath = result.stdout.toString().trim();
  final tmp = Directory('$dataPath/tmp');
  final ready = File('${tmp.path}/$_iosSimulatorScreenshotReadyFile');
  await _waitForFile(ready, 'the simulator screenshot');
  return tmp;
}

Future<void> _waitForFile(File file, String description) async {
  final deadline = DateTime.now().add(const Duration(minutes: 5));
  while (!file.existsSync()) {
    if (DateTime.now().isAfter(deadline)) {
      throw TimeoutException('Timed out waiting for $description');
    }
    await Future<void>.delayed(const Duration(milliseconds: 100));
  }
}

Future<List<int>> _takeIosSimulatorScreenshot() async {
  final directory = await Directory.systemTemp.createTemp('agora-screenshot.');
  final screenshot = File('${directory.path}/screenshot.png');
  try {
    final result = await Process.run(
      'xcrun',
      ['simctl', 'io', 'booted', 'screenshot', screenshot.path],
    );
    if (result.exitCode != 0) {
      throw ProcessException(
        'xcrun',
        ['simctl', 'io', 'booted', 'screenshot', screenshot.path],
        result.stderr.toString(),
        result.exitCode,
      );
    }
    return await screenshot.readAsBytes();
  } finally {
    await directory.delete(recursive: true);
  }
}

Future<bool> _compareScreenshot(
  String screenshotName,
  List<int> screenshotBytes, [
  Map<String, Object?>? args,
]) async {
  final screenshotPath = 'screenshot/$screenshotName.png';

  final srcImage = decodeImage(screenshotBytes);
  if (srcImage == null) {
    return false;
  }

  final srcWidth = srcImage.width;
  final srcHeight = srcImage.height;
  const dstWidth = 400;
  const dstHeight = 400;
  final x = srcWidth / 2.0 - dstWidth / 2.0;
  final y = srcHeight / 2.0 - dstHeight / 2.0;

  final dstImage =
      copyCrop(srcImage, x.toInt(), y.toInt(), dstWidth, dstHeight);

  final imageBytes = encodePng(dstImage);

  final updateGolden = Platform.environment[_udpateGoldenKey] ?? 'false';

  final File imageFile = File(screenshotPath);

  if (updateGolden == 'true') {
    imageFile.writeAsBytesSync(imageBytes);
    stdout.writeln('Updated golden file: $screenshotPath');
    return true;
  }

  if ((Platform.environment[_saveDebugGoldenKey] ?? 'false') == 'true') {
    final File debugGoldenFile = File('screenshot/$screenshotName.debug.png');
    debugGoldenFile.writeAsBytesSync(imageBytes);
  }

  final expectedImage = decodePng(imageFile.readAsBytesSync());

  final result = await compareImages(
    src1: expectedImage,
    src2: dstImage,
    algorithm: PixelMatching(tolerance: 0.3),
  );

  stdout.writeln('compareImages $screenshotPath result: $result');

  // TODO(littlegnal): Need more tolerance with this change:
  // https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/pull/1329
  //
  // see if we can reduce the result later
  return result < (screenshotName.startsWith('android.') ? 0.03 : 0.01);
}
