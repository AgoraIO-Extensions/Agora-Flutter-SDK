# API Example

_English | [中文](README.zh.md)_

## Overview

This repository contains sample projects using the Agora RTC Flutter SDK .

*image_of_a_running_project*

![img.png](img.png)

## Project structure

The project uses a single app to combine a variety of functionalities.

| Function                                                                        | Location                                                                                                                                 |
| ------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| Audio live streaming                                                            | [join_channel_audio.dart](./lib/examples/basic/join_channel_audio/join_channel_audio.dart)                  |
| Video live streaming                                                            | [join_channel_video.dart](./lib/examples/basic/join_channel_video/join_channel_video.dart)                  |
| String user ID                                                                  | [string_uid.dart](./lib/examples/basic/string_uid/string_uid.dart)                  |
| Join multiple channels                                                          | [join_multiple_channel.dart](./lib/examples/advanced/join_multiple_channel/join_multiple_channel.dart)                  |
| Voice effects                                                                   | [voice_changer.dart](./lib/examples/advanced/voice_changer/voice_changer.dart)                  |
| Channel media relay                                                             | [channel_media_relay.dart](./lib/examples/advanced/channel_media_relay/channel_media_relay.dart)                  |
| Send data stream                                                                | [stream_message.dart](./lib/examples/advanced/stream_message/stream_message.dart)                  |
| ...                                                            | ...                  |

## How to run the sample project

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)

### Steps to run

*Steps from cloning the code to running the project*

1. Run `flutter pub get`.
2. Enter the `example` folder.
3. Open [agora.config.json](./lib/config/agora.config.dart) file and specify your App ID and Token.

   > See [Set up Authentication](https://docs.agora.io/en/Agora%20Platform/token) to learn how to get an App ID and access token. You can get a temporary access token to quickly try out this sample project.
   >
   > The Channel name you used to generate the token must be the same as the channel name you use to join a channel.

   > To ensure communication security, Agora uses access tokens (dynamic keys) to authenticate users joining a channel.
   >
   > Temporary access tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating access tokens. See [Generate a Token](https://docs.agora.io/en/Interactive%20Broadcast/token_server) for details.

4. Make the project and run the app in the simulator or connected physical device.

You are all set! Feel free to play with this sample project and explore features of the Agora RTC SDK.


## Feedback

If you have any problems or suggestions regarding the sample projects, feel free to file an issue.

## Reference

- [Product Overview](https://docs.agora.io/en/Interactive%20Broadcast/product_live?platform=Flutter)
- [API Reference](https://docs.agora.io/en/Interactive%20Broadcast/API%20Reference/flutter/index.html)

## Related resources

- Check our [FAQ](https://docs.agora.io/en/faq) to see if your issue has been recorded.
- Dive into [Agora SDK Samples](https://github.com/AgoraIO) to see more tutorials
- Take a look at [Agora Use Case](https://github.com/AgoraIO-usecase) for more complicated real use case
- Repositories managed by developer communities can be found at [Agora Community](https://github.com/AgoraIO-Community)
- If you encounter problems during integration, feel free to ask questions in [Stack Overflow](https://stackoverflow.com/questions/tagged/agora.io)

## License

The sample projects are under the MIT license.
