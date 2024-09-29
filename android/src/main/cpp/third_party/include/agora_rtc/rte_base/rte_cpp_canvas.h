#pragma once

#include "rte_base/c/c_player.h"
#include "rte_base/c/handle.h"
#include "rte_base/c/track/canvas.h"

#include "rte_cpp_error.h"
#include "rte_cpp_rte.h"
#include "rte_cpp_callback_utils.h"


namespace rte {

using VideoRenderMode = ::RteVideoRenderMode;
using VideoMirrorMode = ::RteVideoMirrorMode;
using ViewConfig = ::RteViewConfig;
using View = ::RteView;
using Rect = ::RteRect;

/**
 * The CanvasInitialConfig class is used to initialize the Canvas object.
 * @since v4.4.0
 * @technical preview
 */
class CanvasInitialConfig {
  public:
    CanvasInitialConfig() {RteCanvasInitialConfigInit(&c_canvas_initial_config, nullptr);}
    ~CanvasInitialConfig() {RteCanvasInitialConfigDeinit(&c_canvas_initial_config, nullptr);}
  
  private:
    friend class Canvas;
    ::RteCanvasInitialConfig c_canvas_initial_config;
};

/**
 * The CanvasConfig class is used to configure the Canvas object.
 * @since v4.4.0
 * @technical preview
 */
class CanvasConfig {
 public:
 CanvasConfig() {RteCanvasConfigInit(&c_canvas_config, nullptr);}
 ~CanvasConfig() {RteCanvasConfigDeinit(&c_canvas_config, nullptr);}

 /**
  * Set the Render Mode.
  * @since v4.4.0
  * @param mode 
  * @param err 
  * @return void
  * @technical preview
  */
 void SetRenderMode(VideoRenderMode mode, Error *err = nullptr) {
    RteCanvasConfigSetVideoRenderMode(&c_canvas_config, mode, err != nullptr ? err->get_underlying_impl() : nullptr);
 }

 /**
  * Get the Render Mode.
  * @since v4.4.0
  * @param err 
  * @return VideoRenderMode 
  * @technical preview
  */
  VideoRenderMode GetRenderMode(Error *err = nullptr) {
    VideoRenderMode mode;
    RteCanvasConfigGetVideoRenderMode(&c_canvas_config, &mode, err != nullptr ? err->get_underlying_impl() : nullptr);
    return mode;
 }

  /**
   * Set the Mirror Mode.
   * @since v4.4.0
   * @param mode
   * @param err
   * @return void
   * @technical preview
   */
  void SetMirrorMode(VideoMirrorMode mode, Error *err = nullptr) {
    RteCanvasConfigSetVideoMirrorMode(&c_canvas_config, mode, err != nullptr ? err->get_underlying_impl() : nullptr);
  }
  
  /**
   * Get the Mirror Mode.
   * @since v4.4.0
   * @param err
   * @return VideoMirrorMode
   */
  VideoMirrorMode GetMirrorMode(Error *err = nullptr) {
    VideoMirrorMode mode;
    RteCanvasConfigGetVideoMirrorMode(&c_canvas_config, &mode, err != nullptr ? err->get_underlying_impl() : nullptr);
    return mode;
  }

  /**
   * Set the Crop Area.
   * @since v4.4.0
   * @param crop_area
   * @param err
   * @return void
   * @technical preview
   */
  void SetCropArea(RteRect &crop_area, Error *err = nullptr) {
    RteCanvasConfigSetCropArea(&c_canvas_config, crop_area, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Get the Crop Area.
   * @since v4.4.0
   * @param err
   * @return RteRect
   * @technical preview
   */
  RteRect GetCropArea(Error *err = nullptr) {
    RteRect crop_area;
    RteCanvasConfigGetCropArea(&c_canvas_config, &crop_area, err != nullptr ? err->get_underlying_impl() : nullptr);
    return crop_area;
  }

 private:
  friend class Canvas;
  ::RteCanvasConfig c_canvas_config;
};

/**
 * The Canvas class is used to render the video stream.
 * @since v4.4.0
 * @technical preview
 */
class Canvas {
 public:
  Canvas(Rte *rte, CanvasInitialConfig *initial_config = nullptr) {
    c_canvas = ::RteCanvasCreate(&rte->c_rte, initial_config != nullptr ? &initial_config->c_canvas_initial_config : nullptr, nullptr);
  };
  ~Canvas() { RteCanvasDestroy(&c_canvas, nullptr); };

  Canvas(Canvas&& other) : c_canvas(other.c_canvas) {
    other.c_canvas = {};
  }

  //@{
  Canvas(const Canvas& other) = delete;
  Canvas& operator=(const Canvas& other) = delete;
  Canvas& operator=(Canvas&& other) = delete;
  //@}


  /**
   * Get the Configs object.
   * @since v4.4.0
   * @param config
   * @param err
   * @return true
   * @return false
   * @technical preview
   */
  bool GetConfigs(CanvasConfig *config, Error *err = nullptr) {
    return RteCanvasGetConfigs(&c_canvas, &config->c_canvas_config, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Set the Configs object.
   * @since v4.4.0
   * @param config
   * @param err
   * @return true
   * @return false
   * @technical preview
   */
  bool SetConfigs(CanvasConfig *config, Error *err = nullptr) {
    return RteCanvasSetConfigs(&c_canvas, &config->c_canvas_config, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Add the View object.
   * @since v4.4.0
   * @param view
   * @param config
   * @param err
   * @return true
   * @return false
   * @technical preview
   */
  bool AddView(View *view, ViewConfig *config, rte::Error *err = nullptr) {
    return RteCanvasAddView(&c_canvas, view, config, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Remove the View object.
   * @since v4.4.0
   * @param view 
   * @param config 
   * @param err 
   * @return true
   * @return false
   * @technical preview
   */
  bool RemoveView(View *view, ViewConfig *config, rte::Error *err = nullptr) {
    return RteCanvasRemoveView(&c_canvas, view, config, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

 private:

  friend class Player;

  ::RteCanvas c_canvas;
};

}  // namespace rte