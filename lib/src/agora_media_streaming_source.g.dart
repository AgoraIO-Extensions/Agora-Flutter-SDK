// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: non_constant_identifier_names, deprecated_member_use_from_same_package, unused_element

part of 'agora_media_streaming_source.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputSeiData _$InputSeiDataFromJson(Map<String, dynamic> json) => InputSeiData(
      type: (json['type'] as num?)?.toInt(),
      timestamp: (json['timestamp'] as num?)?.toInt(),
      frameIndex: (json['frame_index'] as num?)?.toInt(),
      dataSize: (json['data_size'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InputSeiDataToJson(InputSeiData instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type);
  writeNotNull('timestamp', instance.timestamp);
  writeNotNull('frame_index', instance.frameIndex);
  writeNotNull('data_size', instance.dataSize);
  return val;
}

const _$StreamingSrcErrEnumMap = {
  StreamingSrcErr.streamingSrcErrNone: 0,
  StreamingSrcErr.streamingSrcErrUnknown: 1,
  StreamingSrcErr.streamingSrcErrInvalidParam: 2,
  StreamingSrcErr.streamingSrcErrBadState: 3,
  StreamingSrcErr.streamingSrcErrNoMem: 4,
  StreamingSrcErr.streamingSrcErrBufferOverflow: 5,
  StreamingSrcErr.streamingSrcErrBufferUnderflow: 6,
  StreamingSrcErr.streamingSrcErrNotFound: 7,
  StreamingSrcErr.streamingSrcErrTimeout: 8,
  StreamingSrcErr.streamingSrcErrExpired: 9,
  StreamingSrcErr.streamingSrcErrUnsupported: 10,
  StreamingSrcErr.streamingSrcErrNotExist: 11,
  StreamingSrcErr.streamingSrcErrExist: 12,
  StreamingSrcErr.streamingSrcErrOpen: 13,
  StreamingSrcErr.streamingSrcErrClose: 14,
  StreamingSrcErr.streamingSrcErrRead: 15,
  StreamingSrcErr.streamingSrcErrWrite: 16,
  StreamingSrcErr.streamingSrcErrSeek: 17,
  StreamingSrcErr.streamingSrcErrEof: 18,
  StreamingSrcErr.streamingSrcErrCodecopen: 19,
  StreamingSrcErr.streamingSrcErrCodecclose: 20,
  StreamingSrcErr.streamingSrcErrCodecproc: 21,
};

const _$StreamingSrcStateEnumMap = {
  StreamingSrcState.streamingSrcStateClosed: 0,
  StreamingSrcState.streamingSrcStateOpening: 1,
  StreamingSrcState.streamingSrcStateIdle: 2,
  StreamingSrcState.streamingSrcStatePlaying: 3,
  StreamingSrcState.streamingSrcStateSeeking: 4,
  StreamingSrcState.streamingSrcStateEof: 5,
  StreamingSrcState.streamingSrcStateError: 6,
};
