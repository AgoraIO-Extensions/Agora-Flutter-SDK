import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_h265_transcoder.g.dart';

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum H265TranscodeResult {
  /// @nodoc
  @JsonValue(-1)
  h265TranscodeResultUnknown,

  /// @nodoc
  @JsonValue(0)
  h265TranscodeResultSuccess,

  /// @nodoc
  @JsonValue(1)
  h265TranscodeResultRequestInvalid,

  /// @nodoc
  @JsonValue(2)
  h265TranscodeResultUnauthorized,

  /// @nodoc
  @JsonValue(3)
  h265TranscodeResultTokenExpired,

  /// @nodoc
  @JsonValue(4)
  h265TranscodeResultForbidden,

  /// @nodoc
  @JsonValue(5)
  h265TranscodeResultNotFound,

  /// @nodoc
  @JsonValue(6)
  h265TranscodeResultConflicted,

  /// @nodoc
  @JsonValue(7)
  h265TranscodeResultNotSupported,

  /// @nodoc
  @JsonValue(8)
  h265TranscodeResultTooOften,

  /// @nodoc
  @JsonValue(9)
  h265TranscodeResultServerInternalError,

  /// @nodoc
  @JsonValue(10)
  h265TranscodeResultServiceUnavailable,
}

/// @nodoc
extension H265TranscodeResultExt on H265TranscodeResult {
  /// @nodoc
  static H265TranscodeResult fromValue(int value) {
    return $enumDecode(_$H265TranscodeResultEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$H265TranscodeResultEnumMap[this]!;
  }
}

/// @nodoc
class H265TranscoderObserver {
  /// @nodoc
  const H265TranscoderObserver({
    this.onEnableTranscode,
    this.onQueryChannel,
    this.onTriggerTranscode,
  });

  /// @nodoc
  final void Function(H265TranscodeResult result)? onEnableTranscode;

  /// @nodoc
  final void Function(H265TranscodeResult result, String originChannel,
      String transcodeChannel)? onQueryChannel;

  /// @nodoc
  final void Function(H265TranscodeResult result)? onTriggerTranscode;
}

/// @nodoc
abstract class H265Transcoder {
  /// @nodoc
  Future<void> enableTranscode(
      {required String token, required String channel, required int uid});

  /// @nodoc
  Future<int> queryChannel(
      {required String token, required String channel, required int uid});

  /// @nodoc
  Future<void> triggerTranscode(
      {required String token, required String channel, required int uid});

  /// @nodoc
  void registerTranscoderObserver(H265TranscoderObserver observer);

  /// @nodoc
  void unregisterTranscoderObserver(H265TranscoderObserver observer);
}
