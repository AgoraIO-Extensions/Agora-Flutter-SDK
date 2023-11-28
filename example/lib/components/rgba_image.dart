import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

class RgbaImage extends StatefulWidget {
  const RgbaImage({
    Key? key,
    required this.bytes,
    required this.width,
    required this.height,
    this.format = ui.PixelFormat.rgba8888,
  }) : super(key: key);

  final Uint8List bytes;
  final int width;
  final int height;
  final ui.PixelFormat format;

  @override
  State<RgbaImage> createState() => _RgbaImageState();
}

class _RgbaImageState extends State<RgbaImage> {
  ui.Image? _image;

  Future<void> _loadImage() async {
    final imageCompleter = Completer<ui.Image>();

    ui.decodeImageFromPixels(
        widget.bytes, widget.width, widget.height, widget.format, (result) {
      imageCompleter.complete(result);
    });

    _image = await imageCompleter.future;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    if (_image != null) {
      return RawImage(
        image: _image,
      );
    }

    return const SizedBox();
  }

  @override
  void dispose() {
    _image?.dispose();
    super.dispose();
  }
}
