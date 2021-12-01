import 'package:agora_rtc_engine_example/examples/advanced/audio_mixing/audio_mixing.dart';
import 'package:agora_rtc_engine_example/examples/advanced/channel_media_relay/channel_media_relay.dart';
import 'package:agora_rtc_engine_example/examples/advanced/join_multiple_channel/join_multiple_channel.dart';
import 'package:agora_rtc_engine_example/examples/advanced/rtmp_streaming/rtmp_streaming.dart';
import 'package:agora_rtc_engine_example/examples/advanced/screen_sharing.dart';
import 'package:agora_rtc_engine_example/examples/advanced/set_encryption/set_encryption.dart';
import 'package:agora_rtc_engine_example/examples/advanced/set_video_encoder_configuration/set_video_encoder_configuration.dart';
import 'package:agora_rtc_engine_example/examples/advanced/stream_message/stream_message.dart';
import 'package:agora_rtc_engine_example/examples/advanced/voice_changer/voice_changer.dart';

import 'custom_capture_audio/custom_capture_audio.dart';

/// Data source for advanced examples
final Advanced = [
  {'name': 'Advanced'},
  {'name': 'JoinMultipleChannel', 'widget': JoinMultipleChannel()},
  {
    'name': 'StreamMessage',
    'widget': StreamMessage(),
  },
  {
    'name': 'ChannelMediaRelay',
    'widget': ChannelMediaRelay(),
  },
  {'name': 'VoiceChanger', 'widget': VoiceChanger()},
  {'name': 'CustomCaptureAudio', 'widget': CustomCaptureAudio()},
  {'name': 'ScreenSharing', 'widget': ScreenSharing()},
  {'name': 'AudioMixing', 'widget': AudioMixing()},
  {'name': 'SetEncryption', 'widget': SetEncryption()},
  {'name': 'RtmpStreaming', 'widget': RtmpStreaming()},
  {'name': 'SetVideoEncoderConfiguration', 'widget': SetVideoEncoderConfiguration()},
];
