# agora_rtc_ng

<p align="center">
    <a href="https://pub.dev/packages/agora_rtc_ng"><img src="https://badges.bar/agora_rtc_ng/likes" alt="Pub.dev likes"/></a>
    <a href="https://pub.dev/packages/agora_rtc_ng" alt="Pub.dev popularity"><img src="https://badges.bar/agora_rtc_ng/popularity"/></a>
    <a href="https://pub.dev/packages/agora_rtc_ng"><img src="https://badges.bar/agora_rtc_ng/pub%20points" alt="Pub.dev points"/></a><br/>
    <a href="https://pub.dev/packages/agora_rtc_ng"><img src="https://img.shields.io/pub/v/agora_rtc_ng.svg?include_prereleases" alt="latest version"/></a>
    <a href="https://pub.dev/packages/agora_rtc_ng"><img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20macOS%20%7C%20Web%20%7C%20Windows-blue?logo=flutter" alt="Platform"/></a>
    <a href="./LICENSE"><img src="https://img.shields.io/github/license/agoraio-community/flutter-uikit?color=lightgray" alt="License"/></a>
    <a href="https://www.agora.io/en/join-slack/">
        <img src="https://img.shields.io/badge/slack-@RTE%20Dev-blue.svg?logo=slack" alt="RTE Dev Slack Link"/>
    </a>
</p>

> This Flutter plugin is a wrapper for [Agora Video SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)

Agora.io provides building blocks for you to add real-time voice and video communications through a simple and powerful SDK. You can integrate the Agora SDK to enable real-time communications in your own application quickly.

## Usage

To use this plugin, please add `agora_rtc_ng` as a dependency to
your [pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages) file.

## Getting Started

* Get some basic and advanced examples from the [example](example/lib/examples) folder.

### Privacy Permission

Agora Video SDK requires `Camera` and `Microphone` permission to start a video call.

#### Android

See the required device permissions from
the [AndroidManifest.xml](android/src/main/AndroidManifest.xml) file.

```xml

<manifest>
  ...
  <uses-permission android:name="android.permission.READ_PHONE_STATE" />
  <uses-permission android:name="android.permission.INTERNET" />
  <uses-permission android:name="android.permission.RECORD_AUDIO" />
  <uses-permission android:name="android.permission.CAMERA" />
  <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
  <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
  <uses-permission android:name="android.permission.BLUETOOTH" />
  <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
  <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
  <uses-permission android:name="android.permission.WAKE_LOCK" />
  <uses-permission android:name="android.permission.READ_PRIVILEGED_PHONE_STATE"
    tools:ignore="ProtectedPermissions" />
  ...
</manifest>
```

#### iOS & macOS

Open the `Info.plist` and add:

- `Privacy - Microphone Usage Description`，and add some description into the `Value` column.
- `Privacy - Camera Usage Description`, and add some description into the `Value` column.

### Multiple Platforms

The [agora_rtc_ng](https://pub.dev/packages/agora_rtc_ng) supports Android/iOS/macOS/Windows, but not support Web yet.

## API Reference Resources

* [Flutter](https://docs.agora.io/en/video-call-4.x-beta/API%20Reference/flutter_ng/API/rtc_api_overview_ng.html)
* [Android](https://docs-preprod.agora.io/cn/video-call-4.x-beta/API%20Reference/java_ng/API/rtc_api_overview_ng.html)
* [iOS/macOS](https://docs-preprod.agora.io/cn/video-call-4.x-beta/API%20Reference/mac_ng/API/rtc_api_overview_ng.html)
* [Windows](https://docs-preprod.agora.io/cn/video-call-4.x-beta/API%20Reference/windows_ng/API/rtc_api_overview_ng.html)
* [Web](https://docs.agora.io/en/Video/API%20Reference/web_ng/index.html)

## Feedback

If you have any problems or suggestions regarding the sample projects, feel free to file an [issue](https://github.com/AgoraIO-Community/agora_rtc_ng/issues) OR pull request.

## How to contribute

To help work on this sdk, please refer to [CONTRIBUTING.md](https://github.com/AgoraIO-Community/agora_rtc_ng/blob/main/CONTRIBUTING.md).

## Related resources

- Check our [FAQ](https://docs.agora.io/en/faq) to see if your issue has been recorded.
- Dive into [Agora SDK Samples](https://github.com/AgoraIO) to see more tutorials.
- Take a look at [Agora Use Case](https://github.com/AgoraIO-usecase) for more complicated real use case.
- Repositories managed by developer communities can be found at [Agora Community](https://github.com/AgoraIO-Community).
- If you encounter problems during integration, feel free to ask questions in [Stack Overflow](https://stackoverflow.com/questions/tagged/agora.io).

## License

The project is under the MIT license.
