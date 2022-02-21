import 'dart:io';

import 'package:agora_rtc_engine_example/examples/advanced/audio_mixing/audio_mixing.dart';
import 'package:agora_rtc_engine_example/examples/advanced/channel_media_relay/channel_media_relay.dart';
import 'package:agora_rtc_engine_example/examples/advanced/custom_capture_audio/custom_capture_audio.dart';
import 'package:agora_rtc_engine_example/examples/advanced/device_manager/device_manager.dart';
import 'package:agora_rtc_engine_example/examples/advanced/join_multiple_channel/join_multiple_channel.dart';
import 'package:agora_rtc_engine_example/examples/advanced/rtmp_streaming/rtmp_streaming.dart';
import 'package:agora_rtc_engine_example/examples/advanced/screen_sharing/screen_sharing.dart';
import 'package:agora_rtc_engine_example/examples/advanced/set_encryption/set_encryption.dart';
import 'package:agora_rtc_engine_example/examples/advanced/set_video_encoder_configuration/set_video_encoder_configuration.dart';
import 'package:agora_rtc_engine_example/examples/advanced/stream_message/stream_message.dart';
import 'package:agora_rtc_engine_example/examples/advanced/voice_changer/voice_changer.dart';
import 'package:flutter/foundation.dart';

/// Data source for advanced examples
final Advanced = [
  {'name': 'Advanced'},
  {'name': 'AudioMixing', 'widget': AudioMixing()},
  {'name': 'ChannelMediaRelay', 'widget': ChannelMediaRelay()},
  if (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
    {'name': 'CustomCaptureAudio', 'widget': CustomCaptureAudio()},
  if (kIsWeb || !(Platform.isAndroid || Platform.isIOS))
    {'name': 'DeviceManager', 'widget': DeviceManager()},
  {'name': 'JoinMultipleChannel', 'widget': JoinMultipleChannel()},
  {'name': 'RtmpStreaming', 'widget': RtmpStreaming()},
  if (kIsWeb || !(Platform.isAndroid || Platform.isIOS))
    {'name': 'ScreenSharing', 'widget': ScreenSharing()},
  {'name': 'SetEncryption', 'widget': SetEncryption()},
  {
    'name': 'SetVideoEncoderConfiguration',
    'widget': SetVideoEncoderConfiguration()
  },
  {'name': 'StreamMessage', 'widget': StreamMessage()},
  {'name': 'VoiceChanger', 'widget': VoiceChanger()},
];
