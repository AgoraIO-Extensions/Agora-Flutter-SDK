import 'package:integration_test/integration_test.dart';
import 'generated/audiodevicemanager_fake_test.generated.dart'
    as audiodevicemanager;
import 'testcases/localspatialaudioengine_testcases.dart'
    as localspatialaudioengine;
import 'generated/mediaengine_fake_test.generated.dart' as mediaengine;
import 'generated/mediaplayer_fake_test.generated.dart' as mediaplayer;
import 'generated/mediarecorder_fake_test.generated.dart' as mediarecorder;
import 'generated/musiccontentcenter_fake_test.generated.dart'
    as musiccontentcenter;
import 'testcases/rtcengine_debug_testcases.dart' as rtcengine_debug;
import 'testcases/rtcengine_testcases.dart' as rtcengine;
import 'testcases/rtcengineex_testcases.dart' as rtcengineex;
import 'generated/videodevicemanager_fake_test.generated.dart'
    as videodevicemanager;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  audiodevicemanager.audioDeviceManagerSmokeTestCases();
  localspatialaudioengine.testCases();

  mediaengine.mediaEngineSmokeTestCases();
  mediaplayer.mediaPlayerControllerSmokeTestCases();
  mediarecorder.mediaRecorderSmokeTestCases();
  musiccontentcenter.musicContentCenterSmokeTestCases();
  rtcengine_debug.testCases();
  rtcengine.testCases();
  rtcengineex.testCases();
  videodevicemanager.videoDeviceManagerSmokeTestCases();
}
