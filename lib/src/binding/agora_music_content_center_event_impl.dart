import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:agora_rtc_engine/src/impl/event_loop.dart';

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
        MusicContentCenterStatusCode? status = paramJson.status;
        List<MusicChartInfo>? result = paramJson.result;
        if (requestId == null || status == null || result == null) {
          return true;
        }
        result = result.map((e) => e.fillBuffers(buffers)).toList();
        musicContentCenterEventHandler.onMusicChartsResult!(
            requestId, status, result);
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
        MusicContentCenterStatusCode? status = paramJson.status;
        MusicCollection? result = paramJson.result;
        if (requestId == null || status == null || result == null) {
          return true;
        }
        musicContentCenterEventHandler.onMusicCollectionResult!(
            requestId, status, result);
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
        if (requestId == null || lyricUrl == null) {
          return true;
        }
        musicContentCenterEventHandler.onLyricResult!(requestId, lyricUrl);
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
        PreloadStatusCode? status = paramJson.status;
        String? msg = paramJson.msg;
        String? lyricUrl = paramJson.lyricUrl;
        if (songCode == null ||
            percent == null ||
            status == null ||
            msg == null ||
            lyricUrl == null) {
          return true;
        }
        musicContentCenterEventHandler.onPreLoadEvent!(
            songCode, percent, status, msg, lyricUrl);
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
