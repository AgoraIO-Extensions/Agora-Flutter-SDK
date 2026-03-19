import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'impl/agora_rte_impl.dart'
    if (dart.library.js_interop) 'impl/web/agora_rte_web_impl.dart';

/// Creates and returns an [AgoraRte] instance.
///
/// This is the main entry point for accessing RTE (Real-Time Engagement)
/// functionality. The function returns a singleton instance - the same instance
/// is returned on all subsequent calls, similar to [createAgoraRtcEngine].
///
/// After creating the RTE instance, you must call [AgoraRte.createWithConfig]
/// to initialize it with your configuration, then [AgoraRte.initMediaEngine]
/// to initialize the media engine before using other features.
///
/// **Returns:**
/// A singleton [AgoraRte] instance.
///
/// **Example:**
/// ```dart
/// // Create RTE instance
/// final rte = createAgoraRte();
///
/// // Configure RTE
/// final config = AgoraRteConfig(
///   appId: 'your_app_id',
/// );
/// await rte.createWithConfig(config);
///
/// // Initialize media engine
/// await rte.initMediaEngine();
///
/// // Create a player
/// final player = await rte.createPlayer(AgoraRtePlayerConfig());
/// ```
///
/// **See also:**
/// - [AgoraRte]
/// - [AgoraRte.createWithConfig]
/// - [AgoraRte.initMediaEngine]
///
/// **Since:** v4.4.0
///
/// **Platform:** iOS, Android, Web
AgoraRte createAgoraRte() => createAgoraRteImpl();
