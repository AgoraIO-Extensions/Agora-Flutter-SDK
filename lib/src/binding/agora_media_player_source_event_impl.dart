import 'package:agora_rtc_ng/src/binding_forward_export.dart';
import 'package:agora_rtc_ng/src/binding/impl_forward_export.dart';

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
        int? position = paramJson.position;
        if (position == null) {
          break;
        }
        onPositionChanged!(position);
        break;

      case 'MediaPlayerSourceObserver_onPlayerEvent':
        if (onPlayerEvent == null) break;
        MediaPlayerSourceObserverOnPlayerEventJson paramJson =
            MediaPlayerSourceObserverOnPlayerEventJson.fromJson(jsonMap);
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
        onCompleted!();
        break;

      case 'MediaPlayerSourceObserver_onAgoraCDNTokenWillExpire':
        if (onAgoraCDNTokenWillExpire == null) break;
        MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson paramJson =
            MediaPlayerSourceObserverOnAgoraCDNTokenWillExpireJson.fromJson(
                jsonMap);
        onAgoraCDNTokenWillExpire!();
        break;

      case 'MediaPlayerSourceObserver_onPlayerSrcInfoChanged':
        if (onPlayerSrcInfoChanged == null) break;
        MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson paramJson =
            MediaPlayerSourceObserverOnPlayerSrcInfoChangedJson.fromJson(
                jsonMap);
        SrcInfo? from = paramJson.from;
        SrcInfo? to = paramJson.to;
        if (from == null || to == null) {
          break;
        }
        onPlayerSrcInfoChanged!(from, to);
        break;

      case 'MediaPlayerSourceObserver_onPlayerInfoUpdated':
        if (onPlayerInfoUpdated == null) break;
        MediaPlayerSourceObserverOnPlayerInfoUpdatedJson paramJson =
            MediaPlayerSourceObserverOnPlayerInfoUpdatedJson.fromJson(jsonMap);
        PlayerUpdatedInfo? info = paramJson.info;
        if (info == null) {
          break;
        }
        onPlayerInfoUpdated!(info);
        break;

      case 'MediaPlayerSourceObserver_onAudioVolumeIndication':
        if (onAudioVolumeIndication == null) break;
        MediaPlayerSourceObserverOnAudioVolumeIndicationJson paramJson =
            MediaPlayerSourceObserverOnAudioVolumeIndicationJson.fromJson(
                jsonMap);
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
