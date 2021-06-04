# agora_rtc_engine

![pub package](https://img.shields.io/pub/v/agora_rtc_engine.svg?include_prereleases)

[中文](README.zh.md)

This Flutter plugin is a wrapper for [Agora Video SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms).

Agora.io provides building blocks for you to add real-time voice and video communications through a simple and powerful SDK.
You can integrate the Agora SDK to enable real-time communications in your own application quickly.

## Usage

To use this plugin, please add `agora_rtc_engine` as a dependency to your [pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages) file.

## Getting Started

* Get some basic and advanced examples from the [example](example/lib/examples) folder.

### Privacy Permission

Agora Video SDK requires `Camera` and `Microphone` permission to start a video call.

#### Android

See the required device permissions from the [AndroidManifest.xml](android/src/main/AndroidManifest.xml) file.

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
    <uses-permission android:name="android.permission.WAKE_LOCK"/>
    <uses-permission
        android:name="android.permission.READ_PRIVILEGED_PHONE_STATE"
        tools:ignore="ProtectedPermissions" />
    ...
</manifest>
```

#### iOS & Macos

Open the `Info.plist` and add:

- `Privacy - Microphone Usage Description`，and add some description into the `Value` column.
- `Privacy - Camera Usage Description`, and add some description into the `Value` column.

## Flutter2 support

### Null Safety

We have supported null safety at the [4.0.1](https://pub.dev/packages/agora_rtc_engine/versions/4.0.1) version already.
This version is not downward compatible, your project needs to be migrated to null safety, please refer to [Migrating to null safety](https://dart.dev/null-safety/migration-guide).

### Multiple Platforms

#### Linux

Not support yet.

#### Macos

We have a wrapper library named [AgoraRtcWrapper.framework](macos/AgoraRtcWrapper.framework) for the Native SDK, so you should add it to your `Podfile` file, you can refer to [example/macos/Podfile](example/macos/Podfile).

```ruby
pod 'AgoraRtcWrapper', :path => File.join(File.join('Flutter', 'ephemeral', '.symlinks'), 'plugins', 'agora_rtc_engine', 'macos')
```

**Important**

This is a temporary plan, we will publish this library to Cocoapods before officially released, then you needn't modify the `Podfile` file.

#### Windows

You can get more info from the [CMakeLists.text](windows/CMakeLists.txt) file, such as dependency Libraries on Windows.

#### Web

We use the [js](https://pub.dev/packages/js) library to call JavaScript from the dart layer.

We have a wrapper library named [AgoraRtcWrapper.bundle.js](example/web/AgoraRtcWrapper.bundle.js) for the Web SDK, so you should add it to your `index.html`, you can refer to [example/web/index.html](example/web/index.html).

```html
<script src="AgoraRtcWrapper.bundle.js" type="application/javascript"></script>
```

This wrapper library is the output of the open-source repository [Iris-Rtc-Web](https://github.com/AgoraIO-Community/Iris-Rtc-Web).
The repository attempt to mapping the API from Web SDK as Native SDK, we make it open-source to help developer positioning and troubleshooting.

We have imported it as a Git submodule, you can find it in the [web](web) folder.

## Error handling

Please check **Pinned issues** and search in [Issues](https://github.com/AgoraIO/Agora-Flutter-SDK/issues) first.

### [Background mode #28](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/28)

#### Android

[Android 9.0 Background Capture](https://docs.agora.io/en/Interactive%20Broadcast/faq/android_background?platform=Android)

#### iOS

Select your **TARGET** in Xcode, and click the `Signing & Capabilities` tab, then enable `Background Modes` and check `Audio, AirPlay, and Picture in Picture`.

### [RawData #183](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/183)

Only support Android and iOS yet.

### [Using flutter assets #181](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/181)

### Screen Sharing

Only support Web yet, we will support Macos and Windows at next alpha version.

## API

* [Flutter API](https://docs.agora.io/en/Video/API%20Reference/flutter/index.html)
* [Android API](https://docs.agora.io/en/Video/API%20Reference/java/index.html)
* [iOS/Mac API](https://docs.agora.io/en/Video/API%20Reference/oc/docs/headers/Agora-Objective-C-API-Overview.html)
* [Windows API](https://docs.agora.io/en/Video/API%20Reference/cpp/index.html)
* [Web API](https://docs.agora.io/en/Video/API%20Reference/web_ng/index.html)

## How to contribute

To help work on this sdk, please refer to [CONTRIBUTING.md](https://github.com/AgoraIO/Flutter-SDK/blob/master/CONTRIBUTING.md).
