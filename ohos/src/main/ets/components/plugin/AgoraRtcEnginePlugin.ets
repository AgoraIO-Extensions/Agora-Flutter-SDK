import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
  StandardMessageCodec
} from '@ohos/flutter_ohos';

import { common } from '@kit.AbilityKit';
import { JSON } from '@kit.ArkTS';
import Log from '@ohos/flutter_ohos/src/main/ets/util/Log';

import {
  Constants,
  VideoCanvas,
  LogConfig,
  RtcEngine,
  RtcEngineEx,
  RtcEngineConfig,
  RtcConnection
} from '@shengwang/rtc-full';

import { AgoraVideoCanvasFactory, AgoraVideoCanvas } from './AgoraVideoCanvas';
import { AgoraRtcVideoViewController } from './AgoraRtcVideoViewController';

class DartRtcEngineLogConfig {
  public filePath?: string = undefined;
  public fileSizeInKB?: number = undefined;
  public level?: Constants.LogLevel = undefined;
}

class DartRtcEngineInitContext {
  public appId?: string = undefined;
  public areaCode?: Constants.AreaCode = undefined;
  public logConfig?: DartRtcEngineLogConfig = undefined;
}

class DartRtcEngineCanvas {
  public uid?: number = undefined;
  public view?: number = undefined;
  public renderMode?: number = undefined;
  public mirrorMode?: number = undefined;
  public sourceType?: number = undefined;
}

class DartRtcEngineConnection {
  public channelId?: string = undefined;
  public localUid?: number = undefined;
}

class DartRtcEngineSetupVideoViewContext {
  public canvas?: DartRtcEngineCanvas = undefined;
  public connection?: DartRtcEngineConnection = undefined;
}

const TAG: string = "AgoraRtcEnginePlugin";
const METHOD_CHANNEL: string = "agora_rtc_ng";

