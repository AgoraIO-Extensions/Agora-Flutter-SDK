# Contribute your code

We are glad you are here! Everyone is welcome to contribute code
via pull requests, to help people asking for
help, to add to our documentation, or to help out in any other way.

This document briefly describes some guidance on how you can contribute
to this repository.

## Source code structures

1. **[lib/rtc_engine.dart](lib/rtc_engine.dart)**: Dart APIs wrapper, api message channels to native modules.
2. **[example](example)**: Example demo for quick start/showcase.
3. **[ios/Classes/AgoraRtcEnginePlugin.m](ios/Classes/AgoraRtcEnginePlugin.m)**: iOS native implementation to handle dart message channel api calls.
4. **[android/src/main/kotlin/io/agora/agora_rtc_engine/AgoraRtcEnginePlugin.kt](android/src/main/kotlin/io/agora/agora_rtc_engine/AgoraRtcEnginePlugin.kt)**: Android native implementation to handle dart message channel api calls.

While creating PR, below materials could be helpful:

* [Effective Dart](https://www.dartlang.org/guides/language/effective-dart)
* [Style guide for flutter](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
