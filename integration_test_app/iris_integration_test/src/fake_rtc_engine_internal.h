#ifndef FAKE_RTC_ENGINE_INTERNAL_H_
#define FAKE_RTC_ENGINE_INTERNAL_H_

#include "IAgoraRtcEngine2.h"

namespace agora {
    namespace rtc {

        class FakeChannelInternal : public agora::rtc::IChannel {
        public:
            ~FakeChannelInternal() override {}

            virtual int release() override { return 0; }

            virtual int setChannelEventHandler(IChannelEventHandler *channelEh) override {
                return 0;
            }

            int joinChannel(const char *token, const char *info, uid_t uid,
                            const ChannelMediaOptions &options) override {
                return 0;
            }

            int joinChannelWithUserAccount(const char *token, const char *userAccount,
                                           const ChannelMediaOptions &options) override {
                return 0;
            }

            int leaveChannel() override { return 0; }

            int publish() override { return 0; }

            int unpublish() override { return 0; }

            const char *channelId() override { return "testapi"; }

            int getCallId(util::AString &callId) override { return 0; }

            int renewToken(const char *token) override { return 0; }

            int setEncryptionSecret(const char *secret) override { return 0; }

            int setEncryptionMode(const char *encryptionMode) override { return 0; }

            int enableEncryption(bool enabled, const EncryptionConfig &config) override {
                return 0;
            }

            int registerPacketObserver(IPacketObserver *observer) override { return 0; }

            int registerMediaMetadataObserver(
                    IMetadataObserver *observer,
                    IMetadataObserver::METADATA_TYPE type) override {
                return 0;
            }

            int setClientRole(CLIENT_ROLE_TYPE role) override { return 0; }

            int setClientRole(CLIENT_ROLE_TYPE role,
                              const ClientRoleOptions &options) override {
                return 0;
            }

            int setRemoteUserPriority(uid_t uid, PRIORITY_TYPE userPriority) override {
                return 0;
            }

            int setRemoteVoicePosition(uid_t uid, double pan, double gain) override {
                return 0;
            }

            int setRemoteRenderMode(uid_t userId, RENDER_MODE_TYPE renderMode,
                                    VIDEO_MIRROR_MODE_TYPE mirrorMode) override {
                return 0;
            }

            int setDefaultMuteAllRemoteAudioStreams(bool mute) override { return 0; }

            int setDefaultMuteAllRemoteVideoStreams(bool mute) override { return 0; }

            int muteLocalAudioStream(bool mute) override { return 0; }

            int muteLocalVideoStream(bool mute) override { return 0; }

            int muteAllRemoteAudioStreams(bool mute) override { return 0; }

            int adjustUserPlaybackSignalVolume(uid_t userId, int volume) override {
                return 0;
            }

            int muteRemoteAudioStream(uid_t userId, bool mute) override { return 0; }

            int muteAllRemoteVideoStreams(bool mute) override { return 0; }

            int muteRemoteVideoStream(uid_t userId, bool mute) override { return 0; }

            int setRemoteVideoStreamType(uid_t userId,
                                         REMOTE_VIDEO_STREAM_TYPE streamType) override {
                return 0;
            }

            int setRemoteDefaultVideoStreamType(
                    REMOTE_VIDEO_STREAM_TYPE streamType) override {
                return 0;
            }

            virtual int createDataStream(int *streamId, bool reliable, bool ordered) override {
                return 0;
            }

            virtual int createDataStream(int *streamId, DataStreamConfig &config) override {
                return 0;
            }

            int sendStreamMessage(int streamId, const char *data,
                                  size_t length) override {
                return 0;
            }

            int addPublishStreamUrl(const char *url, bool transcodingEnabled) override {
                return 0;
            }

            int removePublishStreamUrl(const char *url) override { return 0; }

            int setLiveTranscoding(const LiveTranscoding &transcoding) override {
                return 0;
            }

            int addInjectStreamUrl(const char *url,
                                   const InjectStreamConfig &config) override {
                return 0;
            }

            int removeInjectStreamUrl(const char *url) override { return 0; }

            int startChannelMediaRelay(
                    const ChannelMediaRelayConfiguration &configuration) override {
                return 0;
            }

            int updateChannelMediaRelay(
                    const ChannelMediaRelayConfiguration &configuration) override {
                return 0;
            }

