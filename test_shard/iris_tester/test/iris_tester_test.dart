import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import 'package:iris_tester/iris_tester_platform_interface.dart';
import 'package:iris_tester/iris_tester_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIrisTesterPlatform 
    with MockPlatformInterfaceMixin
    implements IrisTesterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IrisTesterPlatform initialPlatform = IrisTesterPlatform.instance;

  test('$MethodChannelIrisTester is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIrisTester>());
  });

  test('getPlatformVersion', () async {
    IrisTester irisTesterPlugin = IrisTester();
    MockIrisTesterPlatform fakePlatform = MockIrisTesterPlatform();
    IrisTesterPlatform.instance = fakePlatform;
  
    expect(await irisTesterPlugin.getPlatformVersion(), '42');
  });
}
