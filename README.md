# Agora RTC SDK for Flutter

<p align="center">
    <a href="https://pub.dev/packages/agora_rtc_engine"><img src="https://badges.bar/agora_rtc_engine/likes" alt="Pub.dev likes"/></a>
    <a href="https://pub.dev/packages/agora_rtc_engine" alt="Pub.dev popularity"><img src="https://badges.bar/agora_rtc_engine/popularity"/></a>
    <a href="https://pub.dev/packages/agora_rtc_engine"><img src="https://badges.bar/agora_rtc_engine/pub%20points" alt="Pub.dev points"/></a><br/>
    <a href="https://pub.dev/packages/agora_rtc_engine"><img src="https://img.shields.io/pub/v/agora_rtc_engine.svg?include_prereleases" alt="latest version"/></a>
    <a href="https://pub.dev/packages/agora_rtc_engine"><img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20macOS%20%7C%20Web%20%7C%20Windows-blue?logo=flutter" alt="Platform"/></a>
    <a href="./LICENSE"><img src="https://img.shields.io/github/license/agoraio-community/flutter-uikit?color=lightgray" alt="License"/></a>
    <a href="https://www.agora.io/en/join-slack/">
        <img src="https://img.shields.io/badge/slack-@RTE%20Dev-blue.svg?logo=slack" alt="RTE Dev Slack Link"/>
    </a>
</p>



[中文](README.zh.md)

> This Flutter plugin is a wrapper for [Agora Video SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)

Agora.io provides building blocks for you to add real-time voice and video communications through a simple and powerful SDK. You can integrate the Agora SDK to enable real-time communications in your own application quickly.

## Usage

To use this plugin, please add `agora_rtc_engine` as a dependency to
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

## Flutter2 support

### Null Safety

