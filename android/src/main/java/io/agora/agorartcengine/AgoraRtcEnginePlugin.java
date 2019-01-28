package io.agora.agorartcengine;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


import android.content.Context;
import android.graphics.Rect;
import android.view.SurfaceView;

import java.util.HashMap;

import io.agora.rtc.Constants;
import io.agora.rtc.RtcEngine;
import io.agora.rtc.IRtcEngineEventHandler;
//import io.agora.rtc.RtcEngine

import io.agora.rtc.video.VideoCanvas;
import io.agora.rtc.video.VideoEncoderConfiguration;
import io.flutter.plugin.common.StandardMessageCodec;

/** AgoraRtcEnginePlugin */
public class AgoraRtcEnginePlugin implements MethodCallHandler {

  private final Registrar mRegistrar;
  private final MethodChannel mMethodChannel;
  private RtcEngine mRtcEngine;
  private HashMap<String, SurfaceView> mRendererViews;

  public void addView(SurfaceView view, int id) {
    mRendererViews.put("" + id, view);
  }

  public void removeView(int id) {
    mRendererViews.remove("" + id);
  }

  public SurfaceView getView(int id) {
    return mRendererViews.get("" + id);
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "agora_rtc_engine");

    AgoraRtcEnginePlugin plugin = new AgoraRtcEnginePlugin(registrar, channel);
    channel.setMethodCallHandler(plugin);

