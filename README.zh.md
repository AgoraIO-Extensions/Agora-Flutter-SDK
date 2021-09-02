# agora_rtc_engine

![pub package](https://img.shields.io/pub/v/agora_rtc_engine.svg?include_prereleases)

[English](README.md)
[日本語](README.jp.md)

此 Flutter 插件 是对 [Agora 视频 SDK](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms) 的包装。

Agora.io 通过一个简单而强大的 SDK 为您提供了添加实时语音和视频通信的构建块。您可以集成此 SDK 以便在您自己的应用程序中快速实现实时通信。

## 如何使用

为了使用此插件, 添加 `agora_rtc_engine` 到您的 [pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages) 文件中。

## 快速开始

* 参阅 [example](example) 目录，这是一个一对一视频聊天的示例。
* 或者检出 [Tutorial](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart) ，这是一个直播场景的示例.

## 设备权限

Agora 视频 SDK 需要 `摄像头` 和 `麦克风` 权限来开始视频通话。

### Android

打开 `AndroidManifest.xml` 文件并且添加必备的权限到此文件中.

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

打开 `info.plist` 文件并且添加：

- `Privacy - Microphone Usage Description`，并且在 `Value` 列中添加描述。
- `Privacy - Camera Usage Description`, 并且在 `Value` 列中添加描述。

您的程序可以在后台运行音视频通话，前提是您开启了后台模式。在 Xcode 中选择您的 app target，点击 **Capabilities** 标签，开启 **Background Modes**，并且检查 **Audio、AirPlay 和 Picture in Picture**。

## 常见问题

### iOS 无法显示视频（Android 是好的）

我们的 SDK 使用 `PlatformView`，您需要设置 `io.flutter.embedded_views_preview` 为 `YES` 在您的 **info.plist** 中。

### iOS 内存泄漏

如果您使用 `stable` 版本的 `flutter`，`PlatformView` 会导致内存泄漏，您可以运行 `flutter channel beta`

您可以参考这个 [pull request](https://github.com/flutter/engine/pull/14326)

## API

* [Flutter API](https://docs.agora.io/cn/All/api-ref?platform=Flutter)
* [Android API](https://docs.agora.io/en/Video/API%20Reference/java/index.html)
* [iOS API](https://docs.agora.io/en/Video/API%20Reference/oc/docs/headers/Agora-Objective-C-API-Overview.html)

## 反馈

如果你有任何问题或建议，可以通过 [issue](https://github.com/AgoraIO/Agora-Flutter-SDK/issues) 的形式反馈。

## 参与贡献

为了提升 SDK 的质量和易用性, 请参考我们的 [贡献说明](https://github.com/AgoraIO/Flutter-SDK/blob/master/CONTRIBUTING.md)。

## 相关资源

- 你可以先参阅 [常见问题](https://docs.agora.io/cn/faq)
- 如果你想了解更多官方示例，可以参考 [官方 SDK 示例](https://github.com/AgoraIO)
- 如果你想了解声网 SDK 在复杂场景下的应用，可以参考 [官方场景案例](https://github.com/AgoraIO-usecase)
- 如果你想了解声网的一些社区开发者维护的项目，可以查看 [社区](https://github.com/AgoraIO-Community)
- 若遇到问题需要开发者帮助，你可以到 [开发者社区](https://rtcdeveloper.com/) 提问
- 如果需要售后技术支持, 你可以在 [Agora Dashboard](https://dashboard.agora.io) 提交工单

## 代码许可

示例项目遵守 MIT 许可证。
