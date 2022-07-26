import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_event/iris_event.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

extension MediaPlayerSourceObserverExt on MediaPlayerSourceObserver {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'MediaPlayerSourceObserver_onPlayerSourceStateChanged':
        if (onPlayerSourceStateChanged == null) break;
        MediaPlayerSourceObserverOnPlayerSourceStateChangedJson paramJson =
            MediaPlayerSourceObserverOnPlayerSourceStateChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        MediaPlayerState? state = paramJson.state;
        MediaPlayerError? ec = paramJson.ec;
        if (state == null || ec == null) {
          break;
        }
        onPlayerSourceStateChanged!(state, ec);
        break;

      case 'MediaPlayerSourceObserver_onPositionChanged':
        if (onPositionChanged == null) break;
        MediaPlayerSourceObserverOnPositionChangedJson paramJson =
            MediaPlayerSourceObserverOnPositionChangedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? positionMs = paramJson.positionMs;
        if (positionMs == null) {
          break;
        }
        onPositionChanged!(positionMs);
        break;

      case 'MediaPlayerSourceObserver_onPlayerEvent':
        if (onPlayerEvent == null) break;
        MediaPlayerSourceObserverOnPlayerEventJson paramJson =
            MediaPlayerSourceObserverOnPlayerEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        MediaPlayerEvent? eventCode = paramJson.eventCode;
        int? elapsedTime = paramJson.elapsedTime;
        String? message = paramJson.message;
        if (eventCode == null || elapsedTime == null || message == null) {
          break;
        }
        onPlayerEvent!(eventCode, elapsedTime, message);
        break;

      case 'MediaPlayerSourceObserver_onMetaData':
        if (onMetaData == null) break;
        MediaPlayerSourceObserverOnMetaDataJson paramJson =
            MediaPlayerSourceObserverOnMetaDataJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        Uint8List? data = paramJson.data;
        int? length = paramJson.length;
        if (data == null || length == null) {
          break;
        }
        onMetaData!(data, length);
        break;

      case 'MediaPlayerSourceObserver_onPlayBufferUpdated':
        if (onPlayBufferUpdated == null) break;
        MediaPlayerSourceObserverOnPlayBufferUpdatedJson paramJson =
            MediaPlayerSourceObserverOnPlayBufferUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? playCachedBuffer = paramJson.playCachedBuffer;
        if (playCachedBuffer == null) {
          break;
        }
        onPlayBufferUpdated!(playCachedBuffer);
        break;

      case 'MediaPlayerSourceObserver_onPreloadEvent':
        if (onPreloadEvent == null) break;
        MediaPlayerSourceObserverOnPreloadEventJson paramJson =
            MediaPlayerSourceObserverOnPreloadEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? src = paramJson.src;
        PlayerPreloadEvent? event = paramJson.event;
        if (src == null || event == null) {
          break;
        }
        onPreloadEvent!(src, event);
        break;

      case 'MediaPlayerSourceObserver_onCompleted':
        if (onCompleted == null) break;
        MediaPlayerSourceObserverOnCompletedJson paramJson =
            MediaPlayerSourceObserverOnCompletedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        onCompleted!();
        break;

      case 'MediaPlayerSourceObserver_onAgoraCDNTokenWillExpire':
        if (onAgoraCDNTokenWillExpire == null) break;
        MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson paramJson =
            MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        onAgoraCDNTokenWillExpire!();
        break;

      case 'MediaPlayerSourceObserver_onPlayerSrcInfoChanged':
        if (onPlayerSrcInfoChanged == null) break;
        MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson paramJson =
            MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        SrcInfo? from = paramJson.from;
        SrcInfo? to = paramJson.to;
        if (from == null || to == null) {
          break;
        }
        from = from.fillBuffers(buffers);
        to = to.fillBuffers(buffers);
        onPlayerSrcInfoChanged!(from, to);
        break;

      case 'MediaPlayerSourceObserver_onPlayerInfoUpdated':
        if (onPlayerInfoUpdated == null) break;
        MediaPlayerSourceObserverOnPlayerInfoUpdatedJson paramJson =
            MediaPlayerSourceObserverOnPlayerInfoUpdatedJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        PlayerUpdatedInfo? info = paramJson.info;
        if (info == null) {
          break;
        }
        info = info.fillBuffers(buffers);
        onPlayerInfoUpdated!(info);
        break;

      case 'MediaPlayerSourceObserver_onAudioVolumeIndication':
        if (onAudioVolumeIndication == null) break;
        MediaPlayerSourceObserverOnAudioVolumeIndicationJson paramJson =
            MediaPlayerSourceObserverOnAudioVolumeIndicationJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? volume = paramJson.volume;
        if (volume == null) {
          break;
        }
        onAudioVolumeIndication!(volume);
        break;
      default:
        break;
    }
  }
}

class MediaPlayerSourceObserverWrapper implements IrisEventHandler {
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
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('MediaPlayerSourceObserver')) return;
    mediaPlayerSourceObserver.process(event, data, buffers);
  }
}
