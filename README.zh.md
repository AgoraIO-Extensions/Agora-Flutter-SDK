# agora_rtc_engine

![pub package](https://img.shields.io/pub/v/agora_rtc_engine.svg?include_prereleases)

[English](README.md)

此 Flutter 插件 是对 [Agora 视频 SDK](https://docs.agora.io/cn/Interactive%20Broadcast/product_live?platform=All%20Platforms) 的包装。

Agora.io 通过一个简单而强大的 SDK 为您提供了添加实时语音和视频通信的构建块。您可以集成此 SDK 以便在您自己的应用程序中快速实现实时通信。

## 如何使用

为了使用此插件, 请添加 `agora_rtc_engine` 到您的 [pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages) 文件中。

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
    <uses-permission android:name="android.permission.WAKE_LOCK"/>
    <uses-permission
        android:name="android.permission.READ_PRIVILEGED_PHONE_STATE"
        tools:ignore="ProtectedPermissions" />
    ...
</manifest>
```

#### iOS 和 Macos

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

#### Macos

我们针对 Native SDK 有一个 [AgoraRtcWrapper.framework](macos/AgoraRtcWrapper.framework) 包装库，所以需要在您的 Podfile 中添加引用，可以参考 [example/macos/Podfile](example/macos/Podfile) 。

```ruby
pod 'AgoraRtcWrapper', :path => File.join(File.join('Flutter', 'ephemeral', '.symlinks'), 'plugins', 'agora_rtc_engine', 'macos')
```

**重要信息**

这只是一个临时方案，在正式发版前我们会将此包装库发布到 `Cocoapods` 上，到时候便不再需要手动修改 `Podfile`。

#### Windows

您可以从 [CMakeLists.text](windows/CMakeLists.txt) 文件中获取更多信息, 比如在 Windows 上的依赖库。

#### Web

我们使用 [js](https://pub.dev/packages/js) 库实现 dart 对 JavaScript 的调用。

我们针对 Web SDK 有一个 [AgoraRtcWrapper.bundle.js](example/web/AgoraRtcWrapper.bundle.js) 包装库，所以需要在您的 `index.html` 中添加引用，可以参考 [example/web/index.html](example/web/index.html) 。

```html
<script src="AgoraRtcWrapper.bundle.js" type="application/javascript"></script>
```

此包装库是 [Iris-Rtc-Web](https://github.com/AgoraIO-Community/Iris-Rtc-Web) 开源库的编译产物，它尝试将 Web SDK 接口映射成 Native SDK 接口，我们将其开源以便开发者定位和排查问题。

我们已将其作为 Git Submodule 导入到工程中，您可以在 [web](web) 目录中找到它。

## 常见问题

请优先查看 **Pinned issues** 和在 [Issues](https://github.com/AgoraIO/Agora-Flutter-SDK/issues) 中搜索。

### [后台采集](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/28)

#### Android

[Android 9.0 后台采集无效](https://docs.agora.io/cn/Interactive%20Broadcast/faq/android_background?platform=Android)

#### iOS

在 Xcode 中选择您的 **TARGET**，点击 `Signing & Capabilities` 标签，开启 `Background Modes`，并且勾选 `Audio, AirPlay, and Picture in Picture`。

### [获取裸数据](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/183)

目前仅支持 Android 和 iOS。

### [使用 flutter assets 作为路径](https://github.com/AgoraIO/Agora-Flutter-SDK/issues/181)

### 屏幕共享

目前仅支持 Web，对于Macos 和 Windows的支持将会在后续版本中推出。

## API

* [Flutter API](https://docs.agora.io/cn/Video/API%20Reference/flutter/index.html)
* [Android API](https://docs.agora.io/cn/Video/API%20Reference/java/index.html)
* [iOS/Mac API](https://docs.agora.io/cn/Video/API%20Reference/oc/docs/headers/Agora-Objective-C-API-Overview.html)
* [Windows API](https://docs.agora.io/cn/Video/API%20Reference/cpp/index.html)
* [Web API](https://docs.agora.io/cn/Video/API%20Reference/web_ng/index.html)

## 参与贡献

为了提升 SDK 的质量和易用性, 请参考我们的 [贡献说明](https://github.com/AgoraIO/Flutter-SDK/blob/master/CONTRIBUTING.md) 。
