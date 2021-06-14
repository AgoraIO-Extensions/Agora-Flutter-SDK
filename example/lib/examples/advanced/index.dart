import 'package:agora_rtc_engine_example/examples/advanced/create_stream_data.dart';
import 'package:agora_rtc_engine_example/examples/advanced/live_streaming.dart';
import 'package:agora_rtc_engine_example/examples/advanced/media_channel_relay.dart';
import 'package:agora_rtc_engine_example/examples/advanced/multi_channel.dart';
import 'package:agora_rtc_engine_example/examples/advanced/screen_sharing.dart';
import 'package:agora_rtc_engine_example/examples/advanced/voice_change.dart';

/// Data source for advanced examples
final Advanced = [
  {'name': 'Advanced'},
  {'name': 'MultiChannel', 'widget': MultiChannel()},
  {'name': 'LiveStreaming', 'widget': LiveStreaming()},
  {'name': 'CreateStreamData', 'widget': CreateStreamData()},
  {'name': 'MediaChannelRelay', 'widget': MediaChannelRelay()},
  {'name': 'ScreenSharing', 'widget': ScreenSharing()},
  {'name': 'VoiceChange', 'widget': VoiceChange()},
];