            int pauseAllChannelMediaRelay() override { return 0; }

            int resumeAllChannelMediaRelay() override { return 0; }

            int stopChannelMediaRelay() override { return 0; }

            CONNECTION_STATE_TYPE getConnectionState() override {
                return CONNECTION_STATE_CONNECTING;
            }

            int enableRemoteSuperResolution(uid_t userId, bool enable) override {
                return 0;
            }

            int setAVSyncSource(const char *channelId, uid_t uid) override {
                return 0;
            }

            int startRtmpStreamWithoutTranscoding(const char *url) override {
                return 0;
            }

            int
            startRtmpStreamWithTranscoding(const char *url,
                                           const LiveTranscoding &transcoding) override {
                return 0;
            }

            int updateRtmpTranscoding(const LiveTranscoding &transcoding) override {
                return 0;
            }

            int stopRtmpStream(const char *url) override {
                return 0;
            }
        };

        class FakeRtcEngineInternal : public IRtcEngine3 {
        public:
            int setVideoProfileEx(int width, int height, int frameRate,
                                  int bitrate) override {
                return 0;
            }

            int setAppType(AppType appType) override { return 0; }

        public:
            virtual IChannel *createChannel(const char *channelId) override {
                return new FakeChannelInternal();
            }

        public:
            int initialize(const RtcEngineContext &context) override { return 0; }

            int setChannelProfile(CHANNEL_PROFILE_TYPE profile) override { return 0; }

            int setClientRole(CLIENT_ROLE_TYPE role) override { return 0; }

            int setClientRole(CLIENT_ROLE_TYPE role,
                              const ClientRoleOptions &options) override {
                return 0;
            }

            int joinChannel(const char *token, const char *channelId, const char *info,
                            uid_t uid) override {
                return 0;
            }

            int joinChannel(const char *token, const char *channelId, const char *info,
                            uid_t uid, const ChannelMediaOptions &options) override {
                return 0;
            }

            int switchChannel(const char *token, const char *channelId) override {
                return 0;
            }

            int switchChannel(const char *token, const char *channelId,
                              const ChannelMediaOptions &options) override {
                return 0;
            }

            int leaveChannel() override { return 0; }

            int renewToken(const char *token) override { return 0; }

            int queryInterface(INTERFACE_ID_TYPE iid, void **inter) override { return 0; }

            int registerLocalUserAccount(const char *appId,
                                         const char *userAccount) override {
                return 0;
            }

            int joinChannelWithUserAccount(const char *token, const char *channelId,
                                           const char *userAccount) override {
                return 0;
            }

            int joinChannelWithUserAccount(const char *token, const char *channelId,
                                           const char *userAccount,
                                           const ChannelMediaOptions &options) override {
                return 0;
            }

            int getUserInfoByUserAccount(const char *userAccount,
                                         UserInfo *userInfo) override {
                return 0;
            }

            int getUserInfoByUid(uid_t uid, UserInfo *userInfo) override { return 0; }

            int startEchoTest() override { return 0; }

            int startEchoTest(int intervalInSeconds) override { return 0; }

            int startEchoTest(const EchoTestConfiguration &config) override { return 0; }

            int stopEchoTest() override { return 0; }

            int setCloudProxy(CLOUD_PROXY_TYPE proxyType) override { return 0; }

            int enableVideo() override { return 0; }

            int disableVideo() override { return 0; }

            int setVideoProfile(VIDEO_PROFILE_TYPE profile,
                                bool swapWidthAndHeight) override {
                return 0;
            }

            int setVideoEncoderConfiguration(
                    const VideoEncoderConfiguration &config) override {
                return 0;
            }

            int setCameraCapturerConfiguration(
                    const CameraCapturerConfiguration &config) override {
                return 0;
            }

            int setupLocalVideo(const VideoCanvas &canvas) override { return 0; }

            int setupRemoteVideo(const VideoCanvas &canvas) override { return 0; }

            int startPreview() override { return 0; }

            int setRemoteUserPriority(uid_t uid, PRIORITY_TYPE userPriority) override {
                return 0;
            }

            int stopPreview() override { return 0; }

            int enableAudio() override { return 0; }

            int enableLocalAudio(bool enabled) override { return 0; }

