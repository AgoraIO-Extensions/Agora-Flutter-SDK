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

import { AgoraLog } from './AgoraRtcUtils';

const TAG: string = "AgoraRtcVideoViewController";
const METHOD_CHANNEL: string = "agora_rtc_ng/video_view_controller";

export class AgoraRtcVideoViewController implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;

  constructor() {
    AgoraLog.i(TAG, 'constructor')
  }

  getUniqueClassName(): string {
    return TAG;
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    AgoraLog.i(TAG, 'attach to engine');

    this.channel = new MethodChannel(binding.getBinaryMessenger(), METHOD_CHANNEL);
    this.channel.setMethodCallHandler(this);

    AgoraLog.i(TAG, 'attached to engine');
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null);
    }

    AgoraLog.i(TAG, 'detached from engine');
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    AgoraLog.i(TAG, 'onMethodCall: ' + call.method + ' width: ' + call.args);
    try {
      if (call.method == "dispose") {
        result.success(true);
      } else if (call.method == "createTextureRender") {
        result.error(TAG, 'Handle method call failed', 'createTextureRender not implemented');
      } else if (call.method == "destroyTextureRender") {
        result.error(TAG, 'Handle method call failed', 'destroyTextureRender not implemented');
      } else if (call.method == "addPlatformRenderRef") {
        result.success(true);
      } else if (call.method == "dePlatfromViewRef") {
        result.success(true);
      } else {
        result.notImplemented();
      }
    } catch (err) {
      const errorDetails = 'onMethodCall: ' + call.method + ', ' + err;
      AgoraLog.e(TAG, errorDetails);
      result.error(TAG, 'Handle method call failed', errorDetails);
    }
  }
}