import 'dart:io';

import 'package:args/args.dart';
import 'package:paraphrase/paraphrase.dart';
import 'package:testcase_gen/generator.dart';
import 'package:testcase_gen/media_recorder_observer_somke_test_generator.dart';
import 'package:testcase_gen/rtc_channel_event_handler_smoke_test_generator.dart';
import 'package:testcase_gen/rtc_device_manager_smoke_test_generator.dart';
import 'package:testcase_gen/rtc_engine_event_handler_somke_test_generator.dart';
import 'package:testcase_gen/rtc_engine_sub_process_smoke_test_generator.dart';
import 'package:file/file.dart' as file;
import 'package:file/local.dart';
import 'package:path/path.dart' as path;
import 'package:testcase_gen/templated_generator.dart';

import 'event_handler_gen_config.dart';
import 'method_call_gen_config.dart';

final List<Generator> generators = [
  const RtcEngineSubProcessSmokeTestGenerator(),
  const RtcEngineEventHandlerSomkeTestGenerator(),
  const RtcDeviceManagerSmokeTestGenerator(),
  const RtcChannelEventHandlerSomkeTestGenerator(),
  const MediaRecorderObserverSomkeTestGenerator(),
];

const file.FileSystem fileSystem = LocalFileSystem();

void main(List<String> arguments) {
  final parser = ArgParser();
  parser.addFlag('gen-integration-test');
  parser.addFlag('gen-fake-test');
  parser.addOption('output-dir', mandatory: true);

  final results = parser.parse(arguments);

  final genIntegrationTest = results['gen-integration-test'] ?? false;
  final genFakeTest = results['gen-fake-test'] ?? false;
  final outputDir = results['output-dir']!;

  final srcDir = path.join(
    fileSystem.currentDirectory.absolute.path,
    'lib',
    'src',
  );
  final List<String> includedPaths = <String>[
    path.join(srcDir, 'agora_base.dart'),
    path.join(srcDir, 'agora_log.dart'),
    path.join(srcDir, 'agora_media_base.dart'),
    path.join(srcDir, 'agora_media_player.dart'),
    path.join(srcDir, 'agora_media_player_types.dart'),
    path.join(srcDir, 'agora_media_player_source.dart'),
    path.join(srcDir, 'agora_rhythm_player.dart'),
    path.join(srcDir, 'agora_rtc_engine.dart'),
    path.join(srcDir, 'agora_rtc_engine_ex.dart'),
    path.join(srcDir, 'audio_device_manager.dart'),
    path.join(srcDir, 'agora_media_engine.dart'),
    path.join(srcDir, 'agora_spatial_audio.dart'),
    path.join(srcDir, 'agora_media_recorder.dart'),
    path.join(srcDir, 'agora_music_content_center.dart'),
    path.join(srcDir, 'agora_h265_transcoder.dart'),
    path.join(srcDir, 'render/media_player_controller.dart'),
  ];

  List<TemplatedTestCase> templatedTestCases = [];
  if (genIntegrationTest) {
    templatedTestCases = createIntegarationTestCases(outputDir);
  } else if (genFakeTest) {
    templatedTestCases = [
      ...createFakeTestCases(outputDir),
      ...createEventHandlerTestCases(outputDir),
    ];
  }

  Paraphrase paraphrase = Paraphrase(includedPaths: includedPaths);
  final parseResult = paraphrase.visit();

  final generator = TemplatedGenerator(templatedTestCases);

  final file = File('tmp');
  final fileSink = file.openWrite();
  generator.generate(fileSink, parseResult);

  file.delete(recursive: true);
}
