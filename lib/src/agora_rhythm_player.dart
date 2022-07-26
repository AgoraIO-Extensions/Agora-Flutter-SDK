import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rhythm_player.g.dart';

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum RhythmPlayerStateType {
  /// @nodoc
  @JsonValue(810)
  rhythmPlayerStateIdle,

  /// @nodoc
  @JsonValue(811)
  rhythmPlayerStateOpening,

  /// @nodoc
  @JsonValue(812)
  rhythmPlayerStateDecoding,

  /// @nodoc
  @JsonValue(813)
  rhythmPlayerStatePlaying,

  /// @nodoc
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

/// The metronome configuration.
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRhythmPlayerConfig {
  /// @nodoc
  const AgoraRhythmPlayerConfig({this.beatsPerMeasure, this.beatsPerMinute});

  /// The number of beats per measure, which ranges from 1 to 9. The default value is 4, which means that each measure contains one downbeat and three upbeats.
  @JsonKey(name: 'beatsPerMeasure')
  final int? beatsPerMeasure;

  /// The beat speed (beats/minute), which ranges from 60 to 360. The default value is 60, which means that the metronome plays 60 beats in one minute.
  @JsonKey(name: 'beatsPerMinute')
  final int? beatsPerMinute;

  /// @nodoc
  factory AgoraRhythmPlayerConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRhythmPlayerConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AgoraRhythmPlayerConfigToJson(this);
}
