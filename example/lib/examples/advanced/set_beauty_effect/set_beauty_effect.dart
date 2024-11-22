// ignore_for_file: unnecessary_brace_in_string_interps
import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:agora_rtc_engine_example/components/remote_video_views_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

/// SetBeautyEffect Example
class SetBeautyEffect extends StatefulWidget {
  /// Construct the [SetBeautyEffect]
  const SetBeautyEffect({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<SetBeautyEffect> with KeepRemoteVideoViewsMixin {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  bool isJoined = false;
  late TextEditingController _channelIdController;
  double _lighteningLevel = 0.0;
  double _smoothnessLevel = 0.0;
  double _rednessLevel = 0.0;
  double _sharpnessLevel = 0.0;

  LighteningContrastLevel _selectedLighteningContrastLevel =
      LighteningContrastLevel.lighteningContrastHigh;
  final List<LighteningContrastLevel> _lighteningContrastLevels = [
    LighteningContrastLevel.lighteningContrastLow,
    LighteningContrastLevel.lighteningContrastNormal,
    LighteningContrastLevel.lighteningContrastHigh,
  ];

  final List<FaceShapeBeautyStyle> _faceShapeBeautyStyles = [
    FaceShapeBeautyStyle.faceShapeBeautyStyleFemale,
    FaceShapeBeautyStyle.faceShapeBeautyStyleMale,
  ];
  FaceShapeBeautyStyle _selecctedFaceShapeBeautyStyle =
      FaceShapeBeautyStyle.faceShapeBeautyStyleFemale;
  bool _isFaceShapeBeautyEnabled = false;
  int _faceShapeBeautyStyleIntensity = 0; // 0 - 100

  final List<FaceShapeArea> _faceShapeAreas = [
    FaceShapeArea.faceShapeAreaHeadscale,
    /* 0 - 100 */
    FaceShapeArea.faceShapeAreaForehead,
    /* -100 - 100 */
    FaceShapeArea.faceShapeAreaFacecontour,
    /* 0 - 100 */
    FaceShapeArea.faceShapeAreaFacelength,
    /* -100 - 100 */
    FaceShapeArea.faceShapeAreaFacewidth,
    /* 0 - 100 */
    FaceShapeArea.faceShapeAreaCheekbone,
    /* 0 - 100 */
    FaceShapeArea.faceShapeAreaCheek,
    /* 0 - 100 */
    FaceShapeArea.faceShapeAreaChin,
    /* -100 - 100 */
    FaceShapeArea.faceShapeAreaEyescale,
    FaceShapeArea.faceShapeAreaNoselength,
    /* -100 - 100 */
    FaceShapeArea.faceShapeAreaNosewidth,
    /* -100 - 100 */
    FaceShapeArea.faceShapeAreaMouthscale, /* -100 - 100 */
  ];

  FaceShapeArea _selectedFaceShapeArea = FaceShapeArea.faceShapeAreaHeadscale;
  int _faceShapeAreaIntensity = 0; // 0 - 100 or -100 -

  static const String UNSET_FILTER_ASSET = "assets/none";
  final List<String> _filterAssets = [
    UNSET_FILTER_ASSET,
    "assets/lengbai32",
    "assets/nenbai32",
    "assets/yuansheng32",
  ];

  String _selectedFilterAsset = UNSET_FILTER_ASSET;
  double _filterStrength = 0.5; /* 0.0-1.0 */

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: config.channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  void _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  void _initEngine() async {
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
          isJoined = true;
        });
      },
      onUserJoined: (RtcConnection connection, int rUid, int elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()} remoteUid: $rUid elapsed: $elapsed');
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      onExtensionError:
          (String provider, String extName, int error, String msg) {
        logSink.log(
            '[onExtensionErrored] provider: $provider, extName: $extName, error: $error, msg: $msg');
      },
      onExtensionStarted: (String provider, String extName) {
        logSink
            .log('[onExtensionStarted] provider: $provider, extName: $extName');
      },
      onExtensionEvent:
          (String provider, String extName, String key, String value) {
        logSink
            .log('[onExtensionEvent] provider: $provider, extName: $extName');
      },
      onExtensionStopped: (String provider, String extName) {
        logSink
            .log('[onExtensionStopped] provider: $provider, extName: $extName');
      },
    ));

    await _engine.enableVideo();

    await _engine.enableExtension(
        provider: "agora_video_filters_clear_vision",
        extension: "clear_vision");

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  void _joinChannel() async {
    await _engine.joinChannel(
        token: config.token,
        channelId: _channelIdController.text,
        uid: 0,
        options: const ChannelMediaOptions());
  }

  _leaveChannel() async {
    await _engine.setFaceShapeBeautyOptions(
        enabled: false,
        options: const FaceShapeBeautyOptions(
            shapeStyle: FaceShapeBeautyStyle.faceShapeBeautyStyleFemale,
            styleIntensity: 0));
    await _engine.setBeautyEffectOptions(
      enabled: false,
      options: BeautyOptions(
        lighteningContrastLevel: _selectedLighteningContrastLevel,
        lighteningLevel: _lighteningLevel,
        smoothnessLevel: _smoothnessLevel,
        rednessLevel: _rednessLevel,
        sharpnessLevel: _sharpnessLevel,
      ),
    );

    await _engine.leaveChannel();

    setState(() {
      _lighteningLevel = 0.0;
      _smoothnessLevel = 0.0;
      _rednessLevel = 0.0;
      _sharpnessLevel = 0.0;
      _selectedLighteningContrastLevel =
          LighteningContrastLevel.lighteningContrastHigh;

      _isFaceShapeBeautyEnabled = false;
      _faceShapeBeautyStyleIntensity = 0;
      _faceShapeAreaIntensity = 0;
    });
  }

  Future<String> _loadAssetsIntoDocumentDirectory(String assetPath) async {
    print('load asset file path: $assetPath');

    try {
      final ByteData data = await rootBundle.load(assetPath);

      print('load asset result: ${data.lengthInBytes}');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      Directory appDocDir = Platform.isAndroid
          ? (await getExternalStorageDirectory())!
          : await getApplicationDocumentsDirectory();

      String appDocPath = path.join(appDocDir.path, path.basename(assetPath)+'.cube');

      print("target filter asset file path: $appDocPath");

      final file = File(appDocPath);
      if (!(await file.exists())) {
        await file.create(recursive: true);
        await file.writeAsBytes(bytes);
      }

      return appDocPath;
    } catch (e) {
      print('load asset error: $e');
      return "";
    }
  }

  Widget _buildBeautyEffectOptions() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Beauty Options
          Row(children: [
            const Text('LighteningContrastLevels: '),
            DropdownButton<LighteningContrastLevel>(
                items: _lighteningContrastLevels.map((v) {
                  return DropdownMenuItem(
                    value: v,
                    child: Text(
                      v.toString().split('.')[1],
                      style: const TextStyle(fontSize: 13),
                    ),
                  );
                }).toList(),
                value: _selectedLighteningContrastLevel,
                onChanged: (v) async {
                  _selectedLighteningContrastLevel = v!;

                  await _engine.setBeautyEffectOptions(
                    enabled: true,
                    options: BeautyOptions(
                      lighteningContrastLevel: _selectedLighteningContrastLevel,
                      lighteningLevel: _lighteningLevel,
                      smoothnessLevel: _smoothnessLevel,
                      rednessLevel: _rednessLevel,
                      sharpnessLevel: _sharpnessLevel,
                    ),
                  );

                  setState(() {});
                }),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Lightening Level:'),
              Slider(
                value: _lighteningLevel,
                min: 0,
                max: 1,
                divisions: 10,
                label: 'Lightening Level',
                onChanged: (double value) async {
                  _lighteningLevel = value;

                  await _engine.setBeautyEffectOptions(
                    enabled: true,
                    options: BeautyOptions(
                      lighteningContrastLevel: _selectedLighteningContrastLevel,
                      lighteningLevel: _lighteningLevel,
                      smoothnessLevel: _smoothnessLevel,
                      rednessLevel: _rednessLevel,
                      sharpnessLevel: _sharpnessLevel,
                    ),
                  );

                  setState(() {});
                },
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Smoothness Level:'),
              Slider(
                value: _smoothnessLevel,
                min: 0,
                max: 1,
                divisions: 10,
                label: 'Smoothness Level',
                onChanged: (double value) async {
                  _smoothnessLevel = value;

                  await _engine.setBeautyEffectOptions(
                    enabled: true,
                    options: BeautyOptions(
                      lighteningContrastLevel: _selectedLighteningContrastLevel,
                      lighteningLevel: _lighteningLevel,
                      smoothnessLevel: _smoothnessLevel,
                      rednessLevel: _rednessLevel,
                      sharpnessLevel: _sharpnessLevel,
                    ),
                  );

                  setState(() {});
                },
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Redness Level:'),
              Slider(
                value: _rednessLevel,
                min: 0,
                max: 1,
                divisions: 10,
                label: 'Redness Level',
                onChanged: (double value) async {
                  _rednessLevel = value;
                  await _engine.setBeautyEffectOptions(
                    enabled: true,
                    options: BeautyOptions(
                      lighteningContrastLevel: _selectedLighteningContrastLevel,
                      lighteningLevel: _lighteningLevel,
                      smoothnessLevel: _smoothnessLevel,
                      rednessLevel: _rednessLevel,
                      sharpnessLevel: _sharpnessLevel,
                    ),
                  );

                  setState(() {});
                },
              )
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Sharpness Level:'),
              Slider(
                value: _sharpnessLevel,
                min: 0,
                max: 1,
                divisions: 10,
                label: 'Sharpness Level',
                onChanged: (double value) async {
                  _sharpnessLevel = value;
                  await _engine.setBeautyEffectOptions(
                    enabled: true,
                    options: BeautyOptions(
                      lighteningContrastLevel: _selectedLighteningContrastLevel,
                      lighteningLevel: _lighteningLevel,
                      smoothnessLevel: _smoothnessLevel,
                      rednessLevel: _rednessLevel,
                      sharpnessLevel: _sharpnessLevel,
                    ),
                  );
                  setState(() {});
                },
              )
            ],
          ),
          SizedBox(height: 20),

          // Filter Options
          Row(
            children: [
              const Text('FilterOptions: '),
              DropdownButton<String>(
                value: _selectedFilterAsset,
                items: _filterAssets.map((v) {
                  return DropdownMenuItem(
                    value: v,
                    child: Text(
                      path.basename(v), 
                      style: const TextStyle(fontSize: 13),
                    ),
                  );
                }).toList(),
                onChanged: (v) async {
                  print('selected filter asset: $v');
                  // return if the same filter asset is selected
                  if (v == _selectedFilterAsset) return;

                  bool isFilterEnabled = v != UNSET_FILTER_ASSET;
                  String path = isFilterEnabled
                      ? await _loadAssetsIntoDocumentDirectory(v!)
                      : "";
                  print('selected filter asset: $path');
                  await _engine.setFilterEffectOptions(
                      enabled: isFilterEnabled,
                      options: FilterEffectOptions(
                          path: path, strength: _filterStrength));
                  print('selected filter asset: $path');

                  _selectedFilterAsset = v!;
                  setState(() {});
                },
              ),
            ],
          ),
          if (_selectedFilterAsset != UNSET_FILTER_ASSET) ...[
            const Text('FilterStrength: '),
            Slider(
              value: _filterStrength,
              min: 0,
              max: 1,
              divisions: 10,
              label: 'FilterStrength',
              onChanged: (double value) async {
                if (_filterStrength == value) return;

                _filterStrength = value;

                await _engine.setFilterEffectOptions(
                    enabled: _selectedFilterAsset != UNSET_FILTER_ASSET,
                    options: FilterEffectOptions(
                        path: _selectedFilterAsset == UNSET_FILTER_ASSET
                            ? ""
                            : await _loadAssetsIntoDocumentDirectory(
                                _selectedFilterAsset),
                        strength: _filterStrength));

                setState(() {});
              },
            ),
          ],
          SizedBox(height: 20),

          // FaceShapeBeautyOptions
          Row(
            children: [
              const Text('FaceShapeBeautyOptions: '),
              Checkbox(
                  value: _isFaceShapeBeautyEnabled,
                  onChanged: (v) async {
                    _isFaceShapeBeautyEnabled = v!;

                    await _engine.setFaceShapeBeautyOptions(
                      enabled: v,
                      options: FaceShapeBeautyOptions(
                        shapeStyle: _selecctedFaceShapeBeautyStyle,
                        styleIntensity: _faceShapeBeautyStyleIntensity,
                      ),
                    );

                    setState(() {});
                  }),
            ],
          ),
          if (_isFaceShapeBeautyEnabled) ...[
            SizedBox(height: 20),
            Row(
              children: [
                const Text('Style: '),
                DropdownButton<FaceShapeBeautyStyle>(
                  items: _faceShapeBeautyStyles.map((v) {
                    return DropdownMenuItem(
                      value: v,
                      child: Text(
                        v.toString().split('faceShapeBeautyStyle')[1],
                        style: const TextStyle(fontSize: 13),
                      ),
                    );
                  }).toList(),
                  value: _selecctedFaceShapeBeautyStyle,
                  onChanged: (v) async {
                    await _engine.setFaceShapeBeautyOptions(
                      enabled: _isFaceShapeBeautyEnabled,
                      options: FaceShapeBeautyOptions(
                        shapeStyle: v!,
                        styleIntensity: _faceShapeBeautyStyleIntensity,
                      ),
                    );
                    setState(() {
                      _selecctedFaceShapeBeautyStyle = v;
                    });
                  },
                ),
              ],
            ),
            Slider(
              value: _faceShapeBeautyStyleIntensity.toDouble(),
              min: 0,
              max: 100,
              divisions: 10,
              label: _faceShapeBeautyStyleIntensity.toString(),
              onChanged: (double value) async {
                await _engine.setFaceShapeBeautyOptions(
                  enabled: _isFaceShapeBeautyEnabled,
                  options: FaceShapeBeautyOptions(
                    shapeStyle: _selecctedFaceShapeBeautyStyle,
                    styleIntensity: value.toInt(),
                  ),
                );

                setState(() {
                  _faceShapeBeautyStyleIntensity = value.toInt();
                });
              },
            ),
            Row(children: [
              const Text('Area: '),
              DropdownButton<FaceShapeArea>(
                items: _faceShapeAreas.map((v) {
                  return DropdownMenuItem(
                    value: v,
                    child: Text(
                      v.toString().split('faceShapeArea')[1],
                      style: const TextStyle(fontSize: 13),
                    ),
                  );
                }).toList(),
                value: _selectedFaceShapeArea,
                onChanged: (v) async {
                  await _engine.setFaceShapeAreaOptions(
                      options: FaceShapeAreaOptions(
                    shapeArea: v!,
                    shapeIntensity: _faceShapeAreaIntensity,
                  ));
                  setState(() {
                    _selectedFaceShapeArea = v;
                  });
                },
              ),
            ]),
            Slider(
              value: _faceShapeAreaIntensity.toDouble(),
              min: 0,
              max: 100,
              divisions: 10,
              label: _faceShapeAreaIntensity.toString(),
              onChanged: (double value) async {
                await _engine.setFaceShapeAreaOptions(
                    options: FaceShapeAreaOptions(
                  shapeArea: _selectedFaceShapeArea,
                  shapeIntensity: value.toInt(),
                ));

                setState(() {
                  _faceShapeAreaIntensity = value.toInt();
                });
              },
            )
          ],
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      children: [
        TextField(
          controller: _channelIdController,
          decoration: const InputDecoration(hintText: 'Channel ID'),
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: isJoined ? _leaveChannel : _joinChannel,
                child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
              ),
            )
          ],
        ),
        if (isJoined) _buildBeautyEffectOptions(),
      ],
    );
  }

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
        return _buildOptions();
      },
    );
  }
}
