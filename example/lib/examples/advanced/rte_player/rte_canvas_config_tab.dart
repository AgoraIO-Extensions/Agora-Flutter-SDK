import 'package:agora_rtc_engine/agora_rte_engine.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class RteCanvasConfigTab extends StatefulWidget {
  final AgoraRteCanvas? canvas;
  final Function(String) onLog;

  const RteCanvasConfigTab({
    Key? key,
    this.canvas,
    required this.onLog,
  }) : super(key: key);

  @override
  State<RteCanvasConfigTab> createState() => _RteCanvasConfigTabState();
}

class _RteCanvasConfigTabState extends State<RteCanvasConfigTab> {
  AgoraRteVideoRenderMode _videoRenderMode = AgoraRteVideoRenderMode.fit;
  AgoraRteVideoMirrorMode _videoMirrorMode = AgoraRteVideoMirrorMode.auto;
  AgoraRteRect _cropArea = const AgoraRteRect();

  @override
  void initState() {
    super.initState();
    _loadCanvasConfig();
  }

  @override
  void didUpdateWidget(covariant RteCanvasConfigTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.canvas != widget.canvas) {
      _loadCanvasConfig();
    }
  }

  Future<AgoraRteCanvasConfig> _loadCanvasConfig() async {
    if (widget.canvas == null) return const AgoraRteCanvasConfig();
    try {
      final rteCanvasConfig = await widget.canvas!.getConfigs();
      if (mounted) {
        setState(() {
          _videoRenderMode =
              rteCanvasConfig.videoRenderMode ?? AgoraRteVideoRenderMode.fit;
          _videoMirrorMode =
              rteCanvasConfig.videoMirrorMode ?? AgoraRteVideoMirrorMode.auto;
          _cropArea = rteCanvasConfig.cropArea ?? const AgoraRteRect();
        });
      }
      return rteCanvasConfig;
    } catch (e) {
      widget.onLog('Load Canvas config error: $e');
      return const AgoraRteCanvasConfig();
    }
  }

  Future<void> _setCanvasVideoRenderMode(AgoraRteVideoRenderMode mode) async {
    if (widget.canvas == null) return;
    try {
      await widget.canvas!
          .setConfigs(AgoraRteCanvasConfig(videoRenderMode: mode));
      setState(() {
        _videoRenderMode = mode;
      });
      widget.onLog('Set VideoRenderMode: ${mode.name}');
    } catch (e) {
      widget.onLog('Set VideoRenderMode error: $e');
    }
  }

  Future<void> _setCanvasVideoMirrorMode(AgoraRteVideoMirrorMode mode) async {
    if (widget.canvas == null) return;
    try {
      await widget.canvas!
          .setConfigs(AgoraRteCanvasConfig(videoMirrorMode: mode));
      setState(() {
        _videoMirrorMode = mode;
      });
      widget.onLog('Set VideoMirrorMode: ${mode.name}');
    } catch (e) {
      widget.onLog('Set VideoMirrorMode error: $e');
    }
  }

  Future<void> _setCanvasCropArea(AgoraRteRect rect) async {
    if (widget.canvas == null) return;
    try {
      await widget.canvas!.setConfigs(AgoraRteCanvasConfig(cropArea: rect));
      setState(() {
        _cropArea = rect;
      });
    } catch (e) {
      widget.onLog('Set CropArea error: $e');
    }
  }

  Future<void> _setCanvasConfigsBatch() async {
    if (widget.canvas == null) return;
    try {
      await widget.canvas!.setConfigs(AgoraRteCanvasConfig(
        videoRenderMode: _videoRenderMode,
        videoMirrorMode: _videoMirrorMode,
        cropArea: _cropArea,
      ));
      await _loadCanvasConfig();
      widget.onLog('Set Canvas configs using setConfigs() batch method');
    } catch (e) {
      widget.onLog('Set Canvas configs (batch) error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.canvas == null) {
      return const Center(child: Text('Canvas not initialized'));
    }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Video Render Mode:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: AgoraRteVideoRenderMode.values.map((mode) {
                  return ChoiceChip(
                    label: Text(mode.name),
                    selected: _videoRenderMode == mode,
                    onSelected: (selected) {
                      if (selected) _setCanvasVideoRenderMode(mode);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text('Video Mirror Mode:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 8.0,
                children: AgoraRteVideoMirrorMode.values.map((mode) {
                  return ChoiceChip(
                    label: Text(mode.name),
                    selected: _videoMirrorMode == mode,
                    onSelected: (selected) {
                      if (selected) _setCanvasVideoMirrorMode(mode);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              const Text(
                'Crop Area:${kIsWeb ? ' (Web is not supported)' : ''}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              if (!kIsWeb) ...[
                Text('X: ${_cropArea.x}, Y: ${_cropArea.y}'),
                Text('Width: ${_cropArea.width}, Height: ${_cropArea.height}'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'X'),
                        keyboardType: TextInputType.datetime,
                        onSubmitted: (value) {
                          final x = int.tryParse(value) ?? 0;
                          _setCanvasCropArea(AgoraRteRect(
                            x: x,
                            y: _cropArea.y,
                            width: _cropArea.width,
                            height: _cropArea.height,
                          ));
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'Y'),
                        keyboardType: TextInputType.datetime,
                        onSubmitted: (value) {
                          final y = int.tryParse(value) ?? 0;
                          _setCanvasCropArea(AgoraRteRect(
                            x: _cropArea.x,
                            y: y,
                            width: _cropArea.width,
                            height: _cropArea.height,
                          ));
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'Width'),
                        keyboardType: TextInputType.datetime,
                        onSubmitted: (value) {
                          final width = int.tryParse(value) ?? 0;
                          _setCanvasCropArea(AgoraRteRect(
                            x: _cropArea.x,
                            y: _cropArea.y,
                            width: width,
                            height: _cropArea.height,
                          ));
                        },
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(labelText: 'Height'),
                        keyboardType: TextInputType.datetime,
                        onSubmitted: (value) {
                          final height = int.tryParse(value) ?? 0;
                          _setCanvasCropArea(AgoraRteRect(
                            x: _cropArea.x,
                            y: _cropArea.y,
                            width: _cropArea.width,
                            height: height,
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ] else
                const Text(
                  'JS SDK CanvasConfig does not include cropArea',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _loadCanvasConfig().then((value) {
                    widget.onLog('getConfigs result: ${value.toJson()}');
                  });
                },
                child: const Text('Refresh Config (getConfigs)'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: _setCanvasConfigsBatch,
                child: const Text('Set All Configs (setConfigs)'),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              const Text('Canvas View Management:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const Text(
                'addView() and removeView() are typically called automatically by AgoraRteVideoView:\n'
                '- addView() is called when the view is created\n'
                '- removeView() is called when the widget is disposed\n\n'
                'Manual usage example:\n'
                '```dart\n'
                '// Get viewPtr from platform view\n'
                'final viewPtr = await _platformViewChannel.invokeMethod<int>(\'getNativeViewPtr\');\n'
                '\n'
                '// Add view to canvas\n'
                'await canvas.addView(viewPtr!);\n'
                '\n'
                '// Remove view from canvas (usually called automatically on dispose)\n'
                'await canvas.removeView(viewPtr!);\n'
                '```\n\n'
                'Note: In most cases, you don\'t need to call these methods manually as '
                'AgoraRteVideoView handles view lifecycle automatically.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