            int disableAudio() override { return 0; }

            int setAudioProfile(AUDIO_PROFILE_TYPE profile,
                                AUDIO_SCENARIO_TYPE scenario) override {
                return 0;
            }

            int muteLocalAudioStream(bool mute) override { return 0; }

            int muteAllRemoteAudioStreams(bool mute) override { return 0; }

            int setDefaultMuteAllRemoteAudioStreams(bool mute) override { return 0; }

            int adjustUserPlaybackSignalVolume(unsigned int uid, int volume) override {
                return 0;
            }

            int muteRemoteAudioStream(uid_t userId, bool mute) override { return 0; }

            int muteLocalVideoStream(bool mute) override { return 0; }

            int enableLocalVideo(bool enabled) override { return 0; }

            int muteAllRemoteVideoStreams(bool mute) override { return 0; }

            int setDefaultMuteAllRemoteVideoStreams(bool mute) override { return 0; }

            int muteRemoteVideoStream(uid_t userId, bool mute) override { return 0; }

            int setRemoteVideoStreamType(uid_t userId,
                                         REMOTE_VIDEO_STREAM_TYPE streamType) override {
                return 0;
            }

            int setRemoteDefaultVideoStreamType(
                    REMOTE_VIDEO_STREAM_TYPE streamType) override {
                return 0;
            }

            int enableAudioVolumeIndication(int interval, int smooth,
                                            bool report_vad) override {
                return 0;
            }

            int startAudioRecording(const char *filePath,
                                    AUDIO_RECORDING_QUALITY_TYPE quality) override {
                return 0;
            }

            int startAudioRecording(const char *filePath, int sampleRate,
                                    AUDIO_RECORDING_QUALITY_TYPE quality) override {
                return 0;
            }

            int startAudioRecording(const AudioRecordingConfiguration &config) override {
                return 0;
            }

            int stopAudioRecording() override { return 0; }

            int startAudioMixing(const char *filePath, bool loopback, bool replace,
                                 int cycle) override {
                return 0;
            }

            int startAudioMixing(const char *filePath, bool loopback, bool replace,
                                 int cycle, int startPos) override {
                return 0;
            }

            int setAudioMixingPlaybackSpeed(int speed) override { return 0; }

            int stopAudioMixing() override { return 0; }

            int pauseAudioMixing() override { return 0; }

            int selectAudioTrack(int index) override { return 0; }

            int getAudioTrackCount() override { return 0; }

            int setAudioMixingDualMonoMode(
                    agora::media::AUDIO_MIXING_DUAL_MONO_MODE mode) override {
                return 0;
            }

            int resumeAudioMixing() override { return 0; }

            int setHighQualityAudioParameters(bool fullband, bool stereo,
                                              bool fullBitrate) override {
                return 0;
            }

            int adjustAudioMixingVolume(int volume) override { return 0; }

            int adjustAudioMixingPlayoutVolume(int volume) override { return 0; }

            int getAudioMixingPlayoutVolume() override { return 0; }

            int adjustAudioMixingPublishVolume(int volume) override { return 0; }

            int getAudioMixingPublishVolume() override { return 0; }

            int getAudioMixingDuration() override { return 0; }

            int getAudioMixingCurrentPosition() override { return 0; }

            int setAudioMixingPosition(int pos) override { return 0; }

            int setAudioMixingPitch(int pitch) override { return 0; }

            int getEffectsVolume() override { return 0; }

            int setEffectsVolume(int volume) override { return 0; }

            int setVolumeOfEffect(int soundId, int volume) override { return 0; }

#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)

            int enableFaceDetection(bool enable) override { return 0; }

#endif

            int playEffect(int soundId, const char *filePath, int loopCount, double pitch,
                           double pan, int gain, bool publish) override {
                return 0;
            }

            int playEffect(int soundId, const char *filePath, int loopCount, double pitch,
                           double pan, int gain, bool publish, int startPos) override {
                return 0;
            }

            int stopEffect(int soundId) override { return 0; }

            int stopAllEffects() override { return 0; }

            int preloadEffect(int soundId, const char *filePath) override { return 0; }

            int unloadEffect(int soundId) override { return 0; }

            int pauseEffect(int soundId) override { return 0; }

            int pauseAllEffects() override { return 0; }

