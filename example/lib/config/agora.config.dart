/// Get your own App ID at https://dashboard.agora.io/
String get appId {
  // Allow pass an `appId` as an environment variable with name `TEST_APP_ID` by using --dart-define
  return String.fromEnvironment('TEST_APP_ID', defaultValue: '70378ad04e1e42018ab0cd05eb2a2376');
}

/// Please refer to https://docs.agora.io/en/Agora%20Platform/token
String get token {
  // Allow pass a `token` as an environment variable with name `TEST_TOEKN` by using --dart-define
  return String.fromEnvironment('TEST_TOEKN', defaultValue: '');
}

/// Your channel ID
String get channelId {
  // Allow pass a `channelId` as an environment variable with name `TEST_CHANNEL_ID` by using --dart-define
  return String.fromEnvironment(
    'TEST_CHANNEL_ID',
    defaultValue: 'testapi',
  );
}

/// Your int user ID
const int uid = 0;

/// Your user ID for the screen sharing
const int screenSharingUid = 0;

/// Your string user ID
const String stringUid = '0';
