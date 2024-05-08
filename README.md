# agora_rtc_engine

<p align="center">
    <a href="https://pub.dev/packages/agora_rtc_engine"><img src="https://img.shields.io/pub/likes/agora_rtc_engine?logo=dart" alt="Pub.dev likes"/></a>
    <a href="https://pub.dev/packages/agora_rtc_engine" alt="Pub.dev popularity"><img src="https://img.shields.io/pub/popularity/agora_rtc_engine?logo=dart"/></a>
    <a href="https://pub.dev/packages/agora_rtc_engine"><img src="https://img.shields.io/pub/points/agora_rtc_engine?logo=dart" alt="Pub.dev points"/></a><br/>
    <a href="https://pub.dev/packages/agora_rtc_engine"><img src="https://img.shields.io/pub/v/agora_rtc_engine.svg?include_prereleases" alt="latest version"/></a>
    <a href="https://pub.dev/packages/agora_rtc_engine"><img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20macOS%20%7C%20Windows-blue?logo=flutter" alt="Platform"/></a>
    <a href="./LICENSE"><img src="https://img.shields.io/github/license/agoraio-community/flutter-uikit?color=lightgray" alt="License"/></a>
    <a href="https://www.agora.io/en/join-slack/">
        <img src="https://img.shields.io/badge/slack-@RTE%20Dev-blue.svg?logo=slack" alt="RTE Dev Slack Link"/>
    </a>
</p>

> This Flutter plugin is a wrapper for [Agora Video SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)

Agora.io provides building blocks for you to add real-time voice and video communications through a simple and powerful SDK. You can integrate the Agora SDK to enable real-time communications in your own application quickly.


> NOTE: The `main` branch is major update base on the Agora Native SDK 4.x, which introduces some break changes. previous releases please see the following branches(the version < 6.0.0): 
>
> - [5.x](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/tree/master)

## Usage

To use this plugin, please add `agora_rtc_engine` as a dependency to
your [pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages) file.

## Getting Started

* Get some basic and advanced examples from the [example](example/lib/examples) folder.

### Privacy Permission

Agora Video SDK requires `Camera` and `Microphone` permission to start a video call.

#### Android
> For the latest permission settings, please refer to the documentation at https://docs.agora.io/en/video-calling/get-started/get-started-sdk?platform=android#project-setup

See the required device permissions from
the [AndroidManifest.xml](android/src/main/AndroidManifest.xml) file.

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!-- The Agora SDK requires Bluetooth permissions in case users are using Bluetooth devices. -->
<uses-permission android:name="android.permission.BLUETOOTH" />
<!-- For Android 12 and above devices, the following permission is also required. -->
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
```

#### iOS & macOS
> For the latest permission settings, please refer to the documentation at https://docs.agora.io/en/video-calling/get-started/get-started-sdk?platform=ios#project-setup

Open the `Info.plist` and add:

- `Privacy - Microphone Usage Description`，and add some description into the `Value` column.
- `Privacy - Camera Usage Description`, and add some description into the `Value` column.

#### Web (alpha)
> ***The `agora_rtc_engine` for web is currently in alpha stage, and the documentation is incomplete and it has only been tested on desktop web at this time.***
>
> The `agora_rtc_engine` web is built on top of [iris_web](https://github.com/AgoraIO-Extensions/iris_web), a wrapper for the [Agora Web SDK 4.x](https://api-ref.agora.io/en/video-sdk/web/4.x/index.html). This helps align the Native SDK (Android/iOS/macOS/Windows) APIs through the [Agora Web SDK 4.x](https://api-ref.agora.io/en/video-sdk/web/4.x/index.html). Please note that the agora_rtc_engine web utilizes the [Agora Web SDK 4.x](https://api-ref.agora.io/en/video-sdk/web/4.x/index.html) underneath, so only a subset of the Native SDK APIs can be implemented on the web. If the APIs return `AgoraRtcException` with a `-4` error code, this means these APIs are not supported at this time.

Download the `iris_web`(see the link below) artifact and include it as a `<script />` tag in your `<your-project>/web/index.html` file. For example:

**Project structure**
```
<your-project>
|__web
   |__index.html
   |__iris-web-rtc_<x.y.z>.js
```

```html
<!-- <your-project>/web/index.html -->
<!DOCTYPE html>
<html>
...
<body>
  ...
  <script src="iris-web-rtc_<x.y.z>.js"></script>
</body>
</html>
```
Download: https://download.agora.io/sdk/release/iris-web-rtc_n430_w4200_0.7.0.js

**For Testing Purposes**

You can directly depend on the Agora CDN for testing purposes:
```html
<!-- <your-project>/web/index.html -->
<!DOCTYPE html>
<html>
...
<body>
  ...
  <script src="https://download.agora.io/sdk/release/iris-web-rtc_n430_w4200_0.7.0.js"></script>
</body>
</html>
```

### Interact with Agora RTC Native SDK(Android/iOS only)
> **NOTE**: This feature requires `agora_rtc_engine` >= 6.3.0

Due to performance constraints, direct implementation of advanced features like video and audio raw data processing is not currently feasible in Flutter side.

We enable you to create an `RtcEngine` within Flutter by utilizing the native handle from the `RtcEngine`(Android) or `AgoraRtcEngineKit`(iOS) of the Agora RTC Native SDK. This approach enables your application to directly utilize the advanced features of the Agora RTC Native SDK through the `agora_rtc_engine` package, bridging the gap between native capabilities and Flutter's environment.

More detail, please check the [ProcessVideoRawData](example/lib/examples/advanced/process_video_raw_data/process_video_raw_data.dart) example for reference.

### Known issues
#### iOS not work on release mode

If you experience issues with iOS not working in release mode, you may need to set the configuration below to avoid stripping symbols.

Please refer to the [Flutter documentation](https://docs.flutter.dev/platform-integration/ios/c-interop#stripping-ios-symbols) for more information.

## API Reference Resources

* [Flutter](https://api-ref.agora.io/en/voice-sdk/flutter/6.x/API/rtc_api_overview_ng.html)
* [Android](https://api-ref.agora.io/en/voice-sdk/android/4.x/API/rtc_api_overview_ng.html)
* [iOS/macOS](https://api-ref.agora.io/en/voice-sdk/ios/4.x/API/rtc_api_overview_ng.html)
* [Windows](https://api-ref.agora.io/en/video-sdk/cpp/4.x/API/rtc_api_overview_ng.html)
* [Web](https://api-ref.agora.io/en/video-sdk/web/4.x/index.html)

## Feedback

If you have any problems or suggestions regarding the sample projects, feel free to file an [issue](https://github.com/AgoraIO-Community/agora_rtc_engine/issues) OR pull request.

## How to contribute

To help work on this sdk, please refer to [CONTRIBUTING.md](CONTRIBUTING.md).

## Related resources

- Check our [FAQ](https://docs.agora.io/en/faq) to see if your issue has been recorded.
- Dive into [Agora SDK Samples](https://github.com/AgoraIO) to see more tutorials.
- Take a look at [Agora Use Case](https://github.com/AgoraIO-usecase) for more complicated real use case.
- Repositories managed by developer communities can be found at [Agora Community](https://github.com/AgoraIO-Community).
- If you encounter problems during integration, feel free to ask questions in [Stack Overflow](https://stackoverflow.com/questions/tagged/agora.io).
- [Release notes](https://docs.agora.io/en/video-call-4.x-beta/release_flutter_ng?platform=Flutter).

## License

The project is under the MIT license.
