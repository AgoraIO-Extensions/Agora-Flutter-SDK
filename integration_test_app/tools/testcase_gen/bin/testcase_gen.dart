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

final List<Generator> generators = [
  const RtcEngineSubProcessSmokeTestGenerator(),
  const RtcEngineEventHandlerSomkeTestGenerator(),
  const RtcDeviceManagerSmokeTestGenerator(),
  const RtcChannelEventHandlerSomkeTestGenerator(),
  const MediaRecorderObserverSomkeTestGenerator(),
];

const file.FileSystem fileSystem = LocalFileSystem();

void main(List<String> arguments) {
  final srcDir = path.join(
    fileSystem.currentDirectory.absolute.path,
    'lib',
    'src',
  );
  final List<String> includedPaths = <String>[
    path.join(srcDir, 'rtc_engine.dart'),
    path.join(srcDir, 'enums.dart'),
    path.join(srcDir, 'classes.dart'),
    path.join(srcDir, 'rtc_device_manager.dart'),
    path.join(srcDir, 'rtc_channel_event_handler.dart'),
    path.join(srcDir, 'rtc_engine_event_handler.dart'),
    path.join(srcDir, 'event_types.dart'),
    path.join(srcDir, 'media_recorder.dart'),
  ];

  Paraphrase paraphrase = Paraphrase(includedPaths: includedPaths);
  final parseResult = paraphrase.visit();

  for (final generator in generators) {
    final sink = generator.shouldGenerate(parseResult);
    if (sink != null) {
      generator.generate(sink, parseResult);
      sink.flush();
    }
  }
}
