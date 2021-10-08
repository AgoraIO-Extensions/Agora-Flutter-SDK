# agora_rtc_rawdata

The demo for [agora_rtc_engine](https://pub.dev/packages/agora_rtc_engine) rawdata feature.

## Important

The plugin only exports four methods to the dart layer that can register or unregister the observer.

```dart
class AgoraRtcRawdata {
  static const MethodChannel _channel =
      const MethodChannel('agora_rtc_rawdata');

  static Future<void> registerAudioFrameObserver(int engineHandle) {
    return _channel.invokeMethod('registerAudioFrameObserver', engineHandle);
  }

  static Future<void> unregisterAudioFrameObserver() {
    return _channel.invokeMethod('unregisterAudioFrameObserver');
  }

  static Future<void> registerVideoFrameObserver(int engineHandle) {
    return _channel.invokeMethod('registerVideoFrameObserver', engineHandle);
  }

  static Future<void> unregisterVideoFrameObserver() {
    return _channel.invokeMethod('unregisterVideoFrameObserver');
  }
}
```

The plugin changes the color of the video stream by the default:

* Change local video to green
* Change remote video to pink

You can find the code at:

* Android: [AgoraRtcRawdataPlugin.kt](android/src/main/kotlin/io/agora/agora_rtc_rawdata/AgoraRtcRawdataPlugin.kt)
  * Local video: `onCaptureVideoFrame`
  * Remote video: `onRenderVideoFrame`
* iOS: [AgoraRawdata.swift](ios/Classes/SwiftAgoraRtcRawdataPlugin.swift)
  * Local video: `onCapture`
  * Remote video: `onRenderVideoFrame`

**If you can program with C++, you should process raw data on the C++ layer to improve performance and remove code about
calling Android and iOS.**

You can find the code at:

* Android:
  * Audio: [AudioFrameObserver.cpp](cpp/android/AudioFrameObserver.cpp)
  * Video: [VideoFrameObserver.cpp](cpp/android/VideoFrameObserver.cpp)
* iOS:
  * Audio: [AgoraAudioFrameObserver.mm](ios/Base/AgoraAudioFrameObserver.mm)
  * Video: [AgoraVideoFrameObserver.mm](ios/Base/AgoraVideoFrameObserver.mm)

## Usage

```dart
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_rawdata/agora_rtc_rawdata.dart';

_initEngine() async {
    var engine = await RtcEngine.create(config.appId);
    await AgoraRtcRawdata.registerAudioFrameObserver(
        await engine.getNativeHandle());
    await AgoraRtcRawdata.registerVideoFrameObserver(
        await engine.getNativeHandle());
}
```

## Resources

* [Doc](https://docs.agora.io/en/Interactive%20Broadcast/landing-page?platform=Flutter) for `agora_rtc_engine`
* [Doc](https://docs.agora.io/en/Interactive%20Broadcast/raw_data_video_android?platform=Android) for Android raw video
  data
* [Doc](https://docs.agora.io/en/Interactive%20Broadcast/raw_data_video_apple?platform=iOS) for iOS raw video data

## License

MIT
