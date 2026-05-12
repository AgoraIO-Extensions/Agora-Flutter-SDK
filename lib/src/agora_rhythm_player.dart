import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rhythm_player.g.dart';

/// Virtual metronome state.
@JsonEnum(alwaysCreate: true)
enum RhythmPlayerStateType {
  /// 810: The virtual metronome is not started or has been stopped.
  @JsonValue(810)
  rhythmPlayerStateIdle,

  /// 811: Opening the beat audio file.
  @JsonValue(811)
  rhythmPlayerStateOpening,

  /// 812: Decoding the beat audio file.
  @JsonValue(812)
  rhythmPlayerStateDecoding,

  /// 813: Playing the beat audio file.
  @JsonValue(813)
  rhythmPlayerStatePlaying,

  /// 814: Failed to start the virtual metronome. You can troubleshoot the issue using the reported error code errorCode, or try starting the virtual metronome again.
  @JsonValue(814)
  rhythmPlayerStateFailed,
}

/// @nodoc
extension RhythmPlayerStateTypeExt on RhythmPlayerStateType {
  /// @nodoc
  static RhythmPlayerStateType fromValue(int value) {
    return $enumDecode(_$RhythmPlayerStateTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RhythmPlayerStateTypeEnumMap[this]!;
  }
}

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum RhythmPlayerErrorType {
  /// @nodoc
  @JsonValue(0)
  rhythmPlayerErrorOk,

  /// @nodoc
  @JsonValue(1)
  rhythmPlayerErrorFailed,

  /// @nodoc
  @JsonValue(801)
  rhythmPlayerErrorCanNotOpen,

  /// @nodoc
  @JsonValue(802)
  rhythmPlayerErrorCanNotPlay,

  /// @nodoc
  @JsonValue(803)
  rhythmPlayerErrorFileOverDurationLimit,
}

/// @nodoc
extension RhythmPlayerErrorTypeExt on RhythmPlayerErrorType {
  /// @nodoc
  static RhythmPlayerErrorType fromValue(int value) {
    return $enumDecode(_$RhythmPlayerErrorTypeEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RhythmPlayerErrorTypeEnumMap[this]!;
  }
}

/// Virtual metronome configuration.
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRhythmPlayerConfig {
  /// @nodoc
  const AgoraRhythmPlayerConfig({this.beatsPerMeasure, this.beatsPerMinute});

  /// Number of beats per measure, range: [1,9]. Default is 4, which means 1 strong beat and 3 weak beats per measure.
  @JsonKey(name: 'beatsPerMeasure')
  final int? beatsPerMeasure;

  /// Tempo (beats per minute), range: [60,360]. Default is 60, meaning 60 beats per minute.
  @JsonKey(name: 'beatsPerMinute')
  final int? beatsPerMinute;

  /// @nodoc
  factory AgoraRhythmPlayerConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRhythmPlayerConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AgoraRhythmPlayerConfigToJson(this);
}
