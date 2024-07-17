#pragma once

#include "internal/c/c_player.h"
#include "internal/c/handle.h"
#include "internal/c/track/canvas.h"

#include "rte_cpp_error.h"
#include "rte_cpp_rte.h"
#include "rte_cpp_callback_utils.h"


namespace rte {

using VideoRenderMode = ::RteVideoRenderMode;
using VideoMirrorMode = ::RteVideoMirrorMode;
using ViewConfig = ::RteViewConfig;
using View = ::RteView;
using Rect = ::RteRect;

class CanvasInitialConfig {
  public:
    CanvasInitialConfig() {RteCanvasInitialConfigInit(&c_canvas_initial_config, nullptr);}
    ~CanvasInitialConfig() {RteCanvasInitialConfigDeinit(&c_canvas_initial_config, nullptr);}
  
  private:
    friend class Canvas;
    ::RteCanvasInitialConfig c_canvas_initial_config;
};


class CanvasConfig {
 public:
 CanvasConfig() {RteCanvasConfigInit(&c_canvas_config, nullptr);}
 ~CanvasConfig() {RteCanvasConfigDeinit(&c_canvas_config, nullptr);}

 void SetRenderMode(VideoRenderMode mode, Error *err) {
    RteCanvasConfigSetVideoRenderMode(&c_canvas_config, mode, err != nullptr ? err->get_underlying_impl() : nullptr);
 }

 VideoRenderMode GetRenderMode(Error *err) {
    VideoRenderMode mode;
    RteCanvasConfigGetVideoRenderMode(&c_canvas_config, &mode, err != nullptr ? err->get_underlying_impl() : nullptr);
    return mode;
 }

  void SetMirrorMode(VideoMirrorMode mode, Error *err) {
      RteCanvasConfigSetVideoMirrorMode(&c_canvas_config, mode, err != nullptr ? err->get_underlying_impl() : nullptr);
  }
  
  VideoMirrorMode GetMirrorMode(Error *err) {
      VideoMirrorMode mode;
      RteCanvasConfigGetVideoMirrorMode(&c_canvas_config, &mode, err != nullptr ? err->get_underlying_impl() : nullptr);
      return mode;
  }

  void SetCropArea(RteRect &crop_area, Error *err) {
      RteCanvasConfigSetCropArea(&c_canvas_config, crop_area, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  RteRect GetCropArea(Error *err) {
      RteRect crop_area;
      RteCanvasConfigGetCropArea(&c_canvas_config, &crop_area, err != nullptr ? err->get_underlying_impl() : nullptr);
      return crop_area;
  }

 private:
  friend class Canvas;
  ::RteCanvasConfig c_canvas_config;
};

class Canvas {
 public:
  Canvas(Rte *rte, CanvasInitialConfig *initial_config) {
    c_canvas = ::RteCanvasCreate(&rte->c_rte, &initial_config->c_canvas_initial_config, nullptr);
  };
  ~Canvas() { RteCanvasDestroy(&c_canvas, nullptr); };

  void Destroy(Error *err = nullptr) {
    RteCanvasDestroy(&c_canvas,
                     err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  Canvas(const Canvas& other) = delete;
  Canvas(Canvas&& other) = delete;
  Canvas& operator=(const Canvas& other) = delete;
  Canvas& operator=(Canvas&& other) = delete;

  void GetConfigs(CanvasConfig *config, Error *err) {
    RteCanvasGetConfigs(&c_canvas, &config->c_canvas_config, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  void SetConfigs(CanvasConfig *config, std::function<void(Canvas* canvas, void *cb_data, rte::Error *err)> cb, void *cb_data) {
    CallbackContext<Canvas>* callbackCtx = new CallbackContext<Canvas>(this, cb, cb_data);
    RteCanvasSetConfigs(&c_canvas, &config->c_canvas_config, &CallbackFunc<::RteCanvas, Canvas>, callbackCtx);
  }

  void AddView(View *view, ViewConfig *config, std::function<void(Canvas* canvas, View* view, void *cb_data, rte::Error *err)> cb, void *cb_data) {
    CallbackContextWithArgs<Canvas, View*> *ctx = new CallbackContextWithArgs<Canvas, View*>(this, cb, cb_data);
    RteCanvasAddView(&c_canvas, view, config, &CallbackFuncWithArgs<::RteCanvas, Canvas, View*>, ctx);
  }

 private:

  friend class Player;

  ::RteCanvas c_canvas;
};

}  // namespace rte