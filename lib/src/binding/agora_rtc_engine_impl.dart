import 'package:agora_rtc_engine/src/binding_forward_export.dart';
import 'package:agora_rtc_engine/src/binding/impl_forward_export.dart';
import 'package:iris_method_channel/iris_method_channel.dart';
// ignore_for_file: public_member_api_docs, unused_local_variable, annotate_overrides

class VideoDeviceManagerImpl implements VideoDeviceManager {
  VideoDeviceManagerImpl(this.irisMethodChannel);

  @protected
  final IrisMethodChannel irisMethodChannel;

  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'VideoDeviceManager';

  @override
  Future<List<VideoDeviceInfo>> enumerateVideoDevices() async {
    final apiType =
        '${isOverrideClassName ? className : 'VideoDeviceManager'}_enumerateVideoDevices';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as List<VideoDeviceInfo>;
  }

  @override
  Future<void> setDevice(String deviceIdUTF8) async {
    final apiType =
        '${isOverrideClassName ? className : 'VideoDeviceManager'}_setDevice';
    final param = createParams({'deviceIdUTF8': deviceIdUTF8});
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
  }

  @override
  Future<String> getDevice() async {
    final apiType =
        '${isOverrideClassName ? className : 'VideoDeviceManager'}_getDevice';
    final param = createParams({});
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
    final getDeviceJson = VideoDeviceManagerGetDeviceJson.fromJson(rm);
    return getDeviceJson.deviceIdUTF8;
  }

  @override
  Future<int> numberOfCapabilities(String deviceIdUTF8) async {
    final apiType =
        '${isOverrideClassName ? className : 'VideoDeviceManager'}_numberOfCapabilities';
    final param = createParams({'deviceIdUTF8': deviceIdUTF8});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<VideoFormat> getCapability(
      {required String deviceIdUTF8,
      required int deviceCapabilityNumber}) async {
    final apiType =
        '${isOverrideClassName ? className : 'VideoDeviceManager'}_getCapability';
    final param = createParams({
      'deviceIdUTF8': deviceIdUTF8,
      'deviceCapabilityNumber': deviceCapabilityNumber
    });
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
    final getCapabilityJson = VideoDeviceManagerGetCapabilityJson.fromJson(rm);
    return getCapabilityJson.capability;
  }

  @override
  Future<void> startDeviceTest(int hwnd) async {
    final apiType =
        '${isOverrideClassName ? className : 'VideoDeviceManager'}_startDeviceTest';
    final param = createParams({'hwnd': hwnd});
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
  }

  @override
  Future<void> stopDeviceTest() async {
    final apiType =
        '${isOverrideClassName ? className : 'VideoDeviceManager'}_stopDeviceTest';
    final param = createParams({});
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
  }

  @override
  Future<void> release() async {
    final apiType =
        '${isOverrideClassName ? className : 'VideoDeviceManager'}_release';
    final param = createParams({});
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
  }
}

class RtcEngineImpl implements RtcEngine {
  RtcEngineImpl(this.irisMethodChannel);

  @protected
  final IrisMethodChannel irisMethodChannel;

  @protected
  Map<String, dynamic> createParams(Map<String, dynamic> param) {
    return param;
  }

  @protected
  bool get isOverrideClassName => false;

  @protected
  String get className => 'RtcEngine';

  @override
  Future<void> release({bool sync = false}) async {
    final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_release';
    final param = createParams({'sync': sync});
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
  }