            int resumeEffect(int soundId) override { return 0; }

            int resumeAllEffects() override { return 0; }

            int getEffectDuration(const char *filePath) override { return 0; }

            int setEffectPosition(int soundId, int pos) override { return 0; }

            int getEffectCurrentPosition(int soundId) override { return 0; }

            int getAudioFileInfo(const char *filePath) override { return 0; }

            int enableDeepLearningDenoise(bool enable) override { return 0; }

            int enableSoundPositionIndication(bool enabled) override { return 0; }

            int setRemoteVoicePosition(uid_t uid, double pan, double gain) override {
                return 0;
            }

            int setLocalVoicePitch(double pitch) override { return 0; }

            int setLocalVoiceEqualization(AUDIO_EQUALIZATION_BAND_FREQUENCY bandFrequency,
                                          int bandGain) override {
                return 0;
            }

            int setLocalVoiceReverb(AUDIO_REVERB_TYPE reverbKey, int value) override {
                return 0;
            }

            int setLocalVoiceChanger(VOICE_CHANGER_PRESET voiceChanger) override {
                return 0;
            }

            int setLocalVoiceReverbPreset(AUDIO_REVERB_PRESET reverbPreset) override {
                return 0;
            }

            int setVoiceBeautifierPreset(VOICE_BEAUTIFIER_PRESET preset) override {
                return 0;
            }

            int setAudioEffectPreset(AUDIO_EFFECT_PRESET preset) override { return 0; }

            int setVoiceConversionPreset(VOICE_CONVERSION_PRESET preset) override {
                return 0;
            }

            int setAudioEffectParameters(AUDIO_EFFECT_PRESET preset, int param1,
                                         int param2) override {
                return 0;
            }

            int setVoiceBeautifierParameters(VOICE_BEAUTIFIER_PRESET preset, int param1,
                                             int param2) override {
                return 0;
            }

            int setLogFile(const char *filePath) override { return 0; }

            int setLogWriter(agora::commons::ILogWriter *pLogWriter) override {
                return 0;
            }

            int releaseLogWriter() override { return 0; }

            int setLogFilter(unsigned int filter) override { return 0; }

            int setLogFileSize(unsigned int fileSizeInKBytes) override { return 0; }

            int uploadLogFile(agora::util::AString &requestId) override { return 0; }

            int setLocalRenderMode(RENDER_MODE_TYPE renderMode) override { return 0; }

            int setLocalRenderMode(RENDER_MODE_TYPE renderMode,
                                   VIDEO_MIRROR_MODE_TYPE mirrorMode) override {
                return 0;
            }

            int setRemoteRenderMode(uid_t userId, RENDER_MODE_TYPE renderMode) override {
                return 0;
            }

            int setRemoteRenderMode(uid_t userId, RENDER_MODE_TYPE renderMode,
                                    VIDEO_MIRROR_MODE_TYPE mirrorMode) override {
                return 0;
            }

            int setLocalVideoMirrorMode(VIDEO_MIRROR_MODE_TYPE mirrorMode) override {
                return 0;
            }

            int enableDualStreamMode(bool enabled) override { return 0; }

            int setExternalAudioSource(bool enabled, int sampleRate,
                                       int channels) override {
                return 0;
            }

            int setExternalAudioSink(bool enabled, int sampleRate,
                                     int channels) override {
                return 0;
            }

            int setRecordingAudioFrameParameters(int sampleRate, int channel,
                                                 RAW_AUDIO_FRAME_OP_MODE_TYPE mode,
                                                 int samplesPerCall) override {
                return 0;
            }

            int setPlaybackAudioFrameParameters(int sampleRate, int channel,
                                                RAW_AUDIO_FRAME_OP_MODE_TYPE mode,
                                                int samplesPerCall) override {
                return 0;
            }

            int setMixedAudioFrameParameters(int sampleRate,
                                             int samplesPerCall) override {
                return 0;
            }

            int adjustRecordingSignalVolume(int volume) override { return 0; }

            int adjustPlaybackSignalVolume(int volume) override { return 0; }

            int adjustLoopbackRecordingSignalVolume(int volume) override { return 0; }

            int enableWebSdkInteroperability(bool enabled) override { return 0; }

            int setVideoQualityParameters(bool preferFrameRateOverImageQuality) override {
                return 0;
            }

