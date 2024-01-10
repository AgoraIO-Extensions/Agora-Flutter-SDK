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
];

module.exports = {
  deleteNodes: deleteNodes,
  updateNodes: updateNodes,
};
