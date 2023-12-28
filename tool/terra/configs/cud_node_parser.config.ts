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
];

module.exports = {
  deleteNodes: deleteNodes,
  updateNodes: updateNodes,
};