    AgoraRenderViewFactory fac = new AgoraRenderViewFactory(StandardMessageCodec.INSTANCE, plugin);
    registrar.platformViewRegistry().registerViewFactory("AgoraRendererView", fac);
  }

  private AgoraRtcEnginePlugin(Registrar registrar, MethodChannel channel) {
    this.mRegistrar = registrar;
    this.mMethodChannel = channel;
    this.mRendererViews = new HashMap<String, SurfaceView>();
  }

  private Context getActiveContext() {
    return (mRegistrar.activity() != null) ? mRegistrar.activity() : mRegistrar.context();
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    Context context = getActiveContext();

    switch (call.method) {
      case "createEngine":
        try {
          String appId = call.argument("appId");
          mRtcEngine = RtcEngine.create(context, appId, mRtcEventHandler);
        } catch (Exception e) {
          throw new RuntimeException("NEED TO check rtc sdk init fatal error\n");
        }
        break;
      case "joinChannel":
        String appId = call.argument("appId");
        String token = call.argument("token");
        String channel = call.argument("channelId");
        String info = call.argument("info");
        int uid = call.argument("uid");
        mRtcEngine.joinChannel(token, channel, info, uid);
        break;
      case "leaveChannel":
        mRtcEngine.leaveChannel();
        break;
      case "setupLocalVideo":
        int localViewId = call.argument("viewId");
        SurfaceView localView = getView(localViewId);
        int localRenderMode = call.argument("renderMode");
        VideoCanvas localCanvas = new VideoCanvas(localView);
        localCanvas.renderMode = localRenderMode;
        mRtcEngine.setupLocalVideo(localCanvas);
        break;
      case "setupRemoteVideo":
        int remoteViewId = call.argument("viewId");
        SurfaceView view = getView(remoteViewId);
        int remoteRenderMode = call.argument("renderMode");
        int remoteUid = call.argument("uid");
        mRtcEngine.setupRemoteVideo(new VideoCanvas(view, remoteRenderMode, remoteUid));
        break;
      case "enableVideo":
        mRtcEngine.enableVideo();
        break;
      case "disableVideo":
        mRtcEngine.disableVideo();
      case "startPreview":
        mRtcEngine.startPreview();
      case "stopPreview":
        mRtcEngine.stopPreview();
        break;
      default:
        result.notImplemented();
    }
  }

  final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {
    @Override
    public void onWarning(int warn) {
      super.onWarning(warn);
    }

    @Override
    public void onError(int err) {
      super.onError(err);
    }

    @Override
    public void onJoinChannelSuccess(String channel, int uid, int elapsed) {
      super.onJoinChannelSuccess(channel, uid, elapsed);
      HashMap map = new HashMap<String, Object>();
      map.put("channel", channel);
      map.put("uid", uid);
      map.put("elapsed", elapsed);
      mMethodChannel.invokeMethod("onJoinChannelSuccess", map);
    }

    @Override
    public void onRejoinChannelSuccess(String channel, int uid, int elapsed) {
      super.onRejoinChannelSuccess(channel, uid, elapsed);
    }

    @Override
    public void onLeaveChannel(RtcStats stats) {
      super.onLeaveChannel(stats);
      HashMap map = new HashMap<String, Object>();
      map.put("stats", mapFromStats(stats));
      mMethodChannel.invokeMethod("onLeaveChannel", map);
    }

    @Override
    public void onClientRoleChanged(int oldRole, int newRole) {
      super.onClientRoleChanged(oldRole, newRole);
    }

    @Override
    public void onUserJoined(int uid, int elapsed) {
      super.onUserJoined(uid, elapsed);
      HashMap map = new HashMap<String, Object>();
      map.put("uid", uid);
      map.put("elapsed", elapsed);
      mMethodChannel.invokeMethod("onUserJoined", map);
    }

    @Override
    public void onUserOffline(int uid, int reason) {
      super.onUserOffline(uid, reason);
      HashMap map = new HashMap<String, Object>();
      map.put("uid", uid);
      map.put("reason", reason);
      mMethodChannel.invokeMethod("onUserOffline", map);
    }

    @Override
    public void onConnectionStateChanged(int state, int reason) {
      super.onConnectionStateChanged(state, reason);
    }

    @Override
    public void onConnectionLost() {
      super.onConnectionLost();
    }

    @Override
    public void onApiCallExecuted(int error, String api, String result) {
      super.onApiCallExecuted(error, api, result);
    }

    @Override
    public void onTokenPrivilegeWillExpire(String token) {
      super.onTokenPrivilegeWillExpire(token);
    }

    @Override
    public void onRequestToken() {
      super.onRequestToken();
    }

    @Override
    public void onMicrophoneEnabled(boolean enabled) {
      super.onMicrophoneEnabled(enabled);
    }

    @Override
    public void onAudioVolumeIndication(AudioVolumeInfo[] speakers, int totalVolume) {
      super.onAudioVolumeIndication(speakers, totalVolume);
    }

    @Override
    public void onActiveSpeaker(int uid) {
      super.onActiveSpeaker(uid);
    }

    @Override
    public void onFirstLocalAudioFrame(int elapsed) {
      super.onFirstLocalAudioFrame(elapsed);
    }

    @Override
    public void onFirstRemoteAudioFrame(int uid, int elapsed) {
      super.onFirstRemoteAudioFrame(uid, elapsed);
    }

    @Override
    public void onVideoStopped() {
      super.onVideoStopped();
    }

    @Override
    public void onFirstLocalVideoFrame(int width, int height, int elapsed) {
      super.onFirstLocalVideoFrame(width, height, elapsed);
    }

    @Override
    public void onFirstRemoteVideoDecoded(int uid, int width, int height, int elapsed) {
      super.onFirstRemoteVideoDecoded(uid, width, height, elapsed);
    }

    @Override
    public void onFirstRemoteVideoFrame(int uid, int width, int height, int elapsed) {
      super.onFirstRemoteVideoFrame(uid, width, height, elapsed);
    }

    @Override
    public void onUserMuteAudio(int uid, boolean muted) {
      super.onUserMuteAudio(uid, muted);
    }

    @Override
    public void onUserMuteVideo(int uid, boolean muted) {
      super.onUserMuteVideo(uid, muted);
    }

    @Override
    public void onUserEnableVideo(int uid, boolean enabled) {
      super.onUserEnableVideo(uid, enabled);
    }

    @Override
    public void onUserEnableLocalVideo(int uid, boolean enabled) {
      super.onUserEnableLocalVideo(uid, enabled);
    }

    @Override
    public void onVideoSizeChanged(int uid, int width, int height, int rotation) {
      super.onVideoSizeChanged(uid, width, height, rotation);
    }

    @Override
    public void onRemoteVideoStateChanged(int uid, int state) {
      super.onRemoteVideoStateChanged(uid, state);
    }

    @Override
    public void onLocalPublishFallbackToAudioOnly(boolean isFallbackOrRecover) {
      super.onLocalPublishFallbackToAudioOnly(isFallbackOrRecover);
    }

    @Override
    public void onRemoteSubscribeFallbackToAudioOnly(int uid, boolean isFallbackOrRecover) {
      super.onRemoteSubscribeFallbackToAudioOnly(uid, isFallbackOrRecover);
    }

    @Override
    public void onAudioRouteChanged(int routing) {
      super.onAudioRouteChanged(routing);
    }

    @Override
    public void onCameraReady() {
      super.onCameraReady();
    }

    @Override
    public void onCameraFocusAreaChanged(Rect rect) {
      super.onCameraFocusAreaChanged(rect);
    }

    @Override
    public void onCameraExposureAreaChanged(Rect rect) {
      super.onCameraExposureAreaChanged(rect);
    }

    @Override
    public void onRtcStats(RtcStats stats) {
      super.onRtcStats(stats);
    }

    @Override
    public void onLastmileQuality(int quality) {
      super.onLastmileQuality(quality);
    }

    @Override
    public void onNetworkQuality(int uid, int txQuality, int rxQuality) {
      super.onNetworkQuality(uid, txQuality, rxQuality);
    }

    @Override
    public void onLocalVideoStats(LocalVideoStats stats) {
      super.onLocalVideoStats(stats);
    }

    @Override
    public void onRemoteVideoStats(RemoteVideoStats stats) {
      super.onRemoteVideoStats(stats);
    }

    @Override
    public void onRemoteAudioStats(RemoteAudioStats stats) {
      super.onRemoteAudioStats(stats);
    }

    @Override
    public void onRemoteAudioTransportStats(int uid, int delay, int lost, int rxKBitRate) {
      super.onRemoteAudioTransportStats(uid, delay, lost, rxKBitRate);
    }

    @Override
    public void onRemoteVideoTransportStats(int uid, int delay, int lost, int rxKBitRate) {
      super.onRemoteVideoTransportStats(uid, delay, lost, rxKBitRate);
    }

    @Override
    public void onAudioMixingFinished() {
      super.onAudioMixingFinished();
    }

    @Override
    public void onAudioEffectFinished(int soundId) {
      super.onAudioEffectFinished(soundId);
    }

    @Override
    public void onStreamPublished(String url, int error) {
      super.onStreamPublished(url, error);
    }

    @Override
    public void onStreamUnpublished(String url) {
      super.onStreamUnpublished(url);
    }

    @Override
    public void onTranscodingUpdated() {
      super.onTranscodingUpdated();
    }

    @Override
    public void onStreamInjectedStatus(String url, int uid, int status) {
      super.onStreamInjectedStatus(url, uid, status);
    }

    @Override
    public void onStreamMessage(int uid, int streamId, byte[] data) {
      super.onStreamMessage(uid, streamId, data);
    }

    @Override
    public void onStreamMessageError(int uid, int streamId, int error, int missed, int cached) {
      super.onStreamMessageError(uid, streamId, error, missed, cached);
    }

    @Override
    public void onMediaEngineLoadSuccess() {
      super.onMediaEngineLoadSuccess();
    }

    @Override
    public void onMediaEngineStartCallSuccess() {
      super.onMediaEngineStartCallSuccess();
    }

    private HashMap mapFromStats(RtcStats stats) {
      HashMap map = new HashMap();
      map.put("duration", stats.totalDuration);
      map.put("txBytes", stats.txBytes);
      map.put("rxBytes", stats.rxBytes);
      map.put("txAudioKBitrate", stats.txAudioKBitRate);
      map.put("rxAudioKBitrate", stats.rxAudioKBitRate);
      map.put("txVideoKBitrate", stats.txVideoKBitRate);
      map.put("rxVideoKBitrate", stats.rxVideoKBitRate);
      map.put("lastmileDelay", stats.lastmileDelay);
      map.put("userCount", stats.users);
      map.put("cpuAppUsage", stats.cpuAppUsage);
      map.put("cpuTotalUsage", stats.cpuTotalUsage);
      return map;
    }
  };
}




