import 'package:agora_rtc_engine_example/examples/advanced/stream_message/stream_message.dart';
import 'package:agora_rtc_engine_example/examples/advanced/channel_media_relay/media_channel_relay.dart';
import 'package:agora_rtc_engine_example/examples/advanced/join_multiple_channel/join_multi_channel.dart';
import 'package:agora_rtc_engine_example/examples/advanced/voice_changer/voice_changer.dart';

import 'custom_capture_audio/custom_capture_audio.dart';

/// Data source for advanced examples
final Advanced = [
  {'name': 'Advanced'},
  {'name': 'JoinMultiChannel', 'widget': JoinMultiChannel()},
  {
    'name': 'StreamMessage',
    'widget': StreamMessage(),
  },
  {
    'name': 'MediaChannelRelay',
    'widget': MediaChannelRelay(),
  },
  {'name': 'VoiceChanger', 'widget': VoiceChanger()},
  {'name': 'CustomCaptureAudio', 'widget': CustomCaptureAudio()},
];
