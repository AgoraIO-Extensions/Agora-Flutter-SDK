import { CXXTYPE, SimpleTypeKind } from "@agoraio-extensions/cxx-parser";

const deleteNodes = [
  // agora::rtc::IMetadataObserver
  {
    // onReadyToSendMetadata
    __TYPE: CXXTYPE.MemberFunction,
    name: "onReadyToSendMetadata",
    namespaces: ["agora", "rtc"],
    parent_name: "IMetadataObserver",
  },
  {
    // getMaxMetadataSize
    __TYPE: CXXTYPE.MemberFunction,
    name: "getMaxMetadataSize",
    namespaces: ["agora", "rtc"],
    parent_name: "IMetadataObserver",
  },
  // agora::rtc::IRtcEngineEventHandler
  {
    // eventHandlerType
    __TYPE: CXXTYPE.MemberFunction,
    name: "eventHandlerType",
    namespaces: ["agora", "rtc"],
    parent_name: "IRtcEngineEventHandler",
  },
  // agora::rtc::IRtcEngineEventHandlerEx
  {
    // eventHandlerType
    __TYPE: CXXTYPE.MemberFunction,
    name: "eventHandlerType",
    namespaces: ["agora", "rtc"],
    parent_name: "IRtcEngineEventHandlerEx",
  },
  {
    // onFirstLocalVideoFrame
    __TYPE: CXXTYPE.MemberFunction,
    name: "onFirstLocalVideoFrame",
    namespaces: ["agora", "rtc"],
    parent_name: "IRtcEngineEventHandlerEx",
  },
  {
    // onFirstLocalVideoFramePublished
    __TYPE: CXXTYPE.MemberFunction,
    name: "onFirstLocalVideoFramePublished",
    namespaces: ["agora", "rtc"],
    parent_name: "IRtcEngineEventHandlerEx",
  },
  {
    // onLocalVideoStateChanged
    __TYPE: CXXTYPE.MemberFunction,
    name: "onLocalVideoStateChanged",
    namespaces: ["agora", "rtc"],
    parent_name: "IRtcEngineEventHandlerEx",
  },
  {
    // onLocalVideoStats
    __TYPE: CXXTYPE.MemberFunction,
    name: "onLocalVideoStats",
    namespaces: ["agora", "rtc"],
    parent_name: "IRtcEngineEventHandlerEx",
  },
  {
    // agora::base::IEngineBase
    __TYPE: CXXTYPE.Clazz,
    name: "IEngineBase",
    namespaces: ["agora", "base"],
  },
  {
    // agora::base::AParameter
    __TYPE: CXXTYPE.Clazz,
    name: "AParameter",
    namespaces: ["agora", "base"],
  },
  {
    // agora::util::AutoPtr
    __TYPE: CXXTYPE.Clazz,
    name: "AutoPtr",
    namespaces: ["agora", "util"],
  },
  {
    // agora::util::CopyableAutoPtr
    __TYPE: CXXTYPE.Clazz,
    name: "CopyableAutoPtr",
    namespaces: ["agora", "util"],
  },
  {
    // agora::util::IString
    __TYPE: CXXTYPE.Clazz,
    name: "IString",
    namespaces: ["agora", "util"],
  },
  {
    // agora::util::IIterator
    __TYPE: CXXTYPE.Clazz,
    name: "IIterator",
    namespaces: ["agora", "util"],
  },
  {
    // agora::util::IContainer
    __TYPE: CXXTYPE.Clazz,
    name: "IContainer",
    namespaces: ["agora", "util"],
  },
  {
    // agora::util::AOutputIterator
    __TYPE: CXXTYPE.Clazz,
    name: "AOutputIterator",
    namespaces: ["agora", "util"],
  },
  {
    // agora::util::AList
    __TYPE: CXXTYPE.Clazz,
    name: "AList",
    namespaces: ["agora", "util"],
  },
  {
    // agora::media::base::IMediaPlayerCustomDataProvider
    __TYPE: CXXTYPE.Clazz,
    name: "IMediaPlayerCustomDataProvider",
    namespaces: ["agora", "media", "base"],
  },
  {
    // agora::commons::ILogWriter
    __TYPE: CXXTYPE.Clazz,
    name: "ILogWriter",
    namespaces: ["agora", "commons"],
  },
  {
    // agora::rtc::IMediaPlayerSource
    __TYPE: CXXTYPE.Clazz,
    name: "IMediaPlayerSource",
    namespaces: ["agora", "rtc"],
  },
  {
    // agora::rtc::IMediaStreamingSource
    __TYPE: CXXTYPE.Clazz,
    name: "IMediaStreamingSource",
    namespaces: ["agora", "rtc"],
  },
  {
    // agora::rtc::IMediaStreamingSourceObserver
    __TYPE: CXXTYPE.Clazz,
    name: "IMediaStreamingSourceObserver",
    namespaces: ["agora", "rtc"],
  },
  {
    // agora::rtc::IRhythmPlayer
    __TYPE: CXXTYPE.Clazz,
    name: "IRhythmPlayer",
    namespaces: ["agora", "rtc"],
  },
  // agora::media::base::ExternalVideoFrame
  {
    __TYPE: CXXTYPE.MemberVariable,
    name: "eglContext",
    namespaces: ["agora", "media", "base"],
    parent_name: "ExternalVideoFrame",
  },
  {
    __TYPE: CXXTYPE.MemberVariable,
    name: "d3d11_texture_2d",
    namespaces: ["agora", "media", "base"],
    parent_name: "ExternalVideoFrame",
  },
  // agora::media::base::VideoFrame
  {
    __TYPE: CXXTYPE.MemberVariable,
    name: "sharedContext",
    namespaces: ["agora", "media", "base"],
    parent_name: "VideoFrame",
  },
  {
    __TYPE: CXXTYPE.MemberVariable,
    name: "d3d11Texture2d",
    namespaces: ["agora", "media", "base"],
    parent_name: "VideoFrame",
  },
  // agora::rtc::LocalSpatialAudioConfig
  {
    __TYPE: CXXTYPE.Struct,
    name: "LocalSpatialAudioConfig",
    namespaces: ["agora", "rtc"],
  },
  // agora::UserInfo
  {
    __TYPE: CXXTYPE.Struct,
    name: "UserInfo",
    namespaces: ["agora"],
    member_variables: [
      // Add more info to match the `agora::UserInfo`
      {
        __TYPE: CXXTYPE.MemberVariable,
        name: "hasAudio",
        namespaces: ["agora"],
        parent_name: "UserInfo",
      },
      {
        __TYPE: CXXTYPE.MemberVariable,
        name: "hasVideo",
        namespaces: ["agora"],
        parent_name: "UserInfo",
      },
    ],
  },
  // agora::rtc::IPacketObserver
  {
    __TYPE: CXXTYPE.Clazz,
    name: "IPacketObserver",
    namespaces: ["agora", "rtc"],
  },
  // agora::rtc::LicenseCallback
  {
    __TYPE: CXXTYPE.Clazz,
    name: "LicenseCallback",
    namespaces: ["agora", "base"],
  },
  // agora::media::base::IVideoFrameObserver
  {
    __TYPE: CXXTYPE.Clazz,
    name: "IVideoFrameObserver",
    namespaces: ["agora", "media", "base"],
  },
  // agora::media::IAudioFrameObserverBase
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "onPlaybackAudioFrameBeforeMixing",
    parent_name: "IAudioFrameObserverBase",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getObservedAudioFramePosition",
    parent_name: "IAudioFrameObserverBase",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getPlaybackAudioParams",
    parent_name: "IAudioFrameObserverBase",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getPublishAudioParams",
    parent_name: "IAudioFrameObserverBase",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getRecordAudioParams",
    parent_name: "IAudioFrameObserverBase",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getMixedAudioParams",
    parent_name: "IAudioFrameObserverBase",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getEarMonitoringAudioParams",
    parent_name: "IAudioFrameObserverBase",
    namespaces: ["agora", "media"],
  },
  // agora::media::IVideoFrameObserver
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getVideoFrameProcessMode",
    parent_name: "IVideoFrameObserver",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getVideoFormatPreference",
    parent_name: "IVideoFrameObserver",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getRotationApplied",
    parent_name: "IVideoFrameObserver",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getMirrorApplied",
    parent_name: "IVideoFrameObserver",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "getObservedFramePosition",
    parent_name: "IVideoFrameObserver",
    namespaces: ["agora", "media"],
  },
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "isExternal",
    parent_name: "IVideoFrameObserver",
    namespaces: ["agora", "media"],
  },
  // agora::rtc::IAudioDeviceCollection
  {
    __TYPE: CXXTYPE.Clazz,
    name: "IAudioDeviceCollection",
    namespaces: ["agora", "rtc"],
  },
  // agora::media::addVideoFrameRenderer
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "addVideoFrameRenderer",
    parent_name: "IMediaEngine",
    namespaces: ["agora", "media"],
  },
  // agora::media::removeVideoFrameRenderer
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "removeVideoFrameRenderer",
    parent_name: "IMediaEngine",
    namespaces: ["agora", "media"],
  },
  // agora::media::IMediaPlayer::initialize
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "initialize",
    parent_name: "IMediaPlayer",
    namespaces: ["agora", "rtc"],
  },
  // agora::media::IMediaPlayer::openWithCustomSource
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "openWithCustomSource",
    parent_name: "IMediaPlayer",
    namespaces: ["agora", "rtc"],
  },
  // TODO(littlegnal): We should not config these custom nodes by users.
  // agora::rtc::ext::IRtcEngine::destroyRendererByView
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "destroyRendererByView",
    parent_name: "IRtcEngine",
    namespaces: ["agora", "rtc", "ext"],
  },
  // agora::rtc::ext::IRtcEngine::destroyRendererByConfig
  {
    __TYPE: CXXTYPE.MemberFunction,
    name: "destroyRendererByConfig",
    parent_name: "IRtcEngine",
    namespaces: ["agora", "rtc", "ext"],
  },
  // agora::rtc::IRtcEngine::queryCameraFocalLengthCapability
  {
    __TYPE: CXXTYPE.Variable,
    name: "size",
    namespaces: ["agora", "rtc"],
    parent_name: "queryCameraFocalLengthCapability",
  },
];

