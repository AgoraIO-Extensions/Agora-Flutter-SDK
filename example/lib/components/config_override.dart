/// Key of APP ID
const keyAppId = 'TEST_APP_ID';

/// Key of Channel ID
const keyChannelId = 'TEST_CHANNEL_ID';

/// Key of token
const keyToken = 'TEST_TOKEN';

ExampleConfigOverride? _gConfigOverride;

/// This class allow override the config(appId/channelId/token) in the example.
class ExampleConfigOverride {
  ExampleConfigOverride._();

  factory ExampleConfigOverride() {
    _gConfigOverride = _gConfigOverride ?? ExampleConfigOverride._();
    return _gConfigOverride!;
  }
  final Map<String, String> _overridedConfig = {};

  /// Get the expected APP ID
  String getAppId() {
    return _overridedConfig[keyAppId] ??
        // Allow pass an `appId` as an environment variable with name `TEST_APP_ID` by using --dart-define
        const String.fromEnvironment(keyAppId, defaultValue: '<TEST_APP_ID>');
  }

  /// Get the expected Channel ID
  String getChannelId() {
    return _overridedConfig[keyChannelId] ??
        // Allow pass a `token` as an environment variable with name `TEST_TOKEN` by using --dart-define
        const String.fromEnvironment(keyChannelId,
            defaultValue: '<TEST_CHANNEL_ID>');
  }

  /// Get the expected Token
  String getToken() {
    return _overridedConfig[keyToken] ??
        // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
        const String.fromEnvironment(keyToken, defaultValue: '<TEST_TOKEN>');
  }

  /// Override the config(appId/channelId/token)
  void set(String name, String value) {
    _overridedConfig[name] = value;
  }

  /// Internal testing flag
  bool get isInternalTesting =>
      const bool.fromEnvironment('INTERNAL_TESTING', defaultValue: false);
}
