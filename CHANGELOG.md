# Changelog

### [6.1.1](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/v6.1.0...v6.1.1) (2023-04-28)


### Features

* [ios] Support render mode and mirror mode for AgoraVideoView with flutter texture rendering ([d946eb8](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/d946eb8d46ec108aa9f49724c0ac456c75f6fba0))
* [macos] Support render mode and mirror mode for AgoraVideoView … ([#847](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/847)) ([64e09ed](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/64e09ed798ab83eea9a4964d03819bfb23bfd69b))
* [windows] Support render mode and mirror mode for AgoraVideoView with flutter texture rendering ([#856](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/856)) ([f70a581](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/f70a581f0587bdba6435de443f0954aec70e9287))


### Bug Fixes

* [windows] fix AgoraVideoView dispose crash due to multithreading ([216eb04](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/216eb04fddf6d2a81a75f9c37295e2d593bb9ba4))
* can not call startDirectCdnStreaming again after stopDirectCdnStreaming ([ce9fa44](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/ce9fa442f24c44dc73f0aafef175cf0624e83b2c))
* fix _HotRestartFinalizer._onExitPort not be initialized in release build ([ab478ae](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/ab478aea96bd42171c5381e308858c48c7104062))
* Fix AgoraVideoView not dispose previous renderer when didUpdateWidget called ([100c3f8](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/100c3f88be6814f195906b39cd56680ad9b879d5))
* fix crash caused by memory leak when register the raw data observers ([#957](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/957)) ([5ad823e](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/5ad823ed57800c5f7c0405f5283c45e95630b091))
* fix crash of AgoraVideoView with flutter texture rendering ([f9fdca7](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/f9fdca7785507d3efcbbfb21082644a0f8b404e7))
* Fix getNativeHandle not return correctly ([ada041f](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/ada041f408496d1695ad40ba8af55d36273aa57b))
* fix hot restart not work ([1d9fa0b](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/1d9fa0ba6bdf7e8a6a870400cbde7e65d94877f1))
* fix RtcEngine.release be called due to inaccurate app lifecycle callback in add2app scenario ([f9e6d26](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/f9e6d26af23436cf61d86e3c2cb3917fee9c2c0d))
* fix setupRemoteVideoEx not call correctly ([#909](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/909)) ([ac5900c](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/ac5900c3d6b44856d76b69a9d4fb2fb0f4743b0d))
* lazy initialize AgoraVideoView ([#905](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/905)) ([d370c67](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/d370c675c9dd5f020896cb016e0c6d4686d942d0))
* should not mirror the screen sharing ([69e2b3c](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/69e2b3cb14fbded62009fb730dfca167d450e0e1))

# [6.1.0](https://github.com/AgoraIO/Agora-Flutter-SDK/compare/v6.0.0...v6.1.0) (2022-12-20)


### Features

* Upgrade native sdk 4.1.0 ([1868ecc](https://github.com/AgoraIO/Agora-Flutter-SDK/commit/1868ecc5313c667f38911040568118dee363cdd5))

## [6.0.0](https://github.com/AgoraIO/Agora-Flutter-SDK/compare/v6.0.0-rc.1...v6.0.0) (2022-09-28)


Release 6.0.0

## [6.0.0-rc.2](https://github.com/AgoraIO/Agora-Flutter-SDK/compare/v6.0.0-rc.1...v6.0.0-rc.2) (2022-09-15)


### Bug Fixes

* fix AudioFrameObserver event bugs ([7a85728](https://github.com/AgoraIO/Agora-Flutter-SDK/commit/7a8572804f0d242c7ead4c74458b04138be75980))

## 6.0.0-rc.1 (2022-09-13)


### Features

* Convert kotlin to java to avoid kotlin version conflict ([#2](https://github.com/AgoraIO/Flutter-SDK/issues/2)) ([e972026](https://github.com/AgoraIO/Flutter-SDK/commit/e9720267f124c28fa0e06e101893eb591f56b345))
* Upgrade native sdk 4.0.0-rc.1 ([41115be](https://github.com/AgoraIO/Flutter-SDK/commit/41115be71a6b0a8881d61026cd30cae514962e26))

## 6.0.0-beta.2

feat: Convert kotlin to java to avoid kotlin version conflict

## 6.0.0-beta.1

See release note: 

https://docs.agora.io/en/video-call-4.x-beta/release_flutter_ng?platform=Flutter