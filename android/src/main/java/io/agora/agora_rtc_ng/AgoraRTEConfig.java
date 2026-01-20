package io.agora.agora_rtc_ng;

import io.agora.rte.Rte;
import io.agora.rte.Config;
import io.agora.rte.exception.RteException;

import java.util.HashMap;
import java.util.Map;

/**
 * RTE configuration management class
 */
public class AgoraRTEConfig {
    private final Rte rte;

    public AgoraRTEConfig(Rte rte) {
        this.rte = rte;
    }

    // Getters
    public String getAppId() {
        if (rte == null) {
            return "";
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            String appId = config.getAppId();
            return appId != null ? appId : "";
        } catch (RteException e) {
            return "";
        }
    }

    public String getLogFolder() {
        if (rte == null) {
            return "";
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            String logFolder = config.getLogFolder();
            return logFolder != null ? logFolder : "";
        } catch (RteException e) {
            return "";
        }
    }

    public int getLogFileSize() {
        if (rte == null) {
            return 0;
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            return config.getLogFileSize();
        } catch (RteException e) {
            return 0;
        }
    }

    public int getAreaCode() {
        if (rte == null) {
            return 0;
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            return config.getAreaCode();
        } catch (RteException e) {
            return 0;
        }
    }

    public String getCloudProxy() {
        if (rte == null) {
            return "";
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            String cloudProxy = config.getCloudProxy();
            return cloudProxy != null ? cloudProxy : "";
        } catch (RteException e) {
            return "";
        }
    }

    public String getJsonParameter() {
        if (rte == null) {
            return "";
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            String jsonParameter = config.getJsonParameter();
            return jsonParameter != null ? jsonParameter : "";
        } catch (RteException e) {
            return "";
        }
    }

    // Setters
    public boolean setAppId(String appId) {
        if (rte == null) {
            return false;
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            
            // Set the modified configuration
            config.setAppId(appId);
            rte.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public boolean setLogFolder(String logFolder) {
        if (rte == null) {
            return false;
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            config.setLogFolder(logFolder);
            rte.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public boolean setLogFileSize(int logFileSize) {
        if (rte == null) {
            return false;
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            config.setLogFileSize(logFileSize);
            rte.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public boolean setAreaCode(int areaCode) {
        if (rte == null) {
            return false;
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            config.setAreaCode(areaCode);
            rte.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public boolean setCloudProxy(String cloudProxy) {
        if (rte == null) {
            return false;
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            config.setCloudProxy(cloudProxy);
            rte.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }

    public boolean setJsonParameter(String jsonParameter) {
        if (rte == null) {
            return false;
        }
        try {
            Config config = new Config();
            rte.getConfigs(config);
            config.setJsonParameter(jsonParameter);
            rte.setConfigs(config);
            return true;
        } catch (RteException e) {
            return false;
        }
    }
}
