import {
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
  StandardMessageCodec,
} from '@ohos/flutter_ohos';

import { common } from '@kit.AbilityKit';
import { JSON } from '@kit.ArkTS';

import {
  Constants,
  LogConfig,
  RtcConnection,
  RtcEngine,
  RtcEngineConfig,
  RtcEngineEx,
  VideoCanvas,
} from '@shengwang/rtc-full';
import {
  createRtcEventHandler,
  destroyRtcEventHandler,
  notifyRtcEventHandlerNativeEngineCreated,
  notifyRtcEventHandlerNativeEngineDestroyed,
  setIrisDefaultLogPath,
} from '@shengwang/rtc-wrapper';

import {
  AgoraPlatformView,
  AgoraPlatformViewFactory,
} from './AgoraPlatformViewFactory';
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

const TAG: string = 'AgoraRtcEnginePlugin';
const METHOD_CHANNEL: string = 'agora_rtc_ng';

export default class AgoraRtcEnginePlugin
  implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;
  private applicationContext: common.Context | null = null;
  private engine: RtcEngineEx | null = null;
  private nativeEventHandler: BigInt | null = null;

  constructor() {
    AgoraLog.i(TAG, 'constructor');
  }

  getUniqueClassName(): string {
    return TAG;
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    AgoraLog.i(TAG, 'attach to engine');

    binding.getPlatformViewRegistry()?.registerViewFactory(
      AgoraPlatformView.VIEW_TYPE,
      new AgoraPlatformViewFactory(
        binding.getBinaryMessenger(),
        StandardMessageCodec.INSTANCE,
      ),
    );

    binding.getFlutterEngine()?.getPlugins()?.add(
      new AgoraRtcVideoViewController(),
    );

    this.channel = new MethodChannel(
      binding.getBinaryMessenger(),
      METHOD_CHANNEL,
    );
    this.channel.setMethodCallHandler(this);

    this.applicationContext = binding.getApplicationContext();
    if (this.applicationContext.filesDir !== undefined) {
      setIrisDefaultLogPath(this.applicationContext.filesDir);
    }

    AgoraLog.i(TAG, 'attached to engine');
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel !== null) {
      this.channel.setMethodCallHandler(null);
    }
    this.channel = null;
    this.applicationContext = null;

    AgoraLog.i(TAG, 'detached from engine');
  }

  private onOhosInit(call: MethodCall): string {
    AgoraLog.i(TAG, 'onOhosInit');

    if (this.engine !== null) {
      AgoraLog.w(TAG, 'already created rtc engine');
      if (this.nativeEventHandler === null) {
        throw new Error('rtc engine exists without native event handler');
      }
      return JSON.stringify({
        engine: this.engine.getNativeHandle().toString(),
        eventHandler: this.nativeEventHandler.toString(),
      });
    }
    if (this.applicationContext === null) {
      throw new Error('plugin is not attached to a Flutter engine');
    }

    const initContext =
      JSON.parse(call.args as string) as DartRtcEngineInitContext;
    const config: RtcEngineConfig = new RtcEngineConfig();
    config.mContext = this.applicationContext as common.UIAbilityContext;

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
        config.mLogConfig.level = initContext.logConfig.level;
      }
    }

    if (config.mLogConfig === undefined ||
      config.mLogConfig.filePath === undefined) {
      const logPath = this.applicationContext.filesDir;
      if (logPath !== undefined) {
        setIrisDefaultLogPath(logPath);
      }
    }

    const nativeEventHandler = createRtcEventHandler();
    this.nativeEventHandler = nativeEventHandler;
    const nativeEventHandlerHandle = nativeEventHandler.toString();
    this.engine = RtcEngine.createWithNativeEventHandler(
      config,
      nativeEventHandlerHandle,
    ) as RtcEngineEx;
    if (this.engine === null) {
      destroyRtcEventHandler(nativeEventHandler);
      this.nativeEventHandler = null;
      throw new Error('create rtc engine failed');
    }
    notifyRtcEventHandlerNativeEngineCreated(nativeEventHandler);

    const nativeHandle = this.engine.getNativeHandle().toString();
    AgoraLog.i(TAG, 'native handle: ' + nativeHandle);
    return JSON.stringify({
      engine: nativeHandle,
      eventHandler: nativeEventHandlerHandle,
    });
  }

  private onOhosDestroy(result: MethodResult): void {
    AgoraLog.i(TAG, 'onOhosDestroy');

    if (this.engine === null) {
      AgoraLog.w(TAG, 'already destroyed rtc engine');
      result.success(0);
      return;
    }

    RtcEngine.destroy()
      .then(() => {
        const nativeEventHandler = this.nativeEventHandler;
        if (nativeEventHandler !== null) {
          notifyRtcEventHandlerNativeEngineDestroyed(nativeEventHandler);
          const result = destroyRtcEventHandler(nativeEventHandler);
          if (result !== 0) {
            throw new Error('failed to destroy native rtc event handler: ' + result);
          }
          this.nativeEventHandler = null;
        }
        this.engine = null;
        AgoraLog.i(TAG, 'onOhosDestroy finished');
        result.success(0);
      })
      .catch((error: Error) => {
        const details = 'onOhosDestroy failed, ' + error;
        AgoraLog.e(TAG, details);
        result.error(TAG, 'Handle method call failed', details);
      });
  }

  private onEnableVideo(call: MethodCall): number {
    AgoraLog.i(TAG, 'onEnableVideo');

    if (this.engine === null) {
      return -Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const result = this.engine.enableVideo();
    AgoraLog.i(TAG, 'onEnableVideo finished, result: ' + result);
    return result;
  }

  private createVideoCanvas(
    param: DartRtcEngineSetupVideoViewContext,
  ): VideoCanvas {
    const canvas = param.canvas;
    if (canvas === undefined) {
      throw new Error('canvas is required');
    }

    let xComponentId: string = '';
    if (canvas.setupMode !== 2) {
      if (canvas.view === undefined) {
        throw new Error('canvas.view is required');
      }
      xComponentId =
        AgoraPlatformView.getXComponentIdByViewId(canvas.view);
    }

    const rtcCanvas = new VideoCanvas(xComponentId, false);
    rtcCanvas.uid = canvas.uid ?? 0;
    if (canvas.renderMode !== undefined) {
      rtcCanvas.renderMode = canvas.renderMode;
    }
    if (canvas.mirrorMode !== undefined) {
      rtcCanvas.mirrorMode = canvas.mirrorMode;
    }
    if (canvas.sourceType !== undefined) {
      rtcCanvas.sourceType = canvas.sourceType;
    }
    return rtcCanvas;
  }

  private validateSetupMode(
    context: DartRtcEngineSetupVideoViewContext,
  ): number {
    if (context.canvas?.setupMode === 1) {
      AgoraLog.w(TAG, 'videoViewSetupAdd is not supported on OHOS');
      return -Constants.ErrorCode.ERR_NOT_SUPPORTED;
    }
    return 0;
  }

  private onSetupRemoteVideoEx(call: MethodCall): number {
    AgoraLog.i(TAG, 'onSetupRemoteVideoEx ' + call.args);

    if (this.engine === null) {
      return -Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const context =
      JSON.parse(call.args as string) as DartRtcEngineSetupVideoViewContext;
    const setupModeResult = this.validateSetupMode(context);
    if (setupModeResult < 0) {
      return setupModeResult;
    }
    const connection = context.connection;
    if (connection === undefined || connection.channelId === undefined) {
      throw new Error('connection.channelId is required');
    }

    const result = this.engine.setupRemoteVideoEx(
      this.createVideoCanvas(context),
      new RtcConnection(connection.channelId, connection.localUid ?? 0),
    );
    AgoraLog.i(TAG, 'onSetupRemoteVideoEx finished, result: ' + result);
    return result;
  }

  private onSetupRemoteVideo(call: MethodCall): number {
    AgoraLog.i(TAG, 'onSetupRemoteVideo ' + call.args);

    if (this.engine === null) {
      return -Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const context =
      JSON.parse(call.args as string) as DartRtcEngineSetupVideoViewContext;
    const setupModeResult = this.validateSetupMode(context);
    if (setupModeResult < 0) {
      return setupModeResult;
    }
    const result = this.engine.setupRemoteVideo(
      this.createVideoCanvas(context),
    );
    AgoraLog.i(TAG, 'onSetupRemoteVideo finished, result: ' + result);
    return result;
  }

  private onSetupLocalVideo(call: MethodCall): number {
    AgoraLog.i(TAG, 'onSetupLocalVideo ' + call.args);

    if (this.engine === null) {
      return -Constants.ErrorCode.ERR_NOT_INITIALIZED;
    }

    const context =
      JSON.parse(call.args as string) as DartRtcEngineSetupVideoViewContext;
    const setupModeResult = this.validateSetupMode(context);
    if (setupModeResult < 0) {
      return setupModeResult;
    }
    const result = this.engine.setupLocalVideo(
      this.createVideoCanvas(context),
    );
    AgoraLog.i(TAG, 'onSetupLocalVideo finished, result: ' + result);
    return result;
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    AgoraLog.d(
      TAG,
      'onMethodCall: ' + call.method + ' args: ' + call.args,
    );
    try {
      if (call.method === 'getPlatformVersion') {
        result.success('OpenHarmony');
      } else if (call.method === 'ohosInit') {
        result.success(this.onOhosInit(call));
      } else if (call.method === 'ohosDestroy') {
        this.onOhosDestroy(result);
      } else if (call.method === 'enableVideo') {
        result.success(this.onEnableVideo(call));
      } else if (call.method === 'setupRemoteVideoEx') {
        result.success(this.onSetupRemoteVideoEx(call));
      } else if (call.method === 'setupRemoteVideo') {
        result.success(this.onSetupRemoteVideo(call));
      } else if (call.method === 'setupLocalVideo') {
        result.success(this.onSetupLocalVideo(call));
      } else {
        AgoraLog.w(TAG, 'onMethodCall: ' + call.method + ' not implemented');
        result.notImplemented();
      }
    } catch (error) {
      const details = 'onMethodCall: ' + call.method + ', ' + error;
      AgoraLog.e(TAG, details);
      result.error(TAG, 'Handle method call failed', details);
    }
  }
}
