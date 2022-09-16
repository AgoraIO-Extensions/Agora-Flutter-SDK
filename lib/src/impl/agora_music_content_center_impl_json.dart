import 'package:agora_rtc_engine/src/agora_music_content_center.dart';
import 'package:json_annotation/json_annotation.dart';
part 'agora_music_content_center_impl_json.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class MusicCollectionJson {
  /// @nodoc
  MusicCollectionJson(
      {required this.count,
      required this.total,
      required this.page,
      required this.pageSize,
      required this.music});

  @JsonKey(name: 'count')
  final int count;

  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'page')
  final int page;

  @JsonKey(name: 'pageSize')
  final int pageSize;

  @JsonKey(name: 'music')
  final List<Music>? music;

  /// @nodoc
  factory MusicCollectionJson.fromJson(Map<String, dynamic> json) =>
      _$MusicCollectionJsonFromJson(json);

  /// @nodoc
  Map<String, dynamic> toJson() => _$MusicCollectionJsonToJson(this);
}
