import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  const examplePath =
      'example/lib/examples/advanced/camera_capturer_configuration/camera_capturer_configuration.dart';
  const indexPath = 'example/lib/examples/advanced/index.dart';
  const joinChannelVideoPath =
      'example/lib/examples/basic/join_channel_video/join_channel_video.dart';

  late String example;
  late String index;
  late String joinChannelVideo;

  setUpAll(() {
    example = File(examplePath).readAsStringSync();
    index = File(indexPath).readAsStringSync();
    joinChannelVideo = File(joinChannelVideoPath).readAsStringSync();
  });

  test('registers the dedicated Android example', () {
    expect(example, contains('class CameraCapturerConfiguration'));
    expect(
      index,
      matches(RegExp(
        r"if \(!kIsWeb && Platform\.isAndroid\)\s*\{\s*'name': 'CameraCapturerConfiguration',\s*'widget': const CameraCapturerConfiguration\(\)\s*\}",
      )),
    );
  });

  test('configures selected camera settings before joining', () {
    expect(example,
        contains('await _engine.setCameraCapturerConfiguration(cameraConfig)'));
    expect(example, contains('CameraDirection.values'));
    expect(example, contains('CameraFocalLengthType.values'));
    expect(example, contains('cameraDirection: _cameraDirection'));
    expect(example, contains('cameraFocalLengthType: _cameraFocalLengthType'));
    expect(example,
        contains('followEncodeDimensionRatio: _followEncodeDimensionRatio'));
    expect(example, contains('format: agora.VideoFormat('));
    expect(example, contains('int.tryParse(_widthController.text) ?? 960'));
    expect(example, contains('int.tryParse(_heightController.text) ?? 540'));
    expect(example, contains('int.tryParse(_fpsController.text) ?? 15'));
    expect(example, contains('controller: _widthController'));
    expect(example, contains('controller: _heightController'));
    expect(example, contains('controller: _fpsController'));
    for (final controller in [
      '_widthController',
      '_heightController',
      '_fpsController',
    ]) {
      expect(
        RegExp(
          'controller: ${RegExp.escape(controller)},'
          r'\s*decoration: const InputDecoration\([^)]*\),'
          r'\s*keyboardType: TextInputType\.number,'
          r'\s*enabled: !_isJoined,',
        ).hasMatch(example),
        isTrue,
        reason: '$controller must be disabled while joined',
      );
    }
    expect(example, contains('int.tryParse(_uidController.text) ?? 0'));
    final setConfig =
        example.indexOf('_engine.setCameraCapturerConfiguration(cameraConfig)');
    final startPreview = example.indexOf('_engine.startPreview()');
    final join = example.indexOf('_engine.joinChannel(');
    expect(setConfig, lessThan(startPreview));
    expect(startPreview, lessThan(join));
  });

  test('logs local focal-length event details only in the dedicated example',
      () {
    expect(example, contains('onLocalVideoEvent:'));
    expect(example, contains('source: \$source'));
    expect(example, contains('event: \$event'));
    expect(example, contains('value: \${event.value()}'));
    expect(
      example,
      isNot(contains('localVideoEventTypeCameraFocalLengthApplied')),
    );
    expect(
      example,
      isNot(contains('localVideoEventTypeCameraFocalLengthFallbackToDefault')),
    );
    expect(joinChannelVideo, isNot(contains('onLocalVideoEvent')));
  });
}
