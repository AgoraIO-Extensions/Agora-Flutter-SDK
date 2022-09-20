import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:agora_rtc_engine/src/impl/event_loop.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class AudioFrameObserverBaseWrapper implements EventLoopEventHandler {
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
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onRecordAudioFrame':
        if (audioFrameObserverBase.onRecordAudioFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        AudioFrameObserverBaseOnRecordAudioFrameJson paramJson =
            AudioFrameObserverBaseOnRecordAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || audioFrame == null) {
          return true;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        audioFrameObserverBase.onRecordAudioFrame!(channelId, audioFrame);
        return true;

      case 'onPlaybackAudioFrame':
        if (audioFrameObserverBase.onPlaybackAudioFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        AudioFrameObserverBaseOnPlaybackAudioFrameJson paramJson =
            AudioFrameObserverBaseOnPlaybackAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || audioFrame == null) {
          return true;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        audioFrameObserverBase.onPlaybackAudioFrame!(channelId, audioFrame);
        return true;

      case 'onMixedAudioFrame':
        if (audioFrameObserverBase.onMixedAudioFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        AudioFrameObserverBaseOnMixedAudioFrameJson paramJson =
            AudioFrameObserverBaseOnMixedAudioFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || audioFrame == null) {
          return true;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        audioFrameObserverBase.onMixedAudioFrame!(channelId, audioFrame);
        return true;

      case 'onEarMonitoringAudioFrame':
        if (audioFrameObserverBase.onEarMonitoringAudioFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        AudioFrameObserverBaseOnEarMonitoringAudioFrameJson paramJson =
            AudioFrameObserverBaseOnEarMonitoringAudioFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (audioFrame == null) {
          return true;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        audioFrameObserverBase.onEarMonitoringAudioFrame!(audioFrame);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('AudioFrameObserverBase')) return false;
    final newEvent = eventName.replaceFirst('AudioFrameObserverBase_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}

class AudioFrameObserverWrapper extends AudioFrameObserverBaseWrapper {
  const AudioFrameObserverWrapper(this.audioFrameObserver)
      : super(audioFrameObserver);
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
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onPlaybackAudioFrameBeforeMixing':
        if (audioFrameObserver.onPlaybackAudioFrameBeforeMixing == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson paramJson =
            AudioFrameObserverOnPlaybackAudioFrameBeforeMixingJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        int? uid = paramJson.uid;
        AudioFrame? audioFrame = paramJson.audioFrame;
        if (channelId == null || uid == null || audioFrame == null) {
          return true;
        }
        audioFrame = audioFrame.fillBuffers(buffers);
        audioFrameObserver.onPlaybackAudioFrameBeforeMixing!(
            channelId, uid, audioFrame);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('AudioFrameObserver')) return false;
    final newEvent = eventName.replaceFirst('AudioFrameObserver_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return super.handleEventInternal(newEvent, eventData, buffers);
  }
}

class AudioSpectrumObserverWrapper implements EventLoopEventHandler {
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
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onLocalAudioSpectrum':
        if (audioSpectrumObserver.onLocalAudioSpectrum == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        AudioSpectrumObserverOnLocalAudioSpectrumJson paramJson =
            AudioSpectrumObserverOnLocalAudioSpectrumJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        AudioSpectrumData? data = paramJson.data;
        if (data == null) {
          return true;
        }
        data = data.fillBuffers(buffers);
        audioSpectrumObserver.onLocalAudioSpectrum!(data);
        return true;

      case 'onRemoteAudioSpectrum':
        if (audioSpectrumObserver.onRemoteAudioSpectrum == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        AudioSpectrumObserverOnRemoteAudioSpectrumJson paramJson =
            AudioSpectrumObserverOnRemoteAudioSpectrumJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        List<UserAudioSpectrumInfo>? spectrums = paramJson.spectrums;
        int? spectrumNumber = paramJson.spectrumNumber;
        if (spectrums == null || spectrumNumber == null) {
          return true;
        }
        spectrums = spectrums.map((e) => e.fillBuffers(buffers)).toList();
        audioSpectrumObserver.onRemoteAudioSpectrum!(spectrums, spectrumNumber);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('AudioSpectrumObserver')) return false;
    final newEvent = eventName.replaceFirst('AudioSpectrumObserver_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}

class VideoEncodedFrameObserverWrapper implements EventLoopEventHandler {
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
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onEncodedVideoFrameReceived':
        if (videoEncodedFrameObserver.onEncodedVideoFrameReceived == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
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
          return true;
        }
        videoEncodedFrameInfo = videoEncodedFrameInfo.fillBuffers(buffers);
        videoEncodedFrameObserver.onEncodedVideoFrameReceived!(
            uid, imageBuffer, length, videoEncodedFrameInfo);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('VideoEncodedFrameObserver')) return false;
    final newEvent = eventName.replaceFirst('VideoEncodedFrameObserver_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}

class VideoFrameObserverWrapper implements EventLoopEventHandler {
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
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onCaptureVideoFrame':
        if (videoFrameObserver.onCaptureVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnCaptureVideoFrameJson paramJson =
            VideoFrameObserverOnCaptureVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onCaptureVideoFrame!(videoFrame);
        return true;

      case 'onPreEncodeVideoFrame':
        if (videoFrameObserver.onPreEncodeVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnPreEncodeVideoFrameJson paramJson =
            VideoFrameObserverOnPreEncodeVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onPreEncodeVideoFrame!(videoFrame);
        return true;

      case 'onSecondaryCameraCaptureVideoFrame':
        if (videoFrameObserver.onSecondaryCameraCaptureVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson paramJson =
            VideoFrameObserverOnSecondaryCameraCaptureVideoFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onSecondaryCameraCaptureVideoFrame!(videoFrame);
        return true;

      case 'onSecondaryPreEncodeCameraVideoFrame':
        if (videoFrameObserver.onSecondaryPreEncodeCameraVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson paramJson =
            VideoFrameObserverOnSecondaryPreEncodeCameraVideoFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onSecondaryPreEncodeCameraVideoFrame!(videoFrame);
        return true;

      case 'onScreenCaptureVideoFrame':
        if (videoFrameObserver.onScreenCaptureVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnScreenCaptureVideoFrameJson paramJson =
            VideoFrameObserverOnScreenCaptureVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onScreenCaptureVideoFrame!(videoFrame);
        return true;

      case 'onPreEncodeScreenVideoFrame':
        if (videoFrameObserver.onPreEncodeScreenVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnPreEncodeScreenVideoFrameJson paramJson =
            VideoFrameObserverOnPreEncodeScreenVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onPreEncodeScreenVideoFrame!(videoFrame);
        return true;

      case 'onMediaPlayerVideoFrame':
        if (videoFrameObserver.onMediaPlayerVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnMediaPlayerVideoFrameJson paramJson =
            VideoFrameObserverOnMediaPlayerVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        int? mediaPlayerId = paramJson.mediaPlayerId;
        if (videoFrame == null || mediaPlayerId == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onMediaPlayerVideoFrame!(videoFrame, mediaPlayerId);
        return true;

      case 'onSecondaryScreenCaptureVideoFrame':
        if (videoFrameObserver.onSecondaryScreenCaptureVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson paramJson =
            VideoFrameObserverOnSecondaryScreenCaptureVideoFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onSecondaryScreenCaptureVideoFrame!(videoFrame);
        return true;

      case 'onSecondaryPreEncodeScreenVideoFrame':
        if (videoFrameObserver.onSecondaryPreEncodeScreenVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson paramJson =
            VideoFrameObserverOnSecondaryPreEncodeScreenVideoFrameJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onSecondaryPreEncodeScreenVideoFrame!(videoFrame);
        return true;

      case 'onRenderVideoFrame':
        if (videoFrameObserver.onRenderVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnRenderVideoFrameJson paramJson =
            VideoFrameObserverOnRenderVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? channelId = paramJson.channelId;
        int? remoteUid = paramJson.remoteUid;
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (channelId == null || remoteUid == null || videoFrame == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onRenderVideoFrame!(
            channelId, remoteUid, videoFrame);
        return true;

      case 'onTranscodedVideoFrame':
        if (videoFrameObserver.onTranscodedVideoFrame == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        VideoFrameObserverOnTranscodedVideoFrameJson paramJson =
            VideoFrameObserverOnTranscodedVideoFrameJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        VideoFrame? videoFrame = paramJson.videoFrame;
        if (videoFrame == null) {
          return true;
        }
        videoFrame = videoFrame.fillBuffers(buffers);
        videoFrameObserver.onTranscodedVideoFrame!(videoFrame);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('VideoFrameObserver')) return false;
    final newEvent = eventName.replaceFirst('VideoFrameObserver_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}

class MediaRecorderObserverWrapper implements EventLoopEventHandler {
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
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onRecorderStateChanged':
        if (mediaRecorderObserver.onRecorderStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaRecorderObserverOnRecorderStateChangedJson paramJson =
            MediaRecorderObserverOnRecorderStateChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RecorderState? state = paramJson.state;
        RecorderErrorCode? error = paramJson.error;
        if (state == null || error == null) {
          return true;
        }
        mediaRecorderObserver.onRecorderStateChanged!(state, error);
        return true;

      case 'onRecorderInfoUpdated':
        if (mediaRecorderObserver.onRecorderInfoUpdated == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaRecorderObserverOnRecorderInfoUpdatedJson paramJson =
            MediaRecorderObserverOnRecorderInfoUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        RecorderInfo? info = paramJson.info;
        if (info == null) {
          return true;
        }
        info = info.fillBuffers(buffers);
        mediaRecorderObserver.onRecorderInfoUpdated!(info);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('MediaRecorderObserver')) return false;
    final newEvent = eventName.replaceFirst('MediaRecorderObserver_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}
