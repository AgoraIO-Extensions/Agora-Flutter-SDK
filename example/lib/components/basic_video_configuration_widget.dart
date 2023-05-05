import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

class BasicVideoConfigurationWidget extends StatefulWidget {
  const BasicVideoConfigurationWidget({
    Key? key,
    required this.rtcEngine,
    required this.setConfigButtonText,
    required this.title,
    this.width = 960,
    this.height = 540,
    this.frameRate = 15,
    this.bitrate = 0,
    this.onConfigChanged,
  }) : super(key: key);

  final RtcEngine rtcEngine;

  final String title;
  final int width;
  final int height;
  final int frameRate;
  final int bitrate;

  final Widget setConfigButtonText;
  final Function(int width, int height, int frameRate, int bitrate)?
      onConfigChanged;

  @override
  State<BasicVideoConfigurationWidget> createState() =>
      _BasicVideoConfigurationWidgetState();
}

class _BasicVideoConfigurationWidgetState
    extends State<BasicVideoConfigurationWidget> {
  late TextEditingController _heightController;
  late TextEditingController _widthController;
  late TextEditingController _frameRateController;
  late TextEditingController _bitrateController;

  @override
  void initState() {
    super.initState();

    _widthController = TextEditingController(text: widget.width.toString());
    _heightController = TextEditingController(text: widget.height.toString());
    _frameRateController =
        TextEditingController(text: widget.frameRate.toString());
    _bitrateController = TextEditingController(text: widget.bitrate.toString());
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _widthController.dispose();
    _heightController.dispose();
    _frameRateController.dispose();
    _bitrateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(fontSize: 10),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('width: '),
                    TextField(
                      controller: _widthController,
                      decoration: const InputDecoration(
                        hintText: 'width',
                        border: OutlineInputBorder(gapPadding: 0.0),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('heigth: '),
                    TextField(
                      controller: _heightController,
                      decoration: const InputDecoration(
                        hintText: 'height',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('frame rate: '),
                    TextField(
                      controller: _frameRateController,
                      decoration: const InputDecoration(
                        hintText: 'frame rate',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('bitrate: '),
                    TextField(
                      controller: _bitrateController,
                      decoration: const InputDecoration(
                        hintText: 'bitrate',
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          ElevatedButton(
            child: widget.setConfigButtonText,
            onPressed: () {
              widget.onConfigChanged?.call(
                  int.parse(_widthController.text),
                  int.parse(_heightController.text),
                  int.parse(_frameRateController.text),
                  int.parse(_bitrateController.text));
            },
          ),
        ],
      ),
    );
  }
}
