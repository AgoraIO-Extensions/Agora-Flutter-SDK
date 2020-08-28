package io.agora.agorartcengine;

import android.content.Context;
import android.graphics.Rect;
import android.os.Handler;
import android.os.Looper;
import android.view.SurfaceView;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.agora.rtc.IRtcEngineEventHandler;
import io.agora.rtc.RtcEngine;
import io.agora.rtc.internal.LastmileProbeConfig;
import io.agora.rtc.live.LiveInjectStreamConfig;
import io.agora.rtc.live.LiveTranscoding;
import io.agora.rtc.models.UserInfo;
import io.agora.rtc.video.AgoraImage;
import io.agora.rtc.video.BeautyOptions;
import io.agora.rtc.video.ChannelMediaInfo;
import io.agora.rtc.video.ChannelMediaRelayConfiguration;
import io.agora.rtc.video.VideoCanvas;
import io.agora.rtc.video.VideoEncoderConfiguration;
import io.agora.rtc.video.WatermarkOptions;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import io.flutter.plugin.common.StandardMessageCodec;

/**
 * AgoraRtcEnginePlugin
 */
public class AgoraRtcEnginePlugin implements MethodCallHandler, EventChannel.StreamHandler {

    private final Registrar mRegistrar;
    private static RtcEngine mRtcEngine;
    private HashMap<String, SurfaceView> mRendererViews;
    private Handler mEventHandler = new Handler(Looper.getMainLooper());
    private EventChannel.EventSink sink;

    void addView(SurfaceView view, int id) {
        mRendererViews.put("" + id, view);
    }

    private void removeView(int id) {
        mRendererViews.remove("" + id);
    }

    private SurfaceView getView(int id) {
        return mRendererViews.get("" + id);
    }

    public static RtcEngine getRtcEngine() {
        return mRtcEngine;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "agora_rtc_engine");

        final EventChannel eventChannel = new EventChannel(registrar.messenger(), "agora_rtc_engine_event_channel");

        AgoraRtcEnginePlugin plugin = new AgoraRtcEnginePlugin(registrar);
        channel.setMethodCallHandler(plugin);
        eventChannel.setStreamHandler(plugin);

