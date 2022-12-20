import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:agora_rtc_engine/src/impl/event_loop.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class MediaPlayerSourceObserverWrapper implements EventLoopEventHandler {
  const MediaPlayerSourceObserverWrapper(this.mediaPlayerSourceObserver);
  final MediaPlayerSourceObserver mediaPlayerSourceObserver;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MediaPlayerSourceObserverWrapper &&
        other.mediaPlayerSourceObserver == mediaPlayerSourceObserver;
  }

  @override
  int get hashCode => mediaPlayerSourceObserver.hashCode;
  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onPlayerSourceStateChanged':
        if (mediaPlayerSourceObserver.onPlayerSourceStateChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnPlayerSourceStateChangedJson paramJson =
            MediaPlayerSourceObserverOnPlayerSourceStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        MediaPlayerState? state = paramJson.state;
        MediaPlayerError? ec = paramJson.ec;
        if (state == null || ec == null) {
          return true;
        }
        mediaPlayerSourceObserver.onPlayerSourceStateChanged!(state, ec);
        return true;

      case 'onPositionChanged':
        if (mediaPlayerSourceObserver.onPositionChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnPositionChangedJson paramJson =
            MediaPlayerSourceObserverOnPositionChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? positionMs = paramJson.positionMs;
        if (positionMs == null) {
          return true;
        }
        mediaPlayerSourceObserver.onPositionChanged!(positionMs);
        return true;

      case 'onPlayerEvent':
        if (mediaPlayerSourceObserver.onPlayerEvent == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnPlayerEventJson paramJson =
            MediaPlayerSourceObserverOnPlayerEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        MediaPlayerEvent? eventCode = paramJson.eventCode;
        int? elapsedTime = paramJson.elapsedTime;
        String? message = paramJson.message;
        if (eventCode == null || elapsedTime == null || message == null) {
          return true;
        }
        mediaPlayerSourceObserver.onPlayerEvent!(
            eventCode, elapsedTime, message);
        return true;

      case 'onMetaData':
        if (mediaPlayerSourceObserver.onMetaData == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnMetaDataJson paramJson =
            MediaPlayerSourceObserverOnMetaDataJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        Uint8List? data = paramJson.data;
        int? length = paramJson.length;
        if (data == null || length == null) {
          return true;
        }
        mediaPlayerSourceObserver.onMetaData!(data, length);
        return true;

      case 'onPlayBufferUpdated':
        if (mediaPlayerSourceObserver.onPlayBufferUpdated == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnPlayBufferUpdatedJson paramJson =
            MediaPlayerSourceObserverOnPlayBufferUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? playCachedBuffer = paramJson.playCachedBuffer;
        if (playCachedBuffer == null) {
          return true;
        }
        mediaPlayerSourceObserver.onPlayBufferUpdated!(playCachedBuffer);
        return true;

      case 'onPreloadEvent':
        if (mediaPlayerSourceObserver.onPreloadEvent == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnPreloadEventJson paramJson =
            MediaPlayerSourceObserverOnPreloadEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? src = paramJson.src;
        PlayerPreloadEvent? event = paramJson.event;
        if (src == null || event == null) {
          return true;
        }
        mediaPlayerSourceObserver.onPreloadEvent!(src, event);
        return true;

      case 'onCompleted':
        if (mediaPlayerSourceObserver.onCompleted == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnCompletedJson paramJson =
            MediaPlayerSourceObserverOnCompletedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        mediaPlayerSourceObserver.onCompleted!();
        return true;

      case 'onAgoraCDNTokenWillExpire':
        if (mediaPlayerSourceObserver.onAgoraCDNTokenWillExpire == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson paramJson =
            MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        mediaPlayerSourceObserver.onAgoraCDNTokenWillExpire!();
        return true;

      case 'onPlayerSrcInfoChanged':
        if (mediaPlayerSourceObserver.onPlayerSrcInfoChanged == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson paramJson =
            MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        SrcInfo? from = paramJson.from;
        SrcInfo? to = paramJson.to;
        if (from == null || to == null) {
          return true;
        }
        from = from.fillBuffers(buffers);
        to = to.fillBuffers(buffers);
        mediaPlayerSourceObserver.onPlayerSrcInfoChanged!(from, to);
        return true;

      case 'onPlayerInfoUpdated':
        if (mediaPlayerSourceObserver.onPlayerInfoUpdated == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnPlayerInfoUpdatedJson paramJson =
            MediaPlayerSourceObserverOnPlayerInfoUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        PlayerUpdatedInfo? info = paramJson.info;
        if (info == null) {
          return true;
        }
        info = info.fillBuffers(buffers);
        mediaPlayerSourceObserver.onPlayerInfoUpdated!(info);
        return true;

      case 'onAudioVolumeIndication':
        if (mediaPlayerSourceObserver.onAudioVolumeIndication == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MediaPlayerSourceObserverOnAudioVolumeIndicationJson paramJson =
            MediaPlayerSourceObserverOnAudioVolumeIndicationJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? volume = paramJson.volume;
        if (volume == null) {
          return true;
        }
        mediaPlayerSourceObserver.onAudioVolumeIndication!(volume);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('MediaPlayerSourceObserver')) return false;
    final newEvent = eventName.replaceFirst('MediaPlayerSourceObserver_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}
