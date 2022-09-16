import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_media_streaming_source.g.dart';

@JsonEnum(alwaysCreate: true)
enum StreamingSrcErr {
  @JsonValue(0)
  streamingSrcErrNone,

  @JsonValue(1)
  streamingSrcErrUnknown,

  @JsonValue(2)
  streamingSrcErrInvalidParam,

  @JsonValue(3)
  streamingSrcErrBadState,

  @JsonValue(4)
  streamingSrcErrNoMem,

  @JsonValue(5)
  streamingSrcErrBufferOverflow,

  @JsonValue(6)
  streamingSrcErrBufferUnderflow,

  @JsonValue(7)
  streamingSrcErrNotFound,

  @JsonValue(8)
  streamingSrcErrTimeout,

  @JsonValue(9)
  streamingSrcErrExpired,

  @JsonValue(10)
  streamingSrcErrUnsupported,

  @JsonValue(11)
  streamingSrcErrNotExist,

  @JsonValue(12)
  streamingSrcErrExist,

  @JsonValue(13)
  streamingSrcErrOpen,

  @JsonValue(14)
  streamingSrcErrClose,

  @JsonValue(15)
  streamingSrcErrRead,

  @JsonValue(16)
  streamingSrcErrWrite,

  @JsonValue(17)
  streamingSrcErrSeek,

  @JsonValue(18)
  streamingSrcErrEof,

  @JsonValue(19)
  streamingSrcErrCodecopen,

  @JsonValue(20)
  streamingSrcErrCodecclose,

  @JsonValue(21)
  streamingSrcErrCodecproc,
}

/// Extensions functions of [StreamingSrcErr].
extension StreamingSrcErrExt on StreamingSrcErr {
  /// @nodoc
  static StreamingSrcErr fromValue(int value) {
    return $enumDecode(_$StreamingSrcErrEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$StreamingSrcErrEnumMap[this]!;
  }
}

@JsonEnum(alwaysCreate: true)
enum StreamingSrcState {
  @JsonValue(0)
  streamingSrcStateClosed,

  @JsonValue(1)
  streamingSrcStateOpening,

  @JsonValue(2)
  streamingSrcStateIdle,

  @JsonValue(3)
  streamingSrcStatePlaying,

  @JsonValue(4)
  streamingSrcStateSeeking,

  @JsonValue(5)
  streamingSrcStateEof,

  @JsonValue(6)
  streamingSrcStateError,
}

/// Extensions functions of [StreamingSrcState].
extension StreamingSrcStateExt on StreamingSrcState {
  /// @nodoc
  static StreamingSrcState fromValue(int value) {
    return $enumDecode(_$StreamingSrcStateEnumMap, value);
  }

  /// @nodoc
  int value() {
    return _$StreamingSrcStateEnumMap[this]!;
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class InputSeiData {
  const InputSeiData(
      {this.type,
      this.timestamp,
      this.frameIndex,
      this.privateData,
      this.dataSize});

  @JsonKey(name: 'type')
  final int? type;

  @JsonKey(name: 'timestamp')
  final int? timestamp;

  @JsonKey(name: 'frame_index')
  final int? frameIndex;

  @JsonKey(name: 'private_data', ignore: true)
  final Uint8List? privateData;

  @JsonKey(name: 'data_size')
  final int? dataSize;
  factory InputSeiData.fromJson(Map<String, dynamic> json) =>
      _$InputSeiDataFromJson(json);
  Map<String, dynamic> toJson() => _$InputSeiDataToJson(this);
}
