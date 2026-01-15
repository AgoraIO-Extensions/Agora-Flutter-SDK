import 'package:flutter/services.dart';

/// RTE 配置实现类
class AgoraRteConfigImpl {
  static const MethodChannel _channel = MethodChannel('agora_rtc_ng');

  /// 获取 App ID
  Future<String> appId() async {
    final String result = await _channel.invokeMethod('rteGetAppId');
    return result;
  }

  /// 设置 App ID
  Future<void> setAppId(String appId) async {
    await _channel.invokeMethod('rteSetAppId', {'appId': appId});
  }

  /// 获取日志文件夹
  Future<String> logFolder() async {
    final String result = await _channel.invokeMethod('rteGetLogFolder');
    return result;
  }

  /// 设置日志文件夹
  Future<void> setLogFolder(String logFolder) async {
    await _channel.invokeMethod('rteSetLogFolder', {'logFolder': logFolder});
  }

  /// 获取日志文件大小
  Future<int> logFileSize() async {
    final int result = await _channel.invokeMethod('rteGetLogFileSize');
    return result;
  }

  /// 设置日志文件大小
  Future<void> setLogFileSize(int logFileSize) async {
    await _channel.invokeMethod('rteSetLogFileSize', {'logFileSize': logFileSize});
  }

  /// 获取区域代码
  Future<int> areaCode() async {
    final int result = await _channel.invokeMethod('rteGetAreaCode');
    return result;
  }

  /// 设置区域代码
  Future<void> setAreaCode(int areaCode) async {
    await _channel.invokeMethod('rteSetAreaCode', {'areaCode': areaCode});
  }

  /// 获取云代理
  Future<String> cloudProxy() async {
    final String result = await _channel.invokeMethod('rteGetCloudProxy');
    return result;
  }

  /// 设置云代理
  Future<void> setCloudProxy(String cloudProxy) async {
    await _channel.invokeMethod('rteSetCloudProxy', {'cloudProxy': cloudProxy});
  }

  /// 获取 JSON 参数
  Future<String> jsonParameter() async {
    final String result = await _channel.invokeMethod('rteGetJsonParameter');
    return result;
  }

  /// 设置 JSON 参数
  Future<void> setJsonParameter(String jsonParameter) async {
    await _channel.invokeMethod('rteSetJsonParameter', {'jsonParameter': jsonParameter});
  }
}
