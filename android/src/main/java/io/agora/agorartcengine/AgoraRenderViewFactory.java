package io.agora.agorartcengine;

import android.content.Context;
import android.view.SurfaceView;

import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

import io.agora.rtc.RtcEngine;

public class AgoraRenderViewFactory extends PlatformViewFactory {
  private final AgoraRtcEnginePlugin mEnginePlugin;

  public AgoraRenderViewFactory(MessageCodec<Object> createArgsCodec, AgoraRtcEnginePlugin enginePlugin) {
    super(createArgsCodec);
    this.mEnginePlugin = enginePlugin;
  }

  @Override
  public PlatformView create(Context context, int id, Object o) {
    SurfaceView view = RtcEngine.CreateRendererView(context.getApplicationContext());
    AgoraRendererView rendererView = new AgoraRendererView(view, id);
    mEnginePlugin.addView(view, id);
    return rendererView;
  }
}