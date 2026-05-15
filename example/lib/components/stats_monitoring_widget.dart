import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

/// A widget that overlay the local/remote stats info above the child widget.
///
/// Pass [engineReadyFuture] from the page after [RtcEngine.initialize] (and any
/// setup you need before secondary handlers run). Otherwise this widget may call
/// [RtcEngine.registerEventHandler] before initialization completes.
class StatsMonitoringWidget extends StatelessWidget {
  const StatsMonitoringWidget({
    Key? key,
    required this.rtcEngine,
    required this.uid,
    this.channelId,
    this.engineReadyFuture,
    required this.child,
  }) : super(key: key);

  final RtcEngine rtcEngine;

  final int uid;

  final String? channelId;

  /// Completes when [RtcEngine.initialize] (and typically the owning page's
  /// `_initEngine`) has finished — **before** registering this overlay handler.
  final Future<void>? engineReadyFuture;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          bottom: 0,
          left: 0,
          child: _StatsMonitoringInternalWidget(
            rtcEngine: rtcEngine,
            uid: uid,
            channelId: channelId,
            engineReadyFuture: engineReadyFuture,
          ),
        ),
      ],
    );
  }
}

class _StatsMonitoringInternalWidget extends StatefulWidget {
  const _StatsMonitoringInternalWidget({
    Key? key,
    required this.rtcEngine,
    required this.uid,
    this.channelId,
    this.engineReadyFuture,
  }) : super(key: key);

  final RtcEngine rtcEngine;

  final int uid;

  final String? channelId;

  final Future<void>? engineReadyFuture;

  @override
  State<_StatsMonitoringInternalWidget> createState() =>
      __StatsMonitoringInternalWidgetState();
}

class __StatsMonitoringInternalWidgetState
    extends State<_StatsMonitoringInternalWidget> {
  RtcEngineEventHandler? _eventHandler;
  bool _registeredWithEngine = false;

  RtcStats? _rtcStats;
  LocalAudioStats? _localAudioStats;
  LocalVideoStats? _localVideoStats;
  RemoteAudioStats? _remoteAudioStats;
  RemoteVideoStats? _remoteVideoStats;
  int _volume = 0;

  @override
  void initState() {
    super.initState();
    _registerWhenReady();
  }

  Future<void> _registerWhenReady() async {
    final ready = widget.engineReadyFuture;
    if (ready != null) {
      try {
        await ready;
      } catch (_) {
        return;
      }
    } else {
      final c = Completer<void>();
      WidgetsBinding.instance.addPostFrameCallback((_) => c.complete());
      await c.future;
    }

    if (!mounted) return;

    _eventHandler = RtcEngineEventHandler(
      onRtcStats: (connection, stats) {
        setState(() {
          _rtcStats = stats;
        });
      },
      onLocalAudioStats: (connection, stats) {
        setState(() {
          _localAudioStats = stats;
        });
      },
      onLocalVideoStats: (connection, stats) {
        setState(() {
          _localVideoStats = stats;
        });
      },
      onRemoteAudioStats: (connection, stats) {
        setState(() {
          _remoteAudioStats = stats;
        });
      },
      onRemoteVideoStats: (connection, stats) {
        setState(() {
          _remoteVideoStats = stats;
        });
      },
      onAudioVolumeIndication:
          (connection, speakers, speakerNumber, totalVolume) {
        final volume =
            speakers.firstWhereOrNull((e) => e.uid == widget.uid)?.volume ?? 0;
        if (volume != 0) {
          setState(() {
            _volume = volume;
          });
        }
      },
    );

    widget.rtcEngine.registerEventHandler(_eventHandler!);
    _registeredWithEngine = true;
    await widget.rtcEngine.enableAudioVolumeIndication(
        interval: 200, smooth: 3, reportVad: false);
  }

  @override
  void dispose() {
    if (_registeredWithEngine && _eventHandler != null) {
      widget.rtcEngine.unregisterEventHandler(_eventHandler!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLocal = widget.channelId == null;

    final width = (isLocal
            ? _localVideoStats?.captureFrameWidth
            : _remoteVideoStats?.width) ??
        0;
    final height = (isLocal
            ? _localVideoStats?.captureFrameHeight
            : _remoteVideoStats?.height) ??
        0;
    final fps = (isLocal
            ? _localVideoStats?.captureFrameRate
            : _remoteVideoStats?.decoderOutputFrameRate) ??
        0;
    final lastmileDelay = _rtcStats?.lastmileDelay ?? 0;

    final videoSentBitrate = _localVideoStats?.sentBitrate ?? 0;
    final _audioSentBitrate = _localAudioStats?.sentBitrate ?? 0;
    final cpuTotalUsage = _rtcStats?.cpuTotalUsage ?? 0.0;
    final cpuAppUsage = _rtcStats?.cpuAppUsage ?? 0.0;
    final txPacketLossRate = _rtcStats?.txPacketLossRate ?? 0;

    final videoReceivedBitrate = _remoteVideoStats?.receivedBitrate ?? 0;
    final audioReceivedBitrate = _remoteAudioStats?.receivedBitrate ?? 0;
    final packetLossRate = _remoteVideoStats?.packetLossRate ?? 0;
    final audioLossRate = _remoteAudioStats?.audioLossRate ?? 0;
    final quality = _remoteAudioStats?.quality != null
        ? QualityTypeExt.fromValue(_remoteAudioStats!.quality!)
        : QualityType.qualityUnknown;

    const style = TextStyle(color: Colors.white, fontSize: 10);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('uid: ${widget.uid}', style: style),
        Text('$width x $height, $fps fps', style: style),
        Text('LM Delay: ${lastmileDelay}ms', style: style),
        Text('Volume: $_volume', style: style),
        if (isLocal) ...[
          Text('VSend: ${videoSentBitrate}kbps', style: style),
          Text('ASend: ${_audioSentBitrate}kbps', style: style),
          Text('CPU: $cpuAppUsage% | $cpuTotalUsage%', style: style),
          Text('Send Loss: $txPacketLossRate%', style: style),
        ],
        if (!isLocal) ...[
          Text('VRecv: ${videoReceivedBitrate}kbps', style: style),
          Text('ARecv: ${audioReceivedBitrate}kbps', style: style),
          Text('VLoss: $packetLossRate%', style: style),
          Text('ALoss: $audioLossRate%', style: style),
          Text(
              'AQuality: ${quality.toString().replaceFirst('QualityType.', '')}',
              style: style),
        ],
      ],
    );
  }
}

extension _ListExt<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final item in this) {
      if (test(item)) {
        return item;
      }
    }
    return null;
  }
}
