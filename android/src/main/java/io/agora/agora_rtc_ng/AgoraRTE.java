package io.agora.agora_rtc_ng;

import io.agora.rte.Rte;
import io.agora.rte.InitialConfig;
import io.agora.rte.Config;
import io.agora.rte.callback.AsyncCallback;
import io.agora.rte.exception.RteException;

import java.util.HashMap;
import java.util.Map;

/**
 * RTE main class, manages RTE lifecycle
 */
public class AgoraRTE {
    private Rte rteInstance;
    /** Cache for uint32 values that overflow int (SDK uses int). */
    private Long lastSetLogFileSize;
    private Long lastSetAreaCode;

    public AgoraRTE() {
        this.rteInstance = null;
    }

    /**
     * Create RTE instance from Bridge
     */
    public boolean getFromBridge() {
        try {
            rteInstance = Rte.getFromBridge();
            return true;
        } catch (RteException e) {
            rteInstance = null;
            return false;
        }
    }

    /**
     * Create RTE instance with configuration
     */
    public boolean createWithConfig(Map<String, Object> configMap) {
        if (rteInstance != null) {
            return false;
        }
        InitialConfig initialConfig = new InitialConfig();
        rteInstance = new Rte(initialConfig);
        
        if (configMap != null && !configMap.isEmpty()) {
            if (configMap.containsKey("appId")) {
                Object appIdObj = configMap.get("appId");
                if (appIdObj == null || (appIdObj instanceof String && ((String) appIdObj).isEmpty())) {
                    return false;
                }
            }
            return setConfigs(configMap);
        }
        return true;
    }

    /**
     * Initialize media engine
     */
    public boolean initMediaEngine(AsyncCallback completion) {
        if (rteInstance == null) {
            return false;
        }
        try {
            rteInstance.initMediaEngine(completion);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Batch set configurations
     */
    public boolean setConfigs(Map<String, Object> configMap) {
        if (rteInstance == null) {
            return false;
        }
        try {
            Config rteConfig = new Config();
            
            // Only update properties provided in the map.
            if (configMap.containsKey("appId") && configMap.get("appId") != null) {
                rteConfig.setAppId((String) configMap.get("appId"));
            }
            if (configMap.containsKey("logFolder") && configMap.get("logFolder") != null) {
                rteConfig.setLogFolder((String) configMap.get("logFolder"));
            }
            if (configMap.containsKey("logFileSize") && configMap.get("logFileSize") != null) {
                long v = parseLong(configMap.get("logFileSize"));
                lastSetLogFileSize = v;
                rteConfig.setLogFileSize((int) v);
            }
            if (configMap.containsKey("areaCode") && configMap.get("areaCode") != null) {
                long v = parseLong(configMap.get("areaCode"));
                lastSetAreaCode = v;
                rteConfig.setAreaCode((int) v);
            }
            if (configMap.containsKey("cloudProxy") && configMap.get("cloudProxy") != null) {
                rteConfig.setCloudProxy((String) configMap.get("cloudProxy"));
            }
            if (configMap.containsKey("jsonParameter") && configMap.get("jsonParameter") != null) {
                rteConfig.setJsonParameter((String) configMap.get("jsonParameter"));
            }
            if (configMap.containsKey("useStringUid") && configMap.get("useStringUid") != null) {
                Object useStringUidObj = configMap.get("useStringUid");
                if (useStringUidObj instanceof Boolean) {
                    rteConfig.setUseStringUid((Boolean) useStringUidObj);
                }
            }
            
            rteInstance.setConfigs(rteConfig);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * Get all configurations
     */
    public Map<String, Object> getConfigs() {
        if (rteInstance == null) {
            return null;
        }
        try {
            Config config = new Config();
            rteInstance.getConfigs(config);
            
            Map<String, Object> map = new HashMap<>();
            map.put("appId", config.getAppId() != null ? config.getAppId() : "");
            map.put("logFolder", config.getLogFolder() != null ? config.getLogFolder() : "");
            map.put("logFileSize", lastSetLogFileSize != null ? lastSetLogFileSize : (long) config.getLogFileSize());
            map.put("areaCode", lastSetAreaCode != null ? lastSetAreaCode : (long) config.getAreaCode());
            map.put("cloudProxy", config.getCloudProxy() != null ? config.getCloudProxy() : "");
            map.put("jsonParameter", config.getJsonParameter() != null ? config.getJsonParameter() : "");
            map.put("useStringUid", config.getUseStringUid());
            return map;
        } catch (RteException e) {
            return null;
        }
    }

    /**
     * Destroy RTE instance
     */
    public boolean destroy() {
        if (rteInstance == null) {
            return true;
        }
        try {
            rteInstance.destroy();
            rteInstance = null;
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public Rte getRteInstance() {
        return rteInstance;
    }

    private int parseInt(Object obj) {
        if (obj == null) {
            return 0;
        }
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

    private long parseLong(Object obj) {
        if (obj == null) {
            return 0L;
        }
        if (obj instanceof Number) {
            return ((Number) obj).longValue();
        }
        if (obj instanceof String) {
            try {
                return Long.parseLong((String) obj);
            } catch (Exception e) {
                return 0L;
            }
        }
        return 0L;
    }
}