            int setLocalPublishFallbackOption(STREAM_FALLBACK_OPTIONS option) override {
                return 0;
            }

            int setRemoteSubscribeFallbackOption(
                    STREAM_FALLBACK_OPTIONS option) override {
                return 0;
            }

#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)

            int switchCamera() override { return 0; }

            int switchCamera(CAMERA_DIRECTION direction) override { return 0; }

            int setDefaultAudioRouteToSpeakerphone(bool defaultToSpeaker) override {
                return 0;
            }

            int setEnableSpeakerphone(bool speakerOn) override { return 0; }

            int enableInEarMonitoring(bool enabled) override { return 0; }

            int setInEarMonitoringVolume(int volume) override { return 0; }

            bool isSpeakerphoneEnabled() override { return 0; }

#endif
#if (defined(__APPLE__) && TARGET_OS_IOS)
            int setAudioSessionOperationRestriction(
                AUDIO_SESSION_OPERATION_RESTRICTION restriction) override {
              return 0;
            }
#endif
#if (defined(__APPLE__) && TARGET_OS_MAC && !TARGET_OS_IPHONE)                 \
 || defined(_WIN32)
            int enableLoopbackRecording(bool enabled, const char *deviceName) override {
              return 0;
            }
            IScreenCaptureSourceList *
            getScreenCaptureSources(const SIZE &thumbSize, const SIZE &iconSize,
                                    const bool includeScreen) override {
              return nullptr;
            }
            int startScreenCaptureByDisplayId(
                unsigned int displayId, const Rectangle &regionRect,
                const ScreenCaptureParameters &captureParams) override {
              return 0;
            }
#if defined(_WIN32)
            int startScreenCaptureByScreenRect(
                const Rectangle &screenRect, const Rectangle &regionRect,
                const ScreenCaptureParameters &captureParams) override {
              return 0;
            }
#endif
            int startScreenCaptureByWindowId(
                view_t windowId, const Rectangle &regionRect,
                const ScreenCaptureParameters &captureParams) override {
              return 0;
            }
            int setScreenCaptureContentHint(VideoContentHint contentHint) override {
              return 0;
            }
            int updateScreenCaptureParameters(
                const ScreenCaptureParameters &captureParams) override {
              return 0;
            }
            int updateScreenCaptureRegion(const Rectangle &regionRect) override {
              return 0;
            }
            int stopScreenCapture() override { return 0; }
            int startScreenCapture(WindowIDType windowId, int captureFreq,
                                   const Rect *rect, int bitrate) override {
              return 0;
            }
            int updateScreenCaptureRegion(const Rect *rect) override { return 0; }
#endif
#if defined(_WIN32)
            bool setVideoSource(IVideoSource *source) override { return 0; }
#endif

            int getCallId(agora::util::AString &callId) override { return 0; }

            int rate(const char *callId, int rating, const char *description) override {
                return 0;
            }

            int complain(const char *callId, const char *description) override {
                return 0;
            }

            const char *getVersion(int *build) override { return 0; }

            int enableLastmileTest() override { return 0; }

            int disableLastmileTest() override { return 0; }

            int startLastmileProbeTest(const LastmileProbeConfig &config) override {
                return 0;
            }

            int stopLastmileProbeTest() override { return 0; }

            const char *getErrorDescription(int code) override { return ""; }

            int setEncryptionSecret(const char *secret) override { return 0; }

            int setEncryptionMode(const char *encryptionMode) override { return 0; }

            int enableEncryption(bool enabled, const EncryptionConfig &config) override {
                return 0;
            }

            int registerPacketObserver(IPacketObserver *observer) override { return 0; }

            virtual int createDataStream(int *streamId, bool reliable, bool ordered) override {
                return 0;
            }

            virtual int createDataStream(int *streamId, DataStreamConfig &config) override {
                return 0;
            }

            int sendStreamMessage(int streamId, const char *data,
                                  size_t length) override {
                return 0;
            }

            int addPublishStreamUrl(const char *url, bool transcodingEnabled) override {
                return 0;
            }

            int removePublishStreamUrl(const char *url) override { return 0; }

            int setLiveTranscoding(const LiveTranscoding &transcoding) override {
                return 0;
            }

