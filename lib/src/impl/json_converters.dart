import 'package:agora_rtc_engine/src/agora_media_base.dart';
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
class _VideoFrameMetaInfoInternalJson {
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
  Map<String, dynamic> toJson() => _$VideoFrameMetaInfoInternalJsonToJson(this);
}
