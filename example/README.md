# AgoraRtcEngine Example

Demonstrates how to use the `agora_rtc_engine` plugin.

## Getting Started

### Create an Account and Obtain an App ID

1. Create a developer account at [agora.io](https://dashboard.agora.io/signin/).
2. In the Agora.io Dashboard that appears, click **Projects** > **Project List** in the left navigation.
3. Copy the **App ID** from the Dashboard to a text file. You will use this ID later when you launch the app.

### Update and Run the Sample Application

Open the `main.dart` file. In the `_initAgoraRtcEngine()` method, update `YOUR APP ID` with your App ID.

```Dart
Future<void> _initAgoraRtcEngine() async {
  AgoraRtcEngine.create('YOUR APP ID');
  AgoraRtcEngine.enableVideo();
}
```

### Run example

Connect device and run.
