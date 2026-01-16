package io.agora.agora_rtc_ng;

import io.agora.rte.Rte;
import io.agora.rte.InitialConfig;
import io.agora.rte.Config;
import io.agora.rte.Error;
import io.agora.rte.callback.AsyncCallback;
import io.agora.rte.exception.RteException;

import java.util.HashMap;
import java.util.Map;

/**
 * RTE 主类，管理 RTE 生命周期
 */
public class AgoraRTE {
    private Rte rteInstance;
    private AgoraRTEConfig config;

    public AgoraRTE() {
        this.rteInstance = null;
        this.config = null;
    }

    /**
     * 从 Bridge 创建 RTE 实例
     */
    public boolean getFromBridge() {
        try {
            rteInstance = Rte.getFromBridge();
            if (rteInstance != null) {
                config = new AgoraRTEConfig(rteInstance);
                return true;
            }
            return false;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * 使用配置创建 RTE 实例
     */
    public boolean createWithConfig(Map<String, Object> configMap) {
        InitialConfig initialConfig = new InitialConfig();
        rteInstance = new Rte(initialConfig);
        
        if (rteInstance != null) {
            config = new AgoraRTEConfig(rteInstance);
            
            if (configMap != null && !configMap.isEmpty()) {
                return setConfigs(configMap);
            }
            return true;
        }
        return false;
    }

    /**
     * 初始化媒体引擎
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
     * 批量设置配置
     */
    public boolean setConfigs(Map<String, Object> configMap) {
        if (rteInstance == null) {
            return false;
        }
        try {
            Config rteConfig = new Config();
            
            // 先获取当前配置，避免覆盖其他属性
            rteInstance.getConfigs(rteConfig);
            
            // 只更新字典中提供的属性
            if (configMap.containsKey("appId") && configMap.get("appId") != null) {
                rteConfig.setAppId((String) configMap.get("appId"));
            }
            if (configMap.containsKey("logFolder") && configMap.get("logFolder") != null) {
                rteConfig.setLogFolder((String) configMap.get("logFolder"));
            }
            if (configMap.containsKey("logFileSize") && configMap.get("logFileSize") != null) {
                rteConfig.setLogFileSize(parseInt(configMap.get("logFileSize")));
            }
            if (configMap.containsKey("areaCode") && configMap.get("areaCode") != null) {
                rteConfig.setAreaCode(parseInt(configMap.get("areaCode")));
            }
            if (configMap.containsKey("cloudProxy") && configMap.get("cloudProxy") != null) {
                rteConfig.setCloudProxy((String) configMap.get("cloudProxy"));
            }
            if (configMap.containsKey("jsonParameter") && configMap.get("jsonParameter") != null) {
                rteConfig.setJsonParameter((String) configMap.get("jsonParameter"));
            }
            
            rteInstance.setConfigs(rteConfig);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    /**
     * 获取所有配置
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
            map.put("logFileSize", config.getLogFileSize());
            map.put("areaCode", config.getAreaCode());
            map.put("cloudProxy", config.getCloudProxy() != null ? config.getCloudProxy() : "");
            map.put("jsonParameter", config.getJsonParameter() != null ? config.getJsonParameter() : "");
            return map;
        } catch (RteException e) {
            return null;
        }
    }

    /**
     * 销毁 RTE 实例
     */
    public boolean destroy() {
        if (rteInstance == null) {
            return true;
        }
        try {
            rteInstance.destroy();
            rteInstance = null;
            config = null;
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public Rte getRteInstance() {
        return rteInstance;
    }

    public AgoraRTEConfig getConfig() {
        return config;
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
