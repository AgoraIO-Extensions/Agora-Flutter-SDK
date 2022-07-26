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

/// 虚拟节拍器配置。
///
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class AgoraRhythmPlayerConfig {
  /// @nodoc
  const AgoraRhythmPlayerConfig({this.beatsPerMeasure, this.beatsPerMinute});

  /// 每小节的拍数，取值范围为 [1,9]。默认值为 4，即每小节包含 1 个强拍和 3 个弱拍。
  @JsonKey(name: 'beatsPerMeasure')
  final int? beatsPerMeasure;

  /// 节拍速度（拍/分钟），取值范围为 [60,360]。默认值为 60，即 1 分钟有 60 拍。
  @JsonKey(name: 'beatsPerMinute')
  final int? beatsPerMinute;

  /// @nodoc
  factory AgoraRhythmPlayerConfig.fromJson(Map<String, dynamic> json) =>
      _$AgoraRhythmPlayerConfigFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$AgoraRhythmPlayerConfigToJson(this);
}
