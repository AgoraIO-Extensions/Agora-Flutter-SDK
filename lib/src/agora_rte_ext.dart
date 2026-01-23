import 'package:agora_rtc_engine/src/agora_rte.dart';
import 'package:agora_rtc_engine/src/impl/agora_rte_impl.dart' as impl;

/// Creates an [AgoraRte] instance.
///
/// This returns a singleton instance of the RTE engine, similar to [createAgoraRtcEngine].
/// The same instance is returned on subsequent calls.
AgoraRte createAgoraRte() {
  return impl.AgoraRteImpl.create();
}
