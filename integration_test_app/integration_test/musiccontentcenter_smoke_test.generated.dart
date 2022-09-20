import 'package:integration_test/integration_test.dart';

import 'generated/musiccontentcenter_smoke_test.generated.dart' as generated;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  generated.musicContentCenterSmokeTestCases();
}