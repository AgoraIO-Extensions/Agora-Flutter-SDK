import 'package:agora_rtc_engine/src/binding_forward_export.dart';
part 'agora_media_streaming_source.g.dart';

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum StreamingSrcErr {
  /// @nodoc
  @JsonValue(0)
  streamingSrcErrNone,

  /// @nodoc
  @JsonValue(1)
  streamingSrcErrUnknown,

  /// @nodoc
  @JsonValue(2)
  streamingSrcErrInvalidParam,

  /// @nodoc
  @JsonValue(3)
  streamingSrcErrBadState,

  /// @nodoc
  @JsonValue(4)
  streamingSrcErrNoMem,

  /// @nodoc
  @JsonValue(5)
  streamingSrcErrBufferOverflow,

  /// @nodoc
  @JsonValue(6)
  streamingSrcErrBufferUnderflow,

  /// @nodoc
  @JsonValue(7)
  streamingSrcErrNotFound,

  /// @nodoc
  @JsonValue(8)
  streamingSrcErrTimeout,

  /// @nodoc
  @JsonValue(9)
  streamingSrcErrExpired,

  /// @nodoc
  @JsonValue(10)
  streamingSrcErrUnsupported,

  /// @nodoc
  @JsonValue(11)
  streamingSrcErrNotExist,

  /// @nodoc
  @JsonValue(12)
  streamingSrcErrExist,

  /// @nodoc
  @JsonValue(13)
  streamingSrcErrOpen,

  /// @nodoc
  @JsonValue(14)
  streamingSrcErrClose,

  /// @nodoc
  @JsonValue(15)
  streamingSrcErrRead,

  /// @nodoc
  @JsonValue(16)
  streamingSrcErrWrite,

  /// @nodoc
  @JsonValue(17)
  streamingSrcErrSeek,

  /// @nodoc
  @JsonValue(18)
  streamingSrcErrEof,

  /// @nodoc
  @JsonValue(19)
  streamingSrcErrCodecopen,

  /// @nodoc
  @JsonValue(20)
  streamingSrcErrCodecclose,

  /// @nodoc
  @JsonValue(21)
  streamingSrcErrCodecproc,
}

/// @nodoc
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

/// @nodoc
@JsonEnum(alwaysCreate: true)
enum StreamingSrcState {
  /// @nodoc
  @JsonValue(0)
  streamingSrcStateClosed,

  /// @nodoc
  @JsonValue(1)
  streamingSrcStateOpening,

  /// @nodoc
  @JsonValue(2)
  streamingSrcStateIdle,

  /// @nodoc
  @JsonValue(3)
  streamingSrcStatePlaying,

  /// @nodoc
  @JsonValue(4)
  streamingSrcStateSeeking,

  /// @nodoc
  @JsonValue(5)
  streamingSrcStateEof,

  /// @nodoc
  @JsonValue(6)
  streamingSrcStateError,
}

/// @nodoc
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

/// @nodoc
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class InputSeiData {
  /// @nodoc
  const InputSeiData(
      {this.type,
      this.timestamp,
      this.frameIndex,
      this.privateData,
      this.dataSize});

  /// @nodoc
  @JsonKey(name: 'type')
  final int? type;

  /// @nodoc
  @JsonKey(name: 'timestamp')
  final int? timestamp;

  /// @nodoc
  @JsonKey(name: 'frame_index')
  final int? frameIndex;

  /// @nodoc
  @JsonKey(name: 'private_data', ignore: true)
  final Uint8List? privateData;

  /// @nodoc
  @JsonKey(name: 'data_size')
  final int? dataSize;

  /// @nodoc
  factory InputSeiData.fromJson(Map<String, dynamic> json) =>
      _$InputSeiDataFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$InputSeiDataToJson(this);
}
