import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rhythm_player.g.dart';

/// 虚拟节拍器状态。
///
@JsonEnum(alwaysCreate: true)
enum RhythmPlayerStateType {
  /// 810：虚拟节拍器未开启或已关闭。
  @JsonValue(810)
  rhythmPlayerStateIdle,

  /// 811：正在打开节拍音频文件。
  @JsonValue(811)
  rhythmPlayerStateOpening,

  /// 812：正在解码节拍音频文件。
  @JsonValue(812)
  rhythmPlayerStateDecoding,

  /// 813：正在播放节拍音频文件。
  @JsonValue(813)
  rhythmPlayerStatePlaying,

  /// 814：开启虚拟节拍器失败。你可以通过报告的错误码 errorCode 排查错误原因，也可以重新尝试开启虚拟节拍器。
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

/// 虚拟节拍器错误信息。
///
@JsonEnum(alwaysCreate: true)
enum RhythmPlayerErrorType {
  /// 0：正常播放节拍音频文件，没有错误。
  @JsonValue(0)
  rhythmPlayerErrorOk,

  /// 1：一般性错误，没有明确原因。
  @JsonValue(1)
  rhythmPlayerErrorFailed,

  /// 801：打开节拍音频文件出错。
  @JsonValue(801)
  rhythmPlayerErrorCanNotOpen,

  /// 802：播放节拍音频文件出错。
  @JsonValue(802)
  rhythmPlayerErrorCanNotPlay,

  /// 803：节拍音频文件时长超出限制。最大时长为 1.2 秒。
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
