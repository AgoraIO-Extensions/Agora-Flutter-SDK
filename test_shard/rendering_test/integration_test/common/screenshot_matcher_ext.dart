import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:image_compare/image_compare.dart';
import 'package:path/path.dart' as path;

Future<void> matchScreenShotDesktop(
  RtcEngineEx rtcEngine,
  String screenshotName, {
  Duration timeout = const Duration(seconds: 15),
}) async {
  // The first decoded frame can arrive before the texture is composited.
  // Poll the actual golden check instead of sleeping for every test case.
  final stopwatch = Stopwatch()..start();
  do {
    if (await _matchesScreenShotDesktop(rtcEngine, screenshotName)
        .timeout(timeout - stopwatch.elapsed)) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 100));
  } while (stopwatch.elapsed < timeout);

  fail('Screenshot $screenshotName did not match within $timeout '
      '(the rendering_test window may be missing).');
}

Future<bool> _matchesScreenShotDesktop(
    RtcEngineEx rtcEngine, String screenshotName) async {
  String updateGolden =
      const String.fromEnvironment('UPDATE_GOLDEN', defaultValue: 'false');

  final executableFile = File(Platform.resolvedExecutable);
  late String testPath;
  // TODO(littlegnal): Pass the root path of `rendering_test` project through the command line
  if (Platform.isMacOS) {
    testPath = executableFile
        .parent.parent.parent.parent.parent.parent.parent.parent.parent.path;
  } else {
    testPath = executableFile.parent.parent.parent.parent.parent.parent.path;
  }

  SIZE thumbSize = const SIZE(width: 1000, height: 1000);
  SIZE iconSize = const SIZE(width: 100, height: 100);
  List<ScreenCaptureSourceInfo> sourceInfos =
      await rtcEngine.getScreenCaptureSources(
    thumbSize: thumbSize,
    iconSize: iconSize,
    includeScreen: false,
  );

  img.Image? dstImage;

  for (final info in sourceInfos) {
    if (info.sourceName == 'rendering_test' &&
        info.sourceTitle == 'rendering_test') {
      final thumbImage = info.thumbImage!;
      late img.Image srcImage;
      if (Platform.isWindows) {
        // On windows, the thumbImage.buffer format is bgra
        srcImage = img.Image.fromBytes(
            thumbImage.width!, thumbImage.height!, thumbImage.buffer!,
            format: Format.bgra);
      } else {
        srcImage = img.Image.fromBytes(
            thumbImage.width!, thumbImage.height!, thumbImage.buffer!);
      }

      final srcWidth = srcImage.width;
      final srcHeight = srcImage.height;
      const dstWidth = 400;
      const dstHeight = 400;
      final x = srcWidth / 2.0 - dstWidth / 2.0;
      final y = srcHeight / 2.0 - dstHeight / 2.0;

      dstImage = copyCrop(srcImage, x.toInt(), y.toInt(), dstWidth, dstHeight);

      final imageBytes = encodePng(dstImage);

      final File imageFile =
          File(path.join(testPath, 'screenshot', '$screenshotName.png'));
      if (updateGolden == 'true') {
        imageFile.writeAsBytesSync(imageBytes);
      } else {
        if ((Platform.environment['SAVE_DEBUG_GOLDEN'] ?? 'false') == 'true') {
          final File debugGoldenFile =
              File('screenshot/$screenshotName.debug.png');
          debugGoldenFile.writeAsBytesSync(imageBytes);
        }

        final expectedImage = decodePng(imageFile.readAsBytesSync())!;
        return matchesDesktopGolden(expectedImage, dstImage);
      }

      return true;
    }
  }
  return false;
}

Future<bool> matchesDesktopGolden(img.Image expected, img.Image actual) async {
  final result = await compareImages(
    src1: expected,
    src2: actual,
    algorithm: PixelMatching(tolerance: 0.3),
  );
  debugPrint('compareImages result: $result');
  if (result >= (Platform.isMacOS ? 0.07 : 0.01)) {
    return false;
  }

  // The 100x100 video occupies only 6.25% of the 400x400 golden. A blank
  // white window can pass the macOS 7% tolerance; also require video content.
  final videoResult = await compareImages(
    src1: copyCrop(expected, 150, 150, 100, 100),
    src2: copyCrop(actual, 150, 150, 100, 100),
    algorithm: PixelMatching(tolerance: 0.3),
  );
  return videoResult < 0.5;
}
