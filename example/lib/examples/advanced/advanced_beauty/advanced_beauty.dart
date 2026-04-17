import 'dart:convert';
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

class AdvancedBeautyTemplateOption {
  const AdvancedBeautyTemplateOption(this.label, this.templateName);

  final String label;
  final String? templateName;

  bool get isNone => templateName == null;
}

const advancedBeautyNoneTemplate = AdvancedBeautyTemplateOption('None', null);

class AdvancedBeautyTemplateCatalog {
  const AdvancedBeautyTemplateCatalog({
    required this.beautyTemplates,
    required this.styleMakeupTemplates,
    required this.filterTemplates,
    required this.stickerTemplates,
    this.defaultBeautyTemplateName,
  });

  const AdvancedBeautyTemplateCatalog.empty()
      : beautyTemplates = const [],
        styleMakeupTemplates = const [advancedBeautyNoneTemplate],
        filterTemplates = const [advancedBeautyNoneTemplate],
        stickerTemplates = const [advancedBeautyNoneTemplate],
        defaultBeautyTemplateName = null;

  final List<AdvancedBeautyTemplateOption> beautyTemplates;
  final List<AdvancedBeautyTemplateOption> styleMakeupTemplates;
  final List<AdvancedBeautyTemplateOption> filterTemplates;
  final List<AdvancedBeautyTemplateOption> stickerTemplates;
  final String? defaultBeautyTemplateName;
}

AdvancedBeautyTemplateCatalog advancedBeautyTemplateCatalogFromConfigJson(
  String configJson,
) {
  final decoded = jsonDecode(configJson);
  if (decoded is! Map<String, dynamic>) {
    return const AdvancedBeautyTemplateCatalog.empty();
  }
  return advancedBeautyTemplateCatalogFromConfig(decoded);
}

AdvancedBeautyTemplateCatalog advancedBeautyTemplateCatalogFromConfig(
  Map<String, dynamic> config,
) {
  final options = <String, dynamic>{};
  final userInterfaceOption = config['user_interface_option'];
  if (userInterfaceOption is Map) {
    for (final entry in userInterfaceOption.entries) {
      if (entry.key is String) {
        options[entry.key as String] = entry.value;
      }
    }
  }

  return AdvancedBeautyTemplateCatalog(
    beautyTemplates: _templateOptionsByPrefix(options, 'Beauty-'),
    styleMakeupTemplates: [
      advancedBeautyNoneTemplate,
      ..._templateOptionsByPrefix(options, 'Makeup-'),
    ],
    filterTemplates: [
      advancedBeautyNoneTemplate,
      ..._templateOptionsByPrefix(options, 'Filter-'),
    ],
    stickerTemplates: [
      advancedBeautyNoneTemplate,
      ..._templateOptionsByPrefix(options, 'Sticker-'),
    ],
    defaultBeautyTemplateName: config['beauty_config'] as String?,
  );
}

List<AdvancedBeautyTemplateOption> _templateOptionsByPrefix(
  Map<String, dynamic> options,
  String prefix,
) {
  return options.keys
      .where((name) => name.startsWith(prefix))
      .map((name) => AdvancedBeautyTemplateOption(name, name))
      .toList(growable: false);
}

bool _shouldSkipBeautyMaterialArchiveEntry(String entryName) {
  return entryName.startsWith('__MACOSX/') || entryName.endsWith('.DS_Store');
}

String _resolveBeautyMaterialRootDirName(Archive archive) {
  final rootDirNames = <String>{};
  for (final file in archive.files) {
    final entryName = file.name;
    if (_shouldSkipBeautyMaterialArchiveEntry(entryName)) {
      continue;
    }
    final segments = entryName.split('/');
    if (segments.isNotEmpty && segments.first.isNotEmpty) {
      rootDirNames.add(segments.first);
    }
  }

  if (rootDirNames.isEmpty) {
    throw StateError('No valid beauty material root directory found in zip');
  }
  if (rootDirNames.length == 1) {
    return rootDirNames.first;
  }
  if (rootDirNames.contains('beauty_material_functional')) {
    return 'beauty_material_functional';
  }
  throw StateError(
    'Expected a single beauty material root directory, found: $rootDirNames',
  );
}

