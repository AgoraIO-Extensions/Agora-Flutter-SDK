import 'package:agora_rtc_engine/src/binding_forward_export.dart';

// ignore_for_file: public_member_api_docs, unused_local_variable, prefer_is_empty

extension LocalVideoStatsBufferExt on LocalVideoStats {
  LocalVideoStats fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension RemoteVideoStatsBufferExt on RemoteVideoStats {
  RemoteVideoStats fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension VideoCompositingLayoutBufferExt on VideoCompositingLayout {
  VideoCompositingLayout fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? appData;
    if (bufferList.length > 0) {
      appData = bufferList[0];
    }
    return VideoCompositingLayout(
        canvasWidth: canvasWidth,
        canvasHeight: canvasHeight,
        backgroundColor: backgroundColor,
        regions: regions,
        regionCount: regionCount,
        appData: appData,
        appDataLength: appDataLength);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (appData != null) {
      bufferList.add(appData!);
    }
    return bufferList;
  }
}

extension RegionBufferExt on Region {
  Region fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension InjectStreamConfigBufferExt on InjectStreamConfig {
  InjectStreamConfig fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension PublisherConfigurationBufferExt on PublisherConfiguration {
  PublisherConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AudioTrackConfigBufferExt on AudioTrackConfig {
  AudioTrackConfig fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension CameraCapturerConfigurationBufferExt on CameraCapturerConfiguration {
  CameraCapturerConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ScreenCaptureConfigurationBufferExt on ScreenCaptureConfiguration {
  ScreenCaptureConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension SIZEBufferExt on SIZE {
  SIZE fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ThumbImageBufferBufferExt on ThumbImageBuffer {
  ThumbImageBuffer fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? buffer;
    if (bufferList.length > 0) {
      buffer = bufferList[0];
    }
    return ThumbImageBuffer(
        buffer: buffer, length: length, width: width, height: height);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (buffer != null) {
      bufferList.add(buffer!);
    }
    return bufferList;
  }
}

extension ScreenCaptureSourceInfoBufferExt on ScreenCaptureSourceInfo {
  ScreenCaptureSourceInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AdvancedAudioOptionsBufferExt on AdvancedAudioOptions {
  AdvancedAudioOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ImageTrackOptionsBufferExt on ImageTrackOptions {
  ImageTrackOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ChannelMediaOptionsBufferExt on ChannelMediaOptions {
  ChannelMediaOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension LocalAccessPointConfigurationBufferExt
    on LocalAccessPointConfiguration {
  LocalAccessPointConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension LeaveChannelOptionsBufferExt on LeaveChannelOptions {
  LeaveChannelOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension RtcEngineContextBufferExt on RtcEngineContext {
  RtcEngineContext fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension MetadataBufferExt on Metadata {
  Metadata fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? buffer;
    if (bufferList.length > 0) {
      buffer = bufferList[0];
    }
    return Metadata(
        uid: uid, size: size, buffer: buffer, timeStampMs: timeStampMs);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (buffer != null) {
      bufferList.add(buffer!);
    }
    return bufferList;
  }
}

extension DirectCdnStreamingStatsBufferExt on DirectCdnStreamingStats {
  DirectCdnStreamingStats fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension DirectCdnStreamingMediaOptionsBufferExt
    on DirectCdnStreamingMediaOptions {
  DirectCdnStreamingMediaOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension SDKBuildInfoBufferExt on SDKBuildInfo {
  SDKBuildInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension VideoDeviceInfoBufferExt on VideoDeviceInfo {
  VideoDeviceInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AudioDeviceInfoBufferExt on AudioDeviceInfo {
  AudioDeviceInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension VideoDimensionsBufferExt on VideoDimensions {
  VideoDimensions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension SenderOptionsBufferExt on SenderOptions {
  SenderOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension EncodedAudioFrameAdvancedSettingsBufferExt
    on EncodedAudioFrameAdvancedSettings {
  EncodedAudioFrameAdvancedSettings fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension EncodedAudioFrameInfoBufferExt on EncodedAudioFrameInfo {
  EncodedAudioFrameInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AudioPcmDataInfoBufferExt on AudioPcmDataInfo {
  AudioPcmDataInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension VideoSubscriptionOptionsBufferExt on VideoSubscriptionOptions {
  VideoSubscriptionOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension EncodedVideoFrameInfoBufferExt on EncodedVideoFrameInfo {
  EncodedVideoFrameInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension VideoEncoderConfigurationBufferExt on VideoEncoderConfiguration {
  VideoEncoderConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension DataStreamConfigBufferExt on DataStreamConfig {
  DataStreamConfig fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension SimulcastStreamConfigBufferExt on SimulcastStreamConfig {
  SimulcastStreamConfig fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension RectangleBufferExt on Rectangle {
  Rectangle fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension WatermarkRatioBufferExt on WatermarkRatio {
  WatermarkRatio fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension WatermarkOptionsBufferExt on WatermarkOptions {
  WatermarkOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension RtcStatsBufferExt on RtcStats {
  RtcStats fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ClientRoleOptionsBufferExt on ClientRoleOptions {
  ClientRoleOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension RemoteAudioStatsBufferExt on RemoteAudioStats {
  RemoteAudioStats fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension VideoFormatBufferExt on VideoFormat {
  VideoFormat fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension VideoTrackInfoBufferExt on VideoTrackInfo {
  VideoTrackInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AudioVolumeInfoBufferExt on AudioVolumeInfo {
  AudioVolumeInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension DeviceInfoBufferExt on DeviceInfo {
  DeviceInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension PacketBufferExt on Packet {
  Packet fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? buffer;
    if (bufferList.length > 0) {
      buffer = bufferList[0];
    }
    return Packet(buffer: buffer, size: size);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (buffer != null) {
      bufferList.add(buffer!);
    }
    return bufferList;
  }
}

extension LocalAudioStatsBufferExt on LocalAudioStats {
  LocalAudioStats fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension RtcImageBufferExt on RtcImage {
  RtcImage fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension LiveStreamAdvancedFeatureBufferExt on LiveStreamAdvancedFeature {
  LiveStreamAdvancedFeature fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension TranscodingUserBufferExt on TranscodingUser {
  TranscodingUser fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension LiveTranscodingBufferExt on LiveTranscoding {
  LiveTranscoding fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension TranscodingVideoStreamBufferExt on TranscodingVideoStream {
  TranscodingVideoStream fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension LocalTranscoderConfigurationBufferExt
    on LocalTranscoderConfiguration {
  LocalTranscoderConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension LastmileProbeConfigBufferExt on LastmileProbeConfig {
  LastmileProbeConfig fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension LastmileProbeOneWayResultBufferExt on LastmileProbeOneWayResult {
  LastmileProbeOneWayResult fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension LastmileProbeResultBufferExt on LastmileProbeResult {
  LastmileProbeResult fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension WlAccStatsBufferExt on WlAccStats {
  WlAccStats fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension VideoCanvasBufferExt on VideoCanvas {
  VideoCanvas fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? priv;
    if (bufferList.length > 0) {
      priv = bufferList[0];
    }
    return VideoCanvas(
        view: view,
        renderMode: renderMode,
        mirrorMode: mirrorMode,
        uid: uid,
        isScreenView: isScreenView,
        priv: priv,
        privSize: privSize,
        sourceType: sourceType,
        cropArea: cropArea,
        setupMode: setupMode);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (priv != null) {
      bufferList.add(priv!);
    }
    return bufferList;
  }
}

extension BeautyOptionsBufferExt on BeautyOptions {
  BeautyOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension LowlightEnhanceOptionsBufferExt on LowlightEnhanceOptions {
  LowlightEnhanceOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension VideoDenoiserOptionsBufferExt on VideoDenoiserOptions {
  VideoDenoiserOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ColorEnhanceOptionsBufferExt on ColorEnhanceOptions {
  ColorEnhanceOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension VirtualBackgroundSourceBufferExt on VirtualBackgroundSource {
  VirtualBackgroundSource fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension SegmentationPropertyBufferExt on SegmentationProperty {
  SegmentationProperty fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ScreenCaptureParametersBufferExt on ScreenCaptureParameters {
  ScreenCaptureParameters fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AudioRecordingConfigurationBufferExt on AudioRecordingConfiguration {
  AudioRecordingConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AudioEncodedFrameObserverConfigBufferExt
    on AudioEncodedFrameObserverConfig {
  AudioEncodedFrameObserverConfig fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ChannelMediaInfoBufferExt on ChannelMediaInfo {
  ChannelMediaInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ChannelMediaRelayConfigurationBufferExt
    on ChannelMediaRelayConfiguration {
  ChannelMediaRelayConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension UplinkNetworkInfoBufferExt on UplinkNetworkInfo {
  UplinkNetworkInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension DownlinkNetworkInfoBufferExt on DownlinkNetworkInfo {
  DownlinkNetworkInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension PeerDownlinkInfoBufferExt on PeerDownlinkInfo {
  PeerDownlinkInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension EncryptionConfigBufferExt on EncryptionConfig {
  EncryptionConfig fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? encryptionKdfSalt;
    if (bufferList.length > 0) {
      encryptionKdfSalt = bufferList[0];
    }
    return EncryptionConfig(
        encryptionMode: encryptionMode,
        encryptionKey: encryptionKey,
        encryptionKdfSalt: encryptionKdfSalt);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (encryptionKdfSalt != null) {
      bufferList.add(encryptionKdfSalt!);
    }
    return bufferList;
  }
}

extension EchoTestConfigurationBufferExt on EchoTestConfiguration {
  EchoTestConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension UserInfoBufferExt on UserInfo {
  UserInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ScreenVideoParametersBufferExt on ScreenVideoParameters {
  ScreenVideoParameters fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ScreenAudioParametersBufferExt on ScreenAudioParameters {
  ScreenAudioParameters fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ScreenCaptureParameters2BufferExt on ScreenCaptureParameters2 {
  ScreenCaptureParameters2 fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension SpatialAudioParamsBufferExt on SpatialAudioParams {
  SpatialAudioParams fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AudioParametersBufferExt on AudioParameters {
  AudioParameters fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ContentInspectModuleBufferExt on ContentInspectModule {
  ContentInspectModule fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ContentInspectConfigBufferExt on ContentInspectConfig {
  ContentInspectConfig fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension PacketOptionsBufferExt on PacketOptions {
  PacketOptions fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AudioEncodedFrameInfoBufferExt on AudioEncodedFrameInfo {
  AudioEncodedFrameInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AudioPcmFrameBufferExt on AudioPcmFrame {
  AudioPcmFrame fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ExternalVideoFrameBufferExt on ExternalVideoFrame {
  ExternalVideoFrame fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? buffer;
    if (bufferList.length > 0) {
      buffer = bufferList[0];
    }
    Uint8List? metadataBuffer;
    if (bufferList.length > 1) {
      metadataBuffer = bufferList[1];
    }
    return ExternalVideoFrame(
        type: type,
        format: format,
        buffer: buffer,
        stride: stride,
        height: height,
        cropLeft: cropLeft,
        cropTop: cropTop,
        cropRight: cropRight,
        cropBottom: cropBottom,
        rotation: rotation,
        timestamp: timestamp,
        eglType: eglType,
        textureId: textureId,
        matrix: matrix,
        metadataBuffer: metadataBuffer,
        metadataSize: metadataSize);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (buffer != null) {
      bufferList.add(buffer!);
    }
    if (metadataBuffer != null) {
      bufferList.add(metadataBuffer!);
    }
    return bufferList;
  }
}

extension VideoFrameBufferExt on VideoFrame {
  VideoFrame fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? yBuffer;
    if (bufferList.length > 0) {
      yBuffer = bufferList[0];
    }
    Uint8List? uBuffer;
    if (bufferList.length > 1) {
      uBuffer = bufferList[1];
    }
    Uint8List? vBuffer;
    if (bufferList.length > 2) {
      vBuffer = bufferList[2];
    }
    Uint8List? metadataBuffer;
    if (bufferList.length > 3) {
      metadataBuffer = bufferList[3];
    }
    Uint8List? alphaBuffer;
    if (bufferList.length > 4) {
      alphaBuffer = bufferList[4];
    }
    return VideoFrame(
        type: type,
        width: width,
        height: height,
        yStride: yStride,
        uStride: uStride,
        vStride: vStride,
        yBuffer: yBuffer,
        uBuffer: uBuffer,
        vBuffer: vBuffer,
        rotation: rotation,
        renderTimeMs: renderTimeMs,
        avsyncType: avsyncType,
        metadataBuffer: metadataBuffer,
        metadataSize: metadataSize,
        textureId: textureId,
        matrix: matrix,
        alphaBuffer: alphaBuffer);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (yBuffer != null) {
      bufferList.add(yBuffer!);
    }
    if (uBuffer != null) {
      bufferList.add(uBuffer!);
    }
    if (vBuffer != null) {
      bufferList.add(vBuffer!);
    }
    if (metadataBuffer != null) {
      bufferList.add(metadataBuffer!);
    }
    if (alphaBuffer != null) {
      bufferList.add(alphaBuffer!);
    }
    return bufferList;
  }
}

extension AudioFrameBufferExt on AudioFrame {
  AudioFrame fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? buffer;
    if (bufferList.length > 0) {
      buffer = bufferList[0];
    }
    return AudioFrame(
        type: type,
        samplesPerChannel: samplesPerChannel,
        bytesPerSample: bytesPerSample,
        channels: channels,
        samplesPerSec: samplesPerSec,
        buffer: buffer,
        renderTimeMs: renderTimeMs,
        avsyncType: avsyncType);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (buffer != null) {
      bufferList.add(buffer!);
    }
    return bufferList;
  }
}

extension AudioParamsBufferExt on AudioParams {
  AudioParams fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AudioSpectrumDataBufferExt on AudioSpectrumData {
  AudioSpectrumData fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension UserAudioSpectrumInfoBufferExt on UserAudioSpectrumInfo {
  UserAudioSpectrumInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension MediaRecorderConfigurationBufferExt on MediaRecorderConfiguration {
  MediaRecorderConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension RecorderInfoBufferExt on RecorderInfo {
  RecorderInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension PlayerStreamInfoBufferExt on PlayerStreamInfo {
  PlayerStreamInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension SrcInfoBufferExt on SrcInfo {
  SrcInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension CacheStatisticsBufferExt on CacheStatistics {
  CacheStatistics fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension PlayerUpdatedInfoBufferExt on PlayerUpdatedInfo {
  PlayerUpdatedInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension MediaSourceBufferExt on MediaSource {
  MediaSource fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension LogConfigBufferExt on LogConfig {
  LogConfig fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension InputSeiDataBufferExt on InputSeiData {
  InputSeiData fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    Uint8List? privateData;
    if (bufferList.length > 0) {
      privateData = bufferList[0];
    }
    return InputSeiData(
        type: type,
        timestamp: timestamp,
        frameIndex: frameIndex,
        privateData: privateData,
        dataSize: dataSize);
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    if (privateData != null) {
      bufferList.add(privateData!);
    }
    return bufferList;
  }
}

extension RemoteVoicePositionInfoBufferExt on RemoteVoicePositionInfo {
  RemoteVoicePositionInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension RtcConnectionBufferExt on RtcConnection {
  RtcConnection fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension AgoraRhythmPlayerConfigBufferExt on AgoraRhythmPlayerConfig {
  AgoraRhythmPlayerConfig fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension MusicChartInfoBufferExt on MusicChartInfo {
  MusicChartInfo fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension MvPropertyBufferExt on MvProperty {
  MvProperty fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension ClimaxSegmentBufferExt on ClimaxSegment {
  ClimaxSegment fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension MusicBufferExt on Music {
  Music fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}

extension MusicContentCenterConfigurationBufferExt
    on MusicContentCenterConfiguration {
  MusicContentCenterConfiguration fillBuffers(List<Uint8List> bufferList) {
    if (bufferList.isEmpty) return this;
    return this;
  }

  List<Uint8List> collectBufferList() {
    final bufferList = <Uint8List>[];
    return bufferList;
  }
}
