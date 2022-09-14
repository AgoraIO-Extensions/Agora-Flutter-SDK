import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_event/iris_event.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

extension AudioFrameObserverBaseExt on AudioFrameObserverBase {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'AudioFrameObserver_onRecordAudioFrame':
        if (onRecordAudioFrame == null) break;
        AudioFrameObserverBaseOnRecordAudioFrameJson paramJson =
            AudioFrameObserverBaseOnRecordAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || audioFrame == null) {
          break;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        onRecordAudioFrame!(channelId, audioFrame);
        break;

      case 'AudioFrameObserverBase_onPlaybackAudioFrame':
        if (onPlaybackAudioFrame == null) break;
        AudioFrameObserverBaseOnPlaybackAudioFrameJson paramJson =
            AudioFrameObserverBaseOnPlaybackAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || audioFrame == null) {
          break;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        onPlaybackAudioFrame!(channelId, audioFrame);
        break;

      case 'AudioFrameObserverBase_onMixedAudioFrame':
        if (onMixedAudioFrame == null) break;
        AudioFrameObserverBaseOnMixedAudioFrameJson paramJson =
            AudioFrameObserverBaseOnMixedAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || audioFrame == null) {
          break;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        onMixedAudioFrame!(channelId, audioFrame);
        break;
      default:
        break;
    }
  }
}

class AudioFrameObserverBaseWrapper implements IrisEventHandler {
  const AudioFrameObserverBaseWrapper(this.audioFrameObserverBase);
  final AudioFrameObserverBase audioFrameObserverBase;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AudioFrameObserverBaseWrapper &&
        other.audioFrameObserverBase == audioFrameObserverBase;
  }

  @override
  int get hashCode => audioFrameObserverBase.hashCode;
  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('AudioFrameObserverBase')) return;
    audioFrameObserverBase.process(event, data, buffers);
  }
}

extension AudioFrameObserverExt on AudioFrameObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'AudioFrameObserver_onPlaybackAudioFrameBeforeMixing':
        if (onPlaybackAudioFrameBeforeMixing == null) break;
        AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson paramJson =
            AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        int? uid = paramJson.uid;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || uid == null || audioFrame == null) {
          break;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        onPlaybackAudioFrameBeforeMixing!(channelId, uid, audioFrame);
        break;
      case 'AudioFrameObserver_onRecordAudioFrame':
        if (onRecordAudioFrame == null) break;
        AudioFrameObserverBaseOnRecordAudioFrameJson paramJson =
            AudioFrameObserverBaseOnRecordAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || audioFrame == null) {
          break;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        onRecordAudioFrame!(channelId, audioFrame);
        break;
      default:
        break;
    }
  }
}

class AudioFrameObserverWrapper implements IrisEventHandler {
  const AudioFrameObserverWrapper(this.audioFrameObserver);
  final AudioFrameObserver audioFrameObserver;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AudioFrameObserverWrapper &&
        other.audioFrameObserver == audioFrameObserver;
  }

  @override
  int get hashCode => audioFrameObserver.hashCode;
  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('AudioFrameObserver')) return;
    audioFrameObserver.process(event, data, buffers);
  }
}

extension AudioSpectrumObserverExt on AudioSpectrumObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'AudioSpectrumObserver_onLocalAudioSpectrum':
        if (onLocalAudioSpectrum == null) break;
        AudioSpectrumObserverOnLocalAudioSpectrumJson paramJson =
            AudioSpectrumObserverOnLocalAudioSpectrumJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        AudioSpectrumData? data = paramJson.data;
        if (data == null) {
          break;
        }
        data = data.fillBuffers(buffers);
        onLocalAudioSpectrum!(data);
        break;

      case 'AudioSpectrumObserver_onRemoteAudioSpectrum':
        if (onRemoteAudioSpectrum == null) break;
        AudioSpectrumObserverOnRemoteAudioSpectrumJson paramJson =
            AudioSpectrumObserverOnRemoteAudioSpectrumJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        List<UserAudioSpectrumInfo>? spectrums = paramJson.spectrums;
        int? spectrumNumber = paramJson.spectrumNumber;
        if (spectrums == null || spectrumNumber == null) {
          break;
        }
        spectrums = spectrums.map((e) => e.fillBuffers(buffers)).toList();
        onRemoteAudioSpectrum!(spectrums, spectrumNumber);
        break;
      default:
        break;
    }
  }
}

