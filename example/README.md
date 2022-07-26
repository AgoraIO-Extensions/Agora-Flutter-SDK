# agora_rtc_engine_example

## Overview

This project is an open-source demo that will show you different scenes on how to integrate [agora_rtc_engine](https://pub.dev/packages/agora_rtc_engine) APIs into your project.

Any scene of this project can run successfully alone.

## Project structure

### Basic demos

| Demo                                                         | Description                                        | APIs                                                         |
| ------------------------------------------------------------ | -------------------------------------------------- | ------------------------------------------------------------ |
| [JoinChannelAudio](./lib/examples/basic/join_channel_audio/join_channel_audio.dart) | Audio live streaming | |
| [JoinChannelVideo](./lib/examples/basic/join_channel_video/join_channel_video.dart) | Video live streaming | |
| [StringUid](./lib/examples/basic/string_uid/string_uid.dart) | String user ID | |

### Advanced demos

| Demo                                                         | Description                                                  | APIs                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| [AudioMixing](./lib/examples/advanced/audio_mixing/audio_mixing.dart) | Audio mixing |
| [ChannelMediaRelay](./lib/examples/advanced/channel_media_relay/channel_media_relay.dart) | Channel media relay | |
| [DeviceManager](./lib/examples/advanced/device_manager/device_manager.dart) | Device Manager | |
| [EnableVirtualBackground](./lib/examples/advanced/enable_virtualbackground/enable_virtualbackground.dart) | Enable Virtual Background | |
| [JoinMultipleChannel](./lib/examples/advanced/join_multiple_channel/join_multiple_channel.dart) | Join multiple channels | |
| [MediaPlayer](./lib/examples/advanced/media_player/media_player.dart) | MediaPlayer | |
| [RTMPStreaming](./lib/examples/advanced/rtmp_streaming/rtmp_streaming.dart)| RTMP streaming | |
| [ScreenSharing](./lib/examples/advanced/screen_sharing)| Screen sharing | |
| [SendMetadata](./lib/examples/advanced/send_metadata/send_metadata.dart) | Send Metadata | |
| [SendMultiCameraStream](./lib/examples/advanced/send_multi_camera_stream/send_multi_camera_stream.dart) | Send Multi Camera Stream | |
| [SendMultiVideoStream](./lib/examples/advanced/send_multi_video_stream/send_multi_video_stream.dart) | Send Multi Video Stream | |
| [SetBeautyEffect](./lib/examples/advanced/set_beauty_effect/set_beauty_effect.dart) | SetBeautyEffect | |
| [SetContentInspect](./lib/examples/advanced/set_content_inspect/set_content_inspect.dart) | SetContentInspect | |
| [SetContentInspect](./lib/examples/advanced/set_content_inspect/set_content_inspect.dart) | SetContentInspect | |
| [SetEncryption](./lib/examples/advanced/set_encryption/set_encryption.dart)| Set encryption | |
| [SetVideoEncoderConfiguration](./lib/examples/advanced/set_video_encoder_configuration/set_video_encoder_configuration.dart)| Set video encoder configuration | |
| [StartDirectCDNStreaming](./lib/examples/advanced/start_direct_cdn_streaming/start_direct_cdn_streaming.dart)| Set video encoder configuration | |
| [StartLocalVideoTranscoder](./lib/examples/advanced/start_local_video_transcoder/start_local_video_transcoder.dart)| Start Local Video Transcoder | |
| [StartRhythmPlayer](./lib/examples/advanced/start_rhythm_player/start_rhythm_player.dart)| Start Rhythm Player | |
| [StreamMessage](./lib/examples/advanced/stream_message) | Send data stream  | |
| [TakeSnapshot](./lib/examples/advanced/take_snapshot/take_snapshot.dart)| Take Snapshot | |
| [VoiceChanger](./lib/examples/advanced/voice_changer/voice_changer.dart) | Voice effects | |

## How to run the sample project

#### Developer Environment Requirements

- [Flutter](https://flutter.dev/docs/get-started/install)

### Steps to run

*Steps from cloning the code to running the project*

1. Run `flutter pub get`.
2. Enter the `example` folder.
3. Open [agora.config.dart](./lib/config/agora.config.dart) file and specify your App ID and Token.

   > See [Set up Authentication](https://docs.agora.io/en/Agora%20Platform/token) to learn how to get an App ID and access token. You can get a temporary access token to quickly try out this sample project.
   >
   > The Channel name you used to generate the token must be the same as the channel name you use to join a channel.

   > To ensure communication security, Agora uses access tokens (dynamic keys) to authenticate users joining a channel.
   >
   > Temporary access tokens are for demonstration and testing purposes only and remain valid for 24 hours. In a production environment, you need to deploy your own server for generating access tokens. See [Generate a Token](https://docs.agora.io/en/Interactive%20Broadcast/token_server) for details.

4. Make the project and run the app in the simulator or connected physical device.

You are all set! Feel free to play with this sample project and explore features of the [agora_rtc_engine](https://pub.dev/packages/agora_rtc_engine).