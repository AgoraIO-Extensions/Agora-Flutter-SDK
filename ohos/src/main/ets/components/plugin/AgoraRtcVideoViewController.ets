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

const TAG: string = "AgoraRtcVideoViewController";
const METHOD_CHANNEL: string = "agora_rtc_ng/video_view_controller";

export class AgoraRtcVideoViewController implements FlutterPlugin, MethodCallHandler {
  private channel: MethodChannel | null = null;

  constructor() {
    Log.i(TAG, 'constructor')
  }

  getUniqueClassName(): string {
    return TAG;
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    Log.i(TAG, 'attach to engine');

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

  onMethodCall(call: MethodCall, result: MethodResult): void {
    Log.d(TAG, 'onMethodCall: ' + call.method + ' width: ' + call.args);
    try {
      if (call.method == "dePlatfromViewRef") {
        result.success(true);
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