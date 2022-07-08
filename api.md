## Flutter Only API

### RtcEngine 
https://github.com/AgoraIO-Community/agora_rtc_ng_flutter/blob/dev/6.0.0/lib/src/agora_rtc_engine.dart#L2014-L2021
```dart
  /// Get the [AudioDeviceManager]
  AudioDeviceManager getAudioDeviceManager();

  /// Get the [VideoDeviceManager]
  VideoDeviceManager getVideoDeviceManager();

  /// see https://github.com/AgoraIO/Agora-Flutter-SDK/blob/050949cf3229aa72e49e9f8a8564b5a9bfc59e71/lib/src/rtc_engine.dart#L1764
  void sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType});

  /// see https://github.com/AgoraIO/Agora-Flutter-SDK/blob/050949cf3229aa72e49e9f8a8564b5a9bfc59e71/lib/src/rtc_engine.dart#L1756
  void setMaxMetadataSize(int size);
```

### agora_rtc_engine_ext.dart
见代码注释
https://github.com/AgoraIO-Community/agora_rtc_ng_flutter/blob/dev/6.0.0/lib/src/agora_rtc_engine_ext.dart

### SDKBuildInfo
可参考C++ getVersion
```dart
/// Get the SDK build information
class SDKBuildInfo {
  const SDKBuildInfo({this.buildNumber, this.version});

  /// The SDK build number
  @JsonKey(name: 'build_number')
  final int? buildNumber;

  /// The SDK version
  @JsonKey(name: 'version')
  final String? version;
  
}
```

https://github.com/AgoraIO-Community/agora_rtc_ng_flutter/blob/c2d289e96dd7ad37c72b3d5803ccc4b685ef87a8/lib/src/agora_rtc_engine.dart#L2207


### VideoDeviceInfo

参考IVideoDeviceCollection.getDevice描述

https://github.com/AgoraIO-Community/agora_rtc_ng_flutter/blob/c2d289e96dd7ad37c72b3d5803ccc4b685ef87a8/lib/src/agora_rtc_engine.dart#L2220

### AudioDeviceInfo

参考IAudioDeviceCollection.getDevice描述

https://github.com/AgoraIO-Community/agora_rtc_ng_flutter/blob/c2d289e96dd7ad37c72b3d5803ccc4b685ef87a8/lib/src/agora_rtc_engine.dart#L2233

### agora_video_view.dart
见代码注释
https://github.com/AgoraIO-Community/agora_rtc_ng_flutter/blob/dev/6.0.0/lib/src/render/agora_video_view.dart

### media_player_controller.dart
见代码注释
https://github.com/AgoraIO-Community/agora_rtc_ng_flutter/blob/dev/6.0.0/lib/src/render/media_player_controller.dart

### video_view_controller.dart
见代码注释
https://github.com/AgoraIO-Community/agora_rtc_ng_flutter/blob/dev/6.0.0/lib/src/render/video_view_controller.dart


