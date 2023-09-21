import 'dart:io';
import 'package:image_compare/image_compare.dart';
import 'package:integration_test/integration_test_driver_extended.dart';
import 'package:image/image.dart';

/// export UPDATE_GOLDEN="true"
const _udpateGoldenKey = 'UPDATE_GOLDEN';

Future<void> main() async {
  await integrationDriver(
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
        return true;
      }

      final expectedImage = decodePng(imageFile.readAsBytesSync());

      final result = await compareImages(
        src1: expectedImage,
        src2: dstImage,
        algorithm: PixelMatching(tolerance: 0.3),
      );

      stdout.writeln('compareImages result: $result');

      // TODO(littlegnal): Need more tolerance with this change:
      // https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/pull/1329
      //
      // see if we can reduce the result later
      return result < 0.01;
    },
  );
}
