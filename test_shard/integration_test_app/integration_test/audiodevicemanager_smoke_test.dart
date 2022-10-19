import 'package:integration_test/integration_test.dart';
import 'generated/audiodevicemanager_smoke_test.generated.dart' as generated;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  generated.audioDeviceManagerSmokeTestCases();
}
