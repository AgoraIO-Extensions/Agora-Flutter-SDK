# agora_rtc_engine

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


[English](README.md)

此 Flutter 插件
是对 [Agora 视频 SDK](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms)
的包装。

Agora.io 通过一个简单而强大的 SDK 为您提供了添加实时语音和视频通信的构建块。您可以集成此 SDK 以便在您自己的应用程序中快速实现实时通信。

## 如何使用

为了使用此插件, 请添加 `agora_rtc_engine`
到您的 [pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages) 文件中。

## 快速开始

* 从 [example](example/lib/examples) 目录获取一些基础和高阶的参考示例。

### 隐私权限

Agora 视频 SDK 需要 `摄像头` 和 `麦克风` 权限来开始视频通话。

#### Android

查看 [AndroidManifest.xml](android/src/main/AndroidManifest.xml) 文件中已声明的权限。

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

#### iOS 和 macOS

打开 `Info.plist` 文件并且添加：

- `Privacy - Microphone Usage Description`，并且在 `Value` 列中添加描述。
- `Privacy - Camera Usage Description`, 并且在 `Value` 列中添加描述。

## Flutter2 支持

### 空安全

我们在 [4.0.1](https://pub.dev/packages/agora_rtc_engine/versions/4.0.1) 版本已经正式支持了空安全。
此版本不向下兼容，需要您的工程迁移至空安全，具体参考 [迁移至空安全](https://dart.cn/null-safety/migration-guide) 。

### 多平台

#### Linux

暂不支持。

#### macOS

您可以从 [agora_rtc_engine.podspec](macos/agora_rtc_engine.podspec) 文件中获取更多信息, 比如在 macOS 上的依赖库。

#### Windows

您可以从 [CMakeLists.text](windows/CMakeLists.txt) 文件中获取更多信息, 比如在 Windows 上的依赖库。

#### Web

我们使用 [js](https://pub.dev/packages/js) 库实现 dart 对 JavaScript 的调用。

我们针对 Web SDK 有一个 [AgoraRtcWrapper.bundle.js](assets/AgoraRtcWrapper.bundle.js) 包装库。

此包装库是 [Iris-Rtc-Web](https://github.com/AgoraIO-Community/Iris-Rtc-Web) 开源库的编译产物，它尝试将 Web SDK 接口映射成
Native SDK 接口，我们将其开源以便开发者定位和排查问题。

我们已将其作为 Git Submodule 导入到工程中，您可以在 [web](web) 目录中找到它。

## 在Android/iOS中与[RtcEngine](https://docs.agora.io/cn/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html)/[AgoraRtcEngineKit](https://docs.agora.io/cn/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html)交互

由于性能原因，`agora_rtc_engine`暂时没有实现agora native(Android/iOS)
sdk的所有功能，如[自定义音频采集和渲染](hhttps://docs.agora.io/cn/Video/custom_audio_android?platform=Android)
，[自定义视频采集和渲染](https://docs.agora.io/cn/Video/custom_video_android?platform=Android)，[原始音频数据](https://docs.agora.io/cn/Video/raw_data_audio_android?platform=Android)等功能，`agora_rtc_engine`提供[RtcEnginePlugin](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/android/src/main/java/io/agora/rtc/base/RtcEnginePlugin.kt)/[RtcEnginePlugin](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/ios/Classes/Base/RtcEnginePlugin.h)，允许你在Android/iOS代码中与Flutter端创建的[RtcEngine](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/lib/src/rtc_engine.dart)交互，你可以继承[RtcEnginePlugin](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/android/src/main/java/io/agora/rtc/base/RtcEnginePlugin.kt)/[RtcEnginePlugin](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/ios/Classes/Base/RtcEnginePlugin.h)实现自己的插件，在`onRtcEngineCreated`回调中获取[RtcEngine](https://docs.agora.io/cn/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html)/[AgoraRtcEngineKit](https://docs.agora.io/cn/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html)，请注意不要在Android/iOS中调用[RtcEngine.destroy](https://docs.agora.io/cn/Video/API%20Reference/java/classio_1_1agora_1_1rtc_1_1_rtc_engine.html#afb808cdc9025a77af7dd2bce98311bfe)/[AgoraRtcEngineKit.destroy](https://docs.agora.io/cn/Video/API%20Reference/oc/Classes/AgoraRtcEngineKit.html#//api/name/destroy)方法，因为这会影响Flutter端的[RtcEngine](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/lib/src/rtc_engine.dart)功能。如何使用`RtcEnginePlugin`，请查看我们提供的音频自采集demo:

Android：[CustomAudioPlugin.kt](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/example/android/app/src/main/kotlin/io/agora/agora_rtc_engine_example/custom_audio_source/CustomAudioPlugin.kt)

iOS：[CustmoAudioSourcePlugin.swift](https://github.com/AgoraIO/Agora-Flutter-SDK/blob/master/example/ios/Runner/CustomAudioSource/CustmoAudioSourcePlugin.swift)

## 常见问题

请优先查看 **Pinned issues** 和在 [Issues](https://github.com/AgoraIO/Agora-Flutter-SDK/issues) 中搜索。

### [后台采集](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/28)

#### Android

[Android 9.0 后台采集无效](https://docs.agora.io/cn/Interactive%20Broadcast/faq/android_background?platform=Android)

#### iOS

在 Xcode 中选择您的 **TARGET**，点击 `Signing & Capabilities` 标签，开启 `Background Modes`
，并且勾选 `Audio, AirPlay, and Picture in Picture`。

### [获取裸数据](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/183)

目前仅支持 Android 和 iOS。

### [使用 flutter assets 作为路径](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/181)

### 屏幕共享

目前仅支持 Web、macOS 和 Windows，暂不支持 Android 和 iOS。

**重要信息**

在 macOS 平台上你需要设置 `AppGroup` 并且作为参数在你调用 `getScreenShareHelper` 之前。

你可以参考 [screen_sharing.dart](example/lib/examples/advanced/screen_sharing/screen_sharing.dart)
和 [Apple doc](https://developer.apple.com/library/archive/documentation/Security/Conceptual/AppSandboxDesignGuide/AppSandboxInDepth/AppSandboxInDepth.html#//apple_ref/doc/uid/TP40011183-CH3-SW21)

## API

* [Flutter API](https://docs.agora.io/cn/Video/API%20Reference/flutter/index.html)
* [Android API](https://docs.agora.io/cn/Video/API%20Reference/java/index.html)
* [iOS/Mac API](https://docs.agora.io/cn/Video/API%20Reference/oc/docs/headers/Agora-Objective-C-API-Overview.html)
* [Windows API](https://docs.agora.io/cn/Video/API%20Reference/cpp/index.html)
* [Web API](https://docs.agora.io/cn/Video/API%20Reference/web_ng/index.html)

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
