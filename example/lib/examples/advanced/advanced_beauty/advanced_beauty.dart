import 'dart:io';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/components/remote_video_views_widget.dart';
import 'package:archive/archive_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

// ignore_for_file: public_member_api_docs

/// AdvancedBeauty Example
///
/// Demonstrates the use of [VideoEffectObject] APIs (v4.6.2+).
///
/// Prerequisites:
///  - SDK must include AgoraClearVisionExtension.xcframework (iOS) or
///    libagora_clear_vision_extension.so (Android) — both are in the Special pack.
///  - Obtain AgoraBeautyMaterial.bundle (iOS) / AgoraBeautyMaterial.zip (Android)
///    from technical support and place the contents in the app Documents directory.
///
class AdvancedBeauty extends StatefulWidget {
  /// Construct the [AdvancedBeauty]
  const AdvancedBeauty({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

// ---------- Beauty template options ----------
/// Beauty presets — template names come from the SDK resource bundle's config.json.
enum _BeautyTemplate {
  broadcaster('Anchor (主播)', 'Beauty-Anchor'),
  show('Show (秀场)', 'Beauty-Show'),
  basic('Basic (基础)', 'Beauty-Basic'),
  ordinary('Ordinary (普通)', 'Beauty-Ordinary');

  const _BeautyTemplate(this.label, this.templateName);
  final String label;
  final String templateName;
}

// ---------- Style makeup options ----------
/// Style makeup combines multiple makeup layers in one template.
enum _StyleMakeupTemplate {
  none('None', null),
  mature('Mature (学姐)', 'Makeup-Mature'),
  graceful('Graceful (优雅)', 'Makeup-Graceful'),
  aura('Aura (气质)', 'Makeup-Aura'),
  maiden('Maiden (少女)', 'Makeup-Maiden'),
  young('Young (学妹)', 'Makeup-Young');

  const _StyleMakeupTemplate(this.label, this.templateName);
  final String label;
  final String? templateName;
}

// ---------- Filter options ----------
/// Filter template names (English) from the "暖色系" category of the bundle.
enum _FilterTemplate {
  none('None', null),
  serene('Serene (沉稳)', 'Filter-Serene'),
  urban('Urban (都市)', 'Filter-Urban'),
  glow('Glow (流光)', 'Filter-Glow'),
  gilt('Gilt (鎏金)', 'Filter-Gilt'),
  cream('Cream (奶油)', 'Filter-Cream');

  const _FilterTemplate(this.label, this.templateName);
  final String label;
  final String? templateName;
}

class _State extends State<AdvancedBeauty> with KeepRemoteVideoViewsMixin {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  bool _isJoined = false;
  late TextEditingController _channelIdController;

  // Editable sub-dir inside Documents.
  // Switch to 'beauty_material_efficient' for the lightweight version.
  late final TextEditingController _bundleDirController;

  // Resolved absolute path shown in the UI.
  String? _resolvedBundlePath;

  VideoEffectObject? _videoEffectObject;

  // ---- UI state ----
  bool _beautyEnabled = false;
  _BeautyTemplate _beautyTemplate = _BeautyTemplate.broadcaster;

  // beauty_effect_option params
  double _smoothness = 0.5; // 磨皮  0~1
  double _lightness = 0.3; // 美白  0~1
  double _redness = 0.0; // 红润  0~1

  // face_buffing_option (美肤) params
  double _eyePouch = 0.0; // 去眼袋/去黑眼圈 0~1

  // face_shape_beauty_option (美型) — global style shortcut
  // style: -1(无),0(女神),1(男神),2(自然)
  int _faceStyle = -1;
  int _faceIntensity = 50; // 0~100

  _StyleMakeupTemplate _styleMakeup = _StyleMakeupTemplate.none;
  double _makeupIntensity = 1.0; // style_effect_option / styleIntensity 0~1

  _FilterTemplate _filter = _FilterTemplate.none;
  double _filterStrength = 0.5; // filter_effect_option / strength 0~1

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: config.channelId);
    _bundleDirController =
        TextEditingController(text: 'beauty_material_functional');
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _bundleDirController.dispose();
    _channelIdController.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    if (_videoEffectObject != null) {
      await _engine.destroyVideoEffectObject(_videoEffectObject!);
    }
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));

