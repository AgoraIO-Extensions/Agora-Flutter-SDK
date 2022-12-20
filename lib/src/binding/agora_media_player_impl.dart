import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
// ignore_for_file: public_member_api_docs, unused_local_variable, annotate_overrides

class MediaPlayerImpl implements MediaPlayer {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'MediaPlayer';

  @override
  int getMediaPlayerId() {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_getMediaPlayerId';
// final param = createParams({// // });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as int;
    throw UnimplementedError('Unimplement for getMediaPlayerId');
  }

  @override
  Future<void> open({required String url, required int startPos}) async {
    final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_open';
    final param = createParams({'url': url, 'startPos': startPos});
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
  Future<void> openWithMediaSource(MediaSource source) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_openWithMediaSource';
    final param = createParams({'source': source.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(source.collectBufferList());
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
  Future<void> play() async {
    final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_play';
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
  Future<void> pause() async {
    final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_pause';
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
  Future<void> stop() async {
    final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_stop';
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
  Future<void> resume() async {
    final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_resume';
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
  Future<void> seek(int newPos) async {
    final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_seek';
    final param = createParams({'newPos': newPos});
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
  Future<void> setAudioPitch(int pitch) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setAudioPitch';
    final param = createParams({'pitch': pitch});
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
  Future<int> getDuration() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getDuration';
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
    final getDurationJson = MediaPlayerGetDurationJson.fromJson(rm);
    return getDurationJson.duration;
  }

  @override
  Future<int> getPlayPosition() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getPlayPosition';
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
    final getPlayPositionJson = MediaPlayerGetPlayPositionJson.fromJson(rm);
    return getPlayPositionJson.pos;
  }

  @override
  Future<int> getStreamCount() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getStreamCount';
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
    final getStreamCountJson = MediaPlayerGetStreamCountJson.fromJson(rm);
    return getStreamCountJson.count;
  }

  @override
  Future<PlayerStreamInfo> getStreamInfo(int index) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getStreamInfo';
    final param = createParams({'index': index});
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
    final getStreamInfoJson = MediaPlayerGetStreamInfoJson.fromJson(rm);
    return getStreamInfoJson.info;
  }

  @override
  Future<void> setLoopCount(int loopCount) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setLoopCount';
    final param = createParams({'loopCount': loopCount});
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
  Future<void> setPlaybackSpeed(int speed) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setPlaybackSpeed';
    final param = createParams({'speed': speed});
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
  Future<void> selectAudioTrack(int index) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_selectAudioTrack';
    final param = createParams({'index': index});
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
  Future<void> setPlayerOptionInInt(
      {required String key, required int value}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setPlayerOptionInInt';
    final param = createParams({'key': key, 'value': value});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> setPlayerOptionInString(
      {required String key, required String value}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setPlayerOptionInString';
    final param = createParams({'key': key, 'value': value});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> takeScreenshot(String filename) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_takeScreenshot';
    final param = createParams({'filename': filename});
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
  Future<void> selectInternalSubtitle(int index) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_selectInternalSubtitle';
    final param = createParams({'index': index});
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
  Future<void> setExternalSubtitle(String url) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setExternalSubtitle';
    final param = createParams({'url': url});
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
  Future<MediaPlayerState> getState() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getState';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return MediaPlayerStateExt.fromValue(result);
  }

  @override
  Future<void> mute(bool muted) async {
    final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_mute';
    final param = createParams({'muted': muted});
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
  Future<bool> getMute() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getMute';
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
    final getMuteJson = MediaPlayerGetMuteJson.fromJson(rm);
    return getMuteJson.muted;
  }

  @override
  Future<void> adjustPlayoutVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_adjustPlayoutVolume';
    final param = createParams({'volume': volume});
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
  Future<int> getPlayoutVolume() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getPlayoutVolume';
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
    final getPlayoutVolumeJson = MediaPlayerGetPlayoutVolumeJson.fromJson(rm);
    return getPlayoutVolumeJson.volume;
  }

  @override
  Future<void> adjustPublishSignalVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_adjustPublishSignalVolume';
    final param = createParams({'volume': volume});
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
  Future<int> getPublishSignalVolume() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getPublishSignalVolume';
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
    final getPublishSignalVolumeJson =
        MediaPlayerGetPublishSignalVolumeJson.fromJson(rm);
    return getPublishSignalVolumeJson.volume;
  }

  @override
  Future<void> setView(int view) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setView';
    final param = createParams({'view': view});
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
  Future<void> setRenderMode(RenderModeType renderMode) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setRenderMode';
    final param = createParams({'renderMode': renderMode.value()});
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
  void registerPlayerSourceObserver(MediaPlayerSourceObserver observer) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_registerPlayerSourceObserver';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError('Unimplement for registerPlayerSourceObserver');
  }

  @override
  void unregisterPlayerSourceObserver(MediaPlayerSourceObserver observer) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_unregisterPlayerSourceObserver';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError('Unimplement for unregisterPlayerSourceObserver');
  }

  @override
  void registerMediaPlayerAudioSpectrumObserver(
      {required AudioSpectrumObserver observer, required int intervalInMS}) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_registerMediaPlayerAudioSpectrumObserver';
// final param = createParams({// 'observer':observer, 'intervalInMS':intervalInMS// });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError(
        'Unimplement for registerMediaPlayerAudioSpectrumObserver');
  }

  @override
  void unregisterMediaPlayerAudioSpectrumObserver(
      AudioSpectrumObserver observer) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_unregisterMediaPlayerAudioSpectrumObserver';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError(
        'Unimplement for unregisterMediaPlayerAudioSpectrumObserver');
  }

  @override
  Future<void> setAudioDualMonoMode(AudioDualMonoMode mode) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setAudioDualMonoMode';
    final param = createParams({'mode': mode.value()});
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
  Future<String> getPlayerSdkVersion() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getPlayerSdkVersion';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as String;
  }

  @override
  Future<String> getPlaySrc() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getPlaySrc';
    final param = createParams({});
    final callApiResult =
        await apiCaller.callIrisApi(apiType, jsonEncode(param), buffers: null);
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as String;
  }

  @override
  Future<void> openWithAgoraCDNSrc(
      {required String src, required int startPos}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_openWithAgoraCDNSrc';
    final param = createParams({'src': src, 'startPos': startPos});
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
  Future<int> getAgoraCDNLineCount() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getAgoraCDNLineCount';
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
  Future<void> switchAgoraCDNLineByIndex(int index) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_switchAgoraCDNLineByIndex';
    final param = createParams({'index': index});
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
  Future<int> getCurrentAgoraCDNIndex() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_getCurrentAgoraCDNIndex';
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
  Future<void> enableAutoSwitchAgoraCDN(bool enable) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_enableAutoSwitchAgoraCDN';
    final param = createParams({'enable': enable});
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
  Future<void> renewAgoraCDNSrcToken(
      {required String token, required int ts}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_renewAgoraCDNSrcToken';
    final param = createParams({'token': token, 'ts': ts});
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
  Future<void> switchAgoraCDNSrc(
      {required String src, bool syncPts = false}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_switchAgoraCDNSrc';
    final param = createParams({'src': src, 'syncPts': syncPts});
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
  Future<void> switchSrc({required String src, bool syncPts = true}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_switchSrc';
    final param = createParams({'src': src, 'syncPts': syncPts});
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
  Future<void> preloadSrc({required String src, required int startPos}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_preloadSrc';
    final param = createParams({'src': src, 'startPos': startPos});
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
  Future<void> playPreloadedSrc(String src) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_playPreloadedSrc';
    final param = createParams({'src': src});
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
  Future<void> unloadSrc(String src) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_unloadSrc';
    final param = createParams({'src': src});
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
  Future<void> setSpatialAudioParams(SpatialAudioParams params) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setSpatialAudioParams';
    final param = createParams({'params': params.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(params.collectBufferList());
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
  Future<void> setSoundPositionParams(
      {required double pan, required double gain}) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayer'}_setSoundPositionParams';
    final param = createParams({'pan': pan, 'gain': gain});
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
  void registerAudioFrameObserver(MediaPlayerAudioFrameObserver observer) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_registerAudioFrameObserver';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
    throw UnimplementedError('Unimplement for registerAudioFrameObserver');
  }

  @override
  void unregisterAudioFrameObserver(MediaPlayerAudioFrameObserver observer) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_unregisterAudioFrameObserver';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
    throw UnimplementedError('Unimplement for unregisterAudioFrameObserver');
  }

  @override
  void registerVideoFrameObserver(MediaPlayerVideoFrameObserver observer) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_registerVideoFrameObserver';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
    throw UnimplementedError('Unimplement for registerVideoFrameObserver');
  }

  @override
  void unregisterVideoFrameObserver(MediaPlayerVideoFrameObserver observer) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'MediaPlayer'}_unregisterVideoFrameObserver';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  apiCaller.callIrisApi(apiType, jsonEncode(param), buffers:null);
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
    throw UnimplementedError('Unimplement for unregisterVideoFrameObserver');
  }
}

class MediaPlayerCacheManagerImpl implements MediaPlayerCacheManager {
  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'MediaPlayerCacheManager';

  @override
  Future<void> removeAllCaches() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_removeAllCaches';
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
  Future<void> removeOldCache() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_removeOldCache';
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
  Future<void> removeCacheByUri(String uri) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_removeCacheByUri';
    final param = createParams({'uri': uri});
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
  Future<void> setCacheDir(String path) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_setCacheDir';
    final param = createParams({'path': path});
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
  Future<void> setMaxCacheFileCount(int count) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_setMaxCacheFileCount';
    final param = createParams({'count': count});
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
  Future<void> setMaxCacheFileSize(int cacheSize) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_setMaxCacheFileSize';
    final param = createParams({'cacheSize': cacheSize});
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
  Future<void> enableAutoRemoveCache(bool enable) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_enableAutoRemoveCache';
    final param = createParams({'enable': enable});
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
  Future<String> getCacheDir(int length) async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_getCacheDir';
    final param = createParams({'length': length});
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
    final getCacheDirJson = MediaPlayerCacheManagerGetCacheDirJson.fromJson(rm);
    return getCacheDirJson.path;
  }

  @override
  Future<int> getMaxCacheFileCount() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_getMaxCacheFileCount';
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
  Future<int> getMaxCacheFileSize() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_getMaxCacheFileSize';
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
  Future<int> getCacheFileCount() async {
    final apiType =
        '${isOverrideClassName ? className : 'MediaPlayerCacheManager'}_getCacheFileCount';
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
}
