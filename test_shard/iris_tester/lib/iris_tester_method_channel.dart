import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'iris_tester_platform_interface.dart';

/// An implementation of [IrisTesterPlatform] that uses method channels.
class MethodChannelIrisTester extends IrisTesterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('iris_tester');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
