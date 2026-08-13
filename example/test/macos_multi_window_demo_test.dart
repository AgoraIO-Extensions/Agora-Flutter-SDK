import 'package:agora_rtc_engine_example/macos_multi_window_demo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('passes RTC config when opening child window', (tester) async {
    RtcWindowConfig? openedConfig;
    await tester.pumpWidget(MacOSMultiWindowDemoApp(
      openRtcWindow: (config) async => openedConfig = config,
    ));

    await tester.enterText(find.byKey(const ValueKey('appId')), 'test-app-id');
    await tester.enterText(find.byKey(const ValueKey('token')), 'test-token');
    await tester.enterText(
        find.byKey(const ValueKey('channelId')), 'test-channel');
    await tester.enterText(find.byKey(const ValueKey('uid')), '42');
    await tester.tap(find.byKey(const ValueKey('openRtcWindow')));
    await tester.pump();

    expect(openedConfig?.toMap(), {
      'appId': 'test-app-id',
      'token': 'test-token',
      'channelId': 'test-channel',
      'uid': 42,
    });
  });
}
