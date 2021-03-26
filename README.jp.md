# agora_rtc_engine

![pub package](https://img.shields.io/pub/v/agora_rtc_engine.svg?include_prereleases)

[English](README.md)
[中国語](README.zh.md)

このFlutterプラグインは[Agora Video SDK](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=All%20Platforms)のラッパーです。

Agora.ioは、シンプルで強力なSDKを介してリアルタイムの音声およびビデオ通信を追加するためのビルディングブロックを提供します。 Agora SDKを統合して、独自のアプリケーションでリアルタイム通信をすばやく有効にすることができます。

## 使用方法

このプラグインを使用するには、依存関係として[pubspec.yaml](https://flutter.dev/docs/development/packages-and-plugins/using-packages)ファイルにファイルに `agora_rtc_engine` を追加します。

## 始め方

* `agora_rtc_engine`を使用する1対1のビデオチャットアプリのサンプルについては、[example](example)ディレクトリを参照してください。
* または、[Tutorial](https://github.com/AgoraIO-Community/Agora-Flutter-Quickstart)で、この`agora_rtc_engine`を使用するライブブロードキャストアプリのサンプルを確認してください。

## デバイスの許可

Agora Video SDKを使用するには、ビデオ通話を開始するために`camera`と `microphone`の権限が必要です。

### Android

`AndroidManifest.xml`ファイルを開き、必要なデバイス権限をファイルに追加します。

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

`Info.plist` を開き追加します:

- `Privacy - Microphone Usage Description` のKeyにValueを追加します。
- `Privacy - Camera Usage Description` のKeyにValueを追加します。

バックグラウンドモードが有効になっている場合、アプリケーションはバックグラウンドに切り替えられても音声通話を実行できます。
Xcodeでアプリのターゲットを選択し、 **Capabilities** タブをクリックして、 **Background Modes** を有効にし、 **Audio, AirPlay, and Picture in Picture** をオンにします。

## Error handling

### iOSビデオが見えない時 (Androidでは動作する)

SDKは`PlatformView`を使用しますので、 *Info.plist* ファイルで`io.flutter.embedded_views_preview` を `YES` に設定する必要があります

## API

* [Flutter API](https://agoraio.github.io/Flutter-SDK/index.html)
* [Android API](https://docs.agora.io/en/Video/API%20Reference/java/index.html)
* [iOS API](https://docs.agora.io/en/Video/API%20Reference/oc/docs/headers/Agora-Objective-C-API-Overview.html)

## コントリビューション

このSDKでの作業を支援するには、[contributor guide](https://github.com/AgoraIO/Flutter-SDK/blob/master/CONTRIBUTING.md)をご覧下さい。
