import 'package:flutter/services.dart';

/// RTE configuration implementation
class AgoraRteConfigImpl {
  static const MethodChannel _channel = MethodChannel('agora_rtc_ng');

  /// Get App ID
  Future<String> appId() async {
    final String result = await _channel.invokeMethod('rteGetAppId');
    return result;
  }

  /// Set App ID
  Future<void> setAppId(String appId) async {
    await _channel.invokeMethod('rteSetAppId', {'appId': appId});
  }

  /// Get log folder
  Future<String> logFolder() async {
    final String result = await _channel.invokeMethod('rteGetLogFolder');
    return result;
  }

  /// Set log folder
  Future<void> setLogFolder(String logFolder) async {
    await _channel.invokeMethod('rteSetLogFolder', {'logFolder': logFolder});
  }

  /// Get log file size
  Future<int> logFileSize() async {
    final int result = await _channel.invokeMethod('rteGetLogFileSize');
    return result;
  }

  /// Set log file size
  Future<void> setLogFileSize(int logFileSize) async {
    await _channel.invokeMethod('rteSetLogFileSize', {'logFileSize': logFileSize});
  }

  /// Get area code
  Future<int> areaCode() async {
    final int result = await _channel.invokeMethod('rteGetAreaCode');
    return result;
  }

  /// Set area code
  Future<void> setAreaCode(int areaCode) async {
    await _channel.invokeMethod('rteSetAreaCode', {'areaCode': areaCode});
  }

  /// Get cloud proxy
  Future<String> cloudProxy() async {
    final String result = await _channel.invokeMethod('rteGetCloudProxy');
    return result;
  }

  /// Set cloud proxy
  Future<void> setCloudProxy(String cloudProxy) async {
    await _channel.invokeMethod('rteSetCloudProxy', {'cloudProxy': cloudProxy});
  }

  /// Get JSON parameter
  Future<String> jsonParameter() async {
    final String result = await _channel.invokeMethod('rteGetJsonParameter');
    return result;
  }

  /// Set JSON parameter
  Future<void> setJsonParameter(String jsonParameter) async {
    await _channel.invokeMethod('rteSetJsonParameter', {'jsonParameter': jsonParameter});
  }
}
