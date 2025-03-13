import '/src/_serializable.dart';
import '/src/agora_media_base.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_converters.g.dart';

class VideoFrameMetaInfoConverter
    implements JsonConverter<VideoFrameMetaInfo?, Object?> {
  const VideoFrameMetaInfoConverter();

  @override
  VideoFrameMetaInfo? fromJson(Object? json) {
    if (json is Map<String, dynamic>) {
      final obj = _VideoFrameMetaInfoInternalJson.fromJson(json);
      return _VideoFrameMetaInfoInternal(obj);
    }

    return null;
  }

  @override
  Object? toJson(VideoFrameMetaInfo? object) => null;
}

class _VideoFrameMetaInfoInternal implements VideoFrameMetaInfo {
  const _VideoFrameMetaInfoInternal(this.json);

  final _VideoFrameMetaInfoInternalJson json;

  @override
  Future<String> getMetaInfoStr(MetaInfoKey key) async {
    if (key == MetaInfoKey.keyFaceCapture) {
      return json.KEY_FACE_CAPTURE ?? '';
    }
    return '';
  }
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _VideoFrameMetaInfoInternalJson implements AgoraSerializable {
  // ignore: non_constant_identifier_names
  const _VideoFrameMetaInfoInternalJson({this.KEY_FACE_CAPTURE});
  @JsonKey(name: 'KEY_FACE_CAPTURE')
  // Directly match the native sdk naming.
  // ignore: non_constant_identifier_names
  final String? KEY_FACE_CAPTURE;

  /// @nodoc
  factory _VideoFrameMetaInfoInternalJson.fromJson(Map<String, dynamic> json) =>
      _$VideoFrameMetaInfoInternalJsonFromJson(json);

  /// @nodoc
  @override
  Map<String, dynamic> toJson() => _$VideoFrameMetaInfoInternalJsonToJson(this);
}

int _intPtrStr2Int(String value) {
  // In 64-bits system, the c++ int ptr value (unsigned long 64) can be 2^64 - 1,
  // which may greater than the dart int max value (2^63 - 1), so we can not decode
  // the json with big int c++ int ptr value and parse it directly.
  //
  // After dart sdk 2.0 support parse hexadecimal in unsigned int64 range.
  // https://github.com/dart-lang/language/blob/ee1135e0c22391cee17bf3ee262d6a04582d25de/archive/newsletter/20170929.md#semantics
  //
  // So we retrive the c++ int ptr value from the json string directly, and
  // parse an int from hexadecimal here.
  BigInt valueBI = BigInt.parse(value);
  return int.tryParse('0x${valueBI.toRadixString(16)}') ?? 0;
}

/// Parse a c++ int ptr value from the json key `<key>_str`
Object? readIntPtr(Map json, String key) {
  final newKey = '${key}_str';
  if (json.containsKey(newKey)) {
    final value = json[newKey];
    assert(value is String);
    return _intPtrStr2Int(value);
  }

  return json[key];
}

/// Same as `readIntPtr`, but for list of int ptr.
Object? readIntPtrList(Map json, String key) {
  final newKey = '${key}_str';
  if (json.containsKey(newKey)) {
    final value = json[newKey];
    assert(value is List);
    return List.from(value.map((e) => _intPtrStr2Int(e)));
  }

  return json[key];
}
