import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/impl/agora_rte_impl.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/material.dart';

/// RTE 配置示例
/// 演示如何获取和设置 RTE 配置，特别是如何获取 App ID
class RteConfigExample extends StatefulWidget {
  const RteConfigExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RteConfigExampleState();
}

class _RteConfigExampleState extends State<RteConfigExample> {
  late final AgoraRte _rte;
  bool _isInitialized = false;
  String _statusText = 'Initializing...';
  
  // 配置信息
  String _appId = '';
  String _logFolder = '';
  int _logFileSize = 0;
  int _areaCode = 0;
  String _cloudProxy = '';
  String _jsonParameter = '';

  @override
  void initState() {
    super.initState();
    _initRte();
  }

  Future<void> _initRte() async {
    _rte = AgoraRteImpl();
    try {
      // 使用配置创建 RTE 实例
      await _rte.createWithConfig(AgoraRteConfig(
        appId: config.appId,
        logFolder: '/tmp/agora_rte_logs',
        logFileSize: 1024 * 1024, // 1MB
      ));
      
      // 初始化引擎
      await _rte.initMediaEngine();
      
      setState(() {
        _isInitialized = true;
        _statusText = 'RTE Initialized';
      });
      
      // 初始化后立即获取配置
      await _getAllConfigs();
    } catch (e) {
      logSink.log('Error initializing RTE: $e');
      setState(() {
        _statusText = 'Error: $e';
      });
    }
  }

  /// 获取 App ID（单独获取）
  Future<void> _getAppId() async {
    if (!_isInitialized) {
      setState(() {
        _statusText = 'RTE not initialized';
      });
      return;
    }
    
    try {
      final appId = await _rte.appId();
      setState(() {
        _appId = appId;
        _statusText = 'App ID retrieved: $appId';
      });
      logSink.log('App ID: $appId');
    } catch (e) {
      logSink.log('Error getting App ID: $e');
      setState(() {
        _statusText = 'Error getting App ID: $e';
      });
    }
  }

  /// 获取 Log Folder（单独获取）
  Future<void> _getLogFolder() async {
    if (!_isInitialized) {
      setState(() {
        _statusText = 'RTE not initialized';
      });
      return;
    }
    
    try {
      final logFolder = await _rte.logFolder();
      setState(() {
        _logFolder = logFolder;
        _statusText = 'Log Folder retrieved: $logFolder';
      });
      logSink.log('Log Folder: $logFolder');
    } catch (e) {
      logSink.log('Error getting Log Folder: $e');
      setState(() {
        _statusText = 'Error getting Log Folder: $e';
      });
    }
  }

  /// 获取 Log File Size（单独获取）
  Future<void> _getLogFileSize() async {
    if (!_isInitialized) {
      setState(() {
        _statusText = 'RTE not initialized';
      });
      return;
    }
    
    try {
      final logFileSize = await _rte.logFileSize();
      setState(() {
        _logFileSize = logFileSize;
        _statusText = 'Log File Size retrieved: ${logFileSize / 1024 / 1024} MB';
      });
      logSink.log('Log File Size: $logFileSize bytes');
    } catch (e) {
      logSink.log('Error getting Log File Size: $e');
      setState(() {
        _statusText = 'Error getting Log File Size: $e';
      });
    }
  }

  /// 获取 Area Code（单独获取）
  Future<void> _getAreaCode() async {
    if (!_isInitialized) {
      setState(() {
        _statusText = 'RTE not initialized';
      });
      return;
    }
    
    try {
      final areaCode = await _rte.areaCode();
      setState(() {
        _areaCode = areaCode;
        _statusText = 'Area Code retrieved: $areaCode';
      });
      logSink.log('Area Code: $areaCode');
    } catch (e) {
      logSink.log('Error getting Area Code: $e');
      setState(() {
        _statusText = 'Error getting Area Code: $e';
      });
    }
  }

  /// 获取 Cloud Proxy（单独获取）
  Future<void> _getCloudProxy() async {
    if (!_isInitialized) {
      setState(() {
        _statusText = 'RTE not initialized';
      });
      return;
    }
    
    try {
      final cloudProxy = await _rte.cloudProxy();
      setState(() {
        _cloudProxy = cloudProxy;
        _statusText = cloudProxy.isEmpty 
            ? 'Cloud Proxy retrieved: Not set'
            : 'Cloud Proxy retrieved: $cloudProxy';
      });
      logSink.log('Cloud Proxy: ${cloudProxy.isEmpty ? "Not set" : cloudProxy}');
    } catch (e) {
      logSink.log('Error getting Cloud Proxy: $e');
      setState(() {
        _statusText = 'Error getting Cloud Proxy: $e';
      });
    }
  }