    _engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        logSink.log('[onError] err: $err, msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        logSink.log(
            '[onJoinChannelSuccess] connection: ${connection.toJson()} elapsed: $elapsed');
        setState(() {
          _isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()} rUid: $rUid reason: $reason');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          _isJoined = false;
        });
      },
    ));

    await _engine.enableVideo();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  // ---- VideoEffectObject lifecycle ----
  Future<String> setupBeautyMaterials() async {
    final directory = await getApplicationDocumentsDirectory();
    final targetPath = '${directory.path}/beauty_material_functional';
    final targetDir = Directory(targetPath);

    if (await targetDir.exists()) {
      return targetPath;
    }

    final ByteData data =
        await rootBundle.load('assets/zips/beauty_material.zip');
    final bytes = data.buffer.asUint8List();

    final archive = ZipDecoder().decodeBytes(bytes);
    for (final file in archive) {
      final filename = file.name;
      if (file.isFile) {
        final data = file.content as List<int>;
        File('${directory.path}/$filename')
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        Directory('${directory.path}/$filename').createSync(recursive: true);
      }
    }
    return targetPath;
  }

  Future<void> _createVideoEffectObject() async {
    if (_videoEffectObject != null) return;
    try {
      _resolvedBundlePath = await setupBeautyMaterials();
      logSink.log('[createVideoEffectObject] bundlePath: $_resolvedBundlePath');
      _videoEffectObject = await _engine.createVideoEffectObject(
        bundlePath: _resolvedBundlePath!,
        type: MediaSourceType.primaryCameraSource,
      );
      if (_videoEffectObject == null) {
        logSink.log('[createVideoEffectObject] FAILED — returned null. '
            'Check bundle at: $_resolvedBundlePath');
        return;
      }
      logSink.log('[createVideoEffectObject] success');
      await _applyBeauty();
      setState(() {});
    } catch (e) {
      logSink.log('[createVideoEffectObject] failed: $e');
    }
  }

  Future<void> _destroyVideoEffectObject() async {
    if (_videoEffectObject == null) return;
    try {
      await _engine.destroyVideoEffectObject(_videoEffectObject!);
      logSink.log('[destroyVideoEffectObject] success');
    } catch (e) {
      logSink.log('[destroyVideoEffectObject] failed: $e');
    } finally {
      setState(() {
        _videoEffectObject = null;
        _beautyEnabled = false;
        _styleMakeup = _StyleMakeupTemplate.none;
        _filter = _FilterTemplate.none;
      });
    }
  }

  // ---- UI Sync (Get params from SDK) ----

  Future<void> _syncBeautyUI() async {
    if (_videoEffectObject == null) return;
    try {
      // Sync beauty_effect_option
      _smoothness = await _videoEffectObject!.getVideoEffectFloatParam(
        option: 'beauty_effect_option',
        key: 'smoothness',
      );
      _lightness = await _videoEffectObject!.getVideoEffectFloatParam(
        option: 'beauty_effect_option',
        key: 'lightness',
      );
      _redness = await _videoEffectObject!.getVideoEffectFloatParam(
        option: 'beauty_effect_option',
        key: 'redness',
      );

      // Sync face_buffing_option
      _eyePouch = await _videoEffectObject!.getVideoEffectFloatParam(
        option: 'face_buffing_option',
        key: 'eye_pouch',
      );
      logSink.log(
          '[_syncBeautyUI] synchronized from SDK: smoothness=$_smoothness, lightness=$_lightness, redness=$_redness, eyePouch=$_eyePouch');
      setState(() {});
    } catch (e) {
      logSink.log('[_syncBeautyUI] failed: $e');
    }
  }

  // ---- Beauty (BEAUTY node) ----

  Future<void> _applyBeauty() async {
    if (_videoEffectObject == null) return;
    try {
      // Load beauty template (this activates the node and loads saved configs / defaults)
      await _videoEffectObject!.addOrUpdateVideoEffect(
        nodeId: VideoEffectNodeId.beauty.value(),
        templateName: _beautyTemplate.templateName,
      );

      // Fetch the actual parameters from the SDK and update the UI
      await _syncBeautyUI();

      logSink
          .log('[applyBeauty] DONE. template: ${_beautyTemplate.templateName}');
      setState(() {
        _beautyEnabled = true;
      });
    } on AgoraRtcException catch (e) {
      logSink.log('[applyBeauty] AgoraRtcException: ${e.code}, ${e.message}');
    } catch (e) {
      logSink.log('[applyBeauty] failed: $e');
    }
  }

  Future<void> _removeBeauty() async {
    if (_videoEffectObject == null) return;
    try {
      await _videoEffectObject!
          .removeVideoEffect(VideoEffectNodeId.beauty.value());
      logSink.log('[removeBeauty] success');
      setState(() {
        _beautyEnabled = false;
      });
    } catch (e) {
      logSink.log('[removeBeauty] failed: $e');
    }
  }

  Future<void> _saveConfig() async {
    if (_videoEffectObject == null) return;
    try {
      await _videoEffectObject!.performVideoEffectAction(
        nodeId: VideoEffectNodeId.beauty.value(),
        actionId: VideoEffectAction.save,
      );
      logSink.log('[performVideoEffectAction] beauty config saved');
    } catch (e) {
      logSink.log('[saveConfig] failed: $e');
    }
  }

  Future<void> _resetConfig() async {
    if (_videoEffectObject == null) return;
    try {
      await _videoEffectObject!.performVideoEffectAction(
        nodeId: VideoEffectNodeId.beauty.value(),
        actionId: VideoEffectAction.reset,
      );
      logSink.log('[performVideoEffectAction] beauty config reset');
      await _syncBeautyUI();
    } catch (e) {
      logSink.log('[resetConfig] failed: $e');
    }
  }

  // ---- Style Makeup (STYLE_MAKEUP node) ----

  Future<void> _applyStyleMakeup(_StyleMakeupTemplate template) async {
    if (_videoEffectObject == null) return;
    try {
      if (template == _StyleMakeupTemplate.none) {
        await _videoEffectObject!
            .removeVideoEffect(VideoEffectNodeId.styleMakeup.value());
        logSink.log('[removeVideoEffect] styleMakeup removed');
      } else {
        await _videoEffectObject!.addOrUpdateVideoEffect(
          nodeId: VideoEffectNodeId.styleMakeup.value(),
          templateName: template.templateName!,
        );
        // Global style makeup intensity
        await _videoEffectObject!.setVideoEffectFloatParam(
          option: 'style_effect_option',
          key: 'styleIntensity',
          param: _makeupIntensity,
        );
        logSink
            .log('[applyStyleMakeup] DONE. template: ${template.templateName}');
      }
      setState(() {
        _styleMakeup = template;
        // Makeup and filter are mutually exclusive (makeup takes priority)
        if (template != _StyleMakeupTemplate.none) {
          _filter = _FilterTemplate.none;
        }
      });
    } on AgoraRtcException catch (e) {
      logSink
          .log('[applyStyleMakeup] AgoraRtcException: ${e.code}, ${e.message}');
    } catch (e) {
      logSink.log('[applyStyleMakeup] failed: $e');
    }
  }

  // ---- Filter (FILTER node) ----

  Future<void> _applyFilter(_FilterTemplate template) async {
    if (_videoEffectObject == null) return;
    try {
      if (template == _FilterTemplate.none) {
        await _videoEffectObject!
            .removeVideoEffect(VideoEffectNodeId.filter.value());
        logSink.log('[removeVideoEffect] filter removed');
      } else {
        // Style makeup takes priority: remove makeup first
        if (_styleMakeup != _StyleMakeupTemplate.none) {
          await _videoEffectObject!
              .removeVideoEffect(VideoEffectNodeId.styleMakeup.value());
          logSink.log('[removeVideoEffect] styleMakeup removed for filter');
        }
        await _videoEffectObject!.addOrUpdateVideoEffect(
          nodeId: VideoEffectNodeId.filter.value(),
          templateName: template.templateName!,
        );
        await _videoEffectObject!.setVideoEffectFloatParam(
          option: 'filter_effect_option',
          key: 'strength',
          param: _filterStrength,
        );
        logSink.log('[applyFilter] DONE. template: ${template.templateName}');
      }
      setState(() {
        _filter = template;
        if (template != _FilterTemplate.none) {
          _styleMakeup = _StyleMakeupTemplate.none;
        }
      });
    } on AgoraRtcException catch (e) {
      logSink.log('[applyFilter] AgoraRtcException: ${e.code}, ${e.message}');
    } catch (e) {
      logSink.log('[applyFilter] failed: $e');
    }
  }

  // ---- Channel ----

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _channelIdController.text,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  // ---- Build ----

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return Stack(
          children: [
            AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: RemoteVideoViewsWidget(
                key: keepRemoteVideoViewsKey,
                rtcEngine: _engine,
                channelId: _channelIdController.text,
              ),
            ),
          ],
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return _buildControls();
      },
    );
  }

  Widget _buildControls() {
    final bool hasObject = _videoEffectObject != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Channel
        TextField(
          controller: _channelIdController,
          decoration: const InputDecoration(hintText: 'Channel ID'),
        ),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: _isJoined ? _leaveChannel : _joinChannel,
              child: Text('${_isJoined ? 'Leave' : 'Join'} channel'),
            ),
          ),
        ]),
        const Divider(),

        // VideoEffectObject lifecycle
        const Text('Video Effect Object',
            style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        TextField(
          controller: _bundleDirController,
          enabled: !hasObject,
          decoration: const InputDecoration(
            labelText: 'Bundle sub-dir (in Documents)',
            hintText: 'beauty_material_functional',
            isDense: true,
          ),
        ),
        if (_resolvedBundlePath != null)
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 4),
            child: Text(
              'Path: $_resolvedBundlePath',
              style: const TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ),
        const SizedBox(height: 4),
        Row(children: [
          Expanded(
            child: ElevatedButton(
              onPressed: hasObject ? null : _createVideoEffectObject,
              child: const Text('Create Effect Object'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: hasObject ? _destroyVideoEffectObject : null,
              child: const Text('Destroy Effect Object'),
            ),
          ),
        ]),

        if (hasObject) ...[
          const Divider(),

          // ---- BEAUTY ----
          const Text('Beauty (BEAUTY node)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          const Text('Template:', style: TextStyle(fontSize: 12)),
          DropdownButton<_BeautyTemplate>(
            isExpanded: true,
            value: _beautyTemplate,
            items: _BeautyTemplate.values.map((t) {
              return DropdownMenuItem(value: t, child: Text(t.label));
            }).toList(),
            onChanged: (t) {
              if (t == null) return;
              setState(() => _beautyTemplate = t);
              _applyBeauty();
            },
          ),
          _buildSlider(
            label: '磨皮 smoothness',
            value: _smoothness,
            onChanged: (v) async {
              setState(() => _smoothness = v);
              if (_videoEffectObject != null) {
                if (!_beautyEnabled) await _applyBeauty();
                await _videoEffectObject!.setVideoEffectFloatParam(
                  option: 'beauty_effect_option',
                  key: 'smoothness',
                  param: v,
                );
              }
            },
          ),
          _buildSlider(
            label: '美白 lightness',
            value: _lightness,
            onChanged: (v) async {
              setState(() => _lightness = v);
              if (_videoEffectObject != null) {
                if (!_beautyEnabled) await _applyBeauty();
                await _videoEffectObject!.setVideoEffectFloatParam(
                  option: 'beauty_effect_option',
                  key: 'lightness',
                  param: v,
                );
              }
            },
          ),
          _buildSlider(
            label: '红润 redness',
            value: _redness,
            onChanged: (v) async {
              setState(() => _redness = v);
              if (_videoEffectObject != null) {
                if (!_beautyEnabled) await _applyBeauty();
                await _videoEffectObject!.setVideoEffectFloatParam(
                  option: 'beauty_effect_option',
                  key: 'redness',
                  param: v,
                );
              }
            },
          ),
          _buildSlider(
            label: '去眼袋 eye_pouch',
            value: _eyePouch,
            onChanged: (v) async {
              setState(() => _eyePouch = v);
              if (_videoEffectObject != null) {
                if (!_beautyEnabled) await _applyBeauty();
                await _videoEffectObject!.setVideoEffectFloatParam(
                  option: 'face_buffing_option',
                  key: 'eye_pouch',
                  param: v,
                );
              }
            },
          ),
          const Text(
              '脸型风格【-1: None(无)、0: Goddess(女神)、1: Male(男神)、2: Natural(自然)】',
              style: TextStyle(fontSize: 11, color: Colors.grey)),
          Row(children: [
            for (final s in [-1, 0, 1, 2])
              Expanded(
                child: RadioListTile<int>(
                  title: Text('$s', style: const TextStyle(fontSize: 11)),
                  value: s,
                  groupValue: _faceStyle,
                  onChanged: (v) async {
                    if (v == null) return;
                    setState(() => _faceStyle = v);
                    if (_videoEffectObject != null) {
                      if (!_beautyEnabled) await _applyBeauty();
                      await _videoEffectObject!.setVideoEffectIntParam(
                        option: 'face_shape_beauty_option',
                        key: 'style',
                        param: v,
                      );
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                ),
              ),
          ]),
          _buildSlider(
            label: '美型强度 intensity (0-100)',
            value: _faceIntensity.toDouble(),
            min: 0,
            max: 100,
            onChanged: (v) async {
              setState(() => _faceIntensity = v.round());
              if (_videoEffectObject != null) {
                if (!_beautyEnabled) await _applyBeauty();
                await _videoEffectObject!.setVideoEffectIntParam(
                  option: 'face_shape_beauty_option',
                  key: 'intensity',
                  param: v.round(),
                );
              }
            },
          ),
          Row(children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _beautyEnabled ? _removeBeauty : _applyBeauty,
                child: Text(_beautyEnabled ? 'Remove Beauty' : 'Apply Beauty'),
              ),
            ),
          ]),
          if (_beautyEnabled)
            Row(children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: _saveConfig, child: const Text('Save Config')),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                    onPressed: _resetConfig, child: const Text('Reset Config')),
              ),
            ]),

          const Divider(),

          // ---- STYLE MAKEUP ----
          const Text('Style Makeup (STYLE_MAKEUP node)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          const Text(
            'Style makeup and filters are mutually exclusive, and filters are automatically removed when selecting makeup',
            style: TextStyle(fontSize: 11, color: Colors.grey),
          ),
          DropdownButton<_StyleMakeupTemplate>(
            isExpanded: true,
            value: _styleMakeup,
            items: _StyleMakeupTemplate.values.map((t) {
              return DropdownMenuItem(value: t, child: Text(t.label));
            }).toList(),
            onChanged: (t) {
              if (t == null) return;
              _applyStyleMakeup(t);
            },
          ),
          if (_styleMakeup != _StyleMakeupTemplate.none)
            _buildSlider(
              label: '妆容强度 styleIntensity',
              value: _makeupIntensity,
              onChanged: (v) {
                setState(() => _makeupIntensity = v);
                _videoEffectObject?.setVideoEffectFloatParam(
                  option: 'style_effect_option',
                  key: 'styleIntensity',
                  param: v,
                );
              },
            ),

          const Divider(),

          // ---- FILTER ----
          const Text('Filter (FILTER node)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<_FilterTemplate>(
            isExpanded: true,
            value: _filter,
            items: _FilterTemplate.values.map((t) {
              return DropdownMenuItem(value: t, child: Text(t.label));
            }).toList(),
            onChanged: (t) {
              if (t == null) return;
              _applyFilter(t);
            },
          ),
          if (_filter != _FilterTemplate.none)
            _buildSlider(
              label: '滤镜强度 strength',
              value: _filterStrength,
              onChanged: (v) {
                setState(() => _filterStrength = v);
                // Live update filter strength
                _videoEffectObject?.setVideoEffectFloatParam(
                  option: 'filter_effect_option',
                  key: 'strength',
                  param: v,
                );
              },
            ),
        ],
      ],
    );
  }

  Widget _buildSlider({
    required String label,
    required double value,
    required ValueChanged<double> onChanged,
    double min = 0.0,
    double max = 1.0,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$label: ${value.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 12)),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: 20,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
