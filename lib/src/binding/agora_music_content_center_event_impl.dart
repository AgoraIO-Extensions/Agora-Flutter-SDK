import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_event/iris_event.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable

extension MusicContentCenterEventHandlerExt on MusicContentCenterEventHandler {
  void process(String event, String data, List<Uint8List> buffers) {
    final jsonMap = jsonDecode(data);
    switch (event) {
      case 'MusicContentCenterEventHandler_onMusicChartsResult':
        if (onMusicChartsResult == null) break;
        MusicContentCenterEventHandlerOnMusicChartsResultJson paramJson =
            MusicContentCenterEventHandlerOnMusicChartsResultJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? requestId = paramJson.requestId;
        MusicContentCenterStatusCode? status = paramJson.status;
        List<MusicChartInfo>? result = paramJson.result;
        if (requestId == null || status == null || result == null) {
          break;
        }
        result = result.map((e) => e.fillBuffers(buffers)).toList();
        onMusicChartsResult!(requestId, status, result);
        break;

      case 'MusicContentCenterEventHandler_onMusicCollectionResult':
        if (onMusicCollectionResult == null) break;
        MusicContentCenterEventHandlerOnMusicCollectionResultJson paramJson =
            MusicContentCenterEventHandlerOnMusicCollectionResultJson.fromJson(
                jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? requestId = paramJson.requestId;
        MusicContentCenterStatusCode? status = paramJson.status;
        MusicCollection? result = paramJson.result;
        if (requestId == null || status == null || result == null) {
          break;
        }
        onMusicCollectionResult!(requestId, status, result);
        break;

      case 'MusicContentCenterEventHandler_onLyricResult':
        if (onLyricResult == null) break;
        MusicContentCenterEventHandlerOnLyricResultJson paramJson =
            MusicContentCenterEventHandlerOnLyricResultJson.fromJson(jsonMap);
        paramJson = paramJson.fillBuffers(buffers);
        String? requestId = paramJson.requestId;
        String? lyricUrl = paramJson.lyricUrl;
        if (requestId == null || lyricUrl == null) {
          break;
        }
        onLyricResult!(requestId, lyricUrl);
        break;

      case 'MusicContentCenterEventHandler_onPreLoadEvent':
        if (onPreLoadEvent == null) break;
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
          break;
        }
        onPreLoadEvent!(songCode, percent, status, msg, lyricUrl);
        break;
      default:
        break;
    }
  }
}

class MusicContentCenterEventHandlerWrapper implements IrisEventHandler {
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
  void onEvent(String event, String data, List<Uint8List> buffers) {
    if (!event.startsWith('MusicContentCenterEventHandler')) return;
    musicContentCenterEventHandler.process(event, data, buffers);
  }
}
