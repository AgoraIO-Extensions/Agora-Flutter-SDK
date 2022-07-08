import 'dart:io';

import 'package:paraphrase/paraphrase.dart';

enum GeneratorConfigPlatform {
  android,
  iOS,
  macOS,
  windows,
  linux,
}

extension GeneratorConfigPlatformExt on GeneratorConfigPlatform {
  String toPlatformExpression() {
    switch (this) {
      case GeneratorConfigPlatform.android:
        return 'Platform.isAndroid';
      case GeneratorConfigPlatform.iOS:
        return 'Platform.isIOS';
      case GeneratorConfigPlatform.macOS:
        return 'Platform.isMacOS';
      case GeneratorConfigPlatform.windows:
        return 'Platform.isWindows';
      case GeneratorConfigPlatform.linux:
        return 'Platform.isLinux';
    }
  }
}

class GeneratorConfig {
  const GeneratorConfig({
    required this.name,
    this.donotGenerate = false,
    this.supportedPlatforms = const [
      GeneratorConfigPlatform.android,
      GeneratorConfigPlatform.iOS,
      GeneratorConfigPlatform.macOS,
      GeneratorConfigPlatform.windows,
      GeneratorConfigPlatform.linux,
    ],
    this.shouldMockResult = false,
    this.shouldMockReturnCode = false,
  });
  final String name;
  final bool donotGenerate;
  final List<GeneratorConfigPlatform> supportedPlatforms;
  final bool shouldMockReturnCode;
  final bool shouldMockResult;
}

const List<GeneratorConfigPlatform> desktopPlatforms = [
  GeneratorConfigPlatform.macOS,
  GeneratorConfigPlatform.windows,
  GeneratorConfigPlatform.linux,
];

const List<GeneratorConfigPlatform> mobilePlatforms = [
  GeneratorConfigPlatform.android,
  GeneratorConfigPlatform.iOS,
];

IOSink? openSink(String? output) {
  if (output == null) {
    return null;
  }
  IOSink sink;
  File file;
  if (output == 'stdout') {
    sink = stdout;
  } else {
    file = File(output);
    sink = file.openWrite();
  }
  return sink;
}

abstract class Generator {
  void generate(StringSink sink, ParseResult parseResult);

  IOSink? shouldGenerate(ParseResult parseResult);
}
