# Picture-in-Picture (PiP)

## Overview

The Picture-in-Picture (PiP) feature allows you to display video content in a small floating window while users interact with other parts of your app. You can show local and remote video streams in the PiP window, or display your own custom UI content. This feature is supported on Android and iOS platforms.

## Features

- Custom control style for PiP window (iOS only)
- Automatic PiP mode activation when app goes to background
- Customizable PiP window size and aspect ratio
- Dynamic size/aspect ratio adjustment during active PiP mode
- Support for multiple video streams in PiP mode
- Custom content view integration with PiP window
- Flexible layout configuration for multiple video streams in PiP mode

## Platform Support

- iOS: 15.0 and above
- Android: 8.0 and above

## Integration Guide

### Android Setup

1. **Declare PiP Support in AndroidManifest.xml**

   > For detailed information, see [Add videos using picture-in-picture (PiP)](https://developer.android.com/develop/ui/views/picture-in-picture#declaring)

   ```xml
   <activity android:name=".MainActivity"
       android:supportsPictureInPicture="true"
       android:configChanges=
           "screenSize|smallestScreenSize|screenLayout|orientation"
       ...
   ```

   Example: [AndroidManifest.xml](../../example/android/app/src/main/AndroidManifest.xml#L21)

2. **Configure Main Activity**

   > According to the [Switch your activity to PiP](https://developer.android.com/develop/ui/views/picture-in-picture#pip_button), automatic PiP mode entry when the app goes to background is only supported on Android 12 and above. For earlier Android versions, you need to explicitly call `enterPictureInPictureMode()` in `onUserLeaveHint()`. This functionality is already implemented in `AgoraPIPFlutterActivity` and `AgoraPIPFlutterFragmentActivity`, so you don't need to implement it yourself. However, if you want to customize the behavior, you can implement `AgoraPIPActivityProxy` interface and override its methods in your own activity.

   ```kotlin
   import io.agora.agora_rtc_ng.AgoraPIPFlutterActivity

   class MainActivity: AgoraPIPFlutterActivity() {
       ...
   }
   ```

   or

   ```kotlin
   import io.agora.agora_rtc_ng.AgoraPIPFlutterFragmentActivity

   class MainActivity: AgoraPIPFlutterFragmentActivity() {
       ...
   }
   ```

   Example: [MainActivity.kt](../../example/android/app/src/main/kotlin/io/agora/agora_rtc_flutter_example/MainActivity.kt#L11)

### iOS Setup

1. **Configure Media Playback Capability**

   > For detailed information, see [Configuring your app for media playback](https://developer.apple.com/documentation/avfoundation/configuring-your-app-for-media-playback?language=objc)

   Steps in Xcode:

   1. Select your app's target and go to Signing & Capabilities tab
   2. Click + Capability button
   3. Add Background Modes capability
   4. Select "Audio, AirPlay, and Picture in Picture" under Background Modes

   Additional Resources:

   - [Background Execution Modes](https://developer.apple.com/documentation/xcode/configuring-background-execution-modes#Specify-the-background-modes-your-app-requires)
   - [Adding Capabilities](https://developer.apple.com/documentation/xcode/adding-capabilities-to-your-app#Add-a-capability)

2. **Camera Access in Multitasking Mode (Optional)**
   > Note: You can skip this step if your app doesn't require camera access during multitasking (for example, if you don't need to show the local video stream in the PiP window).

   > When your app enters a multitasking mode, you should have [com.apple.developer.avfoundation.multitasking-camera-access](https://developer.apple.com/documentation/BundleResources/Entitlements/com.apple.developer.avfoundation.multitasking-camera-access?language=objc) entitlement or set `multitaskingCameraAccessEnabled` to `true` of the capture session. Multitasking modes include Slide Over, Split View, and Picture in Picture (PiP).

   > To learn about best practices for using the camera while multitasking, see [Accessing the camera while multitasking on iPad](https://developer.apple.com/documentation/avkit/accessing-the-camera-while-multitasking-on-ipad?language=objc).

   Requirements:

   - iOS < 16: Requires [com.apple.developer.avfoundation.multitasking-camera-access](https://developer.apple.com/documentation/BundleResources/Entitlements/com.apple.developer.avfoundation.multitasking-camera-access?language=objc) entitlement
     - [Contact Apple](https://developer.apple.com/contact/request/multitasking-camera-access/) for permission
   - iOS ≥ 16: Set `multitaskingCameraAccessEnabled` to `true` in capture session (coming soon)

### Flutter Implementation

> Complete example: [picture_in_picture.dart](../../example/lib/examples/advanced/picture_in_picture/picture_in_picture.dart)

1. **Basic Setup**

   ```dart
   import 'package:agora_rtc_engine/agora_rtc_engine.dart';

   // Declare controllers
   late final RtcEngine _engine;
   late final AgoraPipController _pipController;

   // Create and initialize RtcEngine
   _engine = createAgoraRtcEngine();
   await _engine.initialize(RtcEngineContext(
     // ... configuration
   ));

   // iOS-specific render type configuration
   if (Platform.isIOS) {
     // According to [Adopting Picture in Picture in a Custom Player](https://developer.apple.com/documentation/avkit/adopting_picture_in_picture_in_a_custom_player),
     // the PiP window only supports `AVPlayerLayer` or `AVSampleBufferDisplayLayer` for rendering video content.
     // Therefore, we need to change the internal render type for iOS to use a compatible layer type.
     await _engine.setParameters("{\"che.video.render.mode\":22}");
   }

   // Create PiP controller
   _pipController = _engine.createPipController();
   ```

2. **Configure PiP State Observer**

   ```dart
   _pipController.registerPipStateChangedObserver(AgoraPipStateChangedObserver(
     onPipStateChanged: (state, error) {
       // Handle state changes
     },
   ));

   // Check PiP support
   var isPipSupported = await _pipController.pipIsSupported();
   var isPipAutoEnterSupported = await _pipController.pipIsAutoEnterSupported();
   ```

3. **Configure PiP Options**

   **Android Configuration:**

   ```dart
   AgoraPipOptions options = AgoraPipOptions(
     // Setting autoEnterEnabled to true enables seamless transition to PiP mode when the app enters background,
     // providing the best user experience recommended by both Android and iOS platforms.
     autoEnterEnabled: isPipAutoEnterSupported,

     // Keep the aspect ratio same as the video view. The aspectRatioX and aspectRatioY values
     // should match your video dimensions for optimal display. For example, for 1080p video,
     // use 16:9 ratio (1920:1080 simplified to 16:9).
     aspectRatioX: 16,
     aspectRatioY: 9,

     // According to https://developer.android.com/develop/ui/views/picture-in-picture#set-sourcerecthint
     // The sourceRectHint defines the initial position and size of the PiP window during the transition animation.
     // Setting proper values helps create a smooth animation from your video view to the PiP window.
     // If not set correctly, the system may apply a default content overlay, resulting in a jarring transition.
     sourceRectHintLeft: 0,
     sourceRectHintTop: 0,
     sourceRectHintRight: 0,
     sourceRectHintBottom: 0,

     // According to https://developer.android.com/develop/ui/views/picture-in-picture#seamless-resizing
     // The seamlessResizeEnabled flag enables smooth resizing of the PiP window.
     // Set this to true for video content to allow continuous playback during resizing.
     // Set this to false for non-video content where seamless resizing isn't needed.
     seamlessResizeEnabled: true,

     // The external state monitor checks the PiP view state at the interval specified by externalStateMonitorInterval (100ms).
     // This is necessary because FlutterActivity does not forward PiP state change events to the Flutter side.
     // Even if your Activity is a subclass of AgoraPIPFlutterActivity, you can still use the external state monitor to track PiP state changes.
     useExternalStateMonitor: false,
     externalStateMonitorInterval: 100,
   );
   ```

   **iOS Configuration:**

   ```dart
   AgoraPipOptions options = AgoraPipOptions(
     // Setting autoEnterEnabled to true enables seamless transition to PiP mode when the app enters background,
     // providing the best user experience recommended by both Android and iOS platforms.
     autoEnterEnabled: isPipAutoEnterSupported,

     // Use preferredContentWidth and preferredContentHeight to set the size of the PIP window.
     // These values determine the initial dimensions and can be adjusted while PIP is active.
     // For optimal user experience, we recommend matching these dimensions to your video view size.
     // The system may adjust the final window size to maintain system constraints.
     preferredContentWidth: 1080,
     preferredContentHeight: 720,

     // The sourceContentView determines the source frame for the PiP animation and restore target.
     // Pass 0 to use the app's root view. For optimal animation, set this to the view containing
     // your video content. The system uses this view for the PiP enter/exit animations and as the
     // restore target when returning to the app or stopping PiP.
     sourceContentView: 0,

     // The contentView determines which view will be displayed in the PIP window.
     // If you pass 0, the PIP controller will automatically manage and display all video streams.
     // If you pass a specific view ID, you become responsible for managing the content shown in the PIP window.
     contentView: 0, // force to use native view

     // The contentViewLayout determines the layout of video streams in the PIP window.
     // You can customize the grid layout by specifying:
     // - padding: Space between the window edge and content (in pixels)
     // - spacing: Space between video streams (in pixels)
     // - row: Number of rows in the grid layout
     // - column: Number of columns in the grid layout
     //
     // The SDK provides a basic grid layout system that arranges video streams in a row x column matrix.
     // For example:
     // - row=2, column=2: Up to 4 video streams in a 2x2 grid
     // - row=1, column=2: Up to 2 video streams side by side
     // - row=2, column=1: Up to 2 video streams stacked vertically
     //
     // Note:
     // - This layout configuration only takes effect when contentView is 0 (using native view)
     // - The grid layout is filled from left-to-right, top-to-bottom
     // - Empty cells will be left blank if there are fewer streams than grid spaces
     // - For custom layouts beyond the grid system, set contentView to your own view ID
     contentViewLayout: AgoraPipContentViewLayout(
       padding: 0,
       spacing: 2,
       row: 2,
       column: 2,
     ),

     // The videoStreams array specifies which video streams to display in the PIP window.
     // Each stream can be configured with properties like uid, sourceType, setupMode, and renderMode.
     // Note:
     // - This configuration only takes effect when contentView is set to 0 (native view mode).
     // - The streams will be laid out according to the contentViewLayout grid configuration.
     // - The order of the video streams in the array determines the display order in the PIP window.
     // - The SDK will automatically create and manage native views for each video stream.
     // - The view property in VideoCanvas will be replaced by the SDK-managed native view.
     // - You can customize the rendering of each stream using properties like renderMode and mirrorMode.
     videoStreams: [
       AgoraPipVideoStream(
         connection: RtcConnection(
           channelId: 'channelId',
           localUid: 0,
         ),
         canvas: const VideoCanvas(
           uid: 0,
           view: 0, // will be replaced by native view
           sourceType: VideoSourceType.videoSourceCamera,
           setupMode: VideoViewSetupMode.videoViewSetupAdd,
           renderMode: RenderModeType.renderModeHidden,
           // ... other properties
         ),
       ),
       ..._remoteUsers.entries.map((entry) => AgoraPipVideoStream(
             connection: entry.value,
             canvas: VideoCanvas(
                 uid: entry.key,
                 view: 0, // will be replaced by native view
                 sourceType: VideoSourceType.videoSourceRemote,
                 setupMode: VideoViewSetupMode.videoViewSetupAdd,
                 renderMode: RenderModeType.renderModeHidden),
                 // ... other properties
           )),
     ],

     // The controlStyle property determines which controls are visible in the PiP window.
     // Available styles:
     // * 0: Show all system controls (default) - includes play/pause, forward/backward, close and restore buttons
     // * 1: Hide forward and backward buttons - shows only play/pause, close and restore buttons
     // * 2: Hide play/pause button and progress bar - shows only close and restore buttons (recommended)
     // * 3: Hide all system controls - no buttons visible, including close and restore
     //
     // Note: For most video conferencing use cases, style 2 is recommended since playback controls
     // are not relevant and may confuse users. The close and restore buttons provide essential
     // window management functionality.
     // Note: We do not handle the event of other controls, so the recommended style is 2 or 3.
     controlStyle: 2,
   );
   ```

4. **PiP Lifecycle Management**

   ```dart
   // Setup PiP
   await _pipController.pipSetup(options);

   // Start PiP (iOS: Must be user-initiated)
   // Important: On iOS, Picture-in-Picture playback must only be initiated in response to explicit user actions (e.g. tapping a button).
   // Starting PiP programmatically or automatically may result in App Store rejection.
   // For more details, see Apple's guidelines on [Handle User-Initiated Requests](https://developer.apple.com/documentation/avkit/adopting-picture-in-picture-in-a-custom-player?language=objc#Handle-User-Initiated-Requests).
   await _pipController.pipStart();

   // Stop PiP
   await _pipController.pipStop();

   // Cleanup PiP resources
   // This will stop PiP mode and dispose any native views created by the PiP controller.
   // To use PiP functionality again, you'll need to call pipSetup with new options.
   // Note that this method only cleans up PiP-related resources - it does not dispose the controller itself.
   await _pipController.pipDispose();

   // Dispose controller (prevent memory leaks)
   // This will stop PiP mode, dispose any native views created by the PiP controller,
   // and clean up associated resources. After calling dispose(), this AgoraPipController
   // instance becomes invalid and should not be used again. Create a new instance if you
   // need to use PiP functionality again.
   await _pipController.dispose();
   ```

## Important Notes

1. **iOS User Initiation Requirement**

   > PiP must be initiated by user action on iOS. Programmatic or automatic activation may result in App Store rejection. See [Handle User-Initiated Requests](https://developer.apple.com/documentation/avkit/adopting-picture-in-picture-in-a-custom-player?language=objc#Handle-User-Initiated-Requests)

2. **Memory Management**

   - Always dispose `AgoraPipController` when no longer needed
   - Failure to dispose may result in memory leaks

3. **Control Styles (iOS)**
   - 0: All system controls (default)
   - 1: Hide forward/backward buttons
   - 2: Hide play/pause and progress bar (recommended for video conferencing)
   - 3: Hide all controls
