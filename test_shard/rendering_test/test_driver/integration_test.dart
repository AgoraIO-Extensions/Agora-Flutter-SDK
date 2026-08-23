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

class _SimulatorScreenshotDriver extends FlutterDriver {
  _SimulatorScreenshotDriver(this._delegate);

  final FlutterDriver _delegate;

  @override
  Future<Map<String, dynamic>> sendCommand(Command command) =>
      _delegate.sendCommand(command);

  @override
  Future<List<int>> screenshot({Object? format}) async {
    final directory =
        await Directory.systemTemp.createTemp('agora-screenshot.');
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
      return screenshot.readAsBytes();
    } finally {
      await directory.delete(recursive: true);
    }
  }

  @override
  Future<void> close() => _delegate.close();
}

Future<void> main() async {
  final defaultDriver = await FlutterDriver.connect();
  final driver = Platform.environment[_iosSimulatorScreenshotKey] == 'true'
      ? _SimulatorScreenshotDriver(defaultDriver)
      : defaultDriver;

  await integrationDriver(
    driver: driver,
    onScreenshot: (String screenshotName, List<int> screenshotBytes,
        [Map<String, Object?>? args]) async {
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
        final File debugGoldenFile =
            File('screenshot/$screenshotName.debug.png');
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
      return result < 0.01;
    },
  );
}
