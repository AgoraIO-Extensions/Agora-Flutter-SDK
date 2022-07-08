import 'package:integration_test/integration_test.dart';
import 'generated/mediaplayer_smoke_test.generated.dart' as generated;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  generated.mediaPlayerControllerSmokeTestCases();
}
