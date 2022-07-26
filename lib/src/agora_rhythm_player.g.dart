// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_rhythm_player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AgoraRhythmPlayerConfig _$AgoraRhythmPlayerConfigFromJson(
        Map<String, dynamic> json) =>
    AgoraRhythmPlayerConfig(
      beatsPerMeasure: json['beatsPerMeasure'] as int?,
      beatsPerMinute: json['beatsPerMinute'] as int?,
    );

Map<String, dynamic> _$AgoraRhythmPlayerConfigToJson(
    AgoraRhythmPlayerConfig instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('beatsPerMeasure', instance.beatsPerMeasure);
  writeNotNull('beatsPerMinute', instance.beatsPerMinute);
  return val;
}

const _$RhythmPlayerStateTypeEnumMap = {
  RhythmPlayerStateType.rhythmPlayerStateIdle: 810,
  RhythmPlayerStateType.rhythmPlayerStateOpening: 811,
  RhythmPlayerStateType.rhythmPlayerStateDecoding: 812,
  RhythmPlayerStateType.rhythmPlayerStatePlaying: 813,
  RhythmPlayerStateType.rhythmPlayerStateFailed: 814,
};

const _$RhythmPlayerErrorTypeEnumMap = {
  RhythmPlayerErrorType.rhythmPlayerErrorOk: 0,
  RhythmPlayerErrorType.rhythmPlayerErrorFailed: 1,
  RhythmPlayerErrorType.rhythmPlayerErrorCanNotOpen: 801,
  RhythmPlayerErrorType.rhythmPlayerErrorCanNotPlay: 802,
  RhythmPlayerErrorType.rhythmPlayerErrorFileOverDurationLimit: 803,
};
