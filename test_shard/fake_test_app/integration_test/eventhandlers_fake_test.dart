import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'testcases/rtcengine_rtcengineeventhandler_testcases.dart'
    as rtcengine_rtcengineeventhandler;
import 'generated/rtcengine_audiospectrumobserver_testcases.generated.dart'
    as rtcengine_audiospectrumobserver;
import 'generated/rtcengine_audioencodedframeobserver_testcases.generated.dart'
    as rtcengine_audioencodedframeobserver;
import 'generated/rtcengine_metadataobserver_testcases.generated.dart'
    as rtcengine_metadataobserver;
import 'generated/mediaengine_videoframeobserver_testcases.generated.dart'
    as mediaengine_videoframeobserver;
import 'generated/mediaengine_videoencodedframeobserver_testcases.generated.dart'
    as mediaengine_videoencodedframeobserver;
import 'generated/mediaplayer_audiospectrumobserver_testcases.generated.dart'
    as mediaplayer_audiospectrumobserver;
import 'generated/mediaplayer_audiopcmframesink_testcases.generated.dart'
    as mediaplayer_audiopcmframesink;
import 'generated/mediaplayer_mediaplayersourceobserver_testcases.generated.dart'
    as mediaplayer_mediaplayersourceobserver;
import 'generated/mediaplayer_mediaplayervideoframeobserver_testcases.generated.dart'
    as mediaplayer_mediaplayervideoframeobserver;
import 'generated/mediarecorder_mediarecorderobserver_testcases.generated.dart'
    as mediarecorder_mediarecorderobserver;
import 'generated/musiccontentcenter_musiccontentcentereventhandler_testcases.generated.dart'
    as musiccontentcenter_musiccontentcentereventhandler;
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  IrisTester irisTester = IrisTester();

  setUp(() {
    irisTester.initialize();
    setMockRtcEngineNativeHandle(irisTester.getfakeRtcEngineHandle());
  });

  tearDown(() {
    irisTester.dispose();
    setMockRtcEngineNativeHandle(null);
  });

// RtcEngine events
  rtcengine_rtcengineeventhandler.testCases(irisTester);
  rtcengine_audiospectrumobserver.generatedTestCases(irisTester);
  rtcengine_audioencodedframeobserver.generatedTestCases(irisTester);
  rtcengine_metadataobserver.generatedTestCases(irisTester);

// MediaEngine events
  mediaengine_videoframeobserver.generatedTestCases(irisTester);
  mediaengine_videoencodedframeobserver.generatedTestCases(irisTester);

  // MediaPlayerController events
  mediaplayer_audiospectrumobserver.generatedTestCases(irisTester);
  mediaplayer_audiopcmframesink.generatedTestCases(irisTester);
  mediaplayer_mediaplayersourceobserver.generatedTestCases(irisTester);
  mediaplayer_mediaplayervideoframeobserver.generatedTestCases(irisTester);

  // MediaRecorder events
  mediarecorder_mediarecorderobserver.generatedTestCases(irisTester);

  // MusicContentCenter events
  musiccontentcenter_musiccontentcentereventhandler
      .generatedTestCases(irisTester);
}
