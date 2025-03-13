abstract class AgoraSerializable {
  Map<String, dynamic> toJson();

  @override
  String toString() => '$runtimeType({$toJson()})';
}
