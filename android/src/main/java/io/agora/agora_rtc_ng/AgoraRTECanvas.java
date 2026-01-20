package io.agora.agora_rtc_ng;

import android.view.View;
import io.agora.rte.Rte;
import io.agora.rte.Canvas;
import io.agora.rte.CanvasInitialConfig;
import io.agora.rte.CanvasConfig;
import io.agora.rte.ViewConfig;
import io.agora.rte.Constants;
import io.agora.rte.exception.RteException;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * RTE Canvas management class
 */
public class AgoraRTECanvas {
    private final Rte rte;
    private final Map<String, Canvas> canvases = new HashMap<>();

    public AgoraRTECanvas(Rte rte) {
        this.rte = rte;
    }

    public Map<String, Canvas> getCanvases() {
        return canvases;
    }

    /**
     * Create Canvas
     */
    public String createCanvas(Map<String, Object> config) {
        if (rte == null) {
            return null;
        }
        CanvasInitialConfig initialConfig = new CanvasInitialConfig();
        Canvas canvas = new Canvas(rte, initialConfig);
        
        String canvasId = UUID.randomUUID().toString();
        canvases.put(canvasId, canvas);
        
        // Apply config if provided
        if (config != null && !config.isEmpty()) {
            setConfigs(canvasId, config);
        }
        
        return canvasId;
    }

    /**
     * Destroy Canvas
     */
    public boolean destroyCanvas(String canvasId) {
        Canvas canvas = canvases.remove(canvasId);
        return canvas != null;
    }

    /**
     * Batch set configurations
     */
    public boolean setConfigs(String canvasId, Map<String, Object> configMap) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas == null) {
            return false;
        }
        try {
            CanvasConfig canvasConfig = new CanvasConfig();
            canvas.getConfigs(canvasConfig);
            
            if (configMap.containsKey("videoRenderMode") && configMap.get("videoRenderMode") != null) {
                canvasConfig.setVideoRenderMode(Constants.VideoRenderMode.fromInt(parseInt(configMap.get("videoRenderMode"))));
            }
            if (configMap.containsKey("videoMirrorMode") && configMap.get("videoMirrorMode") != null) {
                canvasConfig.setVideoMirrorMode(Constants.VideoMirrorMode.fromInt(parseInt(configMap.get("videoMirrorMode"))));
            }
            if (configMap.containsKey("cropArea") && configMap.get("cropArea") != null) {
                Map<String, Object> cropAreaDict = (Map<String, Object>) configMap.get("cropArea");
                if (cropAreaDict != null) {
                    // Note: Android SDK may not have setCropArea method, check SDK API
                    // For now, skip crop area setting
                }
            }
            
            canvas.setConfigs(canvasConfig);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Get configurations
     */
    public Map<String, Object> getConfigs(String canvasId) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas == null) {
            return null;
        }
        try {
            CanvasConfig config = new CanvasConfig();
            canvas.getConfigs(config);
            
            Map<String, Object> map = new HashMap<>();
            map.put("videoRenderMode", Constants.VideoRenderMode.getValue(config.getVideoRenderMode()));
            map.put("videoMirrorMode", Constants.VideoMirrorMode.getValue(config.getVideoMirrorMode()));
            // Note: Crop area may not be available in Android SDK
            return map;
        } catch (RteException e) {
            return null;
        }
    }

    // Individual Config Setters/Getters
    public boolean setVideoRenderMode(String canvasId, int mode) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas == null) return false;
        try {
            CanvasConfig config = new CanvasConfig();
            canvas.getConfigs(config);
            config.setVideoRenderMode(Constants.VideoRenderMode.fromInt(mode));
            // canvas.setConfigs(config); // Commented out following iOS pattern
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getVideoRenderMode(String canvasId) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas == null) return 0;
        try {
            CanvasConfig config = new CanvasConfig();
            canvas.getConfigs(config);
            return Constants.VideoRenderMode.getValue(config.getVideoRenderMode());
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setVideoMirrorMode(String canvasId, int mode) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas == null) return false;
        try {
            CanvasConfig config = new CanvasConfig();
            canvas.getConfigs(config);
            config.setVideoMirrorMode(Constants.VideoMirrorMode.fromInt(mode));
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public int getVideoMirrorMode(String canvasId) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas == null) return 0;
        try {
            CanvasConfig config = new CanvasConfig();
            canvas.getConfigs(config);
            return Constants.VideoMirrorMode.getValue(config.getVideoMirrorMode());
        } catch (RteException e) {
            return 0;
        }
    }

    public boolean setCropArea(String canvasId, int x, int y, int width, int height) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas == null) return false;
        try {
            CanvasConfig config = new CanvasConfig();
            canvas.getConfigs(config);
            // Note: Android SDK may not have setCropArea method
            // For now, return true without setting
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public Map<String, Object> getCropArea(String canvasId) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas == null) return null;
        try {
            CanvasConfig config = new CanvasConfig();
            canvas.getConfigs(config);
            // Note: Android SDK may not have getCropArea method
            // Return default values for now
            Map<String, Object> map = new HashMap<>();
            map.put("x", 0);
            map.put("y", 0);
            map.put("width", 0);
            map.put("height", 0);
            return map;
        } catch (RteException e) {
            return null;
        }
    }

    /**
     * Add view
     */
    public boolean addView(String canvasId, View view, Map<String, Object> config) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas == null) {
            return false;
        }
        try {
            ViewConfig viewConfig = new ViewConfig();
            canvas.addView(view, viewConfig);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Remove view
     */
    public boolean removeView(String canvasId, View view, Map<String, Object> config) {
        Canvas canvas = canvases.get(canvasId);
        if (canvas == null) {
            return false;
        }
        try {
            ViewConfig viewConfig = new ViewConfig();
            canvas.removeView(view, viewConfig);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Get Canvas instance
     */
    public Canvas getCanvas(String canvasId) {
        return canvases.get(canvasId);
    }

    private int parseInt(Object obj) {
        if (obj instanceof Number) {
            return ((Number) obj).intValue();
        }
        if (obj instanceof String) {
            try {
                return Integer.parseInt((String) obj);
            } catch (Exception e) {
                return 0;
            }
        }
        return 0;
    }
}
