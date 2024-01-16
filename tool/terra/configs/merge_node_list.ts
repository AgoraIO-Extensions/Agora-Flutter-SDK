module.exports = [
  {
    source: "agora::rtc::IRtcEngineEventHandlerEx",
    target: "agora::rtc::IRtcEngineEventHandler",
    deleteSource: true,
    isFilterOverloadFunctions: false,
  },
  {
    source: "agora::media::IAudioFrameObserverBase",
    target: "agora::media::IAudioFrameObserver",
    deleteSource: false,
    isFilterOverloadFunctions: false,
  },
];
