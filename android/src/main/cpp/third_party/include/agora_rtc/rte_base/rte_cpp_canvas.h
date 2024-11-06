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
 */
class CanvasConfig {
 public:
 CanvasConfig() {RteCanvasConfigInit(&c_canvas_config, nullptr);}
 ~CanvasConfig() {RteCanvasConfigDeinit(&c_canvas_config, nullptr);}

 /**
  * Set the video render mode.
  * @since v4.4.0
  * @param mode The render mode to set. Refer to the rte::VideoRenderMode type, default is kRteVideoRenderModeHidden.
  * @param err Possible return values for ErrorCode:
  *  - kRteOk: Success
  *  - kRteErrorInvalidArgument: The mode parameter is set to an illegal value.
  * @return void
  */
 void SetRenderMode(VideoRenderMode mode, Error *err = nullptr) {
    RteCanvasConfigSetVideoRenderMode(&c_canvas_config, mode, err != nullptr ? err->get_underlying_impl() : nullptr);
 }

 /**
  * Get the render mode.
  * @since v4.4.0
  * @param err Possible return values for ErrorCode:
  *  - kRteOk: Success
  * @return VideoRenderMode 
  */
  VideoRenderMode GetRenderMode(Error *err = nullptr) {
    VideoRenderMode mode;
    RteCanvasConfigGetVideoRenderMode(&c_canvas_config, &mode, err != nullptr ? err->get_underlying_impl() : nullptr);
    return mode;
 }

  /**
   * Set the video mirror mode.
   * @since v4.4.0
   * @param mode The mirror mode to set. Refer to the rte::VideoMirrorMode type, default is kRteVideoMirrorModeAuto.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidArgument: The mode parameter is set to an illegal value.
   * @return void
   */
  void SetMirrorMode(VideoMirrorMode mode, Error *err = nullptr) {
    RteCanvasConfigSetVideoMirrorMode(&c_canvas_config, mode, err != nullptr ? err->get_underlying_impl() : nullptr);
  }
  
  /**
   * Get the video mirror mode.
   * @since v4.4.0
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   * @return VideoMirrorMode The current video mirror mode.
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
 */
class Canvas {
 public:
  /**
   * Construct a Canvas object.
   * @since v4.4.0
   * @param rte Rte object.
   * @param initial_config CanvasInitialConfig initialization configuration object. Currently, a null pointer can be passed.
   */
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
   * Get the configuration of Canvas object.
   * @since v4.4.0
   * @param config The object used to get the canvas config configuration.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Canvas object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The passed config object is null.
   * @return bool Returns the result of getting the configuration information.
   *  - true: Successfully retrieved.
   *  - false: Failed to retrieve.
   */
  bool GetConfigs(CanvasConfig *config, Error *err = nullptr) {
    return RteCanvasGetConfigs(&c_canvas, &config->c_canvas_config, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Configure the Canvas object.
   * @since v4.4.0
   * @param config The object used to set the canvas config configuration.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Canvas object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The passed config object is null.
   * @return bool Returns the result of setting the configuration information.
   *  - true: Successfully set the configuration.
   *  - false: Failed to set the configuration.
   */
  bool SetConfigs(CanvasConfig *config, Error *err = nullptr) {
    return RteCanvasSetConfigs(&c_canvas, &config->c_canvas_config, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /**
   * Add a rendering view. Currently, only one view is supported.
   * @since v4.4.0
   * @param view Pointer to the View object. On the Windows platform, you can assign an HWND window handle to a View type variable and pass it to the interface.
   * @param config View-related configuration. Currently, nullptr can be passed.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Canvas object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The passed view is null.
   * @return bool Returns the result of adding the View.
   *  - true: Successfully add the View.
   *  - false: Failed to add the View.
   */
  bool AddView(View *view, ViewConfig *config, rte::Error *err = nullptr) {
    return RteCanvasAddView(&c_canvas, view, config, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

  /** 
   * Remove a rendering view.
   * @since v4.4.0
   * @param view Pointer to the View object.
   * @param config View-related configuration. Currently, nullptr can be passed.
   * @param err Possible return values for ErrorCode:
   *  - kRteOk: Success
   *  - kRteErrorInvalidOperation: The corresponding internal Canvas object has been destroyed or is invalid.
   *  - kRteErrorInvalidArgument: The passed view is null.
   * @return bool Returns the result of removing the View.
   *  - true: Successfully removed the View.
   *  - false: Failed to remove the View.
   */
  bool RemoveView(View *view, ViewConfig *config, rte::Error *err = nullptr) {
    return RteCanvasRemoveView(&c_canvas, view, config, err != nullptr ? err->get_underlying_impl() : nullptr);
  }

 private:

  friend class Player;

  ::RteCanvas c_canvas;
};

}  // namespace rte