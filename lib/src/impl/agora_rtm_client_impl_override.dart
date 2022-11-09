import 'package:agora_rtc_engine/src/binding/agora_rtm_client_event_impl.dart';
import 'package:agora_rtc_engine/src/binding/agora_rtm_client_impl.dart'
    as rtmc_binding;
import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/impl/global_method_channel.dart';
import 'package:iris_method_channel/iris_method_channel.dart';
import 'package:agora_rtc_engine/src/impl/agora_stream_channel_impl_override.dart';

class _StreamChannelScopedKey implements ScopedKey {
  const _StreamChannelScopedKey(this.channelName);
  final String channelName;

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is _StreamChannelScopedKey && other.channelName == channelName;
  }

  @override
  int get hashCode => channelName.hashCode;
}

class RtmClientImpl extends rtmc_binding.RtmClientImpl {
  RtmClientImpl._(IrisMethodChannel irisMethodChannel)
      : super(irisMethodChannel);

  factory RtmClientImpl.create() {
    if (_instance != null) return _instance!;

    _instance = RtmClientImpl._(IrisMethodChannel());

    return _instance!;
  }

  static RtmClientImpl? _instance;

  final _rtmClientImplScopedKey = const TypedScopedKey(RtmClientImpl);

  final ScopedObjects _scopedObjects = ScopedObjects();

  final DisposableScopedObjects _streamChannelObjects =
      DisposableScopedObjects();

  @override
  Future<StreamChannel> createStreamChannel(String channelName) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtmClient'}_createStreamChannel';
    final param = createParams({'channelName': channelName});

    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));

    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }

    final streamChannel = _streamChannelObjects.putIfAbsent<StreamChannelImpl>(
      _StreamChannelScopedKey(channelName),
      () {
        StreamChannelImpl streamChannel =
            StreamChannelImpl(irisMethodChannel, channelName);
        return streamChannel;
      },
    );
    _scopedObjects.putIfAbsent(
      _rtmClientImplScopedKey,
      () {
        return _streamChannelObjects;
      },
    );

    return streamChannel;
  }

  @override
  Future<void> initialize(RtmConfig config) async {
    await irisMethodChannel.initilize();
    _scopedObjects.putIfAbsent(
      const TypedScopedKey(RtmClientImpl),
      () => _streamChannelObjects,
    );

    const apiType = 'RtmClient_initialize';
    RtmConfig configNew = config;
    if (configNew.logConfig != null) {
      LogConfig logConfigNew = configNew.logConfig!;
      if (logConfigNew.filePath == null) {
        final filePath = await GlobalMethodChannel.getIrisLogAbsolutePath();
        logConfigNew = LogConfig(
            filePath: filePath,
            fileSizeInKB: logConfigNew.fileSizeInKB,
            level: logConfigNew.level);

        configNew = RtmConfig(
          appId: configNew.appId,
          userId: configNew.userId,
          useStringUserId: configNew.useStringUserId,
          eventHandler: configNew.eventHandler,
          logConfig: logConfigNew,
        );
      }
    }
    final param = {'config': configNew.toJson()};

    if (configNew.eventHandler != null) {
      final eventHandlerWrapper =
          RtmEventHandlerWrapper(configNew.eventHandler!);
      final callApiResult = await irisMethodChannel.registerEventHandler(
          ScopedEvent(
              scopedKey: _rtmClientImplScopedKey,
              registerName: 'RtmClient_initialize',
              unregisterName: '',
              handler: eventHandlerWrapper),
          jsonEncode(param));

      if (callApiResult.irisReturnCode < 0) {
        throw AgoraRtcException(code: callApiResult.irisReturnCode);
      }
      final rm = callApiResult.data;

      final result = rm['result'];

      if (result < 0) {
        throw AgoraRtcException(code: result);
      }
    } else {
      final callApiResult = await irisMethodChannel
          .invokeMethod(IrisMethodCall(apiType, jsonEncode(param)));
      if (callApiResult.irisReturnCode < 0) {
        throw AgoraRtcException(code: callApiResult.irisReturnCode);
      }
      final rm = callApiResult.data;
      final result = rm['result'];

      if (result < 0) {
        throw AgoraRtcException(code: result);
      }
    }
  }

  @override
  Future<void> release() async {
    if (_instance == null) return;

    await _scopedObjects.clear();

    await irisMethodChannel.unregisterEventHandlers(_rtmClientImplScopedKey);
    try {
      await super.release();
    } catch (e) {
      debugPrint('RtmClient release error: ${e.toString()}');
    }

    await irisMethodChannel.dispose();
    _instance = null;
  }
}
