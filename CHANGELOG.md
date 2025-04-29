# Changelog

## [6.5.2](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.5.1-rc.2...6.5.2) (2025-04-29)

### Features

* update dependencies ([#2272](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2272)) ([a97726d](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/a97726d1c4d57e79811ac71eaeb8320ed3c7481b))
* update dependencies ([#2280](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2280)) ([14540c3](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/14540c30c8973f4921e54525d8b6b58162c5b839))

### Bug Fixes

* copy CVPixelBuffer for macOS ([#2298](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2298)) ([e17b4f6](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/e17b4f696291ce5f62e59276a7417ef52829cfef))
* hold weak ref of RendererDelegate in async task ([#2265](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2265)) ([#2271](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2271)) ([3a5a91e](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/3a5a91e937c61122ed53dae5299c9df9f0ad180a))
* refine demo with send multi video stream ([#2295](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2295)) ([e7053aa](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/e7053aa33e3e2a2f6e3ed0001745409f9336e85a))
* unregister video frame delegate in dealloc of TextureRender to a… ([#2296](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2296)) ([92c4dbd](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/92c4dbd88f067a4f7ac5596e761b03ddb383e9a5))

## [6.5.1-rc.1](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.5.1...6.5.1-rc.1) (2025-04-11)

### Features

* make data classes serializable ([#2223](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2223)) ([0ff7d49](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/0ff7d4935b7c4b0fd50c1b01961b6f728df526bd))
* modify gen functions to make data classes serializable ([#2223](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2223)) ([#2244](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2244)) ([242472c](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/242472c4c9740483f98bac24bfb88e06f2d79d7d))
* support to pub multi camera streams for iOS ([#2256](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2256)) ([e1e990d](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/e1e990deab7d25369347e3939041b7cc25221016))

### Bug Fixes

* do not clear all platform view renders when dispose render ([#2214](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2214)) ([#2235](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2235)) ([3fac8fa](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/3fac8fa8eb87fad5beef562ee8c5fd7482a7fbea))

## [6.5.1](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.5.0...6.5.1) (2025-03-12)

### Features

* optimize internal dependencies ([#2146](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2146)) ([4afc2ba](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/4afc2ba8c503b7897f80e0704d9299794e7f78bf))
* replace urls of test media files with agora cdn links ([#2144](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2144)) ([2fc4715](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/2fc471538d8102e54a3849beca9f0e1f1b3af714))
* update dependencies ([#2209](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2209)) ([f149b40](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/f149b40bdcc7883c702fdf469218a2c22be9c9ea))

### Bug Fixes

* add missed extra link flags to support to enable 16K page size f… ([#2143](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2143)) ([2146142](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/214614282efb1e9f0c2bdb519449581481a54e6e))
* catch exception of eventHandler when some unknown error code or … ([#2215](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2215)) ([fdfc43b](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/fdfc43ba2f25e0345dcb82f40ad534be826eb70f)), closes [#2210](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2210)
* crash in texture renderer for ios (pick 06896207 4d484b4d from release/6.3) ([#2190](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2190)) ([89cdb5d](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/89cdb5d0ba47f56b461ed3d358dac0a552718340))
* demo typo in media recorder case ([9c36c25](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/9c36c2571055642c77a6ab27502e9b6a05cb3566))
* disable warning 4819 when build windows ([5b9d15e](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/5b9d15e76cb7d9a72d8ea7555a102eeef937f95a))
* use internal custom_headers ([#2145](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2145)) ([fb3ea26](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/fb3ea26e644fe6c627f1dc38be66bfe5c45f5a8c))

## [6.5.0](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.3.2...6.5.0) (2024-12-10)

### Features

* Bump minimum supported Flutter SDK >= 3.7.0 ([#2001](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2001)) ([3cc945b](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/3cc945b69197616deb6fc56fc2ab1ac8db0dd7d5))
* Upgrade native sdk 4.5.0 ([#2087](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2087)) ([cc4ef40](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/cc4ef40573bf4599c6986afeeb89c4db32cb1790))

### Bug Fixes

* [windows] Fix TextureRender crash ([#1999](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1999)) ([0edbfe5](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/0edbfe5e71863fc34f2d2de00254776cf59a3be9))
* Fix a potential crash in AgoraVideoView when the app is force quit ([#2055](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2055)) ([98e12d7](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/98e12d7afe0ab0c58363d996d3af43cfbd700410))
* Fix black screen issue in AgoraVideoView caused by incorrect resize handling ([#2052](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2052)) ([e9d6bcf](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/e9d6bcf5e9d63e555b8adaa6bea486e55c8d24d4))
* Fix potentially NPE in AgoraVideoView ([#2035](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2035)) ([2ad4cff](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/2ad4cff195386577a2058c3b6051cc33439be47a))
* Fix some callbacks not fired ([#2033](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2033)) ([47ac794](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/47ac7944df8c96017a9e9ec289c0e33a36064e5d))
* support android 15 16k page size ([#2043](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2043)) ([3f585c4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/3f585c4e9052a8edd43c91e85ae921bbf2640e57))
* Suppress R8 missing class com.google.devtools.*.ThrowableExtension for AGP 8.x ([#2050](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2050)) ([783c7ef](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/783c7ef58d382b298f401dac3e76193b2205d650))
* Update minSdkVersion to 21 to Fix NDK Compatibility Issue ([#1832](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1832)) ([0024b0a](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/0024b0ac7539574e620a42362f98820e1d5c9a37))

## [6.3.2](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.3.1...6.3.2) (2024-06-06)


### Features

* upgrade native sdk 4.3.2 ([#1795](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1795)) ([e937989](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/e9379891d4d54f8f56cd19af7ad1ebd0ddc0c8f1))

## [6.3.1](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.3.0...6.3.1) (2024-05-09)


### Features

* Upgrade native sdk 4.3.1 ([#1611](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1611)) ([18f1a56](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/18f1a56ad19f761e249656e7b680cb2e174dab48))


### Bug Fixes

* AgoraVideoView crash when dispose after RtcEngine.release ([#1585](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1585)) ([cd33120](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/cd33120b609c9fee410482f5410657579857c984))
* AgoraVideoView takes over the whole browser window ([#1717](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1717)) ([0052cc7](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/0052cc78446244cfaa4cfa5fff53515256704abf)), closes [/github.com/flutter/flutter/issues/143922#issuecomment-1960133128](https://github.com/AgoraIO-Extensions//github.com/flutter/flutter/issues/143922/issues/issuecomment-1960133128)
* Prevent multiple initializations of internal resources when `RtcEngine.initialize` is called simultaneously ([#1712](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1712)) ([462cfc3](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/462cfc3ebddeebe83143f341eb6ec8185a9e5b25))

## [6.3.0](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.2.6...6.3.0) (2024-02-28)


### Features

* Upgrade native sdk 4.3.0 ([#1462](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1462)) ([499d68c](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/499d68cbb7678296a1d59adc4192606c55f05be4))


### Bug Fixes

* [texture rendering] Fix texture id lost when widget is updated ([#1543](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1543)) ([f72552d](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/f72552dafc19553ff1b571d960aa2ddda2a3fd96))
* Fix MediaEngineImpl.unregisterAudioFrameObserver not unregister eventhandler internally ([#1495](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1495)) ([7edcd59](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7edcd59589c1772dce6949ed4815eda41f0de997))

## [6.2.6](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.2.4...6.2.6) (2023-11-21)


### Features

* upgrade native sdk 4.2.6 ([#1425](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1425)) ([#1442](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1442)) ([48b3dc4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/48b3dc47c7d24f8dc2aacd371029cc7bc83baec9))

## [6.2.4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.2.3...6.2.4) (2023-10-23)


### Bug Fixes

* [iOS/macOS] Fix CFBundleShortVersionString not correct in AgoraRtcWrapper framework ([#1387](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1387)) ([ff7a6ce](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/ff7a6ceb5424e1da3ffd8a22bb6241aa1ba1bcde))

## [6.2.3](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.2.2...6.2.3) (2023-10-13)


### Features

* [android] Implement flutter texture rendering ([#1246](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1246)) ([7fd8fee](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7fd8fee851a802dc3fbaef8b70bee3d8215006c0))
* Upgrade native sdk 4.2.3 ([#1312](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1312)) ([553863a](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/553863a1a45861a268cd4b54eca01cc1ce7a7b0b))


### Bug Fixes

* [windows] Fix can not get `irisRtcRenderingHandle` in 32-bit ([#1311](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1311)) ([7438fb2](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7438fb27e0ebc607fdda46a4482bec1f3f2e5070))

## [6.2.2](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.2.1...6.2.2) (2023-08-01)


### Features

* Upgrade native sdk 4.2.2 ([#1142](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1142)) ([3e04fd5](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/3e04fd52fbecd63dc126d044d8570a2b6219c217))


### Bug Fixes

* [android] Fix reset the log file in RtcEngine.initialize cause incorrect log file path ([#1201](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1201)) ([b437bee](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/b437beed39a2ee284a6ff8353a1b0f84703862af))
* [android/ios] Fix crash due to AgoraVideoView.dispose call before RtcEngine.setupxxVideo is completed ([#1224](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1224)) ([f50c4e4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/f50c4e4a89d64090fc6dac25e9999392abbf4327))
* ArgumentError: Invalid argument(s): `6` is not one of the supported values ([25471b8](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/25471b86f39ad14e7d7c624c5266121289b0e43c))
* Fix MediaRecorder.startRecording return -4 after the previous destroy ([76d4dc4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/76d4dc442a4997e7b05e9b9ddfc018845859bf48))
* Fix VideoViewControllerBaseMixin state in-correct issue ([10038b8](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/10038b87a8297d23addbec6124f69e7e7032f297))

### [6.2.1](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.2.0...6.2.1) (2023-06-30)


### Features

* upgrade native sdk 4.2.1 ([#1161](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1161)) ([fbfeb12](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/fbfeb12aef15ac9a1484c3b987b83b06f7abec20))


### Bug Fixes

* do not setup native view if the widget is disposed in platform view rendering ([8fcadea](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/8fcadea2376efb247ffda87fdeccf994d4be31a3))
* Fix AgoraVideoView not showing correctly when reusing the same VideoViewController ([#1169](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1169)) ([6f79203](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/6f792039b90d408d6a258aa2a9e11ab0284c11f7))
* Fix VideoViewController state not correct when the AgoraVideoView is reused ([37e4a21](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/37e4a21eb30e4603a2fe850fe304550a63b8c687))
* no-op if call RtcEngine.release without calling RtcEngine.initialize directly ([95d29ae](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/95d29aeee5ab6dd6c620e38cd5d18b33bc4e06d9))

## [6.2.0](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.1.1+1...6.2.0) (2023-05-26)


### Features

* upgrade native sdk 4.2.0 ([#1071](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1071)) ([1c2813a](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/1c2813ada6eb9443ee9c14802a73e0c416172f3a)), closes [#1106](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1106)

### [6.1.1+1](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/v6.1.1...v6.1.1+1) (2023-05-19)


### Bug Fixes

* Fix build error due to iris_method_channel break change ([7841c26](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7841c2604d8c60da1dfff67cc859d694026c8f10))

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
