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

import {
  Constants,
  VideoCanvas,
  LogConfig,
  RtcEngine,
  RtcEngineEx,
  RtcEngineConfig,
  RtcConnection
} from '@shengwang/rtc-full';

import { setIrisDefaultLogPath, } from '@shengwang/rtc-wrapper';

import { AgoraPlatformViewFactory, AgoraPlatformView } from './AgoraPlatformViewFactory';
import { AgoraRtcVideoViewController } from './AgoraRtcVideoViewController';

import { AgoraLog } from './AgoraRtcUtils';

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
  public setupMode?: number = undefined;
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
    AgoraLog.i(TAG, 'constructor')
  }

  getUniqueClassName(): string {
    return TAG;
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    AgoraLog.i(TAG, 'attach to engine');

    binding.getPlatformViewRegistry()?.
    registerViewFactory(AgoraPlatformView.VIEW_TYPE,
      new AgoraPlatformViewFactory(binding.getBinaryMessenger(), StandardMessageCodec.INSTANCE));

    binding.getFlutterEngine()?.getPlugins()?.add(new AgoraRtcVideoViewController());

    this.channel = new MethodChannel(binding.getBinaryMessenger(), METHOD_CHANNEL);
    this.channel.setMethodCallHandler(this);

    setIrisDefaultLogPath(binding.getApplicationContext()!.filesDir); // /data/app/el2/<USERID>/base/<PACKAGENAME>/base/files

    AgoraLog.i(TAG, 'attached to engine');
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null);
    }

    AgoraLog.i(TAG, 'detached from engine');
  }

  onOhosInit(call: MethodCall) {
    AgoraLog.i(TAG, 'onOhosInit');

    if (this._engine !== null) {
      AgoraLog.w(TAG, 'already created rtc engine');
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

    if (config.mLogConfig == undefined || config.mLogConfig!.filePath == undefined) {
      let logPath = config.mContext?.filesDir; // /data/app/el2/<USERID>/base/<PACKAGENAME>/haps/<module-name>/files
      if (logPath !== undefined) {
        setIrisDefaultLogPath(logPath);
      }
    }

    this._engine = RtcEngine.create(config) as RtcEngineEx;
    if (this._engine === null) {
      throw Error('create rtc engine failed');
    }

    AgoraLog.i(TAG, 'native handle: ' + this._engine!.getNativeHandle().toString());

    return this._engine!.getNativeHandle().toString();
  }

  onOhosDestroy(call: MethodCall) {
    AgoraLog.i(TAG, 'onOhosDestroy');

    if (this._engine === null) {
      AgoraLog.w(TAG, 'already destroyed rtc engine');
      return 0;
    }

    RtcEngine.destroy();

    this._engine = null;

    AgoraLog.i(TAG, 'onOhosDestroy finished');

    return 0;
  }

  onEnableVideo(call: MethodCall) {
    AgoraLog.i(TAG, 'onEnableVideo');

    if (this._engine === null) {
      return Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const ret = this._engine!.enableVideo();

    AgoraLog.i(TAG, 'onEnableVideo finished, ret: ' + ret);

    return ret;
  }

  _createVideoCanvas(param: DartRtcEngineSetupVideoViewContext): VideoCanvas {
    // Replace 0, Add 1, Remove 2
    let xcomponentId: string = param.canvas!.setupMode === 2 ? "" : AgoraPlatformView.getXComponentIdByViewId(param.canvas!.view!);

    let rtcCanvas: VideoCanvas = new VideoCanvas(xcomponentId, false);
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
    AgoraLog.i(TAG, 'onSetupRemoteVideoEx');

    if (this._engine === null) {
      return Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const setupVideoViewContext = JSON.parse(call.args) as DartRtcEngineSetupVideoViewContext;
    let rtcCanvas: VideoCanvas = this._createVideoCanvas(setupVideoViewContext);

    const ret = this._engine!.setupRemoteVideoEx(rtcCanvas,
      new RtcConnection(setupVideoViewContext.connection?.channelId, setupVideoViewContext.connection?.localUid));

    AgoraLog.i(TAG, 'onSetupRemoteVideoEx finished, ret: ' + ret);

    return ret;
  }

  onSetupRemoteVideo(call: MethodCall) {
    AgoraLog.i(TAG, 'onSetupRemoteVideo');

    if (this._engine === null) {
      return Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const setupVideoViewContext = JSON.parse(call.args) as DartRtcEngineSetupVideoViewContext;
    let rtcCanvas: VideoCanvas = this._createVideoCanvas(setupVideoViewContext);

    const ret = this._engine!.setupRemoteVideo(rtcCanvas);

    AgoraLog.i(TAG, 'onSetupRemoteVideo finished, ret: ' + ret);

    return ret;
  }

  onSetupLocalVideo(call: MethodCall) {
    AgoraLog.i(TAG, 'onSetupLocalVideo');

    if (this._engine === null) {
      return Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const setupVideoViewContext = JSON.parse(call.args) as DartRtcEngineSetupVideoViewContext;
    let rtcCanvas: VideoCanvas = this._createVideoCanvas(setupVideoViewContext);

    const ret = this._engine!.setupLocalVideo(rtcCanvas);

    AgoraLog.i(TAG, 'onSetupLocalVideo finished, ret: ' + ret);

    return ret;
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    AgoraLog.d(TAG, 'onMethodCall: ' + call.method + ' width: ' + call.args);
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
        AgoraLog.w(TAG, 'onMethodCall: ' + call.method + ' not implemented');
        result.notImplemented();
      }
    } catch (err) {
      const errorDetails = 'onMethodCall: ' + call.method + ', ' + err;
      AgoraLog.e(TAG, errorDetails);
      result.error(TAG, 'Handle method call failed', errorDetails);
    }
  }
}