        AgoraRenderViewFactory fac = new AgoraRenderViewFactory(StandardMessageCodec.INSTANCE,
                plugin);
        registrar.platformViewRegistry().registerViewFactory("AgoraRendererView", fac);
    }

    private AgoraRtcEnginePlugin(Registrar registrar) {
        this.mRegistrar = registrar;
        this.sink = null;
        this.mRendererViews = new HashMap<>();
    }

    private Context getActiveContext() {
        return (mRegistrar.activity() != null) ? mRegistrar.activity() : mRegistrar.context();
    }

    private AgoraImage createAgoraImage(Map<String, Object> options) {
        AgoraImage image = new AgoraImage();
        image.url = (String) options.get("url");
        image.height = (int) options.get("height");
        image.width = (int) options.get("width");
        image.x = (int) options.get("x");
        image.y = (int) options.get("y");
        return image;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        Context context = getActiveContext();

        switch (call.method) {
            // Core Methods
            case "create": {
                try {
                    String appId = call.argument("appId");
                    mRtcEngine = RtcEngine.create(context, appId, mRtcEventHandler);
                    result.success(null);
                } catch (Exception e) {
                    throw new RuntimeException("NEED TO check rtc sdk init fatal error\n");
                }
            }
            break;
            case "destroy": {
                RtcEngine.destroy();
                result.success(null);
            }
            break;
            case "setChannelProfile": {
                int profile = call.argument("profile");
                mRtcEngine.setChannelProfile(profile);
                result.success(null);
            }
            break;
            case "setClientRole": {
                int role = call.argument("role");
                mRtcEngine.setClientRole(role);
                result.success(null);
            }
            break;
            case "joinChannel": {
                String token = call.argument("token");
                String channel = call.argument("channelId");
                String info = call.argument("info");
                int uid = call.argument("uid");
                result.success(mRtcEngine.joinChannel(token, channel, info, uid) >= 0);
            }
            break;
            case "leaveChannel": {
                result.success(mRtcEngine.leaveChannel() >= 0);
            }
            break;
            case "switchChannel": {
                String token = call.argument("token");
                String channel = call.argument("channelId");
                result.success(mRtcEngine.switchChannel(token, channel) >= 0);
            }
            break;
            case "renewToken": {
                String token = call.argument("token");
                mRtcEngine.renewToken(token);
                result.success(null);
            }
            break;
            case "enableWebSdkInteroperability": {
                boolean enabled = call.argument("enabled");
                mRtcEngine.enableWebSdkInteroperability(enabled);
                result.success(null);
            }
            break;
            case "getConnectionState": {
                int state = mRtcEngine.getConnectionState();
                result.success(state);
            }
            break;
            case "registerLocalUserAccount": {
                String appId = call.argument("appId");
                String userAccount = call.argument("userAccount");
                int state = mRtcEngine.registerLocalUserAccount(appId, userAccount);
                result.success(state == 0 ? true : false);
            }
            break;
            case "joinChannelByUserAccount": {
                String token = call.argument("token");
                String userAccount = call.argument("userAccount");
                String channelId = call.argument("channelId");
                int state = mRtcEngine.joinChannelWithUserAccount(token, channelId, userAccount);
                result.success(state == 0 ? true : false);
            }
            break;
            case "getUserInfoByUserAccount": {
                String userAccount = call.argument("userAccount");
                UserInfo info = new UserInfo();
                int code = mRtcEngine.getUserInfoByUserAccount(userAccount, info);
                if (code == 0) {
                    HashMap<String, Object> map = new HashMap<>();
                    map.put("uid", info.uid);
                    map.put("userAccount", info.userAccount);
                    result.success(map);
                } else {
                    result.error("getUserInfoByUserAccountError", "get user info failed", code);
                }
            }
            break;
            case "getUserInfoByUid": {
                int uid = call.argument("uid");
                UserInfo info = new UserInfo();
                int code = mRtcEngine.getUserInfoByUid(uid, info);
                if (code == 0) {
                    HashMap<String, Object> map = new HashMap<>();
                    map.put("uid", info.uid);
                    map.put("userAccount", info.userAccount);
                    result.success(map);
                } else {
                    result.error("getUserInfoByUid", "get user info failed", code);
                }
            }
            break;
            // Core Audio
            case "enableAudio": {
                mRtcEngine.enableAudio();
                result.success(null);
            }
            break;
            case "disableAudio": {
                mRtcEngine.disableAudio();
                result.success(null);
            }
            break;
            case "setAudioProfile": {
                int profile = call.argument("profile");
                int scenario = call.argument("scenario");
                mRtcEngine.setAudioProfile(profile, scenario);
                result.success(null);
            }
            break;
            case "adjustRecordingSignalVolume": {
                int volume = call.argument("volume");
                mRtcEngine.adjustRecordingSignalVolume(volume);
                result.success(null);
            }
            break;
            case "adjustPlaybackSignalVolume": {
                int volume = call.argument("volume");
                mRtcEngine.adjustPlaybackSignalVolume(volume);
                result.success(null);
            }
            break;
            case "enableAudioVolumeIndication": {
                int interval = call.argument("interval");
                int smooth = call.argument("smooth");
                boolean vad = call.argument("vad");
                mRtcEngine.enableAudioVolumeIndication(interval, smooth, vad);
                result.success(null);
            }
            break;
            case "enableLocalAudio": {
                boolean enabled = call.argument("enabled");
                mRtcEngine.enableLocalAudio(enabled);
                result.success(null);
            }
            break;
            case "muteLocalAudioStream": {
                boolean muted = call.argument("muted");
                mRtcEngine.muteLocalAudioStream(muted);
                result.success(null);
            }
            break;
            case "muteRemoteAudioStream": {
                int uid = call.argument("uid");
                boolean muted = call.argument("muted");
                mRtcEngine.muteRemoteAudioStream(uid, muted);
                result.success(null);
            }
            break;
            case "muteAllRemoteAudioStreams": {
                boolean muted = call.argument("muted");
                mRtcEngine.muteAllRemoteAudioStreams(muted);
                result.success(null);
            }
            break;
            case "setDefaultMuteAllRemoteAudioStreams": {
                boolean muted = call.argument("muted");
                mRtcEngine.setDefaultMuteAllRemoteAudioStreams(muted);
                result.success(null);
            }
            break;
            // Video Pre-process and Post-process
            case "setBeautyEffectOptions": {
                boolean enabled = call.argument("enabled");
                HashMap<String, Object> optionsMap = call.argument("options");
                BeautyOptions options = beautyOptionsFromMap(optionsMap);
                mRtcEngine.setBeautyEffectOptions(enabled, options);
                result.success(null);
            }
            break;
            // Core Video
            case "enableVideo": {
                mRtcEngine.enableVideo();
                result.success(null);
            }
            break;
            case "disableVideo": {
                mRtcEngine.disableVideo();
                result.success(null);
            }
            break;
            case "setVideoEncoderConfiguration": {
                HashMap<String, Object> configDic = call.argument("config");
                VideoEncoderConfiguration config = videoEncoderConfigurationFromMap(configDic);
                mRtcEngine.setVideoEncoderConfiguration(config);
                result.success(null);
            }
            break;
            case "removeNativeView": {
                int viewId = call.argument("viewId");
                removeView(viewId);
                result.success(null);
            }
            break;
            case "setupLocalVideo": {
                int localViewId = call.argument("viewId");
                SurfaceView localView = getView(localViewId);
                int localRenderMode = call.argument("renderMode");
                VideoCanvas localCanvas = new VideoCanvas(localView);
                localCanvas.renderMode = localRenderMode;
                mRtcEngine.setupLocalVideo(localCanvas);
                result.success(null);
            }
            break;
            case "setupRemoteVideo": {
                int remoteViewId = call.argument("viewId");
                SurfaceView view = getView(remoteViewId);
                int remoteRenderMode = call.argument("renderMode");
                int remoteUid = call.argument("uid");
                mRtcEngine.setupRemoteVideo(new VideoCanvas(view, remoteRenderMode, remoteUid));
                result.success(null);
            }
            break;
            case "setLocalRenderMode": {
                int mode = call.argument("mode");
                mRtcEngine.setLocalRenderMode(mode);
                result.success(null);
            }
            break;
            case "setRemoteRenderMode": {
                int uid = call.argument("uid");
                int mode = call.argument("mode");
                mRtcEngine.setRemoteRenderMode(uid, mode);
                result.success(null);
            }
            break;
            case "startPreview": {
                mRtcEngine.startPreview();
                result.success(null);
            }
            break;
            case "stopPreview": {
                mRtcEngine.stopPreview();
                result.success(null);
            }
            break;
            case "enableLocalVideo": {
                boolean enabled = call.argument("enabled");
                mRtcEngine.enableLocalVideo(enabled);
                result.success(null);
            }
            break;
            case "muteLocalVideoStream": {
                boolean muted = call.argument("muted");
                mRtcEngine.muteLocalVideoStream(muted);
                result.success(null);
            }
            break;
            case "muteRemoteVideoStream": {
                int uid = call.argument("uid");
                boolean muted = call.argument("muted");
                mRtcEngine.muteRemoteVideoStream(uid, muted);
                result.success(null);
            }
            break;
            case "muteAllRemoteVideoStreams": {
                boolean muted = call.argument("muted");
                mRtcEngine.muteAllRemoteVideoStreams(muted);
                result.success(null);
            }
            break;
            case "setDefaultMuteAllRemoteVideoStreams": {
                boolean muted = call.argument("muted");
                mRtcEngine.setDefaultMuteAllRemoteVideoStreams(muted);
                result.success(null);
            }
            break;

            // Voice
            case "setLocalVoiceChanger": {
                int changer = call.argument("changer");
                mRtcEngine.setLocalVoiceChanger(changer);
                result.success(null);
            }
            break;

            case "setLocalVoicePitch": {
                double pitch = call.argument("pitch");
                mRtcEngine.setLocalVoicePitch(pitch);
                result.success(null);
            }
            break;
            case "setLocalVoiceEqualizationOfBandFrequency": {
                int bandFrequency = call.argument("bandFrequency");
                int gain = call.argument("gain");
                mRtcEngine.setLocalVoiceEqualization(bandFrequency, gain);
                result.success(null);
            }
            break;
            case "setLocalVoiceReverbOfType": {
                int reverbType = call.argument("reverbType");
                int value = call.argument("value");
                mRtcEngine.setLocalVoiceReverb(reverbType, value);
                result.success(null);
            }
            break;
            case "setLocalVoiceReverbPreset": {
                int reverbType = call.argument("reverbType");
                mRtcEngine.setLocalVoiceReverbPreset(reverbType);
                result.success(null);
            }
            break;
            case "enableSoundPositionIndication": {
                boolean enabled = call.argument("enabled");
                mRtcEngine.enableSoundPositionIndication(enabled);
                result.success(null);
            }
            break;
            case "setRemoteVoicePosition": {
                int uid = call.argument("uid");
                double pan = call.argument("pan");
                int gain = call.argument("gain");
                mRtcEngine.setRemoteVoicePosition(uid, pan, gain);
                result.success(null);
            }
            break;

            // Audio Routing Controller
            case "setDefaultAudioRouteToSpeaker": {
                boolean defaultToSpeaker = call.argument("defaultToSpeaker");
                mRtcEngine.setDefaultAudioRoutetoSpeakerphone(defaultToSpeaker);
                result.success(null);
            }
            break;
            case "setEnableSpeakerphone": {
                boolean enabled = call.argument("enabled");
                mRtcEngine.setEnableSpeakerphone(enabled);
                result.success(null);
            }
            break;
            case "isSpeakerphoneEnabled": {
                boolean enabled = mRtcEngine.isSpeakerphoneEnabled();
                result.success(enabled);
            }
            break;

            // Stream Fallback
            case "setRemoteUserPriority": {
                int uid = call.argument("uid");
                int userPriority = call.argument("userPriority");
                mRtcEngine.setRemoteUserPriority(uid, userPriority);
                result.success(null);
            }
            case "setLocalPublishFallbackOption": {
                int option = call.argument("option");
                mRtcEngine.setLocalPublishFallbackOption(option);
                result.success(null);
            }
            break;
            case "setRemoteSubscribeFallbackOption": {
                int option = call.argument("option");
                mRtcEngine.setRemoteSubscribeFallbackOption(option);
                result.success(null);
            }
            break;

            // Dual-stream Mode
            case "enableDualStreamMode": {
                boolean enabled = call.argument("enabled");
                mRtcEngine.enableDualStreamMode(enabled);
                result.success(null);
            }
            break;
            case "setRemoteVideoStreamType": {
                int uid = call.argument("uid");
                int streamType = call.argument("streamType");
                mRtcEngine.setRemoteVideoStreamType(uid, streamType);
                result.success(null);
            }
            break;
            case "setRemoteDefaultVideoStreamType": {
                int streamType = call.argument("streamType");
                mRtcEngine.setRemoteDefaultVideoStreamType(streamType);
                result.success(null);
            }
            break;

            case "setLiveTranscoding": {
                LiveTranscoding transcoding = new LiveTranscoding();
                Map params = call.argument("transcoding");
                if (params.get("width") != null && params.get("height") != null) {
                    transcoding.width = (int) params.get("width");
                    transcoding.height = (int) params.get("height");
                }
                if (params.get("videoBitrate") != null) {
                    transcoding.videoBitrate = (int) params.get("videoBitrate");
                }
                if (params.get("videoFramerate") != null) {
                    transcoding.videoFramerate = (int) params.get("videoFramerate");
                }
                if (params.get("videoGop") != null) {
                    transcoding.videoGop = (int) params.get("videoGop");
                }
                if (params.get("videoCodecProfile") != null) {
                    int videoCodecProfile = (int) params.get("videoCodecProfile");
                    for (LiveTranscoding.VideoCodecProfileType profileType : LiveTranscoding.VideoCodecProfileType.values()) {
                        if (LiveTranscoding.VideoCodecProfileType.getValue(profileType) == videoCodecProfile) {
                            transcoding.videoCodecProfile = profileType;
                            break;
                        }
                    }
                }
                if (params.get("audioCodecProfile") != null) {
                    int audioCodecProfile = (int) params.get("audioCodecProfile");
                    for (LiveTranscoding.AudioCodecProfileType profileType : LiveTranscoding.AudioCodecProfileType.values()) {
                        if (LiveTranscoding.AudioCodecProfileType.getValue(profileType) == audioCodecProfile) {
                            transcoding.audioCodecProfile = profileType;
                            break;
                        }
                    }
                }
                if (params.get("audioSampleRate") != null) {
                    int audioSampleRate = (int) params.get("audioSampleRate");
                    for (LiveTranscoding.AudioSampleRateType rateType : LiveTranscoding.AudioSampleRateType.values()) {
                        if (LiveTranscoding.AudioSampleRateType.getValue(rateType) == audioSampleRate) {
                            transcoding.audioSampleRate = rateType;
                            break;
                        }
                    }
                }
                if (params.get("watermark") != null) {
                    Map image = (Map) params.get("watermark");
                    Map watermarkMap = new HashMap();
                    watermarkMap.put("url", image.get("url"));
                    watermarkMap.put("x", image.get("x"));
                    watermarkMap.put("y", image.get("y"));
                    watermarkMap.put("width", image.get("width"));
                    watermarkMap.put("height", image.get("height"));
                    transcoding.watermark = this.createAgoraImage(watermarkMap);
                }
                if (params.get("backgroundImage") != null) {
                    Map image = (Map) params.get("backgroundImage");
                    Map backgroundImageMap = new HashMap();
                    backgroundImageMap.put("url", image.get("url"));
                    backgroundImageMap.put("x", image.get("x"));
                    backgroundImageMap.put("y", image.get("y"));
                    backgroundImageMap.put("width", image.get("width"));
                    backgroundImageMap.put("height", image.get("height"));
                    transcoding.backgroundImage = this.createAgoraImage(backgroundImageMap);
                }
                if (params.get("backgroundColor") != null) {
                    transcoding.setBackgroundColor((int) params.get("backgroundColor"));
                }
                if (params.get("audioBitrate") != null) {
                    transcoding.audioBitrate = (int) params.get("audioBitrate");
                }
                if (params.get("audioChannels") != null) {
                    transcoding.audioChannels = (int) params.get("audioChannels");
                }
                if (params.get("transcodingUsers") != null) {
                    ArrayList<LiveTranscoding.TranscodingUser> users = new ArrayList<LiveTranscoding.TranscodingUser>();
                    ArrayList transcodingUsers = (ArrayList) params.get("transcodingUsers");
                    for (int i = 0; i < transcodingUsers.size(); i++) {
                        Map optionUser = (Map) transcodingUsers.get(i);
                        LiveTranscoding.TranscodingUser user = new LiveTranscoding.TranscodingUser();
                        user.uid = (int) optionUser.get("uid");
                        user.x = (int) optionUser.get("x");
                        user.y = (int) optionUser.get("y");
                        user.width = (int) optionUser.get("width");
                        user.height = (int) optionUser.get("height");
                        user.zOrder = (int) optionUser.get("zOrder");
                        user.alpha = ((Double) optionUser.get("alpha")).floatValue();
                        user.audioChannel = (int) optionUser.get("audioChannel");
                        users.add(user);
                    }
                    transcoding.setUsers(users);
                }
                if (params.get("transcodingExtraInfo") != null) {
                    transcoding.userConfigExtraInfo = (String) params.get("transcodingExtraInfo");
                }
                result.success(mRtcEngine.setLiveTranscoding(transcoding));
            }
            break;
            case "addPublishStreamUrl": {
                String url = call.argument("url");
                boolean enable = call.argument("enable");
                result.success(mRtcEngine.addPublishStreamUrl(url, enable));
            }
            break;
            case "removePublishStreamUrl": {
                String url = call.argument("url");
                result.success(mRtcEngine.removePublishStreamUrl(url));
            }
            break;
            case "addInjectStreamUrl": {
                String url = call.argument("url");
                Map config = call.argument("config");
                LiveInjectStreamConfig streamConfig = new LiveInjectStreamConfig();
                if (config.get("width") != null && config.get("height") != null) {
                    streamConfig.width = (int) config.get("width");
                    streamConfig.height = (int) config.get("height");
                }

                if (config.get("videoGop") != null) {
                    streamConfig.videoGop = (int) config.get("videoGop");
                }

                if (config.get("videoFramerate") != null) {
                    streamConfig.videoFramerate = (int) config.get("videoFramerate");
                }

                if (config.get("videoBitrate") != null) {
                    streamConfig.videoBitrate = (int) config.get("videoBitrate");
                }

                if (config.get("audioBitrate") != null) {
                    streamConfig.audioBitrate = (int) config.get("audioBitrate");
                }

                if (config.get("audioChannels") != null) {
                    streamConfig.audioChannels = (int) config.get("audioChannels");
                }

                if (config.get("audioSampleRate") != null) {
                    int audioSampleRate = (int) config.get("audioSampleRate");
                    for (LiveInjectStreamConfig.AudioSampleRateType rateType : LiveInjectStreamConfig.AudioSampleRateType.values()) {
                        if (LiveInjectStreamConfig.AudioSampleRateType.getValue(rateType) == audioSampleRate) {
                            streamConfig.audioSampleRate = rateType;
                            break;
                        }
                    }
                }
                result.success(mRtcEngine.addInjectStreamUrl(url, streamConfig));
            }
            break;
            case "removeInjectStreamUrl": {
                String url = call.argument("url");
                result.success(mRtcEngine.removeInjectStreamUrl(url));
            }
            break;

            // Encryption
            case "setEncryptionSecret": {
                String secret = call.argument("secret");
                mRtcEngine.setEncryptionSecret(secret);
                result.success(null);
            }
            break;
            case "setEncryptionMode": {
                String encryptionMode = call.argument("encryptionMode");
                mRtcEngine.setEncryptionMode(encryptionMode);
                result.success(null);
            }
            break;

            case "startEchoTestWithInterval": {
                int interval = call.argument("interval");
                mRtcEngine.startEchoTest(interval);
                result.success(null);
            }
            break;

            case "stopEchoTest": {
                mRtcEngine.stopEchoTest();
                result.success(null);
            }
            break;

            case "enableLastmileTest": {
                mRtcEngine.enableLastmileTest();
                result.success(null);
            }
            break;

            case "disableLastmileTest": {
                mRtcEngine.disableLastmileTest();
                result.success(null);
            }
            break;

            case "startLastmileProbeTest": {
                HashMap<String, Object> probeConfig = call.argument("config");
                LastmileProbeConfig config = new LastmileProbeConfig();
                config.expectedDownlinkBitrate = (int) probeConfig.get("expectedDownlinkBitrate");
                config.expectedUplinkBitrate = (int) probeConfig.get("expectedUplinkBitrate");
                config.probeDownlink = (boolean) probeConfig.get("probeDownlink");
                config.probeUplink = (boolean) probeConfig.get("probeUplink");

                mRtcEngine.startLastmileProbeTest(config);
                result.success(null);
            }
            break;

            case "stopLastmileProbeTest": {
                mRtcEngine.stopLastmileProbeTest();
                result.success(null);
            }
            break;

            case "addVideoWatermark": {
                String encryptionMode = call.argument("encryptionMode");
                String url = call.argument("url");
                HashMap<String, Object> watermarkOptions = call.argument("options");
                HashMap<String, Object> positionLandscapeOptions = (HashMap<String, Object>) watermarkOptions.get("positionInPortraitMode");
                WatermarkOptions options = new WatermarkOptions();
                WatermarkOptions.Rectangle landscapePosition = new WatermarkOptions.Rectangle();
                landscapePosition.height = (int) positionLandscapeOptions.get("height");
                landscapePosition.width = (int) positionLandscapeOptions.get("width");
                landscapePosition.x = (int) positionLandscapeOptions.get("x");
                landscapePosition.y = (int) positionLandscapeOptions.get("y");

                HashMap<String, Object> positionPortraitOptions = (HashMap<String, Object>) watermarkOptions.get("positionInPortraitMode");
                WatermarkOptions.Rectangle portraitPosition = new WatermarkOptions.Rectangle();
                portraitPosition.height = (int) positionPortraitOptions.get("height");
                portraitPosition.width = (int) positionPortraitOptions.get("width");
                portraitPosition.x = (int) positionPortraitOptions.get("x");
                portraitPosition.y = (int) positionPortraitOptions.get("y");

                options.positionInLandscapeMode = landscapePosition;
                options.visibleInPreview = (boolean) watermarkOptions.get("visibleInPreview");
                options.positionInPortraitMode = portraitPosition;
                mRtcEngine.addVideoWatermark(url, options);
                result.success(null);
            }
            break;

            case "clearVideoWatermarks": {
                mRtcEngine.clearVideoWatermarks();
                result.success(null);
            }
            break;

            case "startAudioMixing": {
                String filepath = call.argument("filepath");
                boolean loopback = call.argument("loopback");
                boolean replace = call.argument("replace");
                int cycle = call.argument("cycle");
                mRtcEngine.startAudioMixing(filepath, loopback, replace, cycle);
                result.success(null);
            }
            break;

            case "stopAudioMixing": {
                mRtcEngine.stopAudioMixing();
                result.success(null);
            }
            break;

            case "pauseAudioMixing": {
                mRtcEngine.pauseAudioMixing();
                result.success(null);
            }
            break;

            case "resumeAudioMixing": {
                mRtcEngine.resumeAudioMixing();
                result.success(null);
            }
            break;

            case "adjustAudioMixingVolume": {
                int volume = call.argument("volume");
                mRtcEngine.adjustAudioMixingVolume(volume);
                result.success(null);
            }
            break;

            case "adjustAudioMixingPlayoutVolume": {
                int volume = call.argument("volume");
                mRtcEngine.adjustAudioMixingPlayoutVolume(volume);
                result.success(null);
            }
            break;

            case "adjustAudioMixingPublishVolume": {
                int volume = call.argument("volume");
                mRtcEngine.adjustAudioMixingPublishVolume(volume);
                result.success(null);
            }
            break;

            case "getAudioMixingPlayoutVolume": {
                int res = mRtcEngine.getAudioMixingPlayoutVolume();
                result.success(res);
            }
            break;

            case "getAudioMixingPublishVolume": {
                int res = mRtcEngine.getAudioMixingPublishVolume();
                result.success(res);
            }
            break;

            case "getAudioMixingDuration": {
                int res = mRtcEngine.getAudioMixingDuration();
                result.success(res);
            }
            break;

            case "getAudioMixingCurrentPosition": {
                int res = mRtcEngine.getAudioMixingCurrentPosition();
                result.success(res);
            }
            break;

            case "setAudioMixingPosition": {
                int pos = call.argument("pos");
                mRtcEngine.setAudioMixingPosition(pos);
                result.success(null);
            }
            break;

            case "getEffectsVolume": {
                double volume = mRtcEngine.getAudioEffectManager().getEffectsVolume();
                result.success(volume);
            }
            break;

            case "setEffectsVolume": {
                double volume = call.argument("volume");
                mRtcEngine.getAudioEffectManager().setEffectsVolume(volume);
                result.success(null);
            }
            break;

            case "setVolumeOfEffect": {
                double volume = call.argument("volume");
                int soundId = call.argument("soundId");
                mRtcEngine.getAudioEffectManager().setVolumeOfEffect(soundId, volume);
                result.success(null);
            }
            break;

            case "playEffect": {
                int soundId = call.argument("soundId");
                String filepath = call.argument("filepath");
                int loopCount = call.argument("loopCount");
                double pitch = call.argument("pitch");
                double pan = call.argument("pan");
                double gain = call.argument("gain");
                boolean publish = call.argument("publish");
                mRtcEngine.getAudioEffectManager().playEffect(soundId, filepath, loopCount, pitch, pan, gain, publish);
                result.success(null);
            }
            break;

            case "stopEffect": {
                int soundId = call.argument("soundId");
                mRtcEngine.getAudioEffectManager().stopEffect(soundId);
                result.success(null);
            }
            break;

            case "stopAllEffects": {
                mRtcEngine.getAudioEffectManager().stopAllEffects();
                result.success(null);
            }
            break;

            case "preloadEffect": {
                int soundId = call.argument("soundId");
                String filepath = call.argument("filepath");
                mRtcEngine.getAudioEffectManager().preloadEffect(soundId, filepath);
                result.success(null);
            }
            break;

            case "unloadEffect": {
                int soundId = call.argument("soundId");
                mRtcEngine.getAudioEffectManager().unloadEffect(soundId);
                result.success(null);
            }
            break;

            case "pauseEffect": {
                int soundId = call.argument("soundId");
                mRtcEngine.getAudioEffectManager().pauseEffect(soundId);
                result.success(null);
            }
            break;

            case "pauseAllEffects": {
                mRtcEngine.getAudioEffectManager().pauseAllEffects();
                result.success(null);
            }
            break;

            case "resumeEffect": {
                int soundId = call.argument("soundId");
                mRtcEngine.getAudioEffectManager().resumeEffect(soundId);
                result.success(null);
            }
            break;

            case "resumeAllEffects": {
                mRtcEngine.getAudioEffectManager().resumeAllEffects();
                result.success(null);
            }
            break;

            case "startChannelMediaRelay": {
                ChannelMediaRelayConfiguration config = new ChannelMediaRelayConfiguration();
                ChannelMediaInfo src = config.getSrcChannelMediaInfo();
                HashMap<String, Object> options = call.argument("config");
                if (options.get("src") != null) {
                    HashMap<String, Object> srcOption = (HashMap<String, Object>) options.get("src");
                    if (srcOption.get("token") != null) {
                        src.token = (String) srcOption.get("token");
                    }
                    if (srcOption.get("channelName") != null) {
                        src.channelName = (String) srcOption.get("channelName");
                    }
                }
                List<HashMap<String, Object>> dstMediaInfo = (List) options.get("channels");
                for (int i = 0; i < dstMediaInfo.size(); i++) {
                    HashMap<String, Object> dst = dstMediaInfo.get(i);
                    String channelName = null;
                    String token = null;
                    Integer uid = 0;
                    if (dst.get("token") != null) {
                        token = token;
                    }
                    if (dst.get("channelName") != null) {
                        channelName = (String) dst.get("channelName");
                    }
                    if (dst.get("uid") != null) {
                        uid = (int) dst.get("uid");
                    }
                    config.setDestChannelInfo(channelName, new ChannelMediaInfo(channelName, token, uid));
                }
                mRtcEngine.startChannelMediaRelay(config);
                result.success(null);
            }
            break;

            case "removeChannelMediaRelay": {
                ChannelMediaRelayConfiguration config = new ChannelMediaRelayConfiguration();
                ChannelMediaInfo src = config.getSrcChannelMediaInfo();
                HashMap<String, Object> options = call.argument("config");
                if (options.get("src") != null) {
                    HashMap<String, Object> srcOption = (HashMap<String, Object>) options.get("src");
                    if (srcOption.get("token") != null) {
                        src.token = (String) srcOption.get("token");
                    }
                    if (srcOption.get("channelName") != null) {
                        src.channelName = (String) srcOption.get("channelName");
                    }
                }
                List<HashMap<String, Object>> dstMediaInfo = (List) options.get("channels");
                for (int i = 0; i < dstMediaInfo.size(); i++) {
                    HashMap<String, Object> dst = dstMediaInfo.get(i);
                    String channelName = null;
                    if (dst.get("channelName") != null) {
                        channelName = (String) dst.get("channelName");
                    }
                    config.removeDestChannelInfo(channelName);
                }
                mRtcEngine.updateChannelMediaRelay(config);
                result.success(null);
            }
            break;

            case "updateChannelMediaRelay": {
                ChannelMediaRelayConfiguration config = new ChannelMediaRelayConfiguration();
                ChannelMediaInfo src = config.getSrcChannelMediaInfo();
                HashMap<String, Object> options = call.argument("config");
                if (options.get("src") != null) {
                    HashMap<String, Object> srcOption = (HashMap<String, Object>) options.get("src");
                    if (srcOption.get("token") != null) {
                        src.token = (String) srcOption.get("token");
                    }
                    if (srcOption.get("channelName") != null) {
                        src.channelName = (String) srcOption.get("channelName");
                    }
                }
                List<HashMap<String, Object>> dstMediaInfo = (List) options.get("channels");
                for (int i = 0; i < dstMediaInfo.size(); i++) {
                    HashMap<String, Object> dst = dstMediaInfo.get(i);
                    String channelName = null;
                    String token = null;
                    Integer uid = 0;
                    if (dst.get("token") != null) {
                        token = token;
                    }
                    if (dst.get("channelName") != null) {
                        channelName = (String) dst.get("channelName");
                    }
                    if (dst.get("uid") != null) {
                        uid = (int) dst.get("uid");
                    }
                    config.setDestChannelInfo(channelName, new ChannelMediaInfo(channelName, token, uid));
                }
                mRtcEngine.updateChannelMediaRelay(config);
                result.success(null);
            }
            break;

            case "stopChannelMediaRelay": {
                mRtcEngine.stopChannelMediaRelay();
                result.success(null);
            }
            break;

            case "enableInEarMonitoring": {
                boolean enabled = call.argument("enabled");
                mRtcEngine.enableInEarMonitoring(enabled);
                result.success(null);
            }
            break;

            case "setInEarMonitoringVolume": {
                int volume = call.argument("volume");
                mRtcEngine.setInEarMonitoringVolume(volume);
                result.success(null);
            }
            break;

            // Camera Control
            case "switchCamera": {
                mRtcEngine.switchCamera();
                result.success(null);
            }
            break;

            // Miscellaneous Methods
            case "getSdkVersion": {
                String version = RtcEngine.getSdkVersion();
                result.success(version);
            }
            break;

            case "setLogFile": {
                String filePath = call.argument("filePath");
                mRtcEngine.setLogFile(filePath);
                result.success(null);
            }
            break;

            case "setLogFilter": {
                int filter = call.argument("filter");
                mRtcEngine.setLogFilter(filter);
                result.success(null);
            }
            break;

            case "setLogFileSize": {
                int fileSizeInKBytes = call.argument("fileSizeInKBytes");
                mRtcEngine.setLogFileSize(fileSizeInKBytes);
                result.success(null);
            }
            break;

            case "setParameters": {
                String params = call.argument("params");
                int res = mRtcEngine.setParameters(params);
                result.success(res);
            }
            break;

            case "getParameters": {
                String params = call.argument("params");
                String args = call.argument("args");
                String res = mRtcEngine.getParameter(params, args);
                result.success(res);
            }
            break;

            default:
                result.notImplemented();
        }
    }

    private VideoEncoderConfiguration.ORIENTATION_MODE orientationFromValue(int value) {
        switch (value) {
            case 0:
                return VideoEncoderConfiguration.ORIENTATION_MODE.ORIENTATION_MODE_ADAPTIVE;
            case 1:
                return VideoEncoderConfiguration.ORIENTATION_MODE.ORIENTATION_MODE_FIXED_LANDSCAPE;
            case 2:
                return VideoEncoderConfiguration.ORIENTATION_MODE.ORIENTATION_MODE_FIXED_PORTRAIT;
            default:
                return VideoEncoderConfiguration.ORIENTATION_MODE.ORIENTATION_MODE_ADAPTIVE;
        }
    }

    private final IRtcEngineEventHandler mRtcEventHandler = new IRtcEngineEventHandler() {
        @Override
        public void onWarning(int warn) {
            super.onWarning(warn);
            HashMap<String, Object> map = new HashMap<>();
            map.put("warn", warn);
            sendEvent("onWarning", map);
        }

        @Override
        public void onError(int err) {
            super.onError(err);
            HashMap<String, Object> map = new HashMap<>();
            map.put("errorCode", err);
            sendEvent("onError", map);
        }

        @Override
        public void onJoinChannelSuccess(String channel, int uid, int elapsed) {
            super.onJoinChannelSuccess(channel, uid, elapsed);
            HashMap<String, Object> map = new HashMap<>();
            map.put("channel", channel);
            map.put("uid", uid);
            map.put("elapsed", elapsed);
            sendEvent("onJoinChannelSuccess", map);
        }

        @Override
        public void onRejoinChannelSuccess(String channel, int uid, int elapsed) {
            super.onRejoinChannelSuccess(channel, uid, elapsed);
            HashMap<String, Object> map = new HashMap<>();
            map.put("channel", channel);
            map.put("uid", uid);
            map.put("elapsed", elapsed);
            sendEvent("onRejoinChannelSuccess", map);
        }

        @Override
        public void onLeaveChannel(RtcStats stats) {
            super.onLeaveChannel(stats);
            HashMap<String, Object> map = new HashMap<>();
            map.put("stats", mapFromStats(stats));
            sendEvent("onLeaveChannel", map);
        }

        @Override
        public void onClientRoleChanged(int oldRole, int newRole) {
            super.onClientRoleChanged(oldRole, newRole);
            HashMap<String, Object> map = new HashMap<>();
            map.put("oldRole", oldRole);
            map.put("newRole", newRole);
            sendEvent("onClientRoleChanged", map);
        }

        @Override
        public void onUserJoined(int uid, int elapsed) {
            super.onUserJoined(uid, elapsed);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("elapsed", elapsed);
            sendEvent("onUserJoined", map);
        }

        @Override
        public void onUserOffline(int uid, int reason) {
            super.onUserOffline(uid, reason);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("reason", reason);
            sendEvent("onUserOffline", map);
        }

        @Override
        public void onLocalUserRegistered(int uid, String userAccount) {
            super.onLocalUserRegistered(uid, userAccount);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("userAccount", userAccount);
            sendEvent("onRegisteredLocalUser", map);
        }

        @Override
        public void onUserInfoUpdated(int uid, UserInfo userInfo) {
            super.onUserInfoUpdated(uid, userInfo);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            HashMap<String, Object> userInfoMap = new HashMap<>();
            userInfoMap.put("uid", userInfo.uid);
            userInfoMap.put("userAccount", userInfo.userAccount);
            map.put("userInfo", userInfoMap);
            sendEvent("onUpdatedUserInfo", map);
        }

        @Override
        public void onConnectionStateChanged(int state, int reason) {
            super.onConnectionStateChanged(state, reason);
            HashMap<String, Object> map = new HashMap<>();
            map.put("state", state);
            map.put("reason", reason);
            sendEvent("onConnectionStateChanged", map);
        }

        @Override
        public void onNetworkTypeChanged(int type) {
            super.onNetworkTypeChanged(type);
            HashMap<String, Object> map = new HashMap<>();
            map.put("type", type);
            sendEvent("onNetworkTypeChanged", map);
        }

        @Override
        public void onConnectionLost() {
            super.onConnectionLost();
            sendEvent("onConnectionLost", null);
        }

        @Override
        public void onApiCallExecuted(int error, String api, String result) {
            super.onApiCallExecuted(error, api, result);
            HashMap<String, Object> map = new HashMap<>();
            map.put("errorCode", error);
            map.put("api", api);
            map.put("result", result);
            sendEvent("onApiCallExecuted", map);
        }

        @Override
        public void onTokenPrivilegeWillExpire(String token) {
            super.onTokenPrivilegeWillExpire(token);
            HashMap<String, Object> map = new HashMap<>();
            map.put("token", token);
            sendEvent("onTokenPrivilegeWillExpire", map);
        }

        @Override
        public void onRequestToken() {
            super.onRequestToken();
            sendEvent("onRequestToken", null);
        }

        @Override
        public void onAudioVolumeIndication(AudioVolumeInfo[] speakers, int totalVolume) {
            super.onAudioVolumeIndication(speakers, totalVolume);
            HashMap<String, Object> map = new HashMap<>();
            map.put("totalVolume", totalVolume);
            map.put("speakers", arrayFromSpeakers(speakers));
            sendEvent("onAudioVolumeIndication", map);
        }

        @Override
        public void onActiveSpeaker(int uid) {
            super.onActiveSpeaker(uid);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            sendEvent("onActiveSpeaker", map);
        }

        @Override
        public void onFirstLocalAudioFrame(int elapsed) {
            super.onFirstLocalAudioFrame(elapsed);
            HashMap<String, Object> map = new HashMap<>();
            map.put("elapsed", elapsed);
            sendEvent("onFirstLocalAudioFrame", map);
        }

        @Override
        public void onFirstRemoteAudioFrame(int uid, int elapsed) {
            super.onFirstRemoteAudioFrame(uid, elapsed);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("elapsed", elapsed);
            sendEvent("onFirstRemoteAudioFrame", map);
        }

        @Override
        public void onFirstRemoteAudioDecoded(int uid, int elapsed) {
            super.onFirstRemoteAudioDecoded(uid, elapsed);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("elapsed", elapsed);
            sendEvent("onFirstRemoteAudioDecoded", map);
        }

        @Override
        public void onFirstLocalVideoFrame(int width, int height, int elapsed) {
            super.onFirstLocalVideoFrame(width, height, elapsed);
            HashMap<String, Object> map = new HashMap<>();
            map.put("width", width);
            map.put("height", height);
            map.put("elapsed", elapsed);
            sendEvent("onFirstLocalVideoFrame", map);
        }

        @Override
        public void onFirstRemoteVideoFrame(int uid, int width, int height, int elapsed) {
            super.onFirstRemoteVideoFrame(uid, width, height, elapsed);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("width", width);
            map.put("height", height);
            map.put("elapsed", elapsed);
            sendEvent("onFirstRemoteVideoFrame", map);
        }

        @Override
        public void onUserMuteAudio(int uid, boolean muted) {
            super.onUserMuteAudio(uid, muted);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("muted", muted);
            sendEvent("onUserMuteAudio", map);
        }

//        @Override
//        public void onUserMuteVideo(int uid , boolean muted) {
//            super.onUserMuteAudio(uid , muted);
//            HashMap<String, Object> map = new HashMap<>();
//            map.put("uid" , uid);
//            map.put("muted" , muted);
//            sendEvent("onUserMuteVideo" , map);
//        }

        @Override
        public void onVideoSizeChanged(int uid, int width, int height, int rotation) {
            super.onVideoSizeChanged(uid, width, height, rotation);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("width", width);
            map.put("height", height);
            map.put("rotation", rotation);
            sendEvent("onVideoSizeChanged", map);
        }

        @Override
        public void onRemoteVideoStateChanged(int uid,
                                              int state,
                                              int reason,
                                              int elapsed) {
            super.onRemoteVideoStateChanged(uid, state, reason, elapsed);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("state", state);
            map.put("reason", reason);
            map.put("elapsed", elapsed);
            sendEvent("onRemoteVideoStateChanged", map);
        }

        @Override
        public void onLocalVideoStateChanged(int state, int error) {
            super.onLocalVideoStateChanged(state, error);
            HashMap<String, Object> map = new HashMap<>();
            map.put("localVideoState", state);
            map.put("errorCode", error);
            sendEvent("onLocalVideoStateChanged", map);
        }

        @Override
        public void onRemoteAudioStateChanged(int uid, int state, int reason, int elapsed) {
            super.onRemoteAudioStateChanged(uid, state, reason, elapsed);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("state", state);
            map.put("reason", reason);
            map.put("elapsed", elapsed);
            sendEvent("onRemoteAudioStateChanged", map);
        }

        @Override
        public void onLocalAudioStateChanged(int state, int error) {
            super.onLocalAudioStateChanged(state, error);
            HashMap<String, Object> map = new HashMap<>();
            map.put("state", state);
            map.put("errorCode", error);
            sendEvent("onLocalAudioStateChanged", map);
        }

        @Override
        public void onLocalPublishFallbackToAudioOnly(boolean isFallbackOrRecover) {
            super.onLocalPublishFallbackToAudioOnly(isFallbackOrRecover);
            HashMap<String, Object> map = new HashMap<>();
            map.put("isFallbackOrRecover", isFallbackOrRecover);
            sendEvent("onLocalPublishFallbackToAudioOnly", map);
        }

        @Override
        public void onRemoteSubscribeFallbackToAudioOnly(int uid, boolean isFallbackOrRecover) {
            super.onRemoteSubscribeFallbackToAudioOnly(uid, isFallbackOrRecover);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("isFallbackOrRecover", isFallbackOrRecover);
            sendEvent("onRemoteSubscribeFallbackToAudioOnly", map);
        }

        @Override
        public void onAudioRouteChanged(int routing) {
            super.onAudioRouteChanged(routing);
            HashMap<String, Object> map = new HashMap<>();
            map.put("routing", routing);
            sendEvent("onAudioRouteChanged", map);
        }

        @Override
        public void onCameraFocusAreaChanged(Rect rect) {
            super.onCameraFocusAreaChanged(rect);
            HashMap<String, Object> map = new HashMap<>();
            map.put("rect", mapFromRect(rect));
            sendEvent("onCameraFocusAreaChanged", map);
        }

        @Override
        public void onCameraExposureAreaChanged(Rect rect) {
            super.onCameraExposureAreaChanged(rect);
            HashMap<String, Object> map = new HashMap<>();
            map.put("rect", mapFromRect(rect));
            sendEvent("onCameraExposureAreaChanged", map);
        }

        @Override
        public void onRtcStats(RtcStats stats) {
            super.onRtcStats(stats);
            HashMap<String, Object> map = new HashMap<>();
            map.put("stats", mapFromStats(stats));
            sendEvent("onRtcStats", map);
        }

        @Override
        public void onLastmileQuality(int quality) {
            super.onLastmileQuality(quality);
            HashMap<String, Object> map = new HashMap<>();
            map.put("quality", quality);
            sendEvent("onLastmileQuality", map);
        }

        @Override
        public void onNetworkQuality(int uid, int txQuality, int rxQuality) {
            super.onNetworkQuality(uid, txQuality, rxQuality);
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", uid);
            map.put("txQuality", txQuality);
            map.put("rxQuality", rxQuality);
            sendEvent("onNetworkQuality", map);
        }

        @Override
        public void onLastmileProbeResult(LastmileProbeResult result) {
            super.onLastmileProbeResult(result);
            HashMap<String, Object> map = new HashMap<>();
            map.put("state", result.state);
            map.put("rtt", result.rtt);
            HashMap<String, Object> uplinkReport = new HashMap<>();
            map.put("uplinkReport", uplinkReport);
            uplinkReport.put("availableBandwidth", result.uplinkReport.availableBandwidth);
            uplinkReport.put("jitter", result.uplinkReport.jitter);
            uplinkReport.put("packetLossRate", result.uplinkReport.packetLossRate);
            HashMap<String, Object> downlinkReport = new HashMap<>();
            map.put("downlinkReport", downlinkReport);
            uplinkReport.put("availableBandwidth", result.downlinkReport.availableBandwidth);
            uplinkReport.put("jitter", result.downlinkReport.jitter);
            uplinkReport.put("packetLossRate", result.downlinkReport.packetLossRate);
            sendEvent("onLastmileProbeTestResult", map);
        }

        @Override
        public void onLocalVideoStats(LocalVideoStats stats) {
            super.onLocalVideoStats(stats);
            HashMap<String, Object> map = new HashMap<>();
            map.put("stats", mapFromLocalVideoStats(stats));
            sendEvent("onLocalVideoStats", map);
        }

        @Override
        public void onLocalAudioStats(LocalAudioStats stats) {
            super.onLocalAudioStats(stats);
            HashMap<String, Object> map = new HashMap<>();
            map.put("stats", mapFromLocalAudioStats(stats));
            sendEvent("onLocalAudioStats", map);
        }

        @Override
        public void onRemoteVideoStats(RemoteVideoStats stats) {
            super.onRemoteVideoStats(stats);
            HashMap<String, Object> map = new HashMap<>();
            map.put("stats", mapFromRemoteVideoStats(stats));
            sendEvent("onRemoteVideoStats", map);
        }

        @Override
        public void onRemoteAudioStats(RemoteAudioStats stats) {
            super.onRemoteAudioStats(stats);
            HashMap<String, Object> map = new HashMap<>();
            map.put("stats", mapFromRemoteAudioStats(stats));
            sendEvent("onRemoteAudioStats", map);
        }

        @Override
        public void onAudioMixingStateChanged(int state, int errorCode) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("state", state);
            map.put("errorCode", errorCode);

            sendEvent("onLocalAudioMixingStateChanged", map);
        }

        @Override
        public void onAudioEffectFinished(int soundId) {
            super.onAudioEffectFinished(soundId);
            HashMap<String, Object> map = new HashMap<>();
            map.put("soundId", soundId);
            sendEvent("onAudioEffectFinished", map);
        }

        @Override
        public void onStreamPublished(String url, int error) {
            super.onStreamPublished(url, error);
            HashMap<String, Object> map = new HashMap<>();
            map.put("url", url);
            map.put("errorCode", error);
            sendEvent("onStreamPublished", map);
        }

        @Override
        public void onStreamUnpublished(String url) {
            super.onStreamUnpublished(url);
            HashMap<String, Object> map = new HashMap<>();
            map.put("url", url);
            sendEvent("onStreamUnpublished", map);
        }

        @Override
        public void onTranscodingUpdated() {
            super.onTranscodingUpdated();
            sendEvent("onTranscodingUpdated", null);
        }

        @Override
        public void onRtmpStreamingStateChanged(String url,
                                                int state,
                                                int errCode) {
            super.onRtmpStreamingStateChanged(url, state, errCode);
            HashMap<String, Object> map = new HashMap<>();
            map.put("url", url);
            map.put("state", state);
            map.put("errorCode", errCode);
            sendEvent("onRtmpStreamingStateChanged", map);
        }


        @Override
        public void onStreamInjectedStatus(String url, int uid, int status) {
            super.onStreamInjectedStatus(url, uid, status);
            HashMap<String, Object> map = new HashMap<>();
            map.put("url", url);
            map.put("uid", uid);
            map.put("status", status);
            sendEvent("onStreamInjectedStatus", map);
        }

        @Override
        public void onMediaEngineLoadSuccess() {
            super.onMediaEngineLoadSuccess();
            sendEvent("onMediaEngineLoadSuccess", null);
        }

        @Override
        public void onMediaEngineStartCallSuccess() {
            super.onMediaEngineStartCallSuccess();
            sendEvent("onMediaEngineStartCallSuccess", null);
        }

        @Override
        public void onChannelMediaRelayStateChanged(int state, int code) {
            super.onChannelMediaRelayStateChanged(state, code);
            HashMap<String, Object> map = new HashMap<>();
            map.put("state", state);
            map.put("errorCode", code);
            sendEvent("onChannelMediaRelayChanged", map);
        }

        @Override
        public void onChannelMediaRelayEvent(int code) {
            super.onChannelMediaRelayEvent(code);
            HashMap<String, Object> map = new HashMap<>();
            map.put("event", code);
            sendEvent("onReceivedChannelMediaRelayEvent", map);
        }

