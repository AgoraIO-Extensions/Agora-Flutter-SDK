import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'apis_call_fake_test.dart';
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
import 'package:iris_method_channel/iris_method_channel.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  IrisTester? irisTester; // = createIrisTester();

  setUp(() {
    irisTester = createIrisTester();
    irisTester!.initialize();
    if (kIsWeb) {
      setMockRtcEngineProvider(
          TestInitilizationArgProvider(irisTester!.getTesterArgs()));
    } else {
      // On IO, the function return from the `irisTester.getTesterArgs()` capture
      // the `Pointer` from `IrisTester`, which is invalid to pass to the `Isolate`,
      // so directly pass the `ObjectIrisHandle` as value to the `setMockRtcEngineProvider`
      final value =
          irisTester!.getTesterArgs()[0](const IrisApiEngineHandle(0));
      setMockRtcEngineProvider(
          TestInitilizationArgProvider.fromValue(ObjectIrisHandle(value)));
    }
  });

  tearDown(() async {
    setMockRtcEngineProvider(null);
    irisTester!.dispose();
    irisTester = null;
    await Future.delayed(const Duration(milliseconds: 500));
  });

  // RtcEngine events
  rtcengine_rtcengineeventhandler.testCases(irisTester!);

  // These callbacks not are implemented on web
  if (!kIsWeb) {
    rtcengine_audiospectrumobserver.generatedTestCases(irisTester!);
    rtcengine_audioencodedframeobserver.generatedTestCases(irisTester!);
    rtcengine_metadataobserver.generatedTestCases(irisTester!);

    // MediaEngine events
    mediaengine_videoframeobserver.generatedTestCases(irisTester!);
    mediaengine_videoencodedframeobserver.generatedTestCases(irisTester!);

    // MediaPlayerController events
    mediaplayer_audiospectrumobserver.generatedTestCases(irisTester!);
    mediaplayer_audiopcmframesink.generatedTestCases(irisTester!);
    mediaplayer_mediaplayersourceobserver.generatedTestCases(irisTester!);
    mediaplayer_mediaplayervideoframeobserver.generatedTestCases(irisTester!);

    // MediaRecorder events
    mediarecorder_mediarecorderobserver.generatedTestCases(irisTester!);

    // MusicContentCenter events
    musiccontentcenter_musiccontentcentereventhandler
        .generatedTestCases(irisTester!);
  }
}
