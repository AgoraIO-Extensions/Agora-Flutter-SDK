# Changelog

## [6.3.2-sp.432246.b.3](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.3.2-sp.432246.b.2...6.3.2-sp.432246.b.3) (2026-01-04)
## 6.3.2-sp.432246.b.2 (2025-12-09)

### Features

* hardcode full range ([#2450](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2450)) ([20fd4af](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/20fd4af7d1ee8966d7eced71b2e3a8e3a23f619e))
* upgrade native sdk 4.3.2.246-dev.2 ([#2409](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2409)) ([be1010f](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/be1010fa229cb7ec0c55d9e79e5a57d60a8f803a))
## 6.3.2-sp.432246.b.1 (2025-07-07)

### Bug Fixes

* copy CVPixelBuffer for iOS and macOS ([#2376](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2376)) ([cab0341](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/cab0341d2e385d997fe8968c7515a8bb4abaf7f5))
* drop frame if current render timems is less than last one ([#2377](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2377)) ([c2900db](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/c2900db672e2abbdb77d9e81c9e4eacf13dcd7b8))
* try to fix frame skip issue on android ([#2341](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2341)) ([88648a8](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/88648a8672751a0ae9fe9ca781a46149bff2c66a))
## 6.3.2-sp.432236.b.2 (2025-05-08)

### Bug Fixes

* add temp variables to avoid data race from commit: 06896207 ([#2188](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2188)) ([0af4751](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/0af4751e3e70e65fdaa3d5a204d22d3b9a57f44d))
* check the renderer in OnVideoFrameReceived before use it ([#2222](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2222)) ([d9b76c4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/d9b76c4cce7775c8cd6e476bf4c0881542019ae6))
* do not clear all platform view renders when dispose render ([#2214](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2214)) ([7f18eca](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7f18ecaec0b14d0a8a87f5b6edc0495a295549ba))
* hold weak ref of RendererDelegate in async task ([#2265](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2265)) ([#2271](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2271)) ([#2278](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2278)) ([2c9545b](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/2c9545b8892f5f0304381c2f9955fe9cbd3e3041))
* unregister video frame delegate in dealloc of TextureRender to a… ([#2297](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2297)) ([9a15415](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/9a15415981f089f27ede059ae323f5cd846e5318)), closes [#2296](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2296)
* use weak ref of renderer to avoid crash in async task ([#2194](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2194)) ([dc54474](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/dc544747cebc939f3782e7a4dfe4e4bd40e16f7a))
## 6.3.2-sp.432236.b.1 (2025-05-08)

### Bug Fixes

* eliminate video playback flicker during resolution changes ([#2305](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2305)) ([938ac09](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/938ac09f990c30341fdb00220b8809f56b65102c))
## 6.3.2-sp.432236 (2025-03-06)

### Features

* upgrade native sdk 4.3.2.236 ([#2213](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2213)) ([e8bec71](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/e8bec7119b6625f79eef5c39da55dcd068928455))
## 6.3.2-sp.432234.b.3 (2025-01-16)

### Features

* upgrade iris 4.3.2.234-build.3 ([#2180](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2180)) ([60bb55c](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/60bb55ce8a3e463f2c74b0e81ee0cdc2f87a7b68))
## 6.3.2-sp.432234 (2024-12-18)

### Features

* replace urls of test media files with agora cdn links ([#2139](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2139)) ([7bd2893](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7bd2893e1cee1fe3d6d62776f25656ae1d10c893))
* upgrade native sdk 4.3.2.234 ([#2160](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2160)) ([9afcc81](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/9afcc81662597f5a519dba1e852fe176047166e5))

### Bug Fixes

* add missed extra link flags to support to enable 16K page size f… ([#2143](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2143)) ([43df691](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/43df691821afa1fa176f6688e06232256d6dfe6a))
## 6.3.2-sp.43211 (2024-12-06)

### Features

* Bump minimum supported Flutter SDK >= 3.7.0 ([#2001](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2001)) ([3cc945b](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/3cc945b69197616deb6fc56fc2ab1ac8db0dd7d5))
* Implement picture-in-picture feature ([#2015](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2015)) ([16b2530](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/16b2530daf783711d45af02cec4416098b107ca9))
* upgrade native sdk 4.3.2.5 ([4c5e2a2](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/4c5e2a21c0cbe44654da73a3b001ab49de633859))
* upgrade native sdk dependencies 20240919 ([#2026](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2026)) ([c5d929e](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/c5d929e0f39b6beb1f56e53a1c0db2b5c30db19b))
* upgrade native sdk to 4.3.2.11 ([#2136](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2136)) ([79c7329](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/79c7329f44e63d2179537a02408aaed8c20d29e7))

### Bug Fixes

* [windows] Fix TextureRender crash ([#1999](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1999)) ([0edbfe5](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/0edbfe5e71863fc34f2d2de00254776cf59a3be9))
* Fix a potential crash in AgoraVideoView when the app is force quit ([#2055](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2055)) ([10f92fe](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/10f92fe39536d21ef368c24ebf404895fe7e78cf))
* Fix black screen issue in AgoraVideoView caused by incorrect resize handling ([#2052](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2052)) ([5ce7f00](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/5ce7f00553664813006363166c1c4c9abadc9569))
* Fix potentially NPE in AgoraVideoView ([#2035](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2035)) ([3d51db3](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/3d51db30c4a4c0e00826186017e39428a8a6ff5e))
* Fix some callbacks not fired ([#2033](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2033)) ([e36069b](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/e36069b6127aadb53c5abffabbd1d7ee717381a1))
* pin kotlin to 1.9.10 and do not test on macos-12 anymore ([#2134](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2134)) ([ec04bf4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/ec04bf430ee06b495fb1de2a03dc500fdd3422b2))
* replace public video urls ([bf8d927](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/bf8d9271f35332dcfc87c869a9c92effc9686c06))
* support android 15 16k page size ([#2043](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2043)) ([98c9092](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/98c90921078f5b447c2451942ad42ff055cf6938))
* Suppress R8 missing class com.google.devtools.*.ThrowableExtension for AGP 8.x ([#2050](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2050)) ([3babf2d](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/3babf2df0990951a587008def47d2c598678264a))
* Update minSdkVersion to 21 to Fix NDK Compatibility Issue ([#1832](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1832)) ([010392b](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/010392b7dbf23717713220b7a6febfa8866213ad))
## 6.3.2 (2024-06-06)

### Features

* upgrade native sdk 4.3.2 ([#1795](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1795)) ([e937989](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/e9379891d4d54f8f56cd19af7ad1ebd0ddc0c8f1))
## 6.3.1 (2024-05-09)

### Features

* Upgrade native sdk 4.3.1 ([#1611](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1611)) ([18f1a56](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/18f1a56ad19f761e249656e7b680cb2e174dab48))

### Bug Fixes

* AgoraVideoView crash when dispose after RtcEngine.release ([#1585](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1585)) ([cd33120](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/cd33120b609c9fee410482f5410657579857c984))
* AgoraVideoView takes over the whole browser window ([#1717](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1717)) ([0052cc7](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/0052cc78446244cfaa4cfa5fff53515256704abf))
* Prevent multiple initializations of internal resources when `RtcEngine.initialize` is called simultaneously ([#1712](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1712)) ([462cfc3](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/462cfc3ebddeebe83143f341eb6ec8185a9e5b25))
## 6.3.0 (2024-02-28)

### Features

* Upgrade native sdk 4.3.0 ([#1462](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1462)) ([499d68c](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/499d68cbb7678296a1d59adc4192606c55f05be4))

### Bug Fixes

* [texture rendering] Fix texture id lost when widget is updated ([#1543](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1543)) ([f72552d](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/f72552dafc19553ff1b571d960aa2ddda2a3fd96))
* Fix MediaEngineImpl.unregisterAudioFrameObserver not unregister eventhandler internally ([#1495](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1495)) ([7edcd59](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7edcd59589c1772dce6949ed4815eda41f0de997))
## 6.2.6 (2023-11-21)

### Features

* upgrade native sdk 4.2.6 ([#1425](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1425)) ([#1442](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1442)) ([48b3dc4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/48b3dc47c7d24f8dc2aacd371029cc7bc83baec9))
## 6.2.4 (2023-10-23)

### Bug Fixes

* [iOS/macOS] Fix CFBundleShortVersionString not correct in AgoraRtcWrapper framework ([#1387](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1387)) ([ff7a6ce](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/ff7a6ceb5424e1da3ffd8a22bb6241aa1ba1bcde))
## 6.2.3 (2023-10-13)

### Features

* [android] Implement flutter texture rendering ([#1246](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1246)) ([7fd8fee](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7fd8fee851a802dc3fbaef8b70bee3d8215006c0))
* Upgrade native sdk 4.2.3 ([#1312](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1312)) ([553863a](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/553863a1a45861a268cd4b54eca01cc1ce7a7b0b))

### Bug Fixes

* [windows] Fix can not get `irisRtcRenderingHandle` in 32-bit ([#1311](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1311)) ([7438fb2](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7438fb27e0ebc607fdda46a4482bec1f3f2e5070))
## 6.2.2 (2023-08-01)

### Features

* Upgrade native sdk 4.2.2 ([#1142](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1142)) ([3e04fd5](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/3e04fd52fbecd63dc126d044d8570a2b6219c217))

### Bug Fixes

* [android] Fix reset the log file in RtcEngine.initialize cause incorrect log file path ([#1201](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1201)) ([b437bee](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/b437beed39a2ee284a6ff8353a1b0f84703862af))
* [android/ios] Fix crash due to AgoraVideoView.dispose call before RtcEngine.setupxxVideo is completed ([#1224](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1224)) ([f50c4e4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/f50c4e4a89d64090fc6dac25e9999392abbf4327))
* ArgumentError: Invalid argument(s): `6` is not one of the supported values ([25471b8](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/25471b86f39ad14e7d7c624c5266121289b0e43c))
* Fix MediaRecorder.startRecording return -4 after the previous destroy ([76d4dc4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/76d4dc442a4997e7b05e9b9ddfc018845859bf48))
* Fix VideoViewControllerBaseMixin state in-correct issue ([10038b8](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/10038b87a8297d23addbec6124f69e7e7032f297))
## 6.2.1 (2023-06-30)

### Features

* upgrade native sdk 4.2.1 ([#1161](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1161)) ([fbfeb12](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/fbfeb12aef15ac9a1484c3b987b83b06f7abec20))

### Bug Fixes

* do not setup native view if the widget is disposed in platform view rendering ([8fcadea](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/8fcadea2376efb247ffda87fdeccf994d4be31a3))
* Fix AgoraVideoView not showing correctly when reusing the same VideoViewController ([#1169](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1169)) ([6f79203](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/6f792039b90d408d6a258aa2a9e11ab0284c11f7))
* Fix VideoViewController state not correct when the AgoraVideoView is reused ([37e4a21](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/37e4a21eb30e4603a2fe850fe304550a63b8c687))
* no-op if call RtcEngine.release without calling RtcEngine.initialize directly ([95d29ae](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/95d29aeee5ab6dd6c620e38cd5d18b33bc4e06d9))
## 6.2.0 (2023-05-26)

### Features

* upgrade native sdk 4.2.0 ([#1071](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1071)) ([1c2813a](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/1c2813ada6eb9443ee9c14802a73e0c416172f3a)), closes [#1106](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/1106)
## 6.1.1+1 (2023-05-19)

### Bug Fixes

* Fix build error due to iris_method_channel break change ([7841c26](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7841c2604d8c60da1dfff67cc859d694026c8f10))
## 6.1.1 (2023-04-28)

### Features

* [ios] Support render mode and mirror mode for AgoraVideoView with flutter texture rendering ([3b5a1b3](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/3b5a1b34fbd51028de808539a529733fe9ea5452))
* [macos] Support render mode and mirror mode for AgoraVideoView … ([#847](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/847)) ([27db897](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/27db897cefeff1d713d1736b034d36bce9d1845c))
* [windows] Support render mode and mirror mode for AgoraVideoView with flutter texture rendering ([#856](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/856)) ([9bcb1c7](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/9bcb1c706cdbf4c8e14957da69911b2aa5171869))

### Bug Fixes

* [windows] fix AgoraVideoView dispose crash due to multithreading ([7e948db](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7e948db315052621873046cd7a72ea509baba91f))
* can not call startDirectCdnStreaming again after stopDirectCdnStreaming ([37d6ecc](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/37d6eccc38a43ab36a4977e94945780787c654bb))
* fix _HotRestartFinalizer._onExitPort not be initialized in release build ([fad76a5](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/fad76a531da9da5fddb889090ba41ba0346e8270))
* Fix AgoraVideoView not dispose previous renderer when didUpdateWidget called ([24aa879](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/24aa879cb9139b51f49ef74080e89664c9fef617))
* fix crash caused by memory leak when register the raw data observers ([#957](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/957)) ([8c3be90](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/8c3be903ce781937cb382ce25beec5e381e90421))
* fix crash of AgoraVideoView with flutter texture rendering ([244128b](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/244128b8755fe8f9b58b670aa87b4e895001e253))
* Fix getNativeHandle not return correctly ([8dbb478](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/8dbb4783e1929d620f5febb1f72486d77b85b442))
* fix hot restart not work ([df4d8be](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/df4d8be97b2b6fda08792c68fcf8d38cf3c6e8ef))
* fix RtcEngine.release be called due to inaccurate app lifecycle callback in add2app scenario ([9072ad2](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/9072ad25f40ae37e2b653ca6680c7e859f324872))
* fix setupRemoteVideoEx not call correctly ([#909](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/909)) ([856e6d7](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/856e6d70761f05cdbfb850be2af443db1cfed635))
* lazy initialize AgoraVideoView ([#905](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/905)) ([9904cc2](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/9904cc274650b8bb37905f271d455611e9469ffe))
* should not mirror the screen sharing ([cc3d402](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/cc3d402cbd70fcd7b84e90f9870e7423b272b447))
## 6.1.0 (2022-12-20)

### Features

* Upgrade native sdk 4.1.0 ([a56d0f7](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/a56d0f74a2be9697cb5876efe42003f7825be30f))
## 6.0.0 (2022-09-28)

### Bug Fixes

* fix AudioFrameObserver event bugs ([2f82f70](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/2f82f70ec344ec2b751e59396b007bc40f5815b2))
## 6.0.0-rc.1 (2022-09-13)

### Features

* Convert kotlin to java to avoid kotlin version conflict ([#2](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2)) ([10d5166](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/10d51666cba04e0202a19262fcbf4ebd7d6731b1))
* Upgrade native sdk 4.0.0-rc.1 ([1ce73fc](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/1ce73fcb6fab2ee53c84d9b2e1f610b2024d4c1a))

## [6.3.2-sp.432246.b.2](///compare/6.3.2-sp.432246.b.1...6.3.2-sp.432246.b.2) (2025-12-09)

### Features

* hardcode full range ([#2450](undefined/undefined/undefined/issues/2450)) 20fd4af
* upgrade native sdk 4.3.2.246-dev.2 ([#2409](undefined/undefined/undefined/issues/2409)) be1010f
## 6.3.2-sp.432246.b.1 (2025-07-07)

### Bug Fixes

* copy CVPixelBuffer for iOS and macOS ([#2376](undefined/undefined/undefined/issues/2376)) cab0341
* drop frame if current render timems is less than last one ([#2377](undefined/undefined/undefined/issues/2377)) c2900db
* try to fix frame skip issue on android ([#2341](undefined/undefined/undefined/issues/2341)) 88648a8
## 6.3.2-sp.432236.b.2 (2025-05-08)

### Bug Fixes

* add temp variables to avoid data race from commit: 06896207 ([#2188](undefined/undefined/undefined/issues/2188)) 0af4751
* check the renderer in OnVideoFrameReceived before use it ([#2222](undefined/undefined/undefined/issues/2222)) d9b76c4
* do not clear all platform view renders when dispose render ([#2214](undefined/undefined/undefined/issues/2214)) 7f18eca
* hold weak ref of RendererDelegate in async task ([#2265](undefined/undefined/undefined/issues/2265)) ([#2271](undefined/undefined/undefined/issues/2271)) ([#2278](undefined/undefined/undefined/issues/2278)) 2c9545b
* unregister video frame delegate in dealloc of TextureRender to a… ([#2297](undefined/undefined/undefined/issues/2297)) 9a15415, closes #2296
* use weak ref of renderer to avoid crash in async task ([#2194](undefined/undefined/undefined/issues/2194)) dc54474
## 6.3.2-sp.432236.b.1 (2025-05-08)

### Bug Fixes

* eliminate video playback flicker during resolution changes ([#2305](undefined/undefined/undefined/issues/2305)) 938ac09
## 6.3.2-sp.432236 (2025-03-06)

### Features

* upgrade native sdk 4.3.2.236 ([#2213](undefined/undefined/undefined/issues/2213)) e8bec71
## 6.3.2-sp.432234.b.3 (2025-01-16)

### Features

* upgrade iris 4.3.2.234-build.3 ([#2180](undefined/undefined/undefined/issues/2180)) 60bb55c
## 6.3.2-sp.432234 (2024-12-18)

### Features

* replace urls of test media files with agora cdn links ([#2139](undefined/undefined/undefined/issues/2139)) 7bd2893
* upgrade native sdk 4.3.2.234 ([#2160](undefined/undefined/undefined/issues/2160)) 9afcc81

### Bug Fixes

* add missed extra link flags to support to enable 16K page size f… ([#2143](undefined/undefined/undefined/issues/2143)) 43df691

### Reverts

* Revert "chore: limit timeout from 120 or 60 mins to 30 mins" (#2138) 94e973c, closes #2138
## 6.3.2-sp.43211 (2024-12-06)

### Features

* Bump minimum supported Flutter SDK >= 3.7.0 ([#2001](undefined/undefined/undefined/issues/2001)) 3cc945b
* Implement picture-in-picture feature ([#2015](undefined/undefined/undefined/issues/2015)) 16b2530
* upgrade native sdk 4.3.2.5 4c5e2a2
* upgrade native sdk dependencies 20240919 ([#2026](undefined/undefined/undefined/issues/2026)) c5d929e
* upgrade native sdk to 4.3.2.11 ([#2136](undefined/undefined/undefined/issues/2136)) 79c7329

### Bug Fixes

* [windows] Fix TextureRender crash ([#1999](undefined/undefined/undefined/issues/1999)) 0edbfe5
* Fix a potential crash in AgoraVideoView when the app is force quit ([#2055](undefined/undefined/undefined/issues/2055)) 10f92fe
* Fix black screen issue in AgoraVideoView caused by incorrect resize handling ([#2052](undefined/undefined/undefined/issues/2052)) 5ce7f00
* Fix potentially NPE in AgoraVideoView ([#2035](undefined/undefined/undefined/issues/2035)) 3d51db3
* Fix some callbacks not fired ([#2033](undefined/undefined/undefined/issues/2033)) e36069b
* pin kotlin to 1.9.10 and do not test on macos-12 anymore ([#2134](undefined/undefined/undefined/issues/2134)) ec04bf4
* replace public video urls bf8d927
* support android 15 16k page size ([#2043](undefined/undefined/undefined/issues/2043)) 98c9092
* Suppress R8 missing class com.google.devtools.*.ThrowableExtension for AGP 8.x ([#2050](undefined/undefined/undefined/issues/2050)) 3babf2d
* Update minSdkVersion to 21 to Fix NDK Compatibility Issue ([#1832](undefined/undefined/undefined/issues/1832)) 010392b
## 6.3.2 (2024-06-06)

### Features

* upgrade native sdk 4.3.2 ([#1795](undefined/undefined/undefined/issues/1795)) e937989
## 6.3.1 (2024-05-09)

### Features

* Upgrade native sdk 4.3.1 ([#1611](undefined/undefined/undefined/issues/1611)) 18f1a56

### Bug Fixes

* AgoraVideoView crash when dispose after RtcEngine.release ([#1585](undefined/undefined/undefined/issues/1585)) cd33120
* AgoraVideoView takes over the whole browser window ([#1717](undefined/undefined/undefined/issues/1717)) 0052cc7
* Prevent multiple initializations of internal resources when `RtcEngine.initialize` is called simultaneously ([#1712](undefined/undefined/undefined/issues/1712)) 462cfc3
## 6.3.0 (2024-02-28)

### Features

* Upgrade native sdk 4.3.0 ([#1462](undefined/undefined/undefined/issues/1462)) 499d68c

### Bug Fixes

* [texture rendering] Fix texture id lost when widget is updated ([#1543](undefined/undefined/undefined/issues/1543)) f72552d
* Fix MediaEngineImpl.unregisterAudioFrameObserver not unregister eventhandler internally ([#1495](undefined/undefined/undefined/issues/1495)) 7edcd59
## 6.2.6 (2023-11-21)

### Features

* upgrade native sdk 4.2.6 ([#1425](undefined/undefined/undefined/issues/1425)) ([#1442](undefined/undefined/undefined/issues/1442)) 48b3dc4
## 6.2.4 (2023-10-23)

### Bug Fixes

* [iOS/macOS] Fix CFBundleShortVersionString not correct in AgoraRtcWrapper framework ([#1387](undefined/undefined/undefined/issues/1387)) ff7a6ce
## 6.2.3 (2023-10-13)

### Features

* [android] Implement flutter texture rendering ([#1246](undefined/undefined/undefined/issues/1246)) 7fd8fee
* Upgrade native sdk 4.2.3 ([#1312](undefined/undefined/undefined/issues/1312)) 553863a

### Bug Fixes

* [windows] Fix can not get `irisRtcRenderingHandle` in 32-bit ([#1311](undefined/undefined/undefined/issues/1311)) 7438fb2
## 6.2.2 (2023-08-01)

### Features

* Upgrade native sdk 4.2.2 ([#1142](undefined/undefined/undefined/issues/1142)) 3e04fd5

### Bug Fixes

* [android] Fix reset the log file in RtcEngine.initialize cause incorrect log file path ([#1201](undefined/undefined/undefined/issues/1201)) b437bee
* [android/ios] Fix crash due to AgoraVideoView.dispose call before RtcEngine.setupxxVideo is completed ([#1224](undefined/undefined/undefined/issues/1224)) f50c4e4
* ArgumentError: Invalid argument(s): `6` is not one of the supported values 25471b8
* Fix MediaRecorder.startRecording return -4 after the previous destroy 76d4dc4
* Fix VideoViewControllerBaseMixin state in-correct issue 10038b8
## 6.2.1 (2023-06-30)

### Features

* upgrade native sdk 4.2.1 ([#1161](undefined/undefined/undefined/issues/1161)) fbfeb12

### Bug Fixes

* do not setup native view if the widget is disposed in platform view rendering 8fcadea
* Fix AgoraVideoView not showing correctly when reusing the same VideoViewController ([#1169](undefined/undefined/undefined/issues/1169)) 6f79203
* Fix VideoViewController state not correct when the AgoraVideoView is reused 37e4a21
* no-op if call RtcEngine.release without calling RtcEngine.initialize directly 95d29ae

### Reverts

* Revert "[ci][ios][rendering-test] Use github action to manipulate the ios simulator (#1167)" 7513d85, closes #1167
* Revert "[ios] Run ios rendering test on github action runner" 80c9e52
## 6.2.0 (2023-05-26)

### Features

* upgrade native sdk 4.2.0 ([#1071](undefined/undefined/undefined/issues/1071)) 1c2813a, closes #1106
## 6.1.1+1 (2023-05-19)

### Bug Fixes

* Fix build error due to iris_method_channel break change 7841c26
## 6.1.1 (2023-04-28)

### Features

* [ios] Support render mode and mirror mode for AgoraVideoView with flutter texture rendering 3b5a1b3
* [macos] Support render mode and mirror mode for AgoraVideoView … ([#847](undefined/undefined/undefined/issues/847)) 27db897
* [windows] Support render mode and mirror mode for AgoraVideoView with flutter texture rendering ([#856](undefined/undefined/undefined/issues/856)) 9bcb1c7

### Bug Fixes

* [windows] fix AgoraVideoView dispose crash due to multithreading 7e948db
* can not call startDirectCdnStreaming again after stopDirectCdnStreaming 37d6ecc
* fix _HotRestartFinalizer._onExitPort not be initialized in release build fad76a5
* Fix AgoraVideoView not dispose previous renderer when didUpdateWidget called 24aa879
* fix crash caused by memory leak when register the raw data observers ([#957](undefined/undefined/undefined/issues/957)) 8c3be90
* fix crash of AgoraVideoView with flutter texture rendering 244128b
* Fix getNativeHandle not return correctly 8dbb478
* fix hot restart not work df4d8be
* fix RtcEngine.release be called due to inaccurate app lifecycle callback in add2app scenario 9072ad2
* fix setupRemoteVideoEx not call correctly ([#909](undefined/undefined/undefined/issues/909)) 856e6d7
* lazy initialize AgoraVideoView ([#905](undefined/undefined/undefined/issues/905)) 9904cc2
* should not mirror the screen sharing cc3d402

### Reverts

* Revert "Optimize initilizate time of AgoraVideoView with PlatformView rendering (#937)" 0d32d58, closes #937
* Revert "[test] add multiple AgoraVideoViews (flutter texture rendering) show/dispose integration test" 2cfb3f9
## 6.1.0 (2022-12-20)

### Features

* Upgrade native sdk 4.1.0 a56d0f7
## 6.0.0 (2022-09-28)

### Bug Fixes

* fix AudioFrameObserver event bugs 2f82f70
## 6.0.0-rc.1 (2022-09-13)

### Features

* Convert kotlin to java to avoid kotlin version conflict ([#2](undefined/undefined/undefined/issues/2)) 10d5166
* Upgrade native sdk 4.0.0-rc.1 1ce73fc

## [6.3.2-sp.432236.b.2](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/compare/6.3.2-sp.432236.b.1...6.3.2-sp.432236.b.2) (2025-05-08)

### Bug Fixes

* add temp variables to avoid data race from commit: 06896207 ([#2188](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2188)) ([0af4751](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/0af4751e3e70e65fdaa3d5a204d22d3b9a57f44d))
* check the renderer in OnVideoFrameReceived before use it ([#2222](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2222)) ([d9b76c4](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/d9b76c4cce7775c8cd6e476bf4c0881542019ae6))
* do not clear all platform view renders when dispose render ([#2214](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2214)) ([7f18eca](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/7f18ecaec0b14d0a8a87f5b6edc0495a295549ba))
* hold weak ref of RendererDelegate in async task ([#2265](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2265)) ([#2271](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2271)) ([#2278](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2278)) ([2c9545b](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/2c9545b8892f5f0304381c2f9955fe9cbd3e3041))
* unregister video frame delegate in dealloc of TextureRender to a… ([#2297](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2297)) ([9a15415](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/9a15415981f089f27ede059ae323f5cd846e5318)), closes [#2296](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2296)
* use weak ref of renderer to avoid crash in async task ([#2194](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/issues/2194)) ([dc54474](https://github.com/AgoraIO-Extensions/Agora-Flutter-SDK/commit/dc544747cebc939f3782e7a4dfe4e4bd40e16f7a))

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
