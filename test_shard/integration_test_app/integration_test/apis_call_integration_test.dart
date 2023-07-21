import 'package:integration_test/integration_test.dart';

import 'generated/mediaplayercachemanager_smoke_test.generated.dart'
    as mediaplayercachemanager;
import 'testcases/agora_video_view_testcases.dart' as agora_video_view;
import 'testcases/mediaengine_smoke_test_testcases.dart' as mediaengine;
import 'testcases/mediaplayer_smoke_test_testcases.dart' as mediaplayer;
import 'testcases/rtcengine_ext_smoke_test_testcases.dart' as rtcengine_ext;
import 'testcases/rtcengine_smoke_test_testcases.dart' as rtcengine;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // mediaplayercachemanager.mediaPlayerCacheManagerSmokeTestCases();
  agora_video_view.testCases();

  // mediaengine.testCases();
  // mediaplayer.testCases();
  // rtcengine_ext.testCases();
  // rtcengine.testCases();
}
