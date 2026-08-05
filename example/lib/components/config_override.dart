/// Key of App ID.
const keyAppId = 'TEST_APP_ID';

/// Key of channel ID.
const keyChannelId = 'TEST_CHANNEL_ID';

/// Key of token.
const keyToken = 'TEST_TOKEN';

/// Default App ID placeholder.
const appIdPlaceholder = '<YOUR_APP_ID>';

/// Default channel ID placeholder.
const channelIdPlaceholder = '<YOUR_CHANNEL_ID>';

/// Default token placeholder.
const tokenPlaceholder = '<YOUR_TOKEN>';

ExampleConfigOverride? _instance;

/// Allows the example to override its compile-time Agora configuration.
class ExampleConfigOverride {
  ExampleConfigOverride._();

  /// Returns the shared configuration override.
  factory ExampleConfigOverride() {
    return _instance ??= ExampleConfigOverride._();
  }

  final Map<String, String> _overriddenConfig = {};

  /// Returns the runtime App ID, or its compile-time value.
  String getAppId() {
    return _overriddenConfig[keyAppId] ??
        const String.fromEnvironment(
          keyAppId,
          defaultValue: appIdPlaceholder,
        );
  }

  /// Returns the runtime channel ID, or its compile-time value.
  String getChannelId() {
    return _overriddenConfig[keyChannelId] ??
        const String.fromEnvironment(
          keyChannelId,
          defaultValue: channelIdPlaceholder,
        );
  }

  /// Returns the runtime token, or its compile-time value.
  String getToken() {
    return _overriddenConfig[keyToken] ??
        const String.fromEnvironment(
          keyToken,
          defaultValue: tokenPlaceholder,
        );
  }

  /// Overrides a configuration value for the current process.
  void set(String name, String value) {
    _overriddenConfig[name] = value;
  }
}
