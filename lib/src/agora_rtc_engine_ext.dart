import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show MethodCall;

import '/src/agora_media_player.dart';
import '/src/agora_rtc_engine.dart';
import '/src/agora_rtc_engine_ex.dart';
import '/src/impl/agora_rtc_engine_impl.dart';
import '/src/impl/agora_rtc_engine_impl.dart' as impl;
import '/src/impl/media_player_impl.dart';
import '/src/agora_pip_controller.dart';
import '/src/impl/agora_pip_controller_impl.dart';

/// @nodoc
extension RtcEngineExt on RtcEngine {
  /// Obtains the actual absolute path of the Asset through the relative path of the Asset.
  ///
  /// * [assetPath] The flutter -> assets field configured in the pubspec.yaml file.
  ///
  /// Returns
  /// The actual path of the Asset.
  Future<String?> getAssetAbsolutePath(String assetPath) async {
    final impl = this as RtcEngineImpl;
    return impl.getAssetAbsolutePath(assetPath);
  }

  /// Creates a [AgoraPipController] instance for managing Picture-in-Picture (PiP) mode.
  ///
  /// Returns
  /// A [AgoraPipController] instance.
  AgoraPipController createPipController() {
    return AgoraPipControllerImpl(this);
  }

  /// Invokes a method on the native platform through the Agora method channel.
  ///
  /// * [method] The name of the method to invoke
  /// * [arguments] Optional arguments to pass to the method
  ///
  /// Returns a Future that completes with the result of type T, or null if no result
  @optionalTypeArgs
  Future<T?> invokeAgoraMethod<T>(String method, [dynamic arguments]) {
    final impl = this as RtcEngineImpl;
    return impl.invokeAgoraMethod<T>(method, arguments);
  }

  /// Registers a handler for a specific method channel.
  ///
  /// * [method] The name of the method to handle
  /// * [handler] The function that will handle calls to this method
  ///
  /// The handler will be called when the native platform invokes the specified method.
  Future<void> registerMethodChannelHandler(
    String method,
    Future<dynamic> Function(MethodCall call) handler,
  ) {
    final impl = this as RtcEngineImpl;
    return impl.registerMethodChannelHandler(method, handler);
  }

  /// Unregisters a previously registered method channel handler.
  ///
  /// * [method] The name of the method whose handler should be removed
  /// * [handler] The handler function to unregister. If null, all handlers for the
  ///            specified method will be removed
  ///
  /// After unregistering, the handler will no longer be called when the method is invoked
  /// from the native platform.
  Future<void> unregisterMethodChannelHandler(
    String method,
    Future<dynamic> Function(MethodCall call)? handler,
  ) {
    final impl = this as RtcEngineImpl;
    return impl.unregisterMethodChannelHandler(method, handler);
  }

  /// Creates a native view for use in Picture-in-Picture (PiP) mode.
  ///
  /// Returns
  /// A native view ID that can be used to reference the view in future method calls.
  Future<int> createNativeView() async {
    final result = await invokeAgoraMethod<int>('nativeViewCreate');
    return result ?? 0;
  }

  /// Destroys a native view previously created through createNativeView.
  ///
  /// * [nativeViewId] The ID of the native view to destroy
  ///
  Future<void> destroyNativeView(int nativeViewId) async {
    await invokeAgoraMethod<void>('nativeViewDestroy', nativeViewId);
  }

  /// Sets the parent view for a native view in Picture-in-Picture (PiP) mode.
  ///
  /// * [nativeViewId] The ID of the native view that will be added as a child
  /// * [parentNativeViewId] The ID of the parent view to add the native view to. If 0, the native view will be removed from its current parent
  /// * [indexOfParentView] The index position where the native view should be inserted in the parent's child view hierarchy. Lower indices are rendered below higher indices.
  ///
  /// Returns a boolean indicating whether the parent-child relationship was successfully established.
  /// Returns false if either view ID is invalid or if the operation fails.
  Future<bool> setNativeViewParent(
    int nativeViewId,
    int parentNativeViewId,
    int? indexOfParentView,
  ) async {
    final result = await invokeAgoraMethod<bool>('nativeViewSetParent', {
      'nativeViewId': nativeViewId,
      'parentNativeViewId': parentNativeViewId,
      'indexOfParentView': indexOfParentView,
    });
    return result ?? false;
  }

  /// Sets the layout constraints for a native view.
  ///
  /// * [nativeViewId] The ID of the native view to set the layout for
  /// * [contentViewLayout] A dictionary containing layout configuration, support key:
  ///   - padding: Distance from top edge
  ///   - spacing: Distance from bottom edge
  ///   - row: Fixed width
  ///   - column: Fixed height
  ///
  /// Returns
  /// A boolean indicating whether the layout was successfully set.
  Future<bool> setNativeViewLayout(
    int nativeViewId,
    Map<String, dynamic>? contentViewLayout,
  ) async {
    final result = await invokeAgoraMethod<bool>('nativeViewSetLayout', {
      'nativeViewId': nativeViewId,
      'contentViewLayout': contentViewLayout,
    });
    return result ?? false;
  }
}

/// Error codes and error messages.
class AgoraRtcException implements Exception {
  /// @nodoc
  AgoraRtcException({required this.code, this.message});

  /// The error code. See ErrorCodeType.
  final int code;

  /// The error message.
  final String? message;

  @override
  String toString() => 'AgoraRtcException($code, $message)';
}

/// Creates one RtcEngine object.
///
/// Currently, the Agora RTC SDK v6.x supports creating only one RtcEngine object for each app.
///
/// Returns
/// One RtcEngine object.
RtcEngine createAgoraRtcEngine({Object? sharedNativeHandle}) {
  return impl.RtcEngineImpl.create(sharedNativeHandle: sharedNativeHandle);
}

/// Creates one RtcEngineEx object.
///
/// Currently, the Agora RTC v6.x SDK supports creating only one RtcEngineEx object for each app.
///
/// Returns
/// One RtcEngineEx object.
RtcEngineEx createAgoraRtcEngineEx({Object? sharedNativeHandle}) {
  return impl.RtcEngineImpl.create(sharedNativeHandle: sharedNativeHandle);
}

/// Gets one MediaPlayerCacheManager instance.
///
/// Before calling any APIs in the MediaPlayerCacheManager class, you need to call this method to get a cache manager instance of a media player.
///
/// Returns
/// The MediaPlayerCacheManager instance.
MediaPlayerCacheManager getMediaPlayerCacheManager(RtcEngine rtcEngine) {
  return MediaPlayerCacheManagerImpl.create(rtcEngine);
}