Future<String> extractBeautyMaterialZip({
  required List<int> zipBytes,
  required String targetRootPath,
}) async {
  final archive = ZipDecoder().decodeBytes(zipBytes);
  final rootDirName = _resolveBeautyMaterialRootDirName(archive);
  final targetDir = Directory('$targetRootPath/$rootDirName');

  if (await targetDir.exists()) {
    await targetDir.delete(recursive: true);
  }

  for (final file in archive.files) {
    final entryName = file.name;
    if (_shouldSkipBeautyMaterialArchiveEntry(entryName)) {
      continue;
    }

    final outputPath = '$targetRootPath/$entryName';
    if (file.isFile) {
      final data = file.content as List<int>;
      File(outputPath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(data);
    } else {
      Directory(outputPath).createSync(recursive: true);
    }
  }

  return targetDir.path;
}

class _State extends State<AdvancedBeauty> with KeepRemoteVideoViewsMixin {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  bool _isJoined = false;
  late TextEditingController _channelIdController;

  // Resolved absolute path shown in the UI.
  String? _resolvedBundlePath;

  VideoEffectObject? _videoEffectObject;

  // ---- UI state ----
  bool _beautyEnabled = false;
  AdvancedBeautyTemplateCatalog _templateCatalog =
      const AdvancedBeautyTemplateCatalog.empty();
  AdvancedBeautyTemplateOption? _beautyTemplate;

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

  AdvancedBeautyTemplateOption _styleMakeup = advancedBeautyNoneTemplate;
  double _makeupIntensity = 1.0; // style_effect_option / styleIntensity 0~1

  AdvancedBeautyTemplateOption _filter = advancedBeautyNoneTemplate;
  double _filterStrength = 0.5; // filter_effect_option / strength 0~1

  AdvancedBeautyTemplateOption _sticker = advancedBeautyNoneTemplate;
  double _stickerStrength = 1.0; // sticker_effect_option / strength 0~1
  bool _stickerEnabled = false;

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: config.channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
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
    final ByteData data =
        await rootBundle.load('assets/zips/beauty_material.zip');
    return extractBeautyMaterialZip(
      zipBytes: data.buffer.asUint8List(),
      targetRootPath: directory.path,
    );
  }

  Future<AdvancedBeautyTemplateCatalog> _loadTemplateCatalog(
    String bundlePath,
  ) async {
    final configFile = File('$bundlePath/config.json');
    if (!await configFile.exists()) {
      return const AdvancedBeautyTemplateCatalog.empty();
    }
    return advancedBeautyTemplateCatalogFromConfigJson(
      await configFile.readAsString(),
    );
  }

  AdvancedBeautyTemplateOption? _findTemplateOption(
    List<AdvancedBeautyTemplateOption> options,
    String? templateName,
  ) {
    if (templateName == null) return null;
    for (final option in options) {
      if (option.templateName == templateName) {
        return option;
      }
    }
    return null;
  }

  AdvancedBeautyTemplateOption? _resolveBeautyTemplate(
    AdvancedBeautyTemplateCatalog catalog,
  ) {
    return _findTemplateOption(
          catalog.beautyTemplates,
          _beautyTemplate?.templateName,
        ) ??
        _findTemplateOption(
          catalog.beautyTemplates,
          catalog.defaultBeautyTemplateName,
        ) ??
        (catalog.beautyTemplates.isNotEmpty
            ? catalog.beautyTemplates.first
            : null);
  }

  AdvancedBeautyTemplateOption _resolveOptionalTemplate(
    List<AdvancedBeautyTemplateOption> options,
    String? templateName,
  ) {
    return _findTemplateOption(options, templateName) ?? options.first;
  }

  void _applyTemplateCatalog(AdvancedBeautyTemplateCatalog catalog) {
    setState(() {
      _templateCatalog = catalog;
      _beautyTemplate = _resolveBeautyTemplate(catalog);
      _styleMakeup = _resolveOptionalTemplate(
        catalog.styleMakeupTemplates,
        _styleMakeup.templateName,
      );
      _filter = _resolveOptionalTemplate(
        catalog.filterTemplates,
        _filter.templateName,
      );
      _sticker = _resolveOptionalTemplate(
        catalog.stickerTemplates,
        _sticker.templateName,
      );
    });
  }

  Future<void> _createVideoEffectObject() async {
    if (_videoEffectObject != null) return;
    try {
      _resolvedBundlePath = await setupBeautyMaterials();
      _applyTemplateCatalog(await _loadTemplateCatalog(_resolvedBundlePath!));
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
      if (_beautyTemplate != null) {
        await _applyBeauty();
      }
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
        _beautyTemplate = _resolveBeautyTemplate(_templateCatalog);
        _styleMakeup = _templateCatalog.styleMakeupTemplates.first;
        _filter = _templateCatalog.filterTemplates.first;
        _sticker = _templateCatalog.stickerTemplates.first;
        _stickerEnabled = false;
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
    final beautyTemplate = _beautyTemplate;
    if (_videoEffectObject == null || beautyTemplate?.templateName == null) {
      return;
    }
    try {
      // Load beauty template (this activates the node and loads saved configs / defaults)
      await _videoEffectObject!.addOrUpdateVideoEffect(
        nodeId: VideoEffectNodeId.beauty.value(),
        templateName: beautyTemplate!.templateName!,
      );

      // Fetch the actual parameters from the SDK and update the UI
      Future.delayed(const Duration(milliseconds: 500), () {
        _syncBeautyUI();
      });

      logSink
          .log('[applyBeauty] DONE. template: ${beautyTemplate.templateName}');
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

  Future<void> _applyStyleMakeup(AdvancedBeautyTemplateOption template) async {
    if (_videoEffectObject == null) return;
    try {
      if (template.isNone) {
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
        if (!template.isNone) {
          _filter = _templateCatalog.filterTemplates.first;
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

  Future<void> _applyFilter(AdvancedBeautyTemplateOption template) async {
    if (_videoEffectObject == null) return;
    try {
      if (template.isNone) {
        await _videoEffectObject!
            .removeVideoEffect(VideoEffectNodeId.filter.value());
        logSink.log('[removeVideoEffect] filter removed');
      } else {
        // Style makeup takes priority: remove makeup first
        if (!_styleMakeup.isNone) {
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
        if (!template.isNone) {
          _styleMakeup = _templateCatalog.styleMakeupTemplates.first;
        }
      });
    } on AgoraRtcException catch (e) {
      logSink.log('[applyFilter] AgoraRtcException: ${e.code}, ${e.message}');
    } catch (e) {
      logSink.log('[applyFilter] failed: $e');
    }
  }

  // ---- Sticker (STICKER node) ----

  Future<void> _applySticker(AdvancedBeautyTemplateOption template) async {
    if (_videoEffectObject == null) return;
    try {
      if (template.isNone) {
        await _videoEffectObject!
            .removeVideoEffect(VideoEffectNodeId.sticker.value());
        logSink.log('[removeVideoEffect] sticker removed');
      } else {
        await _videoEffectObject!.addOrUpdateVideoEffect(
          nodeId: VideoEffectNodeId.sticker.value(),
          templateName: template.templateName!,
        );
        await _videoEffectObject!.setVideoEffectBoolParam(
          option: 'sticker_effect_option',
          key: 'enable',
          param: true,
        );
        await _videoEffectObject!.setVideoEffectFloatParam(
          option: 'sticker_effect_option',
          key: 'strength',
          param: _stickerStrength,
        );
        logSink.log('[applySticker] DONE. template: ${template.templateName}');
      }
      setState(() {
        _sticker = template;
        _stickerEnabled = !template.isNone;
      });
    } on AgoraRtcException catch (e) {
      logSink.log('[applySticker] AgoraRtcException: ${e.code}, ${e.message}');
    } catch (e) {
      logSink.log('[applySticker] failed: $e');
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
        const Text(
          'Source zip: assets/zips/beauty_material.zip',
          style: TextStyle(fontSize: 12, color: Colors.grey),
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
          if (_templateCatalog.beautyTemplates.isNotEmpty)
            DropdownButton<AdvancedBeautyTemplateOption>(
              isExpanded: true,
              value: _beautyTemplate,
              items: _templateCatalog.beautyTemplates.map((t) {
                return DropdownMenuItem(value: t, child: Text(t.label));
              }).toList(),
              onChanged: (t) {
                if (t == null) return;
                setState(() => _beautyTemplate = t);
                _applyBeauty();
              },
            )
          else
            const Text(
              'No beauty templates found in config.json',
              style: TextStyle(fontSize: 12, color: Colors.grey),
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
          RadioGroup<int>(
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
            child: Row(children: [
              for (final s in [-1, 0, 1, 2])
                Expanded(
                  child: RadioListTile<int>(
                    title: Text('$s', style: const TextStyle(fontSize: 11)),
                    value: s,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
            ]),
          ),
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
          DropdownButton<AdvancedBeautyTemplateOption>(
            isExpanded: true,
            value: _styleMakeup,
            items: _templateCatalog.styleMakeupTemplates.map((t) {
              return DropdownMenuItem(value: t, child: Text(t.label));
            }).toList(),
            onChanged: (t) {
              if (t == null) return;
              _applyStyleMakeup(t);
            },
          ),
          if (!_styleMakeup.isNone)
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
          DropdownButton<AdvancedBeautyTemplateOption>(
            isExpanded: true,
            value: _filter,
            items: _templateCatalog.filterTemplates.map((t) {
              return DropdownMenuItem(value: t, child: Text(t.label));
            }).toList(),
            onChanged: (t) {
              if (t == null) return;
              _applyFilter(t);
            },
          ),
          if (!_filter.isNone)
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

          const Divider(),

          // ---- STICKER ----
          const Text('Sticker (STICKER node)',
              style: TextStyle(fontWeight: FontWeight.bold)),
          DropdownButton<AdvancedBeautyTemplateOption>(
            isExpanded: true,
            value: _sticker,
            items: _templateCatalog.stickerTemplates.map((t) {
              return DropdownMenuItem(value: t, child: Text(t.label));
            }).toList(),
            onChanged: (t) {
              if (t == null) return;
              _applySticker(t);
            },
          ),
          if (_stickerEnabled)
            _buildSlider(
              label: '贴纸强度 strength',
              value: _stickerStrength,
              onChanged: (v) {
                setState(() => _stickerStrength = v);
                _videoEffectObject?.setVideoEffectFloatParam(
                  option: 'sticker_effect_option',
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
