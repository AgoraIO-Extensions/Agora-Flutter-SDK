import 'package:iris_method_channel/iris_method_channel.dart';

class SharedNativeEngineInitializationArgProvider
    implements InitilizationArgProvider {
  const SharedNativeEngineInitializationArgProvider(
    this.sharedNativeHandle, {
    this.sharedNativeEventHandler,
  });

  final Object sharedNativeHandle;
  final Object? sharedNativeEventHandler;

  @override
  IrisHandle provide(IrisApiEngineHandle apiEngineHandle) {
    return ObjectIrisHandle(sharedNativeHandle);
  }
}
