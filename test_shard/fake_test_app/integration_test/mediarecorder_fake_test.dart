import 'package:integration_test/integration_test.dart';
import 'generated/mediarecorder_fake_test.generated.dart' as generated;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  generated.mediaRecorderSmokeTestCases();
}
