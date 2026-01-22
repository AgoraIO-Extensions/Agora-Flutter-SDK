import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class RteConfigTab extends StatefulWidget {
  final AgoraRteImpl rte;
  final Function(String) onLog;

  const RteConfigTab({
    Key? key,
    required this.rte,
    required this.onLog,
  }) : super(key: key);

  @override
  State<RteConfigTab> createState() => _RteConfigTabState();
}

class _RteConfigTabState extends State<RteConfigTab> {
  String _appId = '';
  String _logFolder = '';
  int _logFileSize = 0;
  int _areaCode = 0;
  String _cloudProxy = '';
  String _jsonParameter = '';
  bool _useStringUid = false;

  @override
  void initState() {
    super.initState();
    _loadRteConfig();
  }

  @override
  void didUpdateWidget(covariant RteConfigTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.rte != widget.rte) {
      _loadRteConfig();
    }
  }

  Future<void> _loadRteConfig() async {
    try {
      // Example: Using getConfigs() to get all configs at once
      final config = await widget.rte.getConfigs();
      if (mounted) {
        setState(() {
          _appId = config.appId ?? '';
          _logFolder = config.logFolder ?? '';
          _logFileSize = config.logFileSize ?? 0;
          _areaCode = config.areaCode ?? 0;
          _cloudProxy = config.cloudProxy ?? '';
          _jsonParameter = config.jsonParameter ?? '';
          _useStringUid = config.useStringUid ?? false;
        });
      }
      widget.onLog('Loaded RTE config using getConfigs()');
    } catch (e) {
      widget.onLog('Load RTE config error: $e');
      // Fallback to individual getters
      try {
        final appId = await widget.rte.appId();
        final logFolder = await widget.rte.logFolder();
        final logFileSize = await widget.rte.logFileSize();
        final areaCode = await widget.rte.areaCode();
        final cloudProxy = await widget.rte.cloudProxy();
        final jsonParameter = await widget.rte.jsonParameter();
        final useStringUid = await widget.rte.useStringUid();
        if (mounted) {
          setState(() {
            _appId = appId;
            _logFolder = logFolder;
            _logFileSize = logFileSize;
            _areaCode = areaCode;
            _cloudProxy = cloudProxy;
            _jsonParameter = jsonParameter;
            _useStringUid = useStringUid;
          });
        }
      } catch (e2) {
        widget.onLog('Load RTE config (fallback) error: $e2');
      }
    }
  }

  Future<void> _setRteAppId(String appId) async {
    try {
      await widget.rte.config.setAppId(appId);
      await _loadRteConfig();
      widget.onLog('Set RTE AppId: $appId');
    } catch (e) {
      widget.onLog('Set AppId error: $e');
    }
  }

  Future<void> _setRteLogFolder(String folder) async {
    try {
      await widget.rte.config.setLogFolder(folder);
      await _loadRteConfig();
      widget.onLog('Set RTE LogFolder: $folder');
    } catch (e) {
      widget.onLog('Set LogFolder error: $e');
    }
  }

  Future<void> _setRteLogFileSize(int size) async {
    try {
      await widget.rte.config.setLogFileSize(size);
      await _loadRteConfig();
      widget.onLog('Set RTE LogFileSize: $size');
    } catch (e) {
      widget.onLog('Set LogFileSize error: $e');
    }
  }

  Future<void> _setRteAreaCode(int code) async {
    try {
      await widget.rte.config.setAreaCode(code);
      await _loadRteConfig();
      widget.onLog('Set RTE AreaCode: $code');
    } catch (e) {
      widget.onLog('Set AreaCode error: $e');
    }
  }

  Future<void> _setRteCloudProxy(String proxy) async {
    try {
      await widget.rte.config.setCloudProxy(proxy);
      await _loadRteConfig();
      widget.onLog('Set RTE CloudProxy: $proxy');
    } catch (e) {
      widget.onLog('Set CloudProxy error: $e');
    }
  }

  Future<void> _setRteJsonParameter(String param) async {
    try {
      await widget.rte.config.setJsonParameter(param);
      await _loadRteConfig();
      widget.onLog('Set RTE JsonParameter: $param');
    } catch (e) {
      widget.onLog('Set JsonParameter error: $e');
    }
  }

  Future<void> _setRteUseStringUid(bool value) async {
    try {
      await widget.rte.config.setUseStringUid(value);
      await _loadRteConfig();
      widget.onLog('Set RTE UseStringUid: $value');
    } catch (e) {
      widget.onLog('Set UseStringUid error: $e');
    }
  }

  /// Example: Using setConfigs() to set multiple configs at once
  Future<void> _setRteConfigsBatch() async {
    try {
      await widget.rte.setConfigs(AgoraRteConfig(
        appId: _appId.isEmpty ? null : _appId,
        logFolder: _logFolder.isEmpty ? null : _logFolder,
        logFileSize: _logFileSize == 0 ? null : _logFileSize,
        areaCode: _areaCode == 0 ? null : _areaCode,
        cloudProxy: _cloudProxy.isEmpty ? null : _cloudProxy,
        jsonParameter: _jsonParameter.isEmpty ? null : _jsonParameter,
        useStringUid: _useStringUid,
      ));
      await _loadRteConfig();
      widget.onLog('Set RTE configs using setConfigs() batch method');
    } catch (e) {
      widget.onLog('Set RTE configs (batch) error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildConfigItem(
                  'App ID', _appId, (value) => _setRteAppId(value)),
              _buildConfigItem(
                  'Log Folder', _logFolder, (value) => _setRteLogFolder(value)),
              _buildConfigItem('Log File Size', '$_logFileSize',
                  (value) => _setRteLogFileSize(int.tryParse(value) ?? 0)),
              _buildConfigItem('Area Code', '$_areaCode',
                  (value) => _setRteAreaCode(int.tryParse(value) ?? 0)),
              _buildConfigItem('Cloud Proxy', _cloudProxy,
                  (value) => _setRteCloudProxy(value)),
              _buildConfigItem('JSON Parameter', _jsonParameter,
                  (value) => _setRteJsonParameter(value)),
              SwitchListTile(
                title: const Text('Use String UID'),
                value: _useStringUid,
                onChanged: _setRteUseStringUid,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadRteConfig,
                child: const Text('Refresh Config (getConfigs)'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _setRteConfigsBatch,
                child: const Text('Set All Configs (setConfigs)'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConfigItem(String label, String value, Function(String) onSave) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(label),
          ),
          Expanded(
            child: TextField(
              controller: TextEditingController(text: value),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onSubmitted: onSave,
            ),
          ),
        ],
      ),
    );
  }
}
