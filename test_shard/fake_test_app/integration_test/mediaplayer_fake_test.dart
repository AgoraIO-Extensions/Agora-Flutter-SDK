import 'dart:async';
import 'dart:io';

import 'package:integration_test/integration_test.dart';
import 'generated/mediaplayer_fake_test.generated.dart' as generated;
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_test_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  generated.mediaPlayerControllerSmokeTestCases();
}
