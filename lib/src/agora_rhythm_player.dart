import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_rhythm_player.g.dart';

/// Virtual metronome state.
@JsonEnum(alwaysCreate: true)
enum RhythmPlayerStateType {
  /// (810): The virtual metronome is not enabled or disabled already.
  @JsonValue(810)
  rhythmPlayerStateIdle,

  /// 811: Opening the beat files.
  @JsonValue(811)
  rhythmPlayerStateOpening,

  /// 812: Decoding the beat files.
  @JsonValue(812)
  rhythmPlayerStateDecoding,

  /// 813: The beat files are playing.
  @JsonValue(813)
  rhythmPlayerStatePlaying,

  /// 814: Failed to start virtual metronome. You can use the reported errorCode to troubleshoot the cause of the error, or you can try to start the virtual metronome again.
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
enum RhythmPlayerReason {
  /// @nodoc
  @JsonValue(0)
  rhythmPlayerReasonOk,

  /// @nodoc
  @JsonValue(1)
  rhythmPlayerReasonFailed,

  /// @nodoc
  @JsonValue(801)
  rhythmPlayerReasonCanNotOpen,

  /// @nodoc
  @JsonValue(802)
  rhythmPlayerReasonCanNotPlay,

  /// @nodoc
  @JsonValue(803)
  rhythmPlayerReasonFileOverDurationLimit,
}

/// @nodoc
extension RhythmPlayerReasonExt on RhythmPlayerReason {
  /// @nodoc
  static RhythmPlayerReason fromValue(int value) {
    return $enumDecode(_$RhythmPlayerReasonEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$RhythmPlayerReasonEnumMap[this]!;
  }
}

/// The metronome configuration.
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