export default class AgoraRtcEnginePlugin implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;
  private _engine: RtcEngineEx | null = null;

  constructor() {
    Log.i(TAG, 'constructor')
  }

  getUniqueClassName(): string {
    return TAG;
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    Log.i(TAG, 'attach to engine');

    binding.getPlatformViewRegistry()?.
    registerViewFactory(AgoraVideoCanvas.VIEW_TYPE,
      new AgoraVideoCanvasFactory(binding.getBinaryMessenger(), StandardMessageCodec.INSTANCE));

    binding.getFlutterEngine()?.getPlugins()?.add(new AgoraRtcVideoViewController());

    this.channel = new MethodChannel(binding.getBinaryMessenger(), METHOD_CHANNEL);
    this.channel.setMethodCallHandler(this);

    Log.i(TAG, 'attached to engine');
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null);
    }

    Log.i(TAG, 'detached from engine');
  }

  onOhosInit(call: MethodCall) {
    Log.i(TAG, 'onOhosInit');

    if (this._engine !== null) {
      Log.w(TAG, 'already created rtc engine');
      return 0;
    }

    const initContext = JSON.parse(call.args) as DartRtcEngineInitContext;

    let config: RtcEngineConfig = new RtcEngineConfig();
    config.mContext = getContext(this) as common.UIAbilityContext;

    if (initContext.appId !== undefined) {
      config.mAppId = initContext.appId;
    }

    if (initContext.areaCode !== undefined) {
      config.areaCode = initContext.areaCode;
    }

    if (initContext.logConfig !== undefined) {
      config.mLogConfig = new LogConfig();
      if (initContext.logConfig.filePath !== undefined) {
        config.mLogConfig.filePath = initContext.logConfig.filePath;
      }

      if (initContext.logConfig.fileSizeInKB !== undefined) {
        config.mLogConfig.fileSizeInKB = initContext.logConfig.fileSizeInKB;
      }

      if (initContext.logConfig.level !== undefined) {
        config.mLogConfig.fileSizeInKB = initContext.logConfig.level;
      }
    }

    this._engine = RtcEngine.create(config) as RtcEngineEx;
    if (this._engine === null) {
      throw Error('create rtc engine failed');
    }

    Log.w(TAG, 'native handle: ' + this._engine!.getNativeHandle().toString());

    return this._engine!.getNativeHandle().toString();
  }

  onOhosDestroy(call: MethodCall) {
    Log.i(TAG, 'onOhosDestroy');

    if (this._engine === null) {
      Log.w(TAG, 'already destroyed rtc engine');
      return 0;
    }

    RtcEngine.destroy();

    this._engine = null;

    return 0;
  }

  onEnableVideo(call: MethodCall) {
    Log.i(TAG, 'onEnableVideo');

    if (this._engine === null) {
      return Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    return this._engine!.enableVideo();
  }

  _createVideoCanvas(param: DartRtcEngineSetupVideoViewContext): VideoCanvas {
    let rtcCanvas: VideoCanvas = new VideoCanvas(AgoraVideoCanvas.getXComponentIdByViewId(param.canvas!.view!), false);
    rtcCanvas.uid = param.canvas!.uid!;
    if (param.canvas!.renderMode !== undefined) {
      rtcCanvas.renderMode = param.canvas!.renderMode;
    }

    if (param.canvas!.mirrorMode !== undefined) {
      rtcCanvas.mirrorMode = param.canvas!.mirrorMode;
    }

    if (param.canvas!.sourceType !== undefined) {
      rtcCanvas.sourceType = param.canvas!.sourceType;
    }

    return rtcCanvas;
  }

  onSetupRemoteVideoEx(call: MethodCall) {
    Log.i(TAG, 'onSetupRemoteVideoEx');

    if (this._engine === null) {
      return Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const setupVideoViewContext = JSON.parse(call.args) as DartRtcEngineSetupVideoViewContext;
    let rtcCanvas: VideoCanvas = this._createVideoCanvas(setupVideoViewContext);

    return this._engine!.setupRemoteVideoEx(rtcCanvas,
      new RtcConnection(setupVideoViewContext.connection?.channelId, setupVideoViewContext.connection?.localUid));
  }

  onSetupRemoteVideo(call: MethodCall) {
    Log.i(TAG, 'onSetupRemoteVideo');

    if (this._engine === null) {
      return Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const setupVideoViewContext = JSON.parse(call.args) as DartRtcEngineSetupVideoViewContext;
    let rtcCanvas: VideoCanvas = this._createVideoCanvas(setupVideoViewContext);

    return this._engine!.setupRemoteVideo(rtcCanvas);
  }

  onSetupLocalVideo(call: MethodCall) {
    Log.i(TAG, 'onSetupLocalVideo');

    if (this._engine === null) {
      return Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const setupVideoViewContext = JSON.parse(call.args) as DartRtcEngineSetupVideoViewContext;
    let rtcCanvas: VideoCanvas = this._createVideoCanvas(setupVideoViewContext);

    return this._engine!.setupLocalVideo(rtcCanvas);
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    Log.d(TAG, 'onMethodCall: ' + call.method + ' width: ' + call.args);
    try {
      if (call.method == "getPlatformVersion") {
        result.success("OpenHarmony ^ ^ ");
      } else if (call.method == "ohosInit") {
        result.success(this.onOhosInit(call));
      } else if (call.method == "ohosDestroy") {
        result.success(this.onOhosDestroy(call));
      } else if (call.method == "enableVideo") {
        result.success(this.onEnableVideo(call));
      } else if (call.method == "setupRemoteVideoEx") {
        result.success(this.onSetupRemoteVideoEx(call));
      } else if (call.method == "setupRemoteVideo") {
        result.success(this.onSetupRemoteVideo(call));
      } else if (call.method == "setupLocalVideo") {
        result.success(this.onSetupLocalVideo(call));
      } else {
        result.notImplemented();
      }
    } catch (err) {
      const errorDetails = 'onMethodCall: ' + call.method + ', ' + err;
      Log.e(TAG, errorDetails);
      result.error(TAG, 'Handle method call failed', errorDetails);
    }
  }
}