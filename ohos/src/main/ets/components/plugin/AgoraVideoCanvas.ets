/*
* Copyright (c) 2023 Hunan OpenValley Digital Industry Development Co., Ltd.
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

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

import Log from '@ohos/flutter_ohos/src/main/ets/util/Log';

import { Constants, } from '@shengwang/rtc-full';

export class AgoraVideoCanvasFactory extends PlatformViewFactory {
  message: BinaryMessenger;

  constructor(message: BinaryMessenger, createArgsCodes: MessageCodec<Object>) {
    super(createArgsCodes);
    this.message = message;
  }

  public create(context: common.Context, viewId: number, args: Object): PlatformView {
    return new AgoraVideoCanvas(context, viewId, args, this.message);
  }
}

@Component
struct InternalComponent {
  @Prop params: Params
  canvas: AgoraVideoCanvas = this.params.platformView as AgoraVideoCanvas

  build() {
    XComponent({
      id: AgoraVideoCanvas.getXComponentIdByViewId(this.canvas.getViewId()),
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
function CanvasBuilder(params: Params) {
  InternalComponent({ params: params })
}

@Observed
export class AgoraVideoCanvas extends PlatformView implements MethodCallHandler {
  public static VIEW_TYPE: string = 'AgoraOhosView';
  private methodChannel: MethodChannel;
  private uid: number = -1;
  private viewId: number = -1;

  public static getXComponentIdByViewId(viewId: number): string {
    return `${AgoraVideoCanvas.VIEW_TYPE}_${viewId.toString()}`;
  }

  constructor(context: common.Context, viewId: number, args: ESObject, message: BinaryMessenger) {
    super();
    this.methodChannel =
      new MethodChannel(message, `agora_rtc_ng/${AgoraVideoCanvas.VIEW_TYPE}_${viewId}`, StandardMethodCodec.INSTANCE);
    this.methodChannel.setMethodCallHandler(this);

    const mapArgs: Map<string, number> = args;
    this.uid = mapArgs.get('uid') || 0;
    this.viewId = viewId;
    Log.i('AgoraVideoCanvas', 'constructor with viewId: ' + viewId + ' with uid: ' + this.uid);
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
    return new WrappedBuilder(CanvasBuilder);
  }

  dispose(): void {
  }
}