  @override
  Future<void> initialize(RtcEngineContext context) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_initialize';
    final param = createParams({'context': context.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(context.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<SDKBuildInfo> getVersion() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getVersion';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as SDKBuildInfo;
  }

  @override
  Future<String> getErrorDescription(int code) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getErrorDescription';
    final param = createParams({'code': code});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as String;
  }

  @override
  Future<void> joinChannel(
      {required String token,
      required String channelId,
      required int uid,
      required ChannelMediaOptions options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_joinChannel';
    final param = createParams({
      'token': token,
      'channelId': channelId,
      'uid': uid,
      'options': options.toJson()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> updateChannelMediaOptions(ChannelMediaOptions options) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_updateChannelMediaOptions';
    final param = createParams({'options': options.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> leaveChannel({LeaveChannelOptions? options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_leaveChannel';
    final param = createParams({'options': options?.toJson()});
    final List<Uint8List> buffers = [];
    if (options != null) {
      buffers.addAll(options.collectBufferList());
    }
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> renewToken(String token) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_renewToken';
    final param = createParams({'token': token});
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
  }

  @override
  Future<void> setChannelProfile(ChannelProfileType profile) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setChannelProfile';
    final param = createParams({'profile': profile.value()});
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
  }

  @override
  Future<void> setClientRole(
      {required ClientRoleType role, ClientRoleOptions? options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setClientRole';
    final param =
        createParams({'role': role.value(), 'options': options?.toJson()});
    final List<Uint8List> buffers = [];
    if (options != null) {
      buffers.addAll(options.collectBufferList());
    }
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> startEchoTest({int intervalInSeconds = 10}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startEchoTest';
    final param = createParams({'intervalInSeconds': intervalInSeconds});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> stopEchoTest() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopEchoTest';
    final param = createParams({});
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
  }

  @override
  Future<void> enableMultiCamera(
      {required bool enabled,
      required CameraCapturerConfiguration config}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableMultiCamera';
    final param = createParams({'enabled': enabled, 'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> enableVideo() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableVideo';
    final param = createParams({});
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
  }

  @override
  Future<void> disableVideo() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_disableVideo';
    final param = createParams({});
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
  }

  @override
  Future<void> startPreview(
      {VideoSourceType sourceType =
          VideoSourceType.videoSourceCameraPrimary}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startPreview';
    final param = createParams({'sourceType': sourceType.value()});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> stopPreview(
      {VideoSourceType sourceType =
          VideoSourceType.videoSourceCameraPrimary}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopPreview';
    final param = createParams({'sourceType': sourceType.value()});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> startLastmileProbeTest(LastmileProbeConfig config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startLastmileProbeTest';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopLastmileProbeTest() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopLastmileProbeTest';
    final param = createParams({});
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
  }

  @override
  Future<void> setVideoEncoderConfiguration(
      VideoEncoderConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setVideoEncoderConfiguration';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> setBeautyEffectOptions(
      {required bool enabled,
      required BeautyOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setBeautyEffectOptions';
    final param = createParams({
      'enabled': enabled,
      'options': options.toJson(),
      'type': type.value()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> setLowlightEnhanceOptions(
      {required bool enabled,
      required LowlightEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLowlightEnhanceOptions';
    final param = createParams({
      'enabled': enabled,
      'options': options.toJson(),
      'type': type.value()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> setVideoDenoiserOptions(
      {required bool enabled,
      required VideoDenoiserOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setVideoDenoiserOptions';
    final param = createParams({
      'enabled': enabled,
      'options': options.toJson(),
      'type': type.value()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> setColorEnhanceOptions(
      {required bool enabled,
      required ColorEnhanceOptions options,
      MediaSourceType type = MediaSourceType.primaryCameraSource}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setColorEnhanceOptions';
    final param = createParams({
      'enabled': enabled,
      'options': options.toJson(),
      'type': type.value()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> enableVirtualBackground(
      {required bool enabled,
      required VirtualBackgroundSource backgroundSource,
      required SegmentationProperty segproperty,
      MediaSourceType type = MediaSourceType.primaryCameraSource}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableVirtualBackground';
    final param = createParams({
      'enabled': enabled,
      'backgroundSource': backgroundSource.toJson(),
      'segproperty': segproperty.toJson(),
      'type': type.value()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(backgroundSource.collectBufferList());
    buffers.addAll(segproperty.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> enableRemoteSuperResolution(
      {required int userId, required bool enable}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableRemoteSuperResolution';
    final param = createParams({'userId': userId, 'enable': enable});
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
  }

  @override
  Future<void> setupRemoteVideo(VideoCanvas canvas) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setupRemoteVideo';
    final param = createParams({'canvas': canvas.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(canvas.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> setupLocalVideo(VideoCanvas canvas) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setupLocalVideo';
    final param = createParams({'canvas': canvas.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(canvas.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> enableAudio() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableAudio';
    final param = createParams({});
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
  }

  @override
  Future<void> disableAudio() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_disableAudio';
    final param = createParams({});
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
  }

  @override
  Future<void> setAudioProfile(
      {required AudioProfileType profile,
      AudioScenarioType scenario =
          AudioScenarioType.audioScenarioDefault}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setAudioProfile';
    final param = createParams(
        {'profile': profile.value(), 'scenario': scenario.value()});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> setAudioScenario(AudioScenarioType scenario) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setAudioScenario';
    final param = createParams({'scenario': scenario.value()});
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
  }

  @override
  Future<void> enableLocalAudio(bool enabled) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableLocalAudio';
    final param = createParams({'enabled': enabled});
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
  }

  @override
  Future<void> muteLocalAudioStream(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_muteLocalAudioStream';
    final param = createParams({'mute': mute});
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
  }

  @override
  Future<void> muteAllRemoteAudioStreams(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_muteAllRemoteAudioStreams';
    final param = createParams({'mute': mute});
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
  }

  @override
  Future<void> setDefaultMuteAllRemoteAudioStreams(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setDefaultMuteAllRemoteAudioStreams';
    final param = createParams({'mute': mute});
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
  }

  @override
  Future<void> muteRemoteAudioStream(
      {required int uid, required bool mute}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_muteRemoteAudioStream';
    final param = createParams({'uid': uid, 'mute': mute});
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
  }

  @override
  Future<void> muteLocalVideoStream(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_muteLocalVideoStream';
    final param = createParams({'mute': mute});
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
  }

  @override
  Future<void> enableLocalVideo(bool enabled) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableLocalVideo';
    final param = createParams({'enabled': enabled});
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
  }

  @override
  Future<void> muteAllRemoteVideoStreams(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_muteAllRemoteVideoStreams';
    final param = createParams({'mute': mute});
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
  }

  @override
  Future<void> setDefaultMuteAllRemoteVideoStreams(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setDefaultMuteAllRemoteVideoStreams';
    final param = createParams({'mute': mute});
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
  }

  @override
  Future<void> muteRemoteVideoStream(
      {required int uid, required bool mute}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_muteRemoteVideoStream';
    final param = createParams({'uid': uid, 'mute': mute});
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
  }

  @override
  Future<void> setRemoteVideoStreamType(
      {required int uid, required VideoStreamType streamType}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setRemoteVideoStreamType';
    final param = createParams({'uid': uid, 'streamType': streamType.value()});
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
  }

  @override
  Future<void> setRemoteVideoSubscriptionOptions(
      {required int uid, required VideoSubscriptionOptions options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setRemoteVideoSubscriptionOptions';
    final param = createParams({'uid': uid, 'options': options.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> setRemoteDefaultVideoStreamType(
      VideoStreamType streamType) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setRemoteDefaultVideoStreamType';
    final param = createParams({'streamType': streamType.value()});
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
  }

  @override
  Future<void> setSubscribeAudioBlocklist(
      {required List<int> uidList, required int uidNumber}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setSubscribeAudioBlocklist';
    final param = createParams({'uidList': uidList, 'uidNumber': uidNumber});
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
  }

  @override
  Future<void> setSubscribeAudioAllowlist(
      {required List<int> uidList, required int uidNumber}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setSubscribeAudioAllowlist';
    final param = createParams({'uidList': uidList, 'uidNumber': uidNumber});
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
  }

  @override
  Future<void> setSubscribeVideoBlocklist(
      {required List<int> uidList, required int uidNumber}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setSubscribeVideoBlocklist';
    final param = createParams({'uidList': uidList, 'uidNumber': uidNumber});
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
  }

  @override
  Future<void> setSubscribeVideoAllowlist(
      {required List<int> uidList, required int uidNumber}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setSubscribeVideoAllowlist';
    final param = createParams({'uidList': uidList, 'uidNumber': uidNumber});
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
  }

  @override
  Future<void> enableAudioVolumeIndication(
      {required int interval,
      required int smooth,
      required bool reportVad}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableAudioVolumeIndication';
    final param = createParams(
        {'interval': interval, 'smooth': smooth, 'reportVad': reportVad});
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
  }

  @override
  Future<void> startAudioRecording(AudioRecordingConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startAudioRecording';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  void registerAudioEncodedFrameObserver(
      {required AudioEncodedFrameObserverConfig config,
      required AudioEncodedFrameObserver observer}) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_registerAudioEncodedFrameObserver';
// final param = createParams({// 'config':config.toJson(), 'observer':observer// });
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:buffers));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError(
        'Unimplement for registerAudioEncodedFrameObserver');
  }

  @override
  Future<void> stopAudioRecording() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopAudioRecording';
    final param = createParams({});
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
  }

  @override
  Future<MediaPlayer> createMediaPlayer() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_createMediaPlayer';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as MediaPlayer;
  }

  @override
  Future<void> destroyMediaPlayer(MediaPlayer mediaPlayer) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_destroyMediaPlayer';
    final param = createParams({'media_player': mediaPlayer});
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
  }

  @override
  Future<void> startAudioMixing(
      {required String filePath,
      required bool loopback,
      required int cycle,
      int startPos = 0}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startAudioMixing';
    final param = createParams({
      'filePath': filePath,
      'loopback': loopback,
      'cycle': cycle,
      'startPos': startPos
    });
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> stopAudioMixing() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopAudioMixing';
    final param = createParams({});
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
  }

  @override
  Future<void> pauseAudioMixing() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_pauseAudioMixing';
    final param = createParams({});
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
  }

  @override
  Future<void> resumeAudioMixing() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_resumeAudioMixing';
    final param = createParams({});
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
  }

  @override
  Future<void> selectAudioTrack(int index) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_selectAudioTrack';
    final param = createParams({'index': index});
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
  }

  @override
  Future<int> getAudioTrackCount() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getAudioTrackCount';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> adjustAudioMixingVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_adjustAudioMixingVolume';
    final param = createParams({'volume': volume});
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
  }

  @override
  Future<void> adjustAudioMixingPublishVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_adjustAudioMixingPublishVolume';
    final param = createParams({'volume': volume});
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
  }

  @override
  Future<int> getAudioMixingPublishVolume() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getAudioMixingPublishVolume';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> adjustAudioMixingPlayoutVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_adjustAudioMixingPlayoutVolume';
    final param = createParams({'volume': volume});
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
  }

  @override
  Future<int> getAudioMixingPlayoutVolume() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getAudioMixingPlayoutVolume';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<int> getAudioMixingDuration() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getAudioMixingDuration';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<int> getAudioMixingCurrentPosition() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getAudioMixingCurrentPosition';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> setAudioMixingPosition(int pos) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setAudioMixingPosition';
    final param = createParams({'pos': pos});
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
  }

  @override
  Future<void> setAudioMixingDualMonoMode(AudioMixingDualMonoMode mode) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setAudioMixingDualMonoMode';
    final param = createParams({'mode': mode.value()});
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
  }

  @override
  Future<void> setAudioMixingPitch(int pitch) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setAudioMixingPitch';
    final param = createParams({'pitch': pitch});
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
  }

  @override
  Future<int> getEffectsVolume() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getEffectsVolume';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> setEffectsVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setEffectsVolume';
    final param = createParams({'volume': volume});
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
  }

  @override
  Future<void> preloadEffect(
      {required int soundId,
      required String filePath,
      int startPos = 0}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_preloadEffect';
    final param = createParams(
        {'soundId': soundId, 'filePath': filePath, 'startPos': startPos});
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
  }

  @override
  Future<void> playEffect(
      {required int soundId,
      required String filePath,
      required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false,
      int startPos = 0}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_playEffect';
    final param = createParams({
      'soundId': soundId,
      'filePath': filePath,
      'loopCount': loopCount,
      'pitch': pitch,
      'pan': pan,
      'gain': gain,
      'publish': publish,
      'startPos': startPos
    });
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
  }

  @override
  Future<void> playAllEffects(
      {required int loopCount,
      required double pitch,
      required double pan,
      required int gain,
      bool publish = false}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_playAllEffects';
    final param = createParams({
      'loopCount': loopCount,
      'pitch': pitch,
      'pan': pan,
      'gain': gain,
      'publish': publish
    });
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
  }

  @override
  Future<int> getVolumeOfEffect(int soundId) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getVolumeOfEffect';
    final param = createParams({'soundId': soundId});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> setVolumeOfEffect(
      {required int soundId, required int volume}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setVolumeOfEffect';
    final param = createParams({'soundId': soundId, 'volume': volume});
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
  }

  @override
  Future<void> pauseEffect(int soundId) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_pauseEffect';
    final param = createParams({'soundId': soundId});
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
  }

  @override
  Future<void> pauseAllEffects() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_pauseAllEffects';
    final param = createParams({});
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
  }

  @override
  Future<void> resumeEffect(int soundId) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_resumeEffect';
    final param = createParams({'soundId': soundId});
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
  }

  @override
  Future<void> resumeAllEffects() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_resumeAllEffects';
    final param = createParams({});
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
  }

  @override
  Future<void> stopEffect(int soundId) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopEffect';
    final param = createParams({'soundId': soundId});
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
  }

  @override
  Future<void> stopAllEffects() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopAllEffects';
    final param = createParams({});
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
  }

  @override
  Future<void> unloadEffect(int soundId) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_unloadEffect';
    final param = createParams({'soundId': soundId});
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
  }

  @override
  Future<void> unloadAllEffects() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_unloadAllEffects';
    final param = createParams({});
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
  }

  @override
  Future<int> getEffectDuration(String filePath) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getEffectDuration';
    final param = createParams({'filePath': filePath});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> setEffectPosition(
      {required int soundId, required int pos}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setEffectPosition';
    final param = createParams({'soundId': soundId, 'pos': pos});
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
  }

  @override
  Future<int> getEffectCurrentPosition(int soundId) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getEffectCurrentPosition';
    final param = createParams({'soundId': soundId});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> enableSoundPositionIndication(bool enabled) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableSoundPositionIndication';
    final param = createParams({'enabled': enabled});
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
  }

  @override
  Future<void> setRemoteVoicePosition(
      {required int uid, required double pan, required double gain}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setRemoteVoicePosition';
    final param = createParams({'uid': uid, 'pan': pan, 'gain': gain});
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
  }

  @override
  Future<void> enableSpatialAudio(bool enabled) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableSpatialAudio';
    final param = createParams({'enabled': enabled});
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
  }

  @override
  Future<void> setRemoteUserSpatialAudioParams(
      {required int uid, required SpatialAudioParams params}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setRemoteUserSpatialAudioParams';
    final param = createParams({'uid': uid, 'params': params.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(params.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> setVoiceBeautifierPreset(VoiceBeautifierPreset preset) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setVoiceBeautifierPreset';
    final param = createParams({'preset': preset.value()});
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
  }

  @override
  Future<void> setAudioEffectPreset(AudioEffectPreset preset) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setAudioEffectPreset';
    final param = createParams({'preset': preset.value()});
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
  }

  @override
  Future<void> setVoiceConversionPreset(VoiceConversionPreset preset) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setVoiceConversionPreset';
    final param = createParams({'preset': preset.value()});
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
  }

  @override
  Future<void> setAudioEffectParameters(
      {required AudioEffectPreset preset,
      required int param1,
      required int param2}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setAudioEffectParameters';
    final param = createParams(
        {'preset': preset.value(), 'param1': param1, 'param2': param2});
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
  }

  @override
  Future<void> setVoiceBeautifierParameters(
      {required VoiceBeautifierPreset preset,
      required int param1,
      required int param2}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setVoiceBeautifierParameters';
    final param = createParams(
        {'preset': preset.value(), 'param1': param1, 'param2': param2});
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
  }

  @override
  Future<void> setVoiceConversionParameters(
      {required VoiceConversionPreset preset,
      required int param1,
      required int param2}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setVoiceConversionParameters';
    final param = createParams(
        {'preset': preset.value(), 'param1': param1, 'param2': param2});
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
  }

  @override
  Future<void> setLocalVoicePitch(double pitch) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLocalVoicePitch';
    final param = createParams({'pitch': pitch});
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
  }

  @override
  Future<void> setLocalVoiceEqualization(
      {required AudioEqualizationBandFrequency bandFrequency,
      required int bandGain}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLocalVoiceEqualization';
    final param = createParams(
        {'bandFrequency': bandFrequency.value(), 'bandGain': bandGain});
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
  }

  @override
  Future<void> setLocalVoiceReverb(
      {required AudioReverbType reverbKey, required int value}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLocalVoiceReverb';
    final param =
        createParams({'reverbKey': reverbKey.value(), 'value': value});
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
  }

  @override
  Future<void> setHeadphoneEQPreset(HeadphoneEqualizerPreset preset) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setHeadphoneEQPreset';
    final param = createParams({'preset': preset.value()});
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
  }

  @override
  Future<void> setHeadphoneEQParameters(
      {required int lowGain, required int highGain}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setHeadphoneEQParameters';
    final param = createParams({'lowGain': lowGain, 'highGain': highGain});
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
  }

  @override
  Future<void> setLogFile(String filePath) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLogFile';
    final param = createParams({'filePath': filePath});
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
  }

  @override
  Future<void> setLogFilter(LogFilterType filter) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLogFilter';
    final param = createParams({'filter': filter.value()});
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
  }

  @override
  Future<void> setLogLevel(LogLevel level) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLogLevel';
    final param = createParams({'level': level.value()});
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
  }

  @override
  Future<void> setLogFileSize(int fileSizeInKBytes) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLogFileSize';
    final param = createParams({'fileSizeInKBytes': fileSizeInKBytes});
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
  }

  @override
  Future<void> uploadLogFile(String requestId) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_uploadLogFile';
    final param = createParams({'requestId': requestId});
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
  }

  @override
  Future<void> setLocalRenderMode(
      {required RenderModeType renderMode,
      VideoMirrorModeType mirrorMode =
          VideoMirrorModeType.videoMirrorModeAuto}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLocalRenderMode';
    final param = createParams(
        {'renderMode': renderMode.value(), 'mirrorMode': mirrorMode.value()});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> setRemoteRenderMode(
      {required int uid,
      required RenderModeType renderMode,
      required VideoMirrorModeType mirrorMode}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setRemoteRenderMode';
    final param = createParams({
      'uid': uid,
      'renderMode': renderMode.value(),
      'mirrorMode': mirrorMode.value()
    });
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
  }

  @override
  Future<void> setLocalVideoMirrorMode(VideoMirrorModeType mirrorMode) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLocalVideoMirrorMode';
    final param = createParams({'mirrorMode': mirrorMode.value()});
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
  }

  @override
  Future<void> enableDualStreamMode(
      {required bool enabled, SimulcastStreamConfig? streamConfig}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableDualStreamMode';
    final param = createParams(
        {'enabled': enabled, 'streamConfig': streamConfig?.toJson()});
    final List<Uint8List> buffers = [];
    if (streamConfig != null) {
      buffers.addAll(streamConfig.collectBufferList());
    }
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> setDualStreamMode(
      {required SimulcastStreamMode mode,
      SimulcastStreamConfig? streamConfig}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setDualStreamMode';
    final param = createParams(
        {'mode': mode.value(), 'streamConfig': streamConfig?.toJson()});
    final List<Uint8List> buffers = [];
    if (streamConfig != null) {
      buffers.addAll(streamConfig.collectBufferList());
    }
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> enableEchoCancellationExternal(
      {required bool enabled, required int audioSourceDelay}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableEchoCancellationExternal';
    final param = createParams(
        {'enabled': enabled, 'audioSourceDelay': audioSourceDelay});
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
  }

  @override
  Future<void> enableCustomAudioLocalPlayback(
      {required int sourceId, required bool enabled}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableCustomAudioLocalPlayback';
    final param = createParams({'sourceId': sourceId, 'enabled': enabled});
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
  }

  @override
  Future<void> startPrimaryCustomAudioTrack(AudioTrackConfig config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startPrimaryCustomAudioTrack';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopPrimaryCustomAudioTrack() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopPrimaryCustomAudioTrack';
    final param = createParams({});
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
  }

  @override
  Future<void> startSecondaryCustomAudioTrack(AudioTrackConfig config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startSecondaryCustomAudioTrack';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopSecondaryCustomAudioTrack() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopSecondaryCustomAudioTrack';
    final param = createParams({});
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
  }

  @override
  Future<void> setRecordingAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setRecordingAudioFrameParameters';
    final param = createParams({
      'sampleRate': sampleRate,
      'channel': channel,
      'mode': mode.value(),
      'samplesPerCall': samplesPerCall
    });
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
  }

  @override
  Future<void> setPlaybackAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setPlaybackAudioFrameParameters';
    final param = createParams({
      'sampleRate': sampleRate,
      'channel': channel,
      'mode': mode.value(),
      'samplesPerCall': samplesPerCall
    });
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
  }

  @override
  Future<void> setMixedAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required int samplesPerCall}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setMixedAudioFrameParameters';
    final param = createParams({
      'sampleRate': sampleRate,
      'channel': channel,
      'samplesPerCall': samplesPerCall
    });
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
  }

  @override
  Future<void> setEarMonitoringAudioFrameParameters(
      {required int sampleRate,
      required int channel,
      required RawAudioFrameOpModeType mode,
      required int samplesPerCall}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setEarMonitoringAudioFrameParameters';
    final param = createParams({
      'sampleRate': sampleRate,
      'channel': channel,
      'mode': mode.value(),
      'samplesPerCall': samplesPerCall
    });
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
  }

  @override
  Future<void> setPlaybackAudioFrameBeforeMixingParameters(
      {required int sampleRate, required int channel}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setPlaybackAudioFrameBeforeMixingParameters';
    final param = createParams({'sampleRate': sampleRate, 'channel': channel});
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
  }

  @override
  Future<void> enableAudioSpectrumMonitor({int intervalInMS = 100}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableAudioSpectrumMonitor';
    final param = createParams({'intervalInMS': intervalInMS});
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
  }

  @override
  Future<void> disableAudioSpectrumMonitor() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_disableAudioSpectrumMonitor';
    final param = createParams({});
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
  }

  @override
  void registerAudioSpectrumObserver(AudioSpectrumObserver observer) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_registerAudioSpectrumObserver';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError('Unimplement for registerAudioSpectrumObserver');
  }

