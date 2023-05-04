import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;
import 'package:image/image.dart';
import 'package:image_compare/image_compare.dart';
import 'package:path/path.dart' as path;

Future<void> matchScreenShotDesktop(
    RtcEngineEx rtcEngine, String screenshotName) async {
  String updateGolden =
      const String.fromEnvironment('UPDATE_GOLDEN', defaultValue: 'false');

  final executableFile = File(Platform.resolvedExecutable);
  late String testPath;
  if (Platform.isMacOS) {
    testPath = executableFile
        .parent.parent.parent.parent.parent.parent.parent.parent.parent.path;
  } else {
    testPath = executableFile.parent.parent.parent.parent.parent.path;
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
        final expectedImage = decodePng(imageFile.readAsBytesSync());

        double tolerance = 0.3;

        final result = await compareImages(
          src1: expectedImage,
          src2: dstImage,
          algorithm: PixelMatching(tolerance: tolerance),
        );
        debugPrint('compareImages result: $result');

        if (Platform.isMacOS) {
          // TODO(littlegnal): Need more tolerance after upgrade to the native sdk 4.2.0, see if
          // we can reduce the result later.
          expect(result < 0.07, isTrue);
        } else {
          expect(result < 0.01, isTrue);
        }
      }

      return;
    }
  }
}