            int addVideoWatermark(const RtcImage &watermark) override { return 0; }

            int addVideoWatermark(const char *watermarkUrl,
                                  const WatermarkOptions &options) override {
                return 0;
            }

            int clearVideoWatermarks() override { return 0; }

            int setBeautyEffectOptions(bool enabled, BeautyOptions options) override {
                return 0;
            }

            int enableVirtualBackground(
                    bool enabled, VirtualBackgroundSource backgroundSource) override {
                return 0;
            }

            int addInjectStreamUrl(const char *url,
                                   const InjectStreamConfig &config) override {
                return 0;
            }

            int startChannelMediaRelay(
                    const ChannelMediaRelayConfiguration &configuration) override {
                return 0;
            }

            int updateChannelMediaRelay(
                    const ChannelMediaRelayConfiguration &configuration) override {
                return 0;
            }

            int pauseAllChannelMediaRelay() override { return 0; }

            int resumeAllChannelMediaRelay() override { return 0; }

            int stopChannelMediaRelay() override { return 0; }

            int removeInjectStreamUrl(const char *url) override { return 0; }

            virtual bool registerEventHandler(IRtcEngineEventHandler *eventHandler) override {
                return 0;
            }

            bool unregisterEventHandler(IRtcEngineEventHandler *eventHandler) override {
                return 0;
            }

            int sendCustomReportMessage(const char *id, const char *category,
                                        const char *event, const char *label,
                                        int value) override {
                return 0;
            }

            CONNECTION_STATE_TYPE getConnectionState() override {
                return CONNECTION_STATE_TYPE::CONNECTION_STATE_CONNECTED;
            }

            int enableRemoteSuperResolution(uid_t userId, bool enable) override {
                return 0;
            }

            int registerMediaMetadataObserver(
                    IMetadataObserver *observer,
                    IMetadataObserver::METADATA_TYPE type) override {
                return 0;
            }

            int setParameters(const char *parameters) override { return 0; }

#if defined(_WIN32)
            int setLocalVideoRenderer(IVideoSink *videoSink) override { return 0; }
            int setRemoteVideoRenderer(uid_t uid, IVideoSink *videoSink) override {
              return 0;
            }
#endif
//  int setLocalAccessPoint(const char **ips, int ipSize,
//                          const char *domain) override {
//    return 0;
//  }
#if defined(__ANDROID__) || (defined(__APPLE__) && TARGET_OS_IOS)

            int setCameraTorchOn(bool isOn) override { return 0; }

            bool isCameraTorchSupported() override { return 0; }

#endif

            int takeSnapshot(const char *channel, uid_t uid,
                             const char *filePath) override {
                return 0;
            }

            int enableContentInspect(bool enabled,
                                     const ContentInspectConfig &config) override {
                return 0;
            }

            int setAVSyncSource(const char *channelId, uid_t uid) override {
                return 0;
            }

            int enableWirelessAccelerate(bool enabled) override {
                return 0;
            }

            bool setVideoSource(IVideoSource *source) override {
                return false;
            }

            int startRtmpStreamWithoutTranscoding(const char *url) override {
                return 0;
            }

            int startRtmpStreamWithTranscoding(const char *url,
                                               const LiveTranscoding &transcoding) override {
                return 0;
            }

            int updateRtmpTranscoding(const LiveTranscoding &transcoding) override {
                return 0;
            }

            int stopRtmpStream(const char *url) override {
                return 0;
            }

            int setLowlightEnhanceOptions(bool enabled, LowLightEnhanceOptions options) override {
                return 0;
            }

            int setVideoDenoiserOptions(bool enabled, VideoDenoiserOptions options) override {
                return 0;
            }

            int setColorEnhanceOptions(bool enabled, ColorEnhanceOptions options) override {
                return 0;
            }

            int setLocalVideoRenderer(IVideoSink *videoSink) override {
                return 0;
            }

            int setRemoteVideoRenderer(uid_t uid, IVideoSink *videoSink) override {
                return 0;
            }

            int setLocalAccessPoint(const LocalAccessPointConfiguration &config) override {
                return 0;
            }

        protected:
            ~FakeRtcEngineInternal() override {

            }
        };

    }// namespace rtc
}// namespace agora

#endif// FAKE_RTC_ENGINE_INTERNAL_H_
