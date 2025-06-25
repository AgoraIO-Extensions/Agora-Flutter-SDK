import MethodChannel, {
  MethodCallHandler,
  MethodResult
} from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodChannel';
import PlatformView, { Params } from '@ohos/flutter_ohos/src/main/ets/plugin/platform/PlatformView';
import PlatformViewFactory from '@ohos/flutter_ohos/src/main/ets/plugin/platform/PlatformViewFactory';
import { BinaryMessenger } from '@ohos/flutter_ohos/src/main/ets/plugin/common/BinaryMessenger';
import StandardMethodCodec from '@ohos/flutter_ohos/src/main/ets/plugin/common/StandardMethodCodec';
import MessageCodec from '@ohos/flutter_ohos/src/main/ets/plugin/common/MessageCodec';
import MethodCall from '@ohos/flutter_ohos/src/main/ets/plugin/common/MethodCall';

import common from '@ohos.app.ability.common';

import { AgoraLog } from './AgoraRtcUtils';

import { Constants, } from '@shengwang/rtc-full';

const TAG: string = "AgoraPlatformViewFactory";

export class AgoraPlatformViewFactory extends PlatformViewFactory {
  message: BinaryMessenger;

  constructor(message: BinaryMessenger, createArgsCodes: MessageCodec<Object>) {
    super(createArgsCodes);
    this.message = message;
  }

  public create(context: common.Context, viewId: number, args: Object): PlatformView {
    AgoraLog.i(TAG, 'AgoraPlatformViewFactory create with viewId: ' + viewId);
    return new AgoraPlatformView(context, viewId, args, this.message);
  }
}

@Component
struct InternalComponent {
  @Prop params: Params
  platformView: AgoraPlatformView = this.params.platformView as AgoraPlatformView

  build() {
    XComponent({
      id: AgoraPlatformView.getXComponentIdByViewId(this.platformView.getViewId()),
      type: XComponentType.SURFACE,
      libraryname: Constants.AGORA_LIB_NAME
    })
      .backgroundColor(Color.Black)
      .direction(Direction.Ltr)
      .width('100%')
      .height('100%')
  }
}

@Builder
function PlatformViewBuilder(params: Params) {
  InternalComponent({ params: params })
}

@Observed
export class AgoraPlatformView extends PlatformView implements MethodCallHandler {
  public static VIEW_TYPE: string = 'AgoraOhosView';
  private methodChannel: MethodChannel;
  private uid: number = -1;
  private viewId: number = -1;

  public static getXComponentIdByViewId(viewId: number): string {
    return `${AgoraPlatformView.VIEW_TYPE}_${viewId.toString()}`;
  }

  constructor(context: common.Context, viewId: number, args: ESObject, message: BinaryMessenger) {
    super();
    this.methodChannel =
      new MethodChannel(message, `agora_rtc_ng/${AgoraPlatformView.VIEW_TYPE}_${viewId}`, StandardMethodCodec.INSTANCE);
    this.methodChannel.setMethodCallHandler(this);

    const mapArgs: Map<string, number> = args;
    this.uid = mapArgs.get('uid') || 0;
    this.viewId = viewId;
    AgoraLog.i(TAG, 'AgoraPlatformView constructor with viewId: ' + viewId + ' with uid: ' + this.uid);
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
  }

  public getUid(): number {
    return this.uid;
  }

  public getViewId(): number {
    return this.viewId;
  }

  public sendMessage = () => {
  }

  getView(): WrappedBuilder<[Params]> {
    return new WrappedBuilder(PlatformViewBuilder);
  }

  dispose(): void {
  }
}