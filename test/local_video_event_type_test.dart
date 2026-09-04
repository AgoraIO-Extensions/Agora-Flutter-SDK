import 'package:agora_rtc_engine/src/agora_base.dart';
import 'package:agora_rtc_engine/src/binding/event_handler_param_json.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('decodes camera focal length local video events', () {
    final applied = RtcEngineEventHandlerOnLocalVideoEventJson.fromJson(
      const {'source': 0, 'event': 5},
    );
    final fallback = RtcEngineEventHandlerOnLocalVideoEventJson.fromJson(
      const {'source': 0, 'event': 6},
    );

    expect(
      applied.event,
      LocalVideoEventType.localVideoEventTypeCameraFocalLengthApplied,
    );
    expect(
      fallback.event,
      LocalVideoEventType.localVideoEventTypeCameraFocalLengthFallbackToDefault,
    );
  });
}
