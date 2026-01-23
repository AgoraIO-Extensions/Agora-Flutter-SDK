import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/material.dart';

class RteConfigTab extends StatefulWidget {
  final AgoraRte rte;
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
                  'App ID', _appId, (value) async {
                await widget.rte.setConfigs(AgoraRteConfig(appId: value));
                await _loadRteConfig();
              }),
              _buildConfigItem(
                  'Log Folder', _logFolder, (value) async {
                await widget.rte.setConfigs(AgoraRteConfig(logFolder: value));
                await _loadRteConfig();
              }),
              _buildConfigItem('Log File Size', '$_logFileSize',
                  (value) async {
                await widget.rte.setConfigs(
                    AgoraRteConfig(logFileSize: int.tryParse(value) ?? 0));
                await _loadRteConfig();
              }),
              _buildConfigItem('Area Code', '$_areaCode',
                  (value) async {
                await widget.rte.setConfigs(
                    AgoraRteConfig(areaCode: int.tryParse(value) ?? 0));
                await _loadRteConfig();
              }),
              _buildConfigItem('Cloud Proxy', _cloudProxy,
                  (value) async {
                await widget.rte.setConfigs(AgoraRteConfig(cloudProxy: value));
                await _loadRteConfig();
              }),
              _buildConfigItem('JSON Parameter', _jsonParameter,
                  (value) async {
                await widget.rte
                    .setConfigs(AgoraRteConfig(jsonParameter: value));
                await _loadRteConfig();
              }),
              SwitchListTile(
                title: const Text('Use String UID'),
                value: _useStringUid,
                onChanged: (value) async {
                  await widget.rte
                      .setConfigs(AgoraRteConfig(useStringUid: value));
                  await _loadRteConfig();
                },
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

  Widget _buildConfigItem(
      String label, String value, Future<void> Function(String) onSave) {
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