const updateNodes = [
  // agora::rtc::IRtcEngineEventHandler

  // onError
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "err",
      namespaces: ["agora", "rtc"],
      parent_name: "onError",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "err",
      namespaces: ["agora", "rtc"],
      parent_name: "onError",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::ERROR_CODE_TYPE",
        source: "agora::ERROR_CODE_TYPE",
      },
    },
  },
  // onAudioVolumeIndication
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "speakers",
      namespaces: ["agora", "rtc"],
      parent_name: "onAudioVolumeIndication",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "speakers",
      namespaces: ["agora", "rtc"],
      parent_name: "onAudioVolumeIndication",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
        name: "agora::rtc::AudioVolumeInfo",
        source: "const agora::rtc::AudioVolumeInfo*",
      },
    },
  },
  // onAudioDeviceStateChanged
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "deviceType",
      namespaces: ["agora", "rtc"],
      parent_name: "onAudioDeviceStateChanged",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "deviceType",
      namespaces: ["agora", "rtc"],
      parent_name: "onAudioDeviceStateChanged",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::MEDIA_DEVICE_TYPE",
        source: "agora::rtc::MEDIA_DEVICE_TYPE",
      },
    },
  },
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "deviceState",
      namespaces: ["agora", "rtc"],
      parent_name: "onAudioDeviceStateChanged",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "deviceState",
      namespaces: ["agora", "rtc"],
      parent_name: "onAudioDeviceStateChanged",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::MEDIA_DEVICE_STATE_TYPE",
        source: "agora::rtc::MEDIA_DEVICE_STATE_TYPE",
      },
    },
  },

  // onVideoDeviceStateChanged
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "deviceType",
      namespaces: ["agora", "rtc"],
      parent_name: "onVideoDeviceStateChanged",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "deviceType",
      namespaces: ["agora", "rtc"],
      parent_name: "onVideoDeviceStateChanged",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::MEDIA_DEVICE_TYPE",
        source: "agora::rtc::MEDIA_DEVICE_TYPE",
      },
    },
  },
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "deviceState",
      namespaces: ["agora", "rtc"],
      parent_name: "onVideoDeviceStateChanged",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "deviceState",
      namespaces: ["agora", "rtc"],
      parent_name: "onVideoDeviceStateChanged",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::MEDIA_DEVICE_STATE_TYPE",
        source: "agora::rtc::MEDIA_DEVICE_STATE_TYPE",
      },
    },
  },
  // onFacePositionChanged
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "vecRectangle",
      namespaces: ["agora", "rtc"],
      parent_name: "onFacePositionChanged",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "vecRectangle",
      namespaces: ["agora", "rtc"],
      parent_name: "onFacePositionChanged",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
        name: "agora::rtc::Rectangle",
        source: "const agora::rtc::Rectangle*",
      },
    },
  },
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "vecDistance",
      namespaces: ["agora", "rtc"],
      parent_name: "onFacePositionChanged",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "vecDistance",
      namespaces: ["agora", "rtc"],
      parent_name: "onFacePositionChanged",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
        name: "int",
        source: "const int*",
      },
    },
  },
  // onChannelMediaRelayStateChanged
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "state",
      namespaces: ["agora", "rtc"],
      parent_name: "onChannelMediaRelayStateChanged",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "state",
      namespaces: ["agora", "rtc"],
      parent_name: "onChannelMediaRelayStateChanged",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::CHANNEL_MEDIA_RELAY_STATE",
        source: "agora::rtc::CHANNEL_MEDIA_RELAY_STATE",
      },
    },
  },
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "code",
      namespaces: ["agora", "rtc"],
      parent_name: "onChannelMediaRelayStateChanged",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "code",
      namespaces: ["agora", "rtc"],
      parent_name: "onChannelMediaRelayStateChanged",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::CHANNEL_MEDIA_RELAY_ERROR",
        source: "agora::rtc::CHANNEL_MEDIA_RELAY_ERROR",
      },
    },
  },
  // agora::rtc::IRtcEngineEventHandler::onAudioMetadataReceived
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "metadata",
      namespaces: ["agora", "rtc"],
      parent_name: "onAudioMetadataReceived",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "metadata",
      namespaces: ["agora", "rtc"],
      parent_name: "onAudioMetadataReceived",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // agora::rtc::IRtcEngineEventHandler::onRdtMessage
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "onRdtMessage",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "onRdtMessage",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },

  //
  // agora::rtc::IRtcEngineEventHandlerEx
  //
  // onAudioQuality
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "quality",
      namespaces: ["agora", "rtc"],
      parent_name: "onAudioQuality",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "quality",
      namespaces: ["agora", "rtc"],
      parent_name: "onAudioQuality",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::QUALITY_TYPE",
        source: "agora::rtc::QUALITY_TYPE",
      },
    },
  },
  // onNetworkQuality
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "txQuality",
      namespaces: ["agora", "rtc"],
      parent_name: "onNetworkQuality",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "txQuality",
      namespaces: ["agora", "rtc"],
      parent_name: "onNetworkQuality",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::QUALITY_TYPE",
        source: "agora::rtc::QUALITY_TYPE",
      },
    },
  },
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "rxQuality",
      namespaces: ["agora", "rtc"],
      parent_name: "onNetworkQuality",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "rxQuality",
      namespaces: ["agora", "rtc"],
      parent_name: "onNetworkQuality",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::QUALITY_TYPE",
        source: "agora::rtc::QUALITY_TYPE",
      },
    },
  },
  // onLastmileQuality
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "quality",
      namespaces: ["agora", "rtc"],
      parent_name: "onLastmileQuality",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "quality",
      namespaces: ["agora", "rtc"],
      parent_name: "onLastmileQuality",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::QUALITY_TYPE",
        source: "agora::rtc::QUALITY_TYPE",
      },
    },
  },
  // onStreamMessage
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "onStreamMessage",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "onStreamMessage",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // onStreamMessageError
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "code",
      namespaces: ["agora", "rtc"],
      parent_name: "onStreamMessageError",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "code",
      namespaces: ["agora", "rtc"],
      parent_name: "onStreamMessageError",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::ERROR_CODE_TYPE",
        source: "agora::ERROR_CODE_TYPE",
      },
    },
  },
  // onRdtMessage
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "onRdtMessage",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "onRdtMessage",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // onMediaControlMessage
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "onMediaControlMessage",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "onMediaControlMessage",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // VideoCompositingLayout
  {
    node: {
      __TYPE: CXXTYPE.MemberVariable,
      name: "appData",
      namespaces: ["agora", "rtc"],
      parent_name: "VideoCompositingLayout",
    },
    updated: {
      __TYPE: CXXTYPE.MemberVariable,
      name: "appData",
      namespaces: ["agora", "rtc"],
      parent_name: "VideoCompositingLayout",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // ThumbImageBuffer
  {
    node: {
      __TYPE: CXXTYPE.MemberVariable,
      name: "buffer",
      namespaces: ["agora", "rtc"],
      parent_name: "ThumbImageBuffer",
    },
    updated: {
      __TYPE: CXXTYPE.MemberVariable,
      name: "buffer",
      namespaces: ["agora", "rtc"],
      parent_name: "ThumbImageBuffer",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // onRemoteAudioSpectrum
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "spectrums",
      namespaces: ["agora", "media"],
      parent_name: "onRemoteAudioSpectrum",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "spectrums",
      namespaces: ["agora", "media"],
      parent_name: "onRemoteAudioSpectrum",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
        name: "agora::media::UserAudioSpectrumInfo",
        source: "const agora::media::UserAudioSpectrumInfo*",
      },
    },
  },
  // onMusicChartsResult
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "result",
      namespaces: ["agora", "rtc"],
      parent_name: "onMusicChartsResult",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "result",
      namespaces: ["agora", "rtc"],
      parent_name: "onMusicChartsResult",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
        name: "agora::rtc::MusicChartInfo",
        source: "const agora::rtc::MusicChartInfo*",
      },
    },
  },
  // agora::media::IMediaEngine::pushAudioFrame
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "frame",
      namespaces: ["agora", "media"],
      parent_name: "pushAudioFrame",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "frame",
      namespaces: ["agora", "media"],
      parent_name: "pushAudioFrame",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "IAudioFrameObserverBase::AudioFrame",
        source: "const IAudioFrameObserverBase::AudioFrame*",
      },
    },
  },
  // agora::media::IMediaEngine::pullAudioFrame
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "frame",
      namespaces: ["agora", "media"],
      parent_name: "pullAudioFrame",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "frame",
      namespaces: ["agora", "media"],
      parent_name: "pullAudioFrame",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "IAudioFrameObserverBase::AudioFrame",
        source: "const IAudioFrameObserverBase::AudioFrame*",
      },
    },
  },
  // agora::media::IMediaEngine::pushVideoFrame
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "frame",
      namespaces: ["agora", "media"],
      parent_name: "pushVideoFrame",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "frame",
      namespaces: ["agora", "media"],
      parent_name: "pushVideoFrame",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "agora::media::base::ExternalVideoFrame",
        source: "const agora::media::base::ExternalVideoFrame*",
      },
    },
  },
  // agora::media::IMediaEngine::addVideoFrameRenderer
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "renderer",
      namespaces: ["agora", "media"],
      parent_name: "addVideoFrameRenderer",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "renderer",
      namespaces: ["agora", "media"],
      parent_name: "addVideoFrameRenderer",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "agora::media::IVideoFrameObserver",
        source: "const agora::media::IVideoFrameObserver*",
      },
    },
  },
  // agora::media::IMediaEngine::removeVideoFrameRenderer
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "renderer",
      namespaces: ["agora", "media"],
      parent_name: "removeVideoFrameRenderer",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "renderer",
      namespaces: ["agora", "media"],
      parent_name: "removeVideoFrameRenderer",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "agora::media::IVideoFrameObserver",
        source: "const agora::media::IVideoFrameObserver*",
      },
    },
  },
  // agora::media::IMediaRecorder::setMediaRecorderObserver
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "callback",
      namespaces: ["agora", "rtc"],
      parent_name: "setMediaRecorderObserver",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "callback",
      namespaces: ["agora", "rtc"],
      parent_name: "setMediaRecorderObserver",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "agora::media::IMediaRecorderObserver",
        source: "const agora::media::IMediaRecorderObserver*",
      },
    },
  },
  // agora::rtc::IMusicContentCenter
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "cacheInfo",
      namespaces: ["agora", "rtc"],
      parent_name: "getCaches",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "cacheInfo",
      namespaces: ["agora", "rtc"],
      parent_name: "getCaches",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.array_t,
        name: "agora::rtc::MusicCacheInfo",
        source: "agora::rtc::MusicCacheInfo*",
      },
    },
  },
  // agora::rtc::IRtcEngineEx
  // agora::rtc::IRtcEngineEx::setSubscribeAudioBlocklistEx
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeAudioBlocklistEx",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeAudioBlocklistEx",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngineEx::setSubscribeAudioAllowlistEx
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeAudioAllowlistEx",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeAudioAllowlistEx",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngineEx::setSubscribeVideoBlocklistEx
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeVideoBlocklistEx",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeVideoBlocklistEx",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngineEx::setSubscribeVideoAllowlistEx
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeVideoAllowlistEx",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeVideoAllowlistEx",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngineEx::setHighPriorityUserListEx
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setHighPriorityUserListEx",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setHighPriorityUserListEx",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngineEx::sendStreamMessageEx
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendStreamMessageEx",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendStreamMessageEx",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // agora::rtc::IRtcEngineEx::sendRdtMessageEx
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendRdtMessageEx",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendRdtMessageEx",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // agora::rtc::IRtcEngineEx::sendMediaControlMessageEx
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendMediaControlMessageEx",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendMediaControlMessageEx",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // agora::rtc::IRtcEngineEx::sendAudioMetadataEx
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "metadata",
      namespaces: ["agora", "rtc"],
      parent_name: "sendAudioMetadataEx",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "metadata",
      namespaces: ["agora", "rtc"],
      parent_name: "sendAudioMetadataEx",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // agora::rtc::IRtcEngine
  // agora::rtc::IRtcEngine::queryCodecCapability
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "codecInfo",
      namespaces: ["agora", "rtc"],
      parent_name: "queryCodecCapability",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "codecInfo",
      namespaces: ["agora", "rtc"],
      parent_name: "queryCodecCapability",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngine::setSubscribeAudioBlocklist
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeAudioBlocklist",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeAudioBlocklist",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngine::setSubscribeAudioAllowlist
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeAudioAllowlist",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeAudioAllowlist",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngine::setSubscribeVideoBlocklist
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeVideoBlocklist",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeVideoBlocklist",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngine::setSubscribeVideoAllowlist
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeVideoAllowlist",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setSubscribeVideoAllowlist",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngine::setLogFilter
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "filter",
      namespaces: ["agora", "rtc"],
      parent_name: "setLogFilter",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "filter",
      namespaces: ["agora", "rtc"],
      parent_name: "setLogFilter",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::commons::LOG_FILTER_TYPE",
        source: "agora::commons::LOG_FILTER_TYPE",
      },
    },
  },
  // agora::rtc::IRtcEngine::setHighPriorityUserList
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setHighPriorityUserList",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "uidList",
      namespaces: ["agora", "rtc"],
      parent_name: "setHighPriorityUserList",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
  // agora::rtc::IRtcEngine::enableInEarMonitoring
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "includeAudioFilters",
      namespaces: ["agora", "rtc"],
      parent_name: "enableInEarMonitoring",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "includeAudioFilters",
      namespaces: ["agora", "rtc"],
      parent_name: "enableInEarMonitoring",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.value_t,
        name: "agora::rtc::EAR_MONITORING_FILTER_TYPE",
        source: "agora::rtc::EAR_MONITORING_FILTER_TYPE",
      },
    },
  },
  // agora::rtc::IRtcEngine::sendStreamMessage
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendStreamMessage",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendStreamMessage",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // agora::rtc::IRtcEngine::sendRdtMessage
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendRdtMessage",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendRdtMessage",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // agora::rtc::IRtcEngine::sendMediaControlMessage
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendMediaControlMessage",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "data",
      namespaces: ["agora", "rtc"],
      parent_name: "sendMediaControlMessage",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // agora::rtc::IRtcEngine::startDirectCdnStreaming
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "eventHandler",
      namespaces: ["agora", "rtc"],
      parent_name: "startDirectCdnStreaming",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "eventHandler",
      namespaces: ["agora", "rtc"],
      parent_name: "startDirectCdnStreaming",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "IDirectCdnStreamingEventHandler",
        source: "const IDirectCdnStreamingEventHandler*",
      },
    },
  },
  // agora::rtc::IRtcEngine::setAdvancedAudioOptions
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "options",
      namespaces: ["agora", "rtc"],
      parent_name: "setAdvancedAudioOptions",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "options",
      namespaces: ["agora", "rtc"],
      parent_name: "setAdvancedAudioOptions",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.reference_t,
        name: "AdvancedAudioOptions",
        source: "const AdvancedAudioOptions&",
      },
    },
  },
  // agora::rtc::IRtcEngine::setAdvancedAudioOptions
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "options",
      namespaces: ["agora", "rtc"],
      parent_name: "setAdvancedAudioOptions",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "options",
      namespaces: ["agora", "rtc"],
      parent_name: "setAdvancedAudioOptions",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.reference_t,
        name: "AdvancedAudioOptions",
        source: "const AdvancedAudioOptions&",
      },
    },
  },
  // agora::rtc::IRtcEngine::setZones
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "zones",
      namespaces: ["agora", "rtc"],
      parent_name: "setZones",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "zones",
      namespaces: ["agora", "rtc"],
      parent_name: "setZones",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.array_t,
        name: "agora::rtc::SpatialAudioZone",
        source: "const agora::rtc::SpatialAudioZone*",
      },
    },
  },
  // agora::rtc::IRtcEngine::sendAudioMetadata
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "metadata",
      namespaces: ["agora", "rtc"],
      parent_name: "sendAudioMetadata",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "metadata",
      namespaces: ["agora", "rtc"],
      parent_name: "sendAudioMetadata",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: true,
        kind: SimpleTypeKind.pointer_t,
        name: "uint8_t",
        source: "const uint8_t*",
      },
    },
  },
  // agora::rtc::IRtcEngine::queryCameraFocalLengthCapability
  {
    node: {
      __TYPE: CXXTYPE.Variable,
      name: "focalLengthInfos",
      namespaces: ["agora", "rtc"],
      parent_name: "queryCameraFocalLengthCapability",
    },
    updated: {
      __TYPE: CXXTYPE.Variable,
      name: "focalLengthInfos",
      namespaces: ["agora", "rtc"],
      parent_name: "queryCameraFocalLengthCapability",
      type: {
        __TYPE: CXXTYPE.SimpleType,
        is_builtin_type: false,
        is_const: false,
        kind: SimpleTypeKind.array_t,
      },
    },
  },
];

module.exports = {
  deleteNodes: deleteNodes,
  updateNodes: updateNodes,
};
