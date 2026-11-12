import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('native SDK initializes, reports its version and releases',
      (tester) async {
    const appId = String.fromEnvironment('TEST_APP_ID');
    expect(appId, isNotEmpty,
        reason: 'TEST_APP_ID is required for native smoke');

    final engine = createAgoraRtcEngine();
    addTearDown(() => engine.release().timeout(const Duration(seconds: 30)));
    await engine
        .initialize(const RtcEngineContext(appId: appId))
        .timeout(const Duration(seconds: 30));
    final info = await engine.getVersion().timeout(const Duration(seconds: 10));
    expect(info.version, isNotEmpty);
    // Record the loaded native version so dependency-update checks are reviewable.
    debugPrint(
        'Native SDK startup passed: ${info.version}, build ${info.build}');
  });
}
