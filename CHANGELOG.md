# Change log

## 1.0.8
* fix onVideoSizeChanged bug

## 1.0.7
* fix iOS setLiveTranscoding crash

## 1.0.6
* upgrade Agora SDK to 2.9.4, not use IMEI now

## 1.0.5
* fix iOS memory leak

## 1.0.4
* AgoraRenderWidget use key now

## 1.0.3
* add log functions

## 1.0.2
* fix Android orientation bug

## 1.0.1
* support 2.9.1 native sdk, [more details](https://github.com/AgoraIO/Flutter-SDK/pull/36/files)

## 1.0.0
* Support CDN Publish & Pull
* Support Switch Channel
* Update to Agora Rtc SDK 2.9.0 version.
* deprecated methods:
  `onUserMuteVideo`
  `onUserEnableVideo`
  `onUserEnableLocalVideo`
  `onFirstRemoteVideoDecoded`
  `onRemoteAudioTransportStats`
* add methods:
  `switchChannel`
  `onLocalAudioStateChanged`
  `onRemoteAudioStateChanged`
  `onLocalAudioStats`
  `setLiveTranscoding`
  `addPublishStreamUrl`
  `removePublishStreamUrl`
  `addInjectStreamUrl`
  `removeInjectStreamUrl`
* enhancement `RemoteVideoStats`  & `LocalVideoStats` & `RtcStats`

## 0.9.9
* Support voice changer
* Add [AgoraRenderWidget](./lib/src/agora_render_widget.dart)

## 0.9.8
* Add native result call.
* Update to Agora Rtc SDK 2.8.0 version.

## 0.9.7

* Move callback to main thread.

## 0.9.6

* Update to Agora Rtc SDK 2.4.1 version.
* Support encryption.
* Adds the onLocalVideoStateChanged callback to indicate the local video state. This replaces the onCameraReady and onVideoStopped callbacks.
* Adds the onNetworkTypeChanged callback to indicate the local network type.
* Adds the onFirstRemoteAudioDecoded callback to report to the app that the SDK decodes first remote audio.

## 0.9.5

* Fix onRtcStats

## 0.9.4

* Update to Agora Rtc SDK 2.4.0 version
* Refact setVideoEncoderConfiguration
* Add setBeautyEffectOptions and setRemoteUserPriority

## 0.9.3

* Added basic enumerations

## 0.9.2 beta

* Fix Android type specifiers issues

## 0.9.1 beta

* Added docs for SDK apis

## 0.9.0 beta

* Flutter for Agora Video SDK beta release
