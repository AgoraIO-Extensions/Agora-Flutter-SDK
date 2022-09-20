import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'iris_tester_method_channel.dart';

abstract class IrisTesterPlatform extends PlatformInterface {
  /// Constructs a IrisTesterPlatform.
  IrisTesterPlatform() : super(token: _token);

  static final Object _token = Object();

  static IrisTesterPlatform _instance = MethodChannelIrisTester();

  /// The default instance of [IrisTesterPlatform] to use.
  ///
  /// Defaults to [MethodChannelIrisTester].
  static IrisTesterPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IrisTesterPlatform] when
  /// they register themselves.
  static set instance(IrisTesterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
