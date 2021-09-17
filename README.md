# agora_rtc_engine

![pub package](https://img.shields.io/pub/v/agora_rtc_engine.svg?include_prereleases)

[中文](README.zh.md)
[日本語](README.jp.md)

This Flutter plugin is a wrapper for [Agora Video SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms).

Agora.io provides building blocks for you to add real-time voice and video communications through a simple and powerful SDK. You can integrate the Agora SDK to enable real-time communications in your own application quickly.

## Usage

To use this plugin, add `agora_rtc_engine` as a dependency in your [pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages) file.

## Getting Started

* See the [example](example) directory for a sample about one to one video chat app which using `agora_rtc_engine`.
* Or checkout this [Tutorial](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart) for a sample about live broadcasting app which using `agora_rtc_engine`.

## Device Permission

Agora Video SDK requires `camera` and `microphone` permission to start video call.

### Android

Open the `AndroidManifest.xml` file and add the required device permissions to the file.

```xml
<manifest>
    ...
    <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.RECORD_AUDIO" />
    <uses-permission android:name="android.permission.CAMERA" />
    <uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
    <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

    <!-- The Agora SDK requires Bluetooth permissions in case users are using Bluetooth devices.-->
    <uses-permission android:name="android.permission.BLUETOOTH" />
    ...
</manifest>
```

### iOS

Open the `Info.plist` and add:

- `Privacy - Microphone Usage Description`, and add a note in the Value column.
- `Privacy - Camera Usage Description`, and add a note in the Value column.

Your application can still run the voice call when it is switched to the background if the background mode is enabled. Select the app target in Xcode, click the **Capabilities** tab, enable **Background Modes**, and check **Audio, AirPlay, and Picture in Picture**.

## Error handling

### Android build error

The error log like `Could not find com.github.agorabuilder:native-full-sdk:3.4.2.`

pls refer to https://github.com/AgoraIO/Agora-Flutter-SDK/issues/321#issuecomment-843913064

## API

* [Flutter API](https://docs.agora.io/en/All/api-ref?platform=Flutter)
* [Android API](https://docs.agora.io/en/Video/API%20Reference/java/index.html)
* [iOS API](https://docs.agora.io/en/Video/API%20Reference/oc/docs/headers/Agora-Objective-C-API-Overview.html)

## Feedback

If you have any problems or suggestions regarding the sample projects, feel free to file an [issue](https://github.com/AgoraIO/Agora-Flutter-SDK/issues).

## How to contribute

To help work on this sdk, see our [contributor guide](https://github.com/AgoraIO/Flutter-SDK/blob/master/CONTRIBUTING.md).

## Related resources

- Check our [FAQ](https://docs.agora.io/en/faq) to see if your issue has been recorded.
- Dive into [Agora SDK Samples](https://github.com/AgoraIO) to see more tutorials
- Take a look at [Agora Use Case](https://github.com/AgoraIO-usecase) for more complicated real use case
- Repositories managed by developer communities can be found at [Agora Community](https://github.com/AgoraIO-Community)
- If you encounter problems during integration, feel free to ask questions in [Stack Overflow](https://stackoverflow.com/questions/tagged/agora.io)

## License

The sample projects are under the MIT license.