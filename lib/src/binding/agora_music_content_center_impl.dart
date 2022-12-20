import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
// ignore_for_file: public_member_api_docs, unused_local_variable, annotate_overrides

class MusicChartCollectionImpl implements MusicChartCollection {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => '';

  @override
  Future<int> getCount() async {
    const apiType = '';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<MusicChartInfo> get(int index) async {
    const apiType = '';
    final param = createParams({'index': index});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as MusicChartInfo;
  }
}

class MusicCollectionImpl implements MusicCollection {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => '';

  @override
  int getCount() {
// Implementation template
// const apiType = '';
// final param = createParams({// // });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as int;
    throw UnimplementedError('Unimplement for getCount');
  }

  @override
  int getTotal() {
// Implementation template
// const apiType = '';
// final param = createParams({// // });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as int;
    throw UnimplementedError('Unimplement for getTotal');
  }

  @override
  int getPage() {
// Implementation template
// const apiType = '';
// final param = createParams({// // });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as int;
    throw UnimplementedError('Unimplement for getPage');
  }

  @override
  int getPageSize() {
// Implementation template
// const apiType = '';
// final param = createParams({// // });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as int;
    throw UnimplementedError('Unimplement for getPageSize');
  }

  @override
  Music getMusic(int index) {
// Implementation template
// const apiType = '';
// final param = createParams({// 'index':index// });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as Music;
    throw UnimplementedError('Unimplement for getMusic');
  }
}

class MusicPlayerImpl extends MediaPlayerImpl implements MusicPlayer {
  @override
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @override
  @protected
  bool get isOverrideClassName => false;

  @override
  @protected
  String get className => 'MusicPlayer';

  @override
  Future<void> openWithSongCode(
      {required int songCode, int startPos = 0}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicPlayer'}_openWithSongCode';
    final param = createParams({'songCode': songCode, 'startPos': startPos});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }
}

class MusicContentCenterImpl implements MusicContentCenter {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'MusicContentCenter';

  @override
  Future<void> initialize(MusicContentCenterConfiguration configuration) async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_initialize';
    final param = createParams({'configuration': configuration.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(configuration.collectBufferList());
    final callApiResult = await apiCaller
        .callIrisApi(apiType, jsonEncode(param), buffers: buffers);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> renewToken(String token) async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_renewToken';
    final param = createParams({'token': token});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<void> release() async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_release';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  void registerEventHandler(MusicContentCenterEventHandler eventHandler) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MusicContentCenter'}_registerEventHandler';
// final param = createParams({// 'eventHandler':eventHandler// });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError('Unimplement for registerEventHandler');
  }

  @override
  void unregisterEventHandler() {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MusicContentCenter'}_unregisterEventHandler';
// final param = createParams({// // });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError('Unimplement for unregisterEventHandler');
  }

  @override
  Future<MusicPlayer> createMusicPlayer() async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_createMusicPlayer';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as MusicPlayer;
  }

  @override
  Future<String> getMusicCharts() async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_getMusicCharts';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final getMusicChartsJson =
        MusicContentCenterGetMusicChartsJson.fromJson(rm);
    return getMusicChartsJson.requestId;
  }

  @override
  Future<String> getMusicCollectionByMusicChartId(
      {required int musicChartId,
      required int page,
      required int pageSize,
      String? jsonOption}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_getMusicCollectionByMusicChartId';
    final param = createParams({
      'musicChartId': musicChartId,
      'page': page,
      'pageSize': pageSize,
      'jsonOption': jsonOption
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final getMusicCollectionByMusicChartIdJson =
        MusicContentCenterGetMusicCollectionByMusicChartIdJson.fromJson(rm);
    return getMusicCollectionByMusicChartIdJson.requestId;
  }

  @override
  Future<String> searchMusic(
      {required String keyWord,
      required int page,
      required int pageSize,
      String? jsonOption}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_searchMusic';
    final param = createParams({
      'keyWord': keyWord,
      'page': page,
      'pageSize': pageSize,
      'jsonOption': jsonOption
    });
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final searchMusicJson = MusicContentCenterSearchMusicJson.fromJson(rm);
    return searchMusicJson.requestId;
  }

  @override
  Future<void> preload({required int songCode, String? jsonOption}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_preload';
    final param =
        createParams({'songCode': songCode, 'jsonOption': jsonOption});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
  }

  @override
  Future<bool> isPreloaded(int songCode) async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_isPreloaded';
    final param = createParams({'songCode': songCode});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as bool;
  }

  @override
  Future<String> getLyric({required int songCode, int lyricType = 0}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MusicContentCenter'}_getLyric';
    final param = createParams({'songCode': songCode, 'LyricType': lyricType});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final getLyricJson = MusicContentCenterGetLyricJson.fromJson(rm);
    return getLyricJson.requestId;
  }
}
