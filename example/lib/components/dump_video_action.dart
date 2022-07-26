import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine/agora_rtc_engine_debug.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'log_sink.dart';

class DumpVideoAction extends StatefulWidget {
  const DumpVideoAction({Key? key, required this.rtcEngine}) : super(key: key);

  final RtcEngine rtcEngine;

  @override
  State<DumpVideoAction> createState() => _DumpVideoActionState();
}

class _DumpVideoActionState extends State<DumpVideoAction> {
  bool _startDumpVideo = false;

  @override
  Widget build(BuildContext context) {
    if (!(defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS)) {
      return Container();
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () async {
            _startDumpVideo = !_startDumpVideo;

            Directory appDocDir = await getApplicationDocumentsDirectory();

            if (_startDumpVideo) {
              widget.rtcEngine.startDumpVideo(
                VideoSourceType.videoSourceCamera.value(),
                appDocDir.absolute.path,
              );
              logSink.log('Video data has dump to ${appDocDir.absolute.path}');
            } else {
              widget.rtcEngine.stopDumpVideo();
            }

            setState(() {});
          },
          child: Text('${_startDumpVideo ? 'Stop' : 'Start'} dump video'),
        ),
      ],
    );
  }
}
