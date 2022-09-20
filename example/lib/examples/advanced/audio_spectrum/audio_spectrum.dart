import 'dart:math';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

/// AudioSpectrum Example
class AudioSpectrum extends StatefulWidget {
  /// Construct the [AudioSpectrum]
  const AudioSpectrum({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<AudioSpectrum> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);

    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    await _engine.setLogFilter(LogFilterType.logFilterError);

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
        setState(() {
          remoteUid.add(rUid);
        });
      },
      onUserOffline:
          (RtcConnection connection, int rUid, UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}  rUid: $rUid reason: $reason');
        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
        });
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));

    await _engine.enableVideo();

    // final observer = AudioSpectrumObserver(
    //   onLocalAudioSpectrum: (AudioSpectrumData data) {
    //     debugPrint('[onLocalAudioSpectrum] data: ${data.toJson()}');
    //   },
    //   onRemoteAudioSpectrum:
    //       (List<UserAudioSpectrumInfo> spectrums, int spectrumNumber) {
    //     debugPrint(
    //         '[onRemoteAudioSpectrum] spectrums: $spectrums, spectrumNumber: $spectrumNumber');
    //   },
    // );

    // _engine.registerAudioSpectrumObserver(observer);
    // _engine.unregisterAudioSpectrumObserver(observer);

    await _engine.setVideoEncoderConfiguration(
      const VideoEncoderConfiguration(
        dimensions: VideoDimensions(width: 640, height: 360),
        frameRate: 15,
        bitrate: 800,
      ),
    );

    await _engine.startPreview();

    setState(() {
      _isReadyPreview = true;
    });
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      uid: config.uid,
      options: const ChannelMediaOptions(
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        if (!_isReadyPreview) return Container();
        return CurveLine(rtcEngine: _engine);
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
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
          ],
        );
      },
    );
    // if (!_isInit) return Container();
  }
}

class CurveLine extends StatefulWidget {
  const CurveLine({Key? key, required this.rtcEngine}) : super(key: key);

  final RtcEngine rtcEngine;

  @override
  State<CurveLine> createState() => _CurveLineState();
}

class _CurveLineState extends State<CurveLine> {
  List<double> audioSpectrumData = [];

  @override
  void initState() {
    super.initState();

    _init();
  }

  Future<void> _init() async {
    await widget.rtcEngine.enableAudioSpectrumMonitor();
    widget.rtcEngine.registerAudioSpectrumObserver(AudioSpectrumObserver(
      onLocalAudioSpectrum: (AudioSpectrumData data) {
        debugPrint('[onLocalAudioSpectrum] data: ${data.toJson()}');

        setState(() {
          audioSpectrumData = data.audioSpectrumData ?? [];
        });
      },
      onRemoteAudioSpectrum:
          (List<UserAudioSpectrumInfo> spectrums, int spectrumNumber) {
        debugPrint(
            '[onRemoteAudioSpectrum] spectrums: $spectrums, spectrumNumber: $spectrumNumber');
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: CurveLinePainter(audioSpectrumData),
      size: const Size.fromHeight(300.0),
    );
  }
}

class CurveLinePainter extends CustomPainter {
  CurveLinePainter(this.audioSpectrumData) {
    if (audioSpectrumData.isEmpty) {
      _max = _min = -1.0;
    } else {
      var tempMax = double.minPositive;
      var tempMin = double.maxFinite;
      _max = audioSpectrumData.fold(tempMax, (pre, e) {
        return max(pre, e);
      });
      _min = audioSpectrumData.fold(tempMin, (pre, e) {
        return min(pre, e);
      });
    }
  }

  final List<double> audioSpectrumData;

  late final double _max;
  late final double _min;

  double getItemSpacing(double width) => width / audioSpectrumData.length;

  double _getXByIndex(double width, int index) {
    var itemSpacing = getItemSpacing(width);
    return itemSpacing * index + itemSpacing / 2.0;
  }

  double _getYByValue(double height, value) {
    if (_max == -1.0 || _min == -1.0) {
      return 0.0;
    } else if (_max == _min) {
      return (height - 40.0) / 2.0;
    } else {
      var drawingHeight = height;
      var availableDrawingHeight = drawingHeight * 0.4;
      return drawingHeight -
          (drawingHeight * 0.3) -
          (availableDrawingHeight / (_max - _min)) * (value - _min);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (audioSpectrumData.isEmpty) return;
    final linePaint = Paint()
      ..isAntiAlias = true
      ..color = const Color.fromARGB(255, 255, 0, 144)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    double preX;
    double preY;
    double curX;
    double curY;
    var firstPoint = audioSpectrumData[0];
    curX = _getXByIndex(size.width, 0);
    curY = _getYByValue(size.height, firstPoint);
    final curvePath = Path();
    curvePath.moveTo(curX, curY);
    for (int i = 0; i < audioSpectrumData.length; i++) {
      final p = audioSpectrumData[i];
      preX = curX;
      preY = curY;
      curX = _getXByIndex(size.width, i);
      curY = _getYByValue(size.height, p);
      double cpx = preX + (curX - preX) / 2.0;
      curvePath.cubicTo(cpx, preY, cpx, curY, curX, curY);
    }

    canvas.drawPath(curvePath, linePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is CurveLinePainter &&
        oldDelegate.audioSpectrumData != audioSpectrumData;
  }
}