  /// 获取 JSON Parameter（单独获取）
  Future<void> _getJsonParameter() async {
    if (!_isInitialized) {
      setState(() {
        _statusText = 'RTE not initialized';
      });
      return;
    }
    
    try {
      final jsonParameter = await _rte.jsonParameter();
      setState(() {
        _jsonParameter = jsonParameter;
        _statusText = jsonParameter.isEmpty
            ? 'JSON Parameter retrieved: Not set'
            : 'JSON Parameter retrieved: $jsonParameter';
      });
      logSink.log('JSON Parameter: ${jsonParameter.isEmpty ? "Not set" : jsonParameter}');
    } catch (e) {
      logSink.log('Error getting JSON Parameter: $e');
      setState(() {
        _statusText = 'Error getting JSON Parameter: $e';
      });
    }
  }

  /// 获取所有配置
  Future<void> _getAllConfigs() async {
    if (!_isInitialized) {
      setState(() {
        _statusText = 'RTE not initialized';
      });
      return;
    }
    
    try {
      final config = await _rte.getConfigs();
      setState(() {
        _appId = config.appId ?? '';
        _logFolder = config.logFolder ?? '';
        _logFileSize = config.logFileSize ?? 0;
        _areaCode = config.areaCode ?? 0;
        _cloudProxy = config.cloudProxy ?? '';
        _jsonParameter = config.jsonParameter ?? '';
        _statusText = 'Config retrieved successfully';
      });
      logSink.log('Config retrieved: ${config.toJson()}');
    } catch (e) {
      logSink.log('Error getting config: $e');
      setState(() {
        _statusText = 'Error getting config: $e';
      });
    }
  }

  /// 设置配置
  Future<void> _setConfig() async {
    if (!_isInitialized) {
      setState(() {
        _statusText = 'RTE not initialized';
      });
      return;
    }
    
    try {
      final newConfig = AgoraRteConfig(
        appId: config.appId,
        logFolder: '/tmp/agora_rte_logs_updated',
        logFileSize: 2 * 1024 * 1024, // 2MB
        areaCode: 0,
      );
      
      await _rte.setConfigs(newConfig);
      setState(() {
        _statusText = 'Config set successfully';
      });
      logSink.log('Config set: ${newConfig.toJson()}');
      
      // 设置后重新获取配置以验证
      await _getAllConfigs();
    } catch (e) {
      logSink.log('Error setting config: $e');
      setState(() {
        _statusText = 'Error setting config: $e';
      });
    }
  }

  @override
  void dispose() {
    _rte.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 状态显示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _statusText,
                      style: TextStyle(
                        color: _isInitialized ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 操作按钮
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _getAppId : null,
                  icon: const Icon(Icons.info_outline),
                  label: const Text('Get App ID'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _getLogFolder : null,
                  icon: const Icon(Icons.folder_outlined),
                  label: const Text('Get Log Folder'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _getLogFileSize : null,
                  icon: const Icon(Icons.storage),
                  label: const Text('Get Log File Size'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _getAreaCode : null,
                  icon: const Icon(Icons.location_on),
                  label: const Text('Get Area Code'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _getCloudProxy : null,
                  icon: const Icon(Icons.cloud),
                  label: const Text('Get Cloud Proxy'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _getJsonParameter : null,
                  icon: const Icon(Icons.code),
                  label: const Text('Get JSON Parameter'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _getAllConfigs : null,
                  icon: const Icon(Icons.settings),
                  label: const Text('Get All Configs'),
                ),
                ElevatedButton.icon(
                  onPressed: _isInitialized ? _setConfig : null,
                  icon: const Icon(Icons.edit),
                  label: const Text('Set Config'),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // 配置信息显示
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Current Configuration',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildConfigItem('App ID', _appId.isEmpty ? 'Not retrieved' : _appId),
                    _buildConfigItem('Log Folder', _logFolder.isEmpty ? 'Not set' : _logFolder),
                    _buildConfigItem('Log File Size', _logFileSize == 0 ? 'Not set' : '${_logFileSize / 1024 / 1024} MB'),
                    _buildConfigItem('Area Code', _areaCode.toString()),
                    _buildConfigItem('Cloud Proxy', _cloudProxy.isEmpty ? 'Not set' : _cloudProxy),
                    _buildConfigItem('JSON Parameter', _jsonParameter.isEmpty ? 'Not set' : _jsonParameter),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // 说明
            Card(
              color: Colors.blue[50],
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '说明',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '1. 各个 "Get XXX" 按钮演示如何使用单独的方法获取对应的配置项：\n'
                      '   - Get App ID: appId()\n'
                      '   - Get Log Folder: logFolder()\n'
                      '   - Get Log File Size: logFileSize()\n'
                      '   - Get Area Code: areaCode()\n'
                      '   - Get Cloud Proxy: cloudProxy()\n'
                      '   - Get JSON Parameter: jsonParameter()\n'
                      '2. "Get All Configs" 按钮演示如何使用 getConfigs() 方法获取所有配置\n'
                      '3. "Set Config" 按钮演示如何设置配置\n'
                      '4. 配置信息会在下方显示',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
