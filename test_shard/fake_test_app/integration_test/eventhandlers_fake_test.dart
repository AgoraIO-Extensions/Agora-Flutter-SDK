import 'package:integration_test/integration_test.dart';
import 'generated/rtcengine_rtcengineeventhandler_testcases.generated.dart'
    as rtcengine_rtcengineeventhandler;
import 'generated/rtcengine_audiospectrumobserver_testcases.generated.dart'
    as rtcengine_audiospectrumobserver;
import 'generated/rtcengine_audioencodedframeobserver_testcases.generated.dart'
    as rtcengine_audioencodedframeobserver;
import 'generated/rtcengine_metadataobserver_testcases.generated.dart'
    as rtcengine_metadataobserver;
import 'generated/mediaengine_audioframeobserver_testcases.generated.dart'
    as mediaengine_audioframeobserver;
import 'generated/mediaengine_videoframeobserver_testcases.generated.dart'
    as mediaengine_videoframeobserver;
import 'generated/mediaengine_videoencodedframeobserver_testcases.generated.dart'
    as mediaengine_videoencodedframeobserver;
import 'generated/mediaplayer_audiospectrumobserver_testcases.generated.dart'
    as mediaplayer_audiospectrumobserver;
import 'generated/mediaplayer_mediaplayeraudioframeobserver_testcases.generated.dart'
    as mediaplayer_mediaplayeraudioframeobserver;
import 'generated/mediaplayer_mediaplayersourceobserver_testcases.generated.dart'
    as mediaplayer_mediaplayersourceobserver;
import 'generated/mediaplayer_mediaplayervideoframeobserver_testcases.generated.dart'
    as mediaplayer_mediaplayervideoframeobserver;
import 'generated/mediarecorder_mediarecorderobserver_testcases.generated.dart'
    as mediarecorder_mediarecorderobserver;
import 'generated/musiccontentcenter_musiccontentcentereventhandler_testcases.generated.dart'
    as musiccontentcenter_musiccontentcentereventhandler;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

// RtcEngine events
  rtcengine_rtcengineeventhandler.generatedTestCases(binding);
  rtcengine_audiospectrumobserver.generatedTestCases(binding);
  rtcengine_audioencodedframeobserver.generatedTestCases(binding);
  rtcengine_metadataobserver.generatedTestCases(binding);

// MediaEngine events
  mediaengine_audioframeobserver.generatedTestCases(binding);
  mediaengine_videoframeobserver.generatedTestCases(binding);
  mediaengine_videoencodedframeobserver.generatedTestCases(binding);

  // MediaPlayerController events
  mediaplayer_audiospectrumobserver.generatedTestCases(binding);
  mediaplayer_mediaplayeraudioframeobserver.generatedTestCases(binding);
  mediaplayer_mediaplayersourceobserver.generatedTestCases(binding);
  mediaplayer_mediaplayervideoframeobserver.generatedTestCases(binding);

  // MediaRecorder events
  mediarecorder_mediarecorderobserver.generatedTestCases(binding);

  // MusicContentCenter events
  musiccontentcenter_musiccontentcentereventhandler.generatedTestCases(binding);
}