  @override
  void unregisterAudioSpectrumObserver(AudioSpectrumObserver observer) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_unregisterAudioSpectrumObserver';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError('Unimplement for unregisterAudioSpectrumObserver');
  }

  @override
  Future<void> adjustRecordingSignalVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_adjustRecordingSignalVolume';
    final param = createParams({'volume': volume});
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
  }

  @override
  Future<void> muteRecordingSignal(bool mute) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_muteRecordingSignal';
    final param = createParams({'mute': mute});
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
  }

  @override
  Future<void> adjustPlaybackSignalVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_adjustPlaybackSignalVolume';
    final param = createParams({'volume': volume});
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
  }

  @override
  Future<void> adjustUserPlaybackSignalVolume(
      {required int uid, required int volume}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_adjustUserPlaybackSignalVolume';
    final param = createParams({'uid': uid, 'volume': volume});
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
  }

  @override
  Future<void> setLocalPublishFallbackOption(
      StreamFallbackOptions option) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLocalPublishFallbackOption';
    final param = createParams({'option': option.value()});
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
  }

  @override
  Future<void> setRemoteSubscribeFallbackOption(
      StreamFallbackOptions option) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setRemoteSubscribeFallbackOption';
    final param = createParams({'option': option.value()});
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
  }

  @override
  Future<void> enableLoopbackRecording(
      {required bool enabled, String? deviceName}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableLoopbackRecording';
    final param = createParams({'enabled': enabled, 'deviceName': deviceName});
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
  }

  @override
  Future<void> adjustLoopbackSignalVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_adjustLoopbackSignalVolume';
    final param = createParams({'volume': volume});
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
  }

  @override
  Future<int> getLoopbackRecordingVolume() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getLoopbackRecordingVolume';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> enableInEarMonitoring(
      {required bool enabled,
      required EarMonitoringFilterType includeAudioFilters}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableInEarMonitoring';
    final param = createParams({
      'enabled': enabled,
      'includeAudioFilters': includeAudioFilters.value()
    });
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
  }

  @override
  Future<void> setInEarMonitoringVolume(int volume) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setInEarMonitoringVolume';
    final param = createParams({'volume': volume});
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
  }

  @override
  Future<void> loadExtensionProvider(
      {required String path, bool unloadAfterUse = false}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_loadExtensionProvider';
    final param =
        createParams({'path': path, 'unload_after_use': unloadAfterUse});
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
  }

  @override
  Future<void> setExtensionProviderProperty(
      {required String provider,
      required String key,
      required String value}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setExtensionProviderProperty';
    final param =
        createParams({'provider': provider, 'key': key, 'value': value});
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
  }

  @override
  Future<void> registerExtension(
      {required String provider,
      required String extension,
      MediaSourceType type = MediaSourceType.unknownMediaSource}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_registerExtension';
    final param = createParams(
        {'provider': provider, 'extension': extension, 'type': type.value()});
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
  }

  @override
  Future<void> enableExtension(
      {required String provider,
      required String extension,
      bool enable = true,
      MediaSourceType type = MediaSourceType.unknownMediaSource}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableExtension';
    final param = createParams({
      'provider': provider,
      'extension': extension,
      'enable': enable,
      'type': type.value()
    });
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> setExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required String value,
      MediaSourceType type = MediaSourceType.unknownMediaSource}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setExtensionProperty';
    final param = createParams({
      'provider': provider,
      'extension': extension,
      'key': key,
      'value': value,
      'type': type.value()
    });
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<String> getExtensionProperty(
      {required String provider,
      required String extension,
      required String key,
      required int bufLen,
      MediaSourceType type = MediaSourceType.unknownMediaSource}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getExtensionProperty';
    final param = createParams({
      'provider': provider,
      'extension': extension,
      'key': key,
      'buf_len': bufLen,
      'type': type.value()
    });
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
    final getExtensionPropertyJson =
        RtcEngineGetExtensionPropertyJson.fromJson(rm);
    return getExtensionPropertyJson.value;
  }

  @override
  Future<void> setCameraCapturerConfiguration(
      CameraCapturerConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setCameraCapturerConfiguration';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<int> createCustomVideoTrack() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_createCustomVideoTrack';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<int> createCustomEncodedVideoTrack(SenderOptions senderOption) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_createCustomEncodedVideoTrack';
    final param = createParams({'sender_option': senderOption.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(senderOption.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> destroyCustomVideoTrack(int videoTrackId) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_destroyCustomVideoTrack';
    final param = createParams({'video_track_id': videoTrackId});
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
  }

  @override
  Future<void> destroyCustomEncodedVideoTrack(int videoTrackId) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_destroyCustomEncodedVideoTrack';
    final param = createParams({'video_track_id': videoTrackId});
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
  }

  @override
  Future<void> switchCamera() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_switchCamera';
    final param = createParams({});
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
  }

  @override
  Future<bool> isCameraZoomSupported() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_isCameraZoomSupported';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as bool;
  }

  @override
  Future<bool> isCameraFaceDetectSupported() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_isCameraFaceDetectSupported';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as bool;
  }

  @override
  Future<bool> isCameraTorchSupported() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_isCameraTorchSupported';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as bool;
  }

  @override
  Future<bool> isCameraFocusSupported() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_isCameraFocusSupported';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as bool;
  }

  @override
  Future<bool> isCameraAutoFocusFaceModeSupported() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_isCameraAutoFocusFaceModeSupported';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as bool;
  }

  @override
  Future<void> setCameraZoomFactor(double factor) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setCameraZoomFactor';
    final param = createParams({'factor': factor});
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
  }

  @override
  Future<void> enableFaceDetection(bool enabled) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableFaceDetection';
    final param = createParams({'enabled': enabled});
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
  }

  @override
  Future<double> getCameraMaxZoomFactor() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getCameraMaxZoomFactor';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as double;
  }

  @override
  Future<void> setCameraFocusPositionInPreview(
      {required double positionX, required double positionY}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setCameraFocusPositionInPreview';
    final param =
        createParams({'positionX': positionX, 'positionY': positionY});
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
  }

  @override
  Future<void> setCameraTorchOn(bool isOn) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setCameraTorchOn';
    final param = createParams({'isOn': isOn});
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
  }

  @override
  Future<void> setCameraAutoFocusFaceModeEnabled(bool enabled) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setCameraAutoFocusFaceModeEnabled';
    final param = createParams({'enabled': enabled});
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
  }

  @override
  Future<bool> isCameraExposurePositionSupported() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_isCameraExposurePositionSupported';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as bool;
  }

  @override
  Future<void> setCameraExposurePosition(
      {required double positionXinView,
      required double positionYinView}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setCameraExposurePosition';
    final param = createParams({
      'positionXinView': positionXinView,
      'positionYinView': positionYinView
    });
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
  }

  @override
  Future<bool> isCameraAutoExposureFaceModeSupported() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_isCameraAutoExposureFaceModeSupported';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as bool;
  }

  @override
  Future<void> setCameraAutoExposureFaceModeEnabled(bool enabled) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setCameraAutoExposureFaceModeEnabled';
    final param = createParams({'enabled': enabled});
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
  }

  @override
  Future<void> setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setDefaultAudioRouteToSpeakerphone';
    final param = createParams({'defaultToSpeaker': defaultToSpeaker});
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
  }

  @override
  Future<void> setEnableSpeakerphone(bool speakerOn) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setEnableSpeakerphone';
    final param = createParams({'speakerOn': speakerOn});
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
  }

  @override
  Future<bool> isSpeakerphoneEnabled() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_isSpeakerphoneEnabled';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as bool;
  }

  @override
  Future<List<ScreenCaptureSourceInfo>> getScreenCaptureSources(
      {required SIZE thumbSize,
      required SIZE iconSize,
      required bool includeScreen}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getScreenCaptureSources';
    final param = createParams({
      'thumbSize': thumbSize.toJson(),
      'iconSize': iconSize.toJson(),
      'includeScreen': includeScreen
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(thumbSize.collectBufferList());
    buffers.addAll(iconSize.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as List<ScreenCaptureSourceInfo>;
  }

  @override
  Future<void> setAudioSessionOperationRestriction(
      AudioSessionOperationRestriction restriction) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setAudioSessionOperationRestriction';
    final param = createParams({'restriction': restriction.value()});
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
  }

  @override
  Future<void> startScreenCaptureByDisplayId(
      {required int displayId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startScreenCaptureByDisplayId';
    final param = createParams({
      'displayId': displayId,
      'regionRect': regionRect.toJson(),
      'captureParams': captureParams.toJson()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(regionRect.collectBufferList());
    buffers.addAll(captureParams.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> startScreenCaptureByScreenRect(
      {required Rectangle screenRect,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startScreenCaptureByScreenRect';
    final param = createParams({
      'screenRect': screenRect.toJson(),
      'regionRect': regionRect.toJson(),
      'captureParams': captureParams.toJson()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(screenRect.collectBufferList());
    buffers.addAll(regionRect.collectBufferList());
    buffers.addAll(captureParams.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<DeviceInfo> getAudioDeviceInfo() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getAudioDeviceInfo';
    final param = createParams({});
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
    final getAudioDeviceInfoJson = RtcEngineGetAudioDeviceInfoJson.fromJson(rm);
    return getAudioDeviceInfoJson.deviceInfo;
  }

  @override
  Future<void> startScreenCaptureByWindowId(
      {required int windowId,
      required Rectangle regionRect,
      required ScreenCaptureParameters captureParams}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startScreenCaptureByWindowId';
    final param = createParams({
      'windowId': windowId,
      'regionRect': regionRect.toJson(),
      'captureParams': captureParams.toJson()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(regionRect.collectBufferList());
    buffers.addAll(captureParams.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> setScreenCaptureContentHint(VideoContentHint contentHint) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setScreenCaptureContentHint';
    final param = createParams({'contentHint': contentHint.value()});
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
  }

  @override
  Future<void> setScreenCaptureScenario(
      ScreenScenarioType screenScenario) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setScreenCaptureScenario';
    final param = createParams({'screenScenario': screenScenario.value()});
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
  }

  @override
  Future<void> updateScreenCaptureRegion(Rectangle regionRect) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_updateScreenCaptureRegion';
    final param = createParams({'regionRect': regionRect.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(regionRect.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> updateScreenCaptureParameters(
      ScreenCaptureParameters captureParams) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_updateScreenCaptureParameters';
    final param = createParams({'captureParams': captureParams.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(captureParams.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> startScreenCapture(
      ScreenCaptureParameters2 captureParams) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startScreenCapture';
    final param = createParams({'captureParams': captureParams.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(captureParams.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> updateScreenCapture(
      ScreenCaptureParameters2 captureParams) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_updateScreenCapture';
    final param = createParams({'captureParams': captureParams.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(captureParams.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopScreenCapture() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopScreenCapture';
    final param = createParams({});
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
  }

  @override
  Future<String> getCallId() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getCallId';
    final param = createParams({});
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
    final getCallIdJson = RtcEngineGetCallIdJson.fromJson(rm);
    return getCallIdJson.callId;
  }

  @override
  Future<void> rate(
      {required String callId,
      required int rating,
      required String description}) async {
    final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_rate';
    final param = createParams(
        {'callId': callId, 'rating': rating, 'description': description});
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
  }

  @override
  Future<void> complain(
      {required String callId, required String description}) async {
    final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_complain';
    final param = createParams({'callId': callId, 'description': description});
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
  }

  @override
  Future<void> startRtmpStreamWithoutTranscoding(String url) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startRtmpStreamWithoutTranscoding';
    final param = createParams({'url': url});
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
  }

  @override
  Future<void> startRtmpStreamWithTranscoding(
      {required String url, required LiveTranscoding transcoding}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startRtmpStreamWithTranscoding';
    final param =
        createParams({'url': url, 'transcoding': transcoding.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(transcoding.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> updateRtmpTranscoding(LiveTranscoding transcoding) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_updateRtmpTranscoding';
    final param = createParams({'transcoding': transcoding.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(transcoding.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopRtmpStream(String url) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopRtmpStream';
    final param = createParams({'url': url});
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
  }

  @override
  Future<void> startLocalVideoTranscoder(
      LocalTranscoderConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startLocalVideoTranscoder';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> updateLocalTranscoderConfiguration(
      LocalTranscoderConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_updateLocalTranscoderConfiguration';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopLocalVideoTranscoder() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopLocalVideoTranscoder';
    final param = createParams({});
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
  }

  @override
  Future<void> startPrimaryCameraCapture(
      CameraCapturerConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startPrimaryCameraCapture';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> startSecondaryCameraCapture(
      CameraCapturerConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startSecondaryCameraCapture';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopPrimaryCameraCapture() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopPrimaryCameraCapture';
    final param = createParams({});
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
  }

  @override
  Future<void> stopSecondaryCameraCapture() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopSecondaryCameraCapture';
    final param = createParams({});
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
  }

  @override
  Future<void> setCameraDeviceOrientation(
      {required VideoSourceType type,
      required VideoOrientation orientation}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setCameraDeviceOrientation';
    final param = createParams(
        {'type': type.value(), 'orientation': orientation.value()});
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
  }

  @override
  Future<void> setScreenCaptureOrientation(
      {required VideoSourceType type,
      required VideoOrientation orientation}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setScreenCaptureOrientation';
    final param = createParams(
        {'type': type.value(), 'orientation': orientation.value()});
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
  }

  @override
  Future<void> startPrimaryScreenCapture(
      ScreenCaptureConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startPrimaryScreenCapture';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> startSecondaryScreenCapture(
      ScreenCaptureConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startSecondaryScreenCapture';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopPrimaryScreenCapture() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopPrimaryScreenCapture';
    final param = createParams({});
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
  }

  @override
  Future<void> stopSecondaryScreenCapture() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopSecondaryScreenCapture';
    final param = createParams({});
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
  }

  @override
  Future<ConnectionStateType> getConnectionState() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getConnectionState';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return ConnectionStateTypeExt.fromValue(result);
  }

  @override
  void registerEventHandler(RtcEngineEventHandler eventHandler) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_registerEventHandler';
// final param = createParams({// 'eventHandler':eventHandler// });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
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
  void unregisterEventHandler(RtcEngineEventHandler eventHandler) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_unregisterEventHandler';
// final param = createParams({// 'eventHandler':eventHandler// });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
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
  Future<void> setRemoteUserPriority(
      {required int uid, required PriorityType userPriority}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setRemoteUserPriority';
    final param =
        createParams({'uid': uid, 'userPriority': userPriority.value()});
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
  }

  @override
  Future<void> setEncryptionMode(String encryptionMode) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setEncryptionMode';
    final param = createParams({'encryptionMode': encryptionMode});
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
  }

  @override
  Future<void> setEncryptionSecret(String secret) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setEncryptionSecret';
    final param = createParams({'secret': secret});
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
  }

  @override
  Future<void> enableEncryption(
      {required bool enabled, required EncryptionConfig config}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableEncryption';
    final param = createParams({'enabled': enabled, 'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<int> createDataStream(DataStreamConfig config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_createDataStream';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    if (result < 0) {
      throw AgoraRtcException(code: result);
    }
    final createDataStreamJson = RtcEngineCreateDataStreamJson.fromJson(rm);
    return createDataStreamJson.streamId;
  }

  @override
  Future<void> sendStreamMessage(
      {required int streamId,
      required Uint8List data,
      required int length}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_sendStreamMessage';
    final param = createParams({'streamId': streamId, 'length': length});
    final List<Uint8List> buffers = [];
    buffers.add(data);
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> addVideoWatermark(
      {required String watermarkUrl, required WatermarkOptions options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_addVideoWatermark';
    final param = createParams(
        {'watermarkUrl': watermarkUrl, 'options': options.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> clearVideoWatermarks() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_clearVideoWatermarks';
    final param = createParams({});
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
  }

  @override
  Future<void> pauseAudio() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_pauseAudio';
    final param = createParams({});
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
  }

  @override
  Future<void> resumeAudio() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_resumeAudio';
    final param = createParams({});
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
  }

  @override
  Future<void> enableWebSdkInteroperability(bool enabled) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableWebSdkInteroperability';
    final param = createParams({'enabled': enabled});
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
  }

  @override
  Future<void> sendCustomReportMessage(
      {required String id,
      required String category,
      required String event,
      required String label,
      required int value}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_sendCustomReportMessage';
    final param = createParams({
      'id': id,
      'category': category,
      'event': event,
      'label': label,
      'value': value
    });
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
  }

  @override
  void registerMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type}) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_registerMediaMetadataObserver';
// final param = createParams({// 'observer':observer, 'type':type// });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError('Unimplement for registerMediaMetadataObserver');
  }

  @override
  void unregisterMediaMetadataObserver(
      {required MetadataObserver observer, required MetadataType type}) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_unregisterMediaMetadataObserver';
// final param = createParams({// 'observer':observer, 'type':type// });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// if (result < 0) {
// throw AgoraRtcException(code: result);
// }
    throw UnimplementedError('Unimplement for unregisterMediaMetadataObserver');
  }

  @override
  Future<void> startAudioFrameDump(
      {required String channelId,
      required int userId,
      required String location,
      required String uuid,
      required String passwd,
      required int durationMs,
      required bool autoUpload}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startAudioFrameDump';
    final param = createParams({
      'channel_id': channelId,
      'user_id': userId,
      'location': location,
      'uuid': uuid,
      'passwd': passwd,
      'duration_ms': durationMs,
      'auto_upload': autoUpload
    });
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
  }

  @override
  Future<void> stopAudioFrameDump(
      {required String channelId,
      required int userId,
      required String location}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopAudioFrameDump';
    final param = createParams(
        {'channel_id': channelId, 'user_id': userId, 'location': location});
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
  }

  @override
  Future<void> registerLocalUserAccount(
      {required String appId, required String userAccount}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_registerLocalUserAccount';
    final param = createParams({'appId': appId, 'userAccount': userAccount});
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
  }

  @override
  Future<void> joinChannelWithUserAccount(
      {required String token,
      required String channelId,
      required String userAccount,
      ChannelMediaOptions? options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_joinChannelWithUserAccount';
    final param = createParams({
      'token': token,
      'channelId': channelId,
      'userAccount': userAccount,
      'options': options?.toJson()
    });
    final List<Uint8List> buffers = [];
    if (options != null) {
      buffers.addAll(options.collectBufferList());
    }
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> joinChannelWithUserAccountEx(
      {required String token,
      required String channelId,
      required String userAccount,
      required ChannelMediaOptions options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_joinChannelWithUserAccountEx';
    final param = createParams({
      'token': token,
      'channelId': channelId,
      'userAccount': userAccount,
      'options': options.toJson()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<UserInfo> getUserInfoByUserAccount(String userAccount) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getUserInfoByUserAccount';
    final param = createParams({'userAccount': userAccount});
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
    final getUserInfoByUserAccountJson =
        RtcEngineGetUserInfoByUserAccountJson.fromJson(rm);
    return getUserInfoByUserAccountJson.userInfo;
  }

  @override
  Future<UserInfo> getUserInfoByUid(int uid) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getUserInfoByUid';
    final param = createParams({'uid': uid});
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
    final getUserInfoByUidJson = RtcEngineGetUserInfoByUidJson.fromJson(rm);
    return getUserInfoByUidJson.userInfo;
  }

  @override
  Future<void> startChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startChannelMediaRelay';
    final param = createParams({'configuration': configuration.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(configuration.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> updateChannelMediaRelay(
      ChannelMediaRelayConfiguration configuration) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_updateChannelMediaRelay';
    final param = createParams({'configuration': configuration.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(configuration.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopChannelMediaRelay() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopChannelMediaRelay';
    final param = createParams({});
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
  }

  @override
  Future<void> pauseAllChannelMediaRelay() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_pauseAllChannelMediaRelay';
    final param = createParams({});
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
  }

  @override
  Future<void> resumeAllChannelMediaRelay() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_resumeAllChannelMediaRelay';
    final param = createParams({});
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
  }

  @override
  Future<void> setDirectCdnStreamingAudioConfiguration(
      AudioProfileType profile) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setDirectCdnStreamingAudioConfiguration';
    final param = createParams({'profile': profile.value()});
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
  }

  @override
  Future<void> setDirectCdnStreamingVideoConfiguration(
      VideoEncoderConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setDirectCdnStreamingVideoConfiguration';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> startDirectCdnStreaming(
      {required DirectCdnStreamingEventHandler eventHandler,
      required String publishUrl,
      required DirectCdnStreamingMediaOptions options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startDirectCdnStreaming';
    final param = createParams({
      'eventHandler': eventHandler,
      'publishUrl': publishUrl,
      'options': options.toJson()
    });
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopDirectCdnStreaming() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopDirectCdnStreaming';
    final param = createParams({});
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
  }

  @override
  Future<void> updateDirectCdnStreamingMediaOptions(
      DirectCdnStreamingMediaOptions options) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_updateDirectCdnStreamingMediaOptions';
    final param = createParams({'options': options.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> startRhythmPlayer(
      {required String sound1,
      required String sound2,
      required AgoraRhythmPlayerConfig config}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_startRhythmPlayer';
    final param = createParams(
        {'sound1': sound1, 'sound2': sound2, 'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> stopRhythmPlayer() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_stopRhythmPlayer';
    final param = createParams({});
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
  }

  @override
  Future<void> configRhythmPlayer(AgoraRhythmPlayerConfig config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_configRhythmPlayer';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> takeSnapshot(
      {required int uid, required String filePath}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_takeSnapshot';
    final param = createParams({'uid': uid, 'filePath': filePath});
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
  }

  @override
  Future<void> enableContentInspect(
      {required bool enabled, required ContentInspectConfig config}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableContentInspect';
    final param = createParams({'enabled': enabled, 'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> adjustCustomAudioPublishVolume(
      {required int sourceId, required int volume}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_adjustCustomAudioPublishVolume';
    final param = createParams({'sourceId': sourceId, 'volume': volume});
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
  }

  @override
  Future<void> adjustCustomAudioPlayoutVolume(
      {required int sourceId, required int volume}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_adjustCustomAudioPlayoutVolume';
    final param = createParams({'sourceId': sourceId, 'volume': volume});
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
  }

  @override
  Future<void> setCloudProxy(CloudProxyType proxyType) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setCloudProxy';
    final param = createParams({'proxyType': proxyType.value()});
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
  }

  @override
  Future<void> setLocalAccessPoint(LocalAccessPointConfiguration config) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setLocalAccessPoint';
    final param = createParams({'config': config.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(config.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> setAdvancedAudioOptions(
      {required AdvancedAudioOptions options, int sourceType = 0}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setAdvancedAudioOptions';
    final param =
        createParams({'options': options.toJson(), 'sourceType': sourceType});
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<void> setAVSyncSource(
      {required String channelId, required int uid}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setAVSyncSource';
    final param = createParams({'channelId': channelId, 'uid': uid});
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
  }

  @override
  Future<void> enableVideoImageSource(
      {required bool enable, required ImageTrackOptions options}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableVideoImageSource';
    final param = createParams({'enable': enable, 'options': options.toJson()});
    final List<Uint8List> buffers = [];
    buffers.addAll(options.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
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
  Future<int> getCurrentMonotonicTimeInMs() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getCurrentMonotonicTimeInMs';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  Future<void> enableWirelessAccelerate(bool enabled) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_enableWirelessAccelerate';
    final param = createParams({'enabled': enabled});
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
  }

  @override
  Future<int> getNetworkType() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getNetworkType';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }

  @override
  AudioDeviceManager getAudioDeviceManager() {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_getAudioDeviceManager';
// final param = createParams({// // });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as AudioDeviceManager;
    throw UnimplementedError('Unimplement for getAudioDeviceManager');
  }

  @override
  VideoDeviceManager getVideoDeviceManager() {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_getVideoDeviceManager';
// final param = createParams({// // });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as VideoDeviceManager;
    throw UnimplementedError('Unimplement for getVideoDeviceManager');
  }

  @override
  MusicContentCenter getMusicContentCenter() {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_getMusicContentCenter';
// final param = createParams({// // });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as MusicContentCenter;
    throw UnimplementedError('Unimplement for getMusicContentCenter');
  }

  @override
  MediaEngine getMediaEngine() {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_getMediaEngine';
// final param = createParams({// // });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as MediaEngine;
    throw UnimplementedError('Unimplement for getMediaEngine');
  }

  @override
  MediaRecorder getMediaRecorder() {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_getMediaRecorder';
// final param = createParams({// // });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as MediaRecorder;
    throw UnimplementedError('Unimplement for getMediaRecorder');
  }

  @override
  LocalSpatialAudioEngine getLocalSpatialAudioEngine() {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_getLocalSpatialAudioEngine';
// final param = createParams({// // });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
// return result as LocalSpatialAudioEngine;
    throw UnimplementedError('Unimplement for getLocalSpatialAudioEngine');
  }

  @override
  Future<void> sendMetaData(
      {required Metadata metadata, required VideoSourceType sourceType}) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_sendMetaData';
    final param = createParams(
        {'metadata': metadata.toJson(), 'source_type': sourceType.value()});
    final List<Uint8List> buffers = [];
    buffers.addAll(metadata.collectBufferList());
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: buffers));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<void> setMaxMetadataSize(int size) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setMaxMetadataSize';
    final param = createParams({'size': size});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  void unregisterAudioEncodedFrameObserver(AudioEncodedFrameObserver observer) {
// Implementation template
// final apiType = '${isOverrideClassName ? className : 'RtcEngine'}_unregisterAudioEncodedFrameObserver';
// final param = createParams({// 'observer':observer// });
// final callApiResult =  irisMethodChannel.invokeMethod(IrisMethodCall(apiType, jsonEncode(param), buffers:null));
// if (callApiResult.irisReturnCode < 0) {
// throw AgoraRtcException(code: callApiResult.irisReturnCode);
// }
// final rm = callApiResult.data;
// final result = rm['result'];
    throw UnimplementedError(
        'Unimplement for unregisterAudioEncodedFrameObserver');
  }

  @override
  Future<void> setParameters(String parameters) async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_setParameters';
    final param = createParams({'parameters': parameters});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
  }

  @override
  Future<int> getNativeHandle() async {
    final apiType =
        '${isOverrideClassName ? className : 'RtcEngine'}_getNativeHandle';
    final param = createParams({});
    final callApiResult = await irisMethodChannel.invokeMethod(
        IrisMethodCall(apiType, jsonEncode(param), buffers: null));
    if (callApiResult.irisReturnCode < 0) {
      throw AgoraRtcException(code: callApiResult.irisReturnCode);
    }
    final rm = callApiResult.data;
    final result = rm['result'];
    return result as int;
  }
}
