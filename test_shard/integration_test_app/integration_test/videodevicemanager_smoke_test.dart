import 'package:integration_test/integration_test.dart';
import 'generated/videodevicemanager_smoke_test.generated.dart' as generated;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  generated.videoDeviceManagerSmokeTestCases();
}
