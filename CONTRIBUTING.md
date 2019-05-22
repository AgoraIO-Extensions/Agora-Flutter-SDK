# Contribute your code

We are glad you are here! Everyone is welcome to contribute code
via pull requests, to help people asking for
help, to add to our documentation, or to help out in any other way.

This document briefly describes some guidance on how you can contribute
to this repository.

## Source code structures

1. **[lib/agora\_rtc\_engine.dart](lib/agora_rtc_engine.dart)**: Dart APIs wrapper, api message channels to native modules.
2. **[example](example)**: Example demo for quick start/showcase.
3. **[ios/Classes/AgoraRtcEnginePlugin.m](https://github.com/AgoraIO/Flutter-SDK/blob/master/ios/Classes/AgoraRtcEnginePlugin.m)**: iOS native implementation to handle dart message channel api calls.
4. **[android/src/main/java/io/agora/agorartcengine/AgoraRtcEnginePlugin.java](android/src/main/java/io/agora/agorartcengine/AgoraRtcEnginePlugin.java)**: Android native implementation to handle dart message channel api calls.

While creating PR, below materials could be helful:

* [Effective Dart](https://www.dartlang.org/guides/language/effective-dart)
* [Style guide for flutter](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo)