//        @Override
//        public void onAudioMixingFinished() {
//            super.onAudioMixingFinished();
//            sendEvent("onAudioMixingFinished", null);
//        }

        private HashMap<String, Object> mapFromStats(RtcStats stats) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("totalDuration", stats.totalDuration);
            map.put("txBytes", stats.txBytes);
            map.put("rxBytes", stats.rxBytes);
            map.put("txAudioBytes", stats.txAudioBytes);
            map.put("txVideoBytes", stats.txVideoBytes);
            map.put("rxAudioBytes", stats.rxAudioBytes);
            map.put("rxVideoBytes", stats.rxVideoBytes);
            map.put("txKBitrate", stats.txKBitRate);
            map.put("rxKBitrate", stats.rxKBitRate);
            map.put("txAudioKBitrate", stats.txAudioKBitRate);
            map.put("rxAudioKBitrate", stats.rxAudioKBitRate);
            map.put("txVideoKBitrate", stats.txVideoKBitRate);
            map.put("rxVideoKBitrate", stats.rxVideoKBitRate);
            map.put("lastmileDelay", stats.lastmileDelay);
            map.put("txPacketLossRate", stats.txPacketLossRate);
            map.put("rxPacketLossRate", stats.rxPacketLossRate);
            map.put("users", stats.users);
            map.put("cpuAppUsage", stats.cpuAppUsage);
            map.put("cpuTotalUsage", stats.cpuTotalUsage);
            return map;
        }

        private HashMap<String, Object> mapFromRect(Rect rect) {
            HashMap<String, Object> map = new HashMap<>();

            map.put("x", rect.left);
            map.put("y", rect.top);
            map.put("width", rect.width());
            map.put("height", rect.height());
            return map;
        }

        private HashMap<String, Object> mapFromLocalVideoStats(LocalVideoStats stats) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("sentBitrate", stats.sentBitrate);
            map.put("sentFrameRate", stats.sentFrameRate);
            map.put("encoderOutputFrameRate", stats.encoderOutputFrameRate);
            map.put("rendererOutputFrameRate", stats.rendererOutputFrameRate);
            map.put("sentTargetBitrate", stats.targetBitrate);
            map.put("sentTargetFrameRate", stats.targetFrameRate);
            map.put("qualityAdaptIndication", stats.targetBitrate);
            map.put("encodedBitrate", stats.targetBitrate);
            map.put("encodedFrameWidth", stats.targetBitrate);
            map.put("encodedFrameHeight", stats.encodedFrameHeight);
            map.put("encodedFrameCount", stats.encodedFrameCount);
            map.put("codecType", stats.codecType);
            return map;
        }

        private HashMap<String, Object> mapFromLocalAudioStats(LocalAudioStats stats) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("numChannels", stats.numChannels);
            map.put("sentSampleRate", stats.sentSampleRate);
            map.put("sentBitrate", stats.sentBitrate);
            return map;
        }

        private HashMap<String, Object> mapFromRemoteVideoStats(RemoteVideoStats stats) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", stats.uid);
            map.put("width", stats.width);
            map.put("height", stats.height);
            map.put("receivedBitrate", stats.receivedBitrate);
            map.put("decoderOutputFrameRate", stats.decoderOutputFrameRate);
            map.put("rendererOutputFrameRate", stats.rendererOutputFrameRate);
            map.put("packetLossRate", stats.packetLossRate);
            map.put("rxStreamType", stats.rxStreamType);
            map.put("totalFrozenTime", stats.totalFrozenTime);
            map.put("frozenRate", stats.frozenRate);
            return map;
        }

        private HashMap<String, Object> mapFromRemoteAudioStats(RemoteAudioStats stats) {
            HashMap<String, Object> map = new HashMap<>();
            map.put("uid", stats.uid);
            map.put("quality", stats.quality);
            map.put("networkTransportDelay", stats.networkTransportDelay);
            map.put("jitterBufferDelay", stats.jitterBufferDelay);
            map.put("audioLossRate", stats.audioLossRate);
            map.put("numChannels", stats.numChannels);
            map.put("receivedSampleRate", stats.receivedSampleRate);
            map.put("receivedBitrate", stats.receivedBitrate);
            map.put("totalFrozenTime", stats.totalFrozenTime);
            map.put("frozenRate", stats.frozenRate);
            return map;
        }

        private ArrayList<HashMap<String, Object>> arrayFromSpeakers(AudioVolumeInfo[] speakers) {
            ArrayList<HashMap<String, Object>> list = new ArrayList<>();

            for (AudioVolumeInfo info : speakers) {
                HashMap<String, Object> map = new HashMap<>();
                map.put("uid", info.uid);
                map.put("volume", info.volume);

                list.add(map);
            }

            return list;
        }
    };

    private BeautyOptions beautyOptionsFromMap(HashMap<String, Object> map) {
        BeautyOptions options = new BeautyOptions();
        options.lighteningContrastLevel =
                ((Double) (map.get("lighteningContrastLevel"))).intValue();
        options.lighteningLevel = ((Double) (map.get("lighteningLevel"))).floatValue();
        options.smoothnessLevel = ((Double) (map.get("smoothnessLevel"))).floatValue();
        options.rednessLevel = ((Double) (map.get("rednessLevel"))).floatValue();
        return options;
    }

    private VideoEncoderConfiguration videoEncoderConfigurationFromMap(HashMap<String, Object> map) {
        int width = (int) (map.get("width"));
        int height = (int) (map.get("height"));
        int frameRate = (int) (map.get("frameRate"));
        int bitrate = (int) (map.get("bitrate"));
        int minBitrate = (int) (map.get("minBitrate"));
        int orientationMode = (int) (map.get("orientationMode"));

        VideoEncoderConfiguration configuration = new VideoEncoderConfiguration();
        configuration.dimensions = new VideoEncoderConfiguration.VideoDimensions(width, height);
        configuration.frameRate = frameRate;
        configuration.bitrate = bitrate;
        configuration.minBitrate = minBitrate;
        configuration.orientationMode = orientationFromValue(orientationMode);

        return configuration;
    }

    private void sendEvent(final String eventName, final HashMap map) {
        map.put("event", eventName);
        mEventHandler.post(new Runnable() {
            @Override
            public void run() {
                if (sink != null) {
                    sink.success(map);
                }
            }
        });
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        this.sink = eventSink;
    }

    @Override
    public void onCancel(Object o) {
        this.sink = null;
    }

    private static class MethodResultWrapper implements MethodChannel.Result {
        private MethodChannel.Result mResult;
        private Handler mHandler;

        MethodResultWrapper(MethodChannel.Result result, Handler handler) {
            this.mResult = result;
            this.mHandler = handler;
        }

        @Override
        public void success(final Object result) {
            mHandler.post(new Runnable() {
                @Override
                public void run() {
                    mResult.success(result);
                }
            });
        }

        @Override
        public void error(final String errorCode, final String errorMessage,
                          final Object errorDetails) {
            mHandler.post(new Runnable() {
                @Override
                public void run() {
                    mResult.error(errorCode, errorMessage, errorDetails);
                }
            });
        }

        @Override
        public void notImplemented() {
            mHandler.post(new Runnable() {
                @Override
                public void run() {
                    mResult.notImplemented();
                }
            });
        }
    }
}
