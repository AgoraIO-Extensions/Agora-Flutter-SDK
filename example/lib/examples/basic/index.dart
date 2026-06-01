import 'package:agora_rtc_engine_example/examples/basic/string_uid/string_uid.dart';
import 'package:agora_rtc_engine_example/examples/basic/web_destroy_video/web_destroy_video.dart';

import 'join_channel_audio/join_channel_audio.dart';
import 'join_channel_video/join_channel_video.dart';
import 'package:flutter/foundation.dart';

/// Data source for basic examples
final basic = [
  {'name': 'Basic'},
  {'name': 'JoinChannelAudio', 'widget': const JoinChannelAudio()},
  {'name': 'JoinChannelVideo', 'widget': const JoinChannelVideo()},
  if (kIsWeb) {'name': 'WebDestroyVideo', 'widget': const WebDestroyVideo()},
  if (!kIsWeb) {'name': 'StringUid', 'widget': const StringUid()}
];