class AudioSpectrumObserverWrapper implements IrisEventHandler {
  const AudioSpectrumObserverWrapper(this.audioSpectrumObserver);
  final AudioSpectrumObserver audioSpectrumObserver;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is AudioSpectrumObserverWrapper &&
        other.audioSpectrumObserver == audioSpectrumObserver;
  }

  @override
  int get hashCode => audioSpectrumObserver.hashCode;
  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('AudioSpectrumObserver')) return;
    audioSpectrumObserver.process(event, data, buffers);
  }
}

extension VideoEncodedFrameObserverExt on VideoEncodedFrameObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'VideoEncodedFrameObserver_OnEncodedVideoFrameReceived':
        if (onEncodedVideoFrameReceived == null) break;
        VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson paramJson =
            VideoEncodedFrameObserverOnEncodedVideoFrameReceivedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? uid = paramJson.uid;
        Uint8List? imageBuffer = paramJson.imageBuffer;
        int? length = paramJson.length;
        EncodedVideoFrameInfo? videoEncodedFrameInfo =
            paramJson.videoEncodedFrameInfo;
        if (uid == null ||
            imageBuffer == null ||
            length == null ||
            videoEncodedFrameInfo == null) {
          break;
        }
        videoEncodedFrameInfo = videoEncodedFrameInfo.fillBuffers(buffers);
        onEncodedVideoFrameReceived!(
            uid, imageBuffer, length, videoEncodedFrameInfo);
        break;
      default:
        break;
    }
  }
}

class VideoEncodedFrameObserverWrapper implements IrisEventHandler {
  const VideoEncodedFrameObserverWrapper(this.videoEncodedFrameObserver);
  final VideoEncodedFrameObserver videoEncodedFrameObserver;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is VideoEncodedFrameObserverWrapper &&
        other.videoEncodedFrameObserver == videoEncodedFrameObserver;
  }

  @override
  int get hashCode => videoEncodedFrameObserver.hashCode;
  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('VideoEncodedFrameObserver')) return;
    videoEncodedFrameObserver.process(event, data, buffers);
  }
}

