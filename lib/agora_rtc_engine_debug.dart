import 'package:agora_rtc_engine/src/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/src/impl/agora_rtc_engine_impl.dart';

extension RtcEngineDebug on RtcEngine {
  Future<void> startDumpVideo(int type, String dir) async {
    return (this as RtcEngineImpl).startDumpVideo(type, dir);
  }

  Future<void> stopDumpVideo() {
    return (this as RtcEngineImpl).stopDumpVideo();
  }
}
