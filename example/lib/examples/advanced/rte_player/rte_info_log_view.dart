import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class RteInfoLogView extends StatefulWidget {
  final ValueNotifier<AgoraRtePlayerStats?> statsNotifier;
  final ValueNotifier<AgoraRtePlayerInfo?> playerInfoNotifier;
  final ValueNotifier<List<String>> eventLogsNotifier;
  final VoidCallback onClearLogs;

  const RteInfoLogView({
    Key? key,
    required this.statsNotifier,
    required this.playerInfoNotifier,
    required this.eventLogsNotifier,
    required this.onClearLogs,
  }) : super(key: key);

  @override
  State<RteInfoLogView> createState() => _RteInfoLogViewState();
}

class _RteInfoLogViewState extends State<RteInfoLogView> {
  String _formatTime(int milliseconds) {
    final seconds = milliseconds ~/ 1000;
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Statistics
          ValueListenableBuilder<AgoraRtePlayerStats?>(
            valueListenable: widget.statsNotifier,
            builder: (context, stats, child) {
              if (stats == null) return const SizedBox.shrink();
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Statistics:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('Video Decode FPS: ${stats.videoDecodeFrameRate}'),
                      Text('Video Render FPS: ${stats.videoRenderFrameRate}'),
                      Text('Video Bitrate: ${stats.videoBitrate} bps'),
                      Text('Audio Bitrate: ${stats.audioBitrate} bps'),
                    ],
                  ),
                ),
              );
            },
          ),

          // Player info
          ValueListenableBuilder<AgoraRtePlayerInfo?>(
            valueListenable: widget.playerInfoNotifier,
            builder: (context, playerInfo, child) {
              if (playerInfo == null) return const SizedBox.shrink();
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Player Info:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                          'State: ${AgoraRtePlayerState.values[playerInfo.state].name}'),
                      Text('Duration: ${_formatTime(playerInfo.duration)}'),
                      Text('Stream Count: ${playerInfo.streamCount}'),
                      Text('Has Audio: ${playerInfo.hasAudio}'),
                      Text('Has Video: ${playerInfo.hasVideo}'),
                      Text('Audio Muted: ${playerInfo.isAudioMuted}'),
                      Text('Video Muted: ${playerInfo.isVideoMuted}'),
                      if (playerInfo.videoWidth > 0 &&
                          playerInfo.videoHeight > 0)
                        Text(
                            'Video Size: ${playerInfo.videoWidth}x${playerInfo.videoHeight}'),
                      if (playerInfo.currentUrl.isNotEmpty)
                        Text('Current URL: ${playerInfo.currentUrl}'),
                    ],
                  ),
                ),
              );
            },
          ),

          // Event logs
          Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Event Logs:',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: widget.onClearLogs,
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  padding: const EdgeInsets.all(8.0),
                  child: ValueListenableBuilder<List<String>>(
                    valueListenable: widget.eventLogsNotifier,
                    builder: (context, eventLogs, child) {
                      return ListView.builder(
                        reverse: true,
                        itemCount: eventLogs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              eventLogs[index],
                              style: const TextStyle(
                                  fontSize: 12, fontFamily: 'monospace'),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
