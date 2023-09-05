import 'package:iris_method_channel/iris_method_channel.dart';

import 'js_iris_api_engine_binding_delegate.dart';

/// `createPlatformBindingsProvider` stub function implementation on web,
/// see also: `lib/src/impl/platform/platform_bindings_provider_expect.dart`
PlatformBindingsProvider createPlatformBindingsProvider() =>
    IrisApiEngineNativeBindingDelegateProviderWeb();
