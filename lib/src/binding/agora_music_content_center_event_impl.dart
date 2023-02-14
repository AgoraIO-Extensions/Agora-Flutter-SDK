import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_method_channel/iris_method_channel.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

class MusicContentCenterEventHandlerWrapper implements EventLoopEventHandler {
  const MusicContentCenterEventHandlerWrapper(
      this.musicContentCenterEventHandler);
  final MusicContentCenterEventHandler musicContentCenterEventHandler;
  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MusicContentCenterEventHandlerWrapper &&
        other.musicContentCenterEventHandler == musicContentCenterEventHandler;
  }

  @override
  int get hashCode => musicContentCenterEventHandler.hashCode;
  @override
  bool handleEventInternal(
      String eventName, String eventData, List<Uint8List> buffers) {
    switch (eventName) {
      case 'onMusicChartsResult':
        if (musicContentCenterEventHandler.onMusicChartsResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MusicContentCenterEventHandlerOnMusicChartsResultJson paramJson =
            MusicContentCenterEventHandlerOnMusicChartsResultJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? requestId = paramJson.requestId;
        List<MusicChartInfo>? result = paramJson.result;
        MusicContentCenterStatusCode? errorCode = paramJson.errorCode;
        if (requestId == null || result == null || errorCode == null) {
          return true;
        }
        result = result.map((e) => e.fillBuffers(buffers)).toList();
        musicContentCenterEventHandler.onMusicChartsResult!(
            requestId, result, errorCode);
        return true;

      case 'onMusicCollectionResult':
        if (musicContentCenterEventHandler.onMusicCollectionResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MusicContentCenterEventHandlerOnMusicCollectionResultJson paramJson =
            MusicContentCenterEventHandlerOnMusicCollectionResultJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? requestId = paramJson.requestId;
        MusicCollection? result = paramJson.result;
        MusicContentCenterStatusCode? errorCode = paramJson.errorCode;
        if (requestId == null || result == null || errorCode == null) {
          return true;
        }
        musicContentCenterEventHandler.onMusicCollectionResult!(
            requestId, result, errorCode);
        return true;

      case 'onLyricResult':
        if (musicContentCenterEventHandler.onLyricResult == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MusicContentCenterEventHandlerOnLyricResultJson paramJson =
            MusicContentCenterEventHandlerOnLyricResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? requestId = paramJson.requestId;
        String? lyricUrl = paramJson.lyricUrl;
        MusicContentCenterStatusCode? errorCode = paramJson.errorCode;
        if (requestId == null || lyricUrl == null || errorCode == null) {
          return true;
        }
        musicContentCenterEventHandler.onLyricResult!(
            requestId, lyricUrl, errorCode);
        return true;

      case 'onPreLoadEvent':
        if (musicContentCenterEventHandler.onPreLoadEvent == null) {
          return true;
        }
        final jsonMap = jsonDecode(eventData);
        MusicContentCenterEventHandlerOnPreLoadEventJson paramJson =
            MusicContentCenterEventHandlerOnPreLoadEventJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        int? songCode = paramJson.songCode;
        int? percent = paramJson.percent;
        String? lyricUrl = paramJson.lyricUrl;
        PreloadStatusCode? status = paramJson.status;
        MusicContentCenterStatusCode? errorCode = paramJson.errorCode;
        if (songCode == null ||
            percent == null ||
            lyricUrl == null ||
            status == null ||
            errorCode == null) {
          return true;
        }
        musicContentCenterEventHandler.onPreLoadEvent!(
            songCode, percent, lyricUrl, status, errorCode);
        return true;
    }
    return false;
  }

  @override
  bool handleEvent(
      String eventName, String eventData, List<Uint8List> buffers) {
    if (!eventName.startsWith('MusicContentCenterEventHandler')) return false;
    final newEvent =
        eventName.replaceFirst('MusicContentCenterEventHandler_', '');
    if (handleEventInternal(newEvent, eventData, buffers)) {
      return true;
    }

    return false;
  }
}