extension VideoFrameObserverExt on VideoFrameObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'VideoFrameObserver_onCaptureVideoFrame':
        if (onCaptureVideoFrame == null) break;
        VideoFrameObserverOnCaptureVideoFrameJson paramJson =
            VideoFrameObserverOnCaptureVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onCaptureVideoFrame!(videoFrame);
        break;

      case 'VideoFrameObserver_onPreEncodeVideoFrame':
        if (onPreEncodeVideoFrame == null) break;
        VideoFrameObserverOnPreEncodeVideoFrameJson paramJson =
            VideoFrameObserverOnPreEncodeVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onPreEncodeVideoFrame!(videoFrame);
        break;

      case 'VideoFrameObserver_onSecondaryCameraCaptureVideoFrame':
        if (onSecondaryCameraCaptureVideoFrame == null) break;
        VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson paramJson =
            VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onSecondaryCameraCaptureVideoFrame!(videoFrame);
        break;

      case 'VideoFrameObserver_onSecondaryPreEncodeCameraVideoFrame':
        if (onSecondaryPreEncodeCameraVideoFrame == null) break;
        VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson paramJson =
            VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onSecondaryPreEncodeCameraVideoFrame!(videoFrame);
        break;

      case 'VideoFrameObserver_onScreenCaptureVideoFrame':
        if (onScreenCaptureVideoFrame == null) break;
        VideoFrameObserverOnScreenCaptureVideoFrameJson paramJson =
            VideoFrameObserverOnScreenCaptureVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onScreenCaptureVideoFrame!(videoFrame);
        break;

      case 'VideoFrameObserver_onPreEncodeScreenVideoFrame':
        if (onPreEncodeScreenVideoFrame == null) break;
        VideoFrameObserverOnPreEncodeScreenVideoFrameJson paramJson =
            VideoFrameObserverOnPreEncodeScreenVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onPreEncodeScreenVideoFrame!(videoFrame);
        break;

      case 'VideoFrameObserver_onMediaPlayerVideoFrame':
        if (onMediaPlayerVideoFrame == null) break;
        VideoFrameObserverOnMediaPlayerVideoFrameJson paramJson =
            VideoFrameObserverOnMediaPlayerVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        int? mediaPlayerId = paramJson.mediaPlayerId;
        if (videoFrame == null || mediaPlayerId == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onMediaPlayerVideoFrame!(videoFrame, mediaPlayerId);
        break;

      case 'VideoFrameObserver_onSecondaryScreenCaptureVideoFrame':
        if (onSecondaryScreenCaptureVideoFrame == null) break;
        VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson paramJson =
            VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onSecondaryScreenCaptureVideoFrame!(videoFrame);
        break;

      case 'VideoFrameObserver_onSecondaryPreEncodeScreenVideoFrame':
        if (onSecondaryPreEncodeScreenVideoFrame == null) break;
        VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson paramJson =
            VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onSecondaryPreEncodeScreenVideoFrame!(videoFrame);
        break;

      case 'VideoFrameObserver_onRenderVideoFrame':
        if (onRenderVideoFrame == null) break;
        VideoFrameObserverOnRenderVideoFrameJson paramJson =
            VideoFrameObserverOnRenderVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        int? remoteUid = paramJson.remoteUid;
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (channelId == null || remoteUid == null || videoFrame == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onRenderVideoFrame!(channelId, remoteUid, videoFrame);
        break;

      case 'VideoFrameObserver_onTranscodedVideoFrame':
        if (onTranscodedVideoFrame == null) break;
        VideoFrameObserverOnTranscodedVideoFrameJson paramJson =
            VideoFrameObserverOnTranscodedVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          break;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        onTranscodedVideoFrame!(videoFrame);
        break;
      default:
        break;
    }
  }
}

class VideoFrameObserverWrapper implements IrisEventHandler {
  const VideoFrameObserverWrapper(this.videoFrameObserver);
  final VideoFrameObserver videoFrameObserver;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is VideoFrameObserverWrapper &&
        other.videoFrameObserver == videoFrameObserver;
  }

  @override
  int get hashCode => videoFrameObserver.hashCode;
  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('VideoFrameObserver')) return;
    videoFrameObserver.process(event, data, buffers);
  }
}

extension MediaRecorderObserverExt on MediaRecorderObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'MediaRecorderObserver_onRecorderStateChanged':
        if (onRecorderStateChanged == null) break;
        MediaRecorderObserverOnRecorderStateChangedJson paramJson =
            MediaRecorderObserverOnRecorderStateChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RecorderState? state = paramJson.state;
        RecorderErrorCode? error = paramJson.error;
        if (state == null || error == null) {
          break;
        }
        onRecorderStateChanged!(state, error);
        break;

      case 'MediaRecorderObserver_onRecorderInfoUpdated':
        if (onRecorderInfoUpdated == null) break;
        MediaRecorderObserverOnRecorderInfoUpdatedJson paramJson =
            MediaRecorderObserverOnRecorderInfoUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RecorderInfo? info = paramJson.info;
        if (info == null) {
          break;
        }
        info = info.fillBuffers(buffers);
        onRecorderInfoUpdated!(info);
        break;
      default:
        break;
    }
  }
}

class MediaRecorderObserverWrapper implements IrisEventHandler {
  const MediaRecorderObserverWrapper(this.mediaRecorderObserver);
  final MediaRecorderObserver mediaRecorderObserver;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MediaRecorderObserverWrapper &&
        other.mediaRecorderObserver == mediaRecorderObserver;
  }

  @override
  int get hashCode => mediaRecorderObserver.hashCode;
  @override
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('MediaRecorderObserver')) return;
    mediaRecorderObserver.process(event, data, buffers);
  }
}