Null safety is supported from [4.0.1](https://pub.dev/packages/agora_rtc_engine/versions/4.0.1) version. This version is not backwards compatible, your project needs to be migrated to null safety. For more information, please refer to [Migrating to null safety](https://dart.dev/null-safety/migration-guide).

### Multiple Platforms

#### Linux

Not support yet.

#### macOS

You can get more info from the [agora_rtc_engine.podspec](macos/agora_rtc_engine.podspec) file, such as dependency Libraries on macOS.

#### Windows

You can get more info from the [CMakeLists.text](windows/CMakeLists.txt) file, such as dependency Libraries on Windows.

#### Web

We use the [js](https://pub.dev/packages/js) library to call JavaScript from the dart layer.

We have a wrapper library named [AgoraRtcWrapper.bundle.js](example/web/AgoraRtcWrapper.bundle.js) for the Web SDK, so you should add it to your `index.html`, you can refer to [example/web/index.html](example/web/index.html).

```html
<script src="AgoraRtcWrapper.bundle.js" type="application/javascript"></script>
```

This wrapper library is the output of the open-source repository [Iris-Rtc-Web](https://github.com/AgoraIO-Community/Iris-Rtc-Web). The repository attempt to mapping the API from Web SDK as Native SDK, we make it open-source to help developer positioning and troubleshooting.

We have imported it as a Git submodule, you can find it in the [web](web) folder.

## Error handling

Please check **Pinned issues** and search in [Issues](https://github.com/AgoraIO/Agora-Flutter-SDK/issues) first.

### [Background mode #28](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/28)

#### Android

[Android 9.0 Background Capture](https://docs.agora.io/en/Interactive%20Broadcast/faq/android_background?platform=Android)

#### iOS

Select your **TARGET** in Xcode, and click the `Signing & Capabilities` tab, then enable `Background Modes` and check `Audio, AirPlay, and Picture in Picture`.

### [RawData #183](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/183)

Currently supported for Android and iOS.

### [Using flutter assets #181](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/181)

### Screen Sharing

Only supported on Web, macOS and Windows so far. Not yet supported for Android and iOS.

**Important**

You should set `AppGroup` on macOS and set as parameter before calling `getScreenShareHelper`.

You can refer to [screen_sharing.dart](example/lib/examples/advanced/screen_sharing/screen_sharing.dart) and [Apple doc](https://developer.apple.com/library/archive/documentation/Security/Conceptual/AppSandboxDesignGuide/AppSandboxInDepth/AppSandboxInDepth.html#//apple_ref/doc/uid/TP40011183-CH3-SW21).

## Experimental Features

### Interact with RtcEngine/AgoraRtcEngineKit on Android/iOS

`agora_rtc_engine` has not implemented all the features of agora native (Android/iOS) sdk, due to performance reasons, such
as [Custom Audio Source and Renderer](https://docs.agora.io/en/Video/custom_audio_android?platform=Android), [Custom Video Source and Renderer](https://docs.agora.io/en/Video/custom_video_android?platform=Android), [Raw Audio Data](https://docs.agora.io/en/Video/raw_data_audio_android?platform=Android), etc.

`agora_rtc_engine` provides [RtcEnginePlugin](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/android/src/main/java/io/agora/rtc/base/RtcEnginePlugin.kt)/[RtcEnginePlugin](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/ios/Classes/Base/RtcEnginePlugin.h), allowing you to to interact with the [RtcEngine](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/lib/src/rtc_engine.dart) created on the Flutter side in the Android/iOS code, you can implement your own plugin by inheriting [RtcEnginePlugin](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/android/src/main/java/io/agora/rtc/base/RtcEnginePlugin.kt)/[RtcEnginePlugin](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/ios/Classes/Base/RtcEnginePlugin.h), and get the [RtcEngine](https://docs.agora.io/en/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html)/[AgoraRtcEngineKit](https://docs.agora.io/en/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html) in the `onRtcEngineCreated` callback.

Please note that you should not call the [RtcEngine.destroy](https://docs.agora.io/en/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#afb808cdc9025a77af7dd2bce98311bfe)/[AgoraRtcEngineKit.destroy](https://docs.agora.io/en/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/destroy) function on Android/iOS code, because it will affect the [RtcEngine](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/lib/src/rtc_engine.dart) on the Flutter side. To see how to use `RtcEnginePlugin`, please check the custom audio source example:

Android: [CustomAudioPlugin.kt](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/example/android/app/src/main/kotlin/io/agora/agora_rtc_engine_example/custom_audio_source/CustomAudioPlugin.kt)

iOS: [CustmoAudioSourcePlugin.swift](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/example/ios/Runner/CustomAudioSource/CustmoAudioSourcePlugin.swift)

## API Reference Resources

* [Flutter](https://docs.agora.io/en/Video/API%20Reference/flutter/index.html)
* [Android](https://docs.agora.io/en/Video/API%20Reference/java/index.html)
* [iOS/macOS](https://docs.agora.io/en/Video/API%20Reference/oc/docs/headers/Agora-Objective-C-API-Overview.html)
* [Windows](https://docs.agora.io/en/Video/API%20Reference/cpp/index.html)
* [Web](https://docs.agora.io/en/Video/API%20Reference/web_ng/index.html)
* [React Native](https://docs.agora.io/en/Video/API%20Reference/react_native/index.html)

## Feedback

If you have any problems or suggestions regarding the sample projects, feel free to file an [issue](https://github.com/AgoraIO/Agora-Flutter-SDK/issues).

## How to contribute

To help work on this sdk, please refer to [CONTRIBUTING.md](https://github.com/AgoraIO/Flutter-SDK/blob/master/CONTRIBUTING.md).

## Related resources

- Check our [FAQ](https://docs.agora.io/en/faq) to see if your issue has been recorded.
- Dive into [Agora SDK Samples](https://github.com/AgoraIO) to see more tutorials.
- Take a look at [Agora Use Case](https://github.com/AgoraIO-usecase) for more complicated real use case.
- Repositories managed by developer communities can be found at [Agora Community](https://github.com/AgoraIO-Community).
- If you encounter problems during integration, feel free to ask questions in [Stack Overflow](https://stackoverflow.com/questions/tagged/agora.io).

## License

The sample projects are under the [MIT license](https://github.com/AgoraIO/Flutter-SDK/blob/master/LICENSE).
