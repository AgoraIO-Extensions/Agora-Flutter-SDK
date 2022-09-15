import 'dart:io';

import 'package:agora_rtc_engine_example/examples/advanced/media_player/media_player.dart';
import 'package:agora_rtc_engine_example/examples/advanced/push_encoded_video_frame/push_encoded_video_frame.dart';
import 'package:agora_rtc_engine_example/examples/advanced/push_video_frame/push_video_frame.dart';
import 'package:agora_rtc_engine_example/examples/advanced/rtmp_streaming/rtmp_streaming.dart';
import 'package:agora_rtc_engine_example/examples/advanced/screen_sharing/screen_sharing.dart';
import 'package:agora_rtc_engine_example/examples/advanced/send_multi_camera_stream/send_multi_camera_stream.dart';
import 'package:agora_rtc_engine_example/examples/advanced/send_multi_video_stream/send_multi_video_stream.dart';
import 'package:agora_rtc_engine_example/examples/advanced/set_beauty_effect/set_beauty_effect.dart';
import 'package:agora_rtc_engine_example/examples/advanced/set_encryption/set_encryption.dart';
import 'package:agora_rtc_engine_example/examples/advanced/set_video_encoder_configuration/set_video_encoder_configuration.dart';
import 'package:agora_rtc_engine_example/examples/advanced/spatial_audio_with_media_player/spatial_audio_with_media_player.dart';
import 'package:agora_rtc_engine_example/examples/advanced/start_direct_cdn_streaming/start_direct_cdn_streaming.dart';
import 'package:agora_rtc_engine_example/examples/advanced/start_local_video_transcoder/start_local_video_transcoder.dart';
import 'package:agora_rtc_engine_example/examples/advanced/stream_message/stream_message.dart';
import 'package:agora_rtc_engine_example/examples/advanced/take_snapshot/take_snapshot.dart';
import 'package:flutter/foundation.dart';

import 'audio_mixing/audio_mixing.dart';
import 'audio_spectrum/audio_spectrum.dart';
import 'channel_media_relay/channel_media_relay.dart';
import 'device_manager/device_manager.dart';
import 'enable_virtualbackground/enable_virtualbackground.dart';
import 'join_multiple_channel/join_multiple_channel.dart';
import 'media_recorder/media_recorder.dart';
import 'precall_test/precall_test.dart';
import 'process_audio_raw_data/process_audio_raw_data.dart';
import 'send_metadata/send_metadata.dart';
import 'set_content_inspect/set_content_inspect.dart';
import 'start_rhythm_player/start_rhythm_player.dart';
import 'voice_changer/voice_changer.dart';

/// Data source for advanced examples
final advanced = [
  {'name': 'Advanced'},
  {'name': 'AudioMixing', 'widget': const AudioMixing()},
  {'name': 'ChannelMediaRelay', 'widget': const ChannelMediaRelay()},
  // if (!kIsWeb && (Platform.isAndroid || Platform.isIOS))
  //   {'name': 'CustomCaptureAudio', 'widget': const CustomCaptureAudio()},
  if (kIsWeb || !(Platform.isAndroid || Platform.isIOS))
    {'name': 'DeviceManager', 'widget': const DeviceManager()},
  {'name': 'JoinMultipleChannel', 'widget': const JoinMultipleChannel()},
  {'name': 'RtmpStreaming', 'widget': const RtmpStreaming()},
  if (!kIsWeb) {'name': 'ScreenSharing', 'widget': const ScreenSharing()},
  {'name': 'SetEncryption', 'widget': SetEncryption()},
  {
    'name': 'SetVideoEncoderConfiguration',
    'widget': const SetVideoEncoderConfiguration()
  },
  {'name': 'StreamMessage', 'widget': const StreamMessage()},
  {'name': 'VoiceChanger', 'widget': const VoiceChanger()},
  {
    'name': 'EnableVirtualBackground',
    'widget': const EnableVirtualBackground()
  },
  {'name': 'MediaPlayer', 'widget': const MediaPlayer()},
  {'name': 'SendMultiVideoStream', 'widget': const SendMultiVideoStream()},
  {'name': 'TakeSnapshot', 'widget': const TakeSnapshot()},
  {
    'name': 'StartDirectCDNStreaming',
    'widget': const StartDirectCDNStreaming()
  },
  {'name': 'SendMetadata', 'widget': const SendMetadata()},
  {'name': 'SetBeautyEffect', 'widget': const SetBeautyEffect()},
  {'name': 'SetContentInspect', 'widget': const SetContentInspect()},
  if (kIsWeb || !(Platform.isAndroid || Platform.isIOS))
    {'name': 'SendMultiCameraStream', 'widget': const SendMultiCameraStream()},
  {'name': 'StartRhythmPlayer', 'widget': const StartRhythmPlayer()},
  if (kIsWeb || !(Platform.isAndroid || Platform.isIOS))
    {
      'name': 'StartLocalVideoTranscoder',
      'widget': const StartLocalVideoTranscoder()
    },
  // {'name': 'ProcessVideoRawData', 'widget': const ProcessVideoRawData()},
  {'name': 'ProcessAudioRawData', 'widget': const ProcessAudioRawData()},
  {'name': 'AudioSpectrum', 'widget': const AudioSpectrum()},
  {'name': 'MediaRecorder', 'widget': const MediaRecorder()},
  {'name': 'PushVideoFrame', 'widget': const PushVideoFrame()},
  // {'name': 'PushAudioFrame', 'widget': const PushAudioFrame()},
  {'name': 'PushEncodedVideoFrame', 'widget': const PushEncodedVideoFrame()},
  {
    'name': 'SpatialAudioWithMediaPlayer',
    'widget': const SpatialAudioWithMediaPlayer()
  },
  if (kIsWeb || !(Platform.isAndroid || Platform.isIOS))
    {'name': 'PreCallTest', 'widget': const PreCallTest()},
];
