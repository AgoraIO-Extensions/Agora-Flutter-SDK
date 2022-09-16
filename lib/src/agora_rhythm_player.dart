import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rhythm_player.g.dart';

@JsonEnum(alwaysCreate: true)
enum RhythmPlayerStateType {
  @JsonValue(810)
  rhythmPlayerStateIdle,

  @JsonValue(811)
  rhythmPlayerStateOpening,

  @JsonValue(812)
  rhythmPlayerStateDecoding,

  @JsonValue(813)
  rhythmPlayerStatePlaying,

  @JsonValue(814)
  rhythmPlayerStateFailed,
}

/// Extensions functions of [RhythmPlayerStateType].
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

@JsonEnum(alwaysCreate: true)
enum RhythmPlayerErrorType {
  @JsonValue(0)
  rhythmPlayerErrorOk,

  @JsonValue(1)
  rhythmPlayerErrorFailed,

  @JsonValue(801)
  rhythmPlayerErrorCanNotOpen,

  @JsonValue(802)
  rhythmPlayerErrorCanNotPlay,

  @JsonValue(803)
  rhythmPlayerErrorFileOverDurationLimit,
}

/// Extensions functions of [RhythmPlayerErrorType].
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

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRhythmPlayerConfig {
  const AgoraRhythmPlayerConfig({this.beatsPerMeasure, this.beatsPerMinute});

  @JsonKey(name: 'beatsPerMeasure')
  final int? beatsPerMeasure;

  @JsonKey(name: 'beatsPerMinute')
  final int? beatsPerMinute;
  factory AgoraRhythmPlayerConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRhythmPlayerConfigFromJson(json);
  Map<String, dynamic> toJson() => _$AgoraRhythmPlayerConfigToJson(this);
}
