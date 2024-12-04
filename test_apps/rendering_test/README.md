# rendering_test

## Running rendering test
### Android/iOS

```
flutter drive --driver=test_driver/integration_test.dart \
    --target=integration_test/agora_video_view_render_test.dart \
    --dart-define=TEST_APP_ID="<APP_ID>"
```

### macOS/Windows

```
flutter test integration_test/agora_video_view_render_test.dart \
    --dart-define=TEST_APP_ID="<APP_ID>"
```

### Web
Follow the https://docs.flutter.dev/cookbook/testing/integration/introduction#5b-web to dowload and setup the `ChromeDriver`

```
flutter drive --driver=test_driver/integration_test.dart \
    --target=integration_test/agora_video_view_render_test.dart \
    --dart-define=TEST_APP_ID="<APP_ID>" \
    -d web-server
```


## Update screenshot
### Android/iOS
To update the screenshot, pass the `export UPDATE_GOLDEN="true"` in command line.

```
export UPDATE_GOLDEN="true"
flutter drive --driver=test_driver/integration_test.dart \
    --target=integration_test/agora_video_view_render_test.dart \
    --dart-define=TEST_APP_ID="<APP_ID>"
```

### macOS/Windows
To update the screenshot, pass the `--dart-define=UPDATE_GOLDEN=true` to the `flutter test` command.

```
flutter test integration_test/agora_video_view_render_test.dart \
    --dart-define=TEST_APP_ID="<APP_ID>" \
    --dart-define=UPDATE_GOLDEN=true
```

### Web
Follow the https://docs.flutter.dev/cookbook/testing/integration/introduction#5b-web to dowload and setup the `ChromeDriver`

To update the screenshot, pass the `export UPDATE_GOLDEN="true"` in command line.

```
export UPDATE_GOLDEN="true"
flutter drive --driver=test_driver/integration_test.dart \
    --target=integration_test/agora_video_view_render_test.dart \
    --dart-define=TEST_APP_ID="<APP_ID>" \
    -d web-server
```