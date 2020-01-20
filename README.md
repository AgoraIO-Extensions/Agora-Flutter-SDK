# AgoraRtcEngine

![pub package](https://img.shields.io/pub/v/agora_rtc_engine.svg)

This Flutter plugin is a wapper for [Agora Video SDK](https://docs.agora.io/en).

Agora.io provides building blocks for you to add real-time voice and video communications through a simple and powerful SDK. You can integrate the Agora SDK to enable real-time communications in your own application quickly.

*Note*: This plugin is still under development, and some APIs might not be available yet.

## Usage

To use this plugin, add `agora_rtc_engine` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

## Getting Started

* See the [example](example) directory for a sample app using AgoraRtcEngine.
* Or checkout this [tutorial](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart) for a simple video call app using Agora Flutter SDK.

## Device Permission

Agora Video SDK requires camera and microphone permission to start video call.

### Android

Open the *AndroidManifest.xml* file and add the required device permissions to the file.

```xml
..
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

<!-- The Agora SDK requires Bluetooth permissions in case users are using Bluetooth devices.-->
<uses-permission android:name="android.permission.BLUETOOTH" />
..
```

### iOS

Open the *info.plist* and add:

- Privacy - Microphone Usage Description, and add a note in the Value column.
- Privacy - Camera Usage Description, and add a note in the Value column.

Your application can still run the voice call when it is switched to the background if the background mode is enabled. Select the app target in Xcode, click the **Capabilities** tab, enable **Background Modes**, and check **Audio, AirPlay, and Picture in Picture**.

## Error handling

### iOS memory leak

if your flutter channel is stable, `PlatformView` will cause memory leak, you can run `flutter channel beta`

[you can refer to this pull request](https://github.com/flutter/engine/pull/14326)

### Android Black screen

if your MainActivity extends `io.flutter.embedding.android.FlutterActivity`

please remove this line of code
```
GeneratedPluginRegistrant.registerWith(this)
```

[you can refer to the official documents](https://flutter.dev/docs/development/packages-and-plugins/plugin-api-migration)

### Android Release crash

it causes by code obfuscation because of flutter set `android.enableR8=true` by the default

Add the following line in the **app/proguard-rules.pro** file to prevent code obfuscation:
```
-keep class io.agora.**{*;}
```

## How to contribute

To help work on this sdk, see our [contributor guide](CONTRIBUTING.md).
