import 'package:pigeon/pigeon.dart';

/// CustomCaptureAudio API definition
@HostApi()
abstract class CustomCaptureAudioApi {
  /// A binding function for setExternalAudioSource on Android/iOS
  void setExternalAudioSource(bool enabled, int sampleRate, int channels);

  /// A binding function for setExternalAudioSourceVolume on Android/iOS
  void setExternalAudioSourceVolume(int sourcePos, int volume);

  /// Record external audio and push using pushExternalAudioFrame on Android/iOS
  void startAudioRecord(int sampleRate, int channels);

  /// Stop record audio
  void stopAudioRecord();
}
