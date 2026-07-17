import {
  Any,
  BinaryMessenger,
  MessageCodec,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
  PlatformView,
  PlatformViewFactory,
  StandardMethodCodec,
} from '@ohos/flutter_ohos';
import { Params } from '@ohos/flutter_ohos/src/main/ets/plugin/platform/PlatformView';
import { common } from '@kit.AbilityKit';

import { Constants } from '@shengwang/rtc-full';

import { AgoraLog } from './AgoraRtcUtils';

const TAG: string = 'AgoraPlatformViewFactory';

export class AgoraPlatformViewFactory extends PlatformViewFactory {
  private messenger: BinaryMessenger;

  constructor(messenger: BinaryMessenger, createArgsCodec: MessageCodec<Any>) {
    super(createArgsCodec);
    this.messenger = messenger;
  }

  public create(
    context: common.Context,
    viewId: number,
    args: Any,
  ): PlatformView {
    AgoraLog.i(TAG, 'create with viewId: ' + viewId);
    return new AgoraPlatformView(context, viewId, args, this.messenger);
  }
}

@Component
struct InternalComponent {
  @Prop params: Params;
  private platformView: AgoraPlatformView =
    this.params.platformView as AgoraPlatformView;

  build() {
    XComponent({
      id: AgoraPlatformView.getXComponentIdByViewId(
        this.platformView.getViewId(),
      ),
      type: XComponentType.SURFACE,
      libraryname: Constants.AGORA_LIB_NAME,
    })
      .backgroundColor(Color.Black)
      .direction(Direction.Ltr)
      .width('100%')
      .height('100%');
  }
}

@Builder
function PlatformViewBuilder(params: Params) {
  InternalComponent({ params: params });
}

@Observed
export class AgoraPlatformView
  extends PlatformView
  implements MethodCallHandler {
  public static VIEW_TYPE: string = 'AgoraOhosView';

  private methodChannel: MethodChannel;
  private uid: number = 0;
  private viewId: number = -1;

  public static getXComponentIdByViewId(viewId: number): string {
    return AgoraPlatformView.VIEW_TYPE + '_' + viewId.toString();
  }

  constructor(
    context: common.Context,
    viewId: number,
    args: Any,
    messenger: BinaryMessenger,
  ) {
    super();
    this.methodChannel = new MethodChannel(
      messenger,
      'agora_rtc_ng/' + AgoraPlatformView.VIEW_TYPE + '_' + viewId,
      StandardMethodCodec.INSTANCE,
    );
    this.methodChannel.setMethodCallHandler(this);

    const mapArgs = args as Map<string, number>;
    this.uid = mapArgs.get('uid') ?? 0;
    this.viewId = viewId;
    AgoraLog.i(
      TAG,
      'constructor with viewId: ' + viewId + ' uid: ' + this.uid,
    );
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    result.notImplemented();
  }

  public getUid(): number {
    return this.uid;
  }

  public getViewId(): number {
    return this.viewId;
  }

  getView(): WrappedBuilder<[Params]> {
    return new WrappedBuilder(PlatformViewBuilder);
  }

  dispose(): void {
    this.methodChannel.setMethodCallHandler(null);
  }
}
