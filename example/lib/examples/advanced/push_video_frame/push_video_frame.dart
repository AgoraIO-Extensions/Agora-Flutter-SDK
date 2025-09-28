import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// PushVideoFrame Example
class PushVideoFrame extends StatefulWidget {
  /// Construct the [PushVideoFrame]
  const PushVideoFrame({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<PushVideoFrame> {
  late final RtcEngine _engine;
  bool _isReadyPreview = false;
  bool _isUseFlutterTexture = true;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _controller;

  late final Uint8List _imageByteData;
  late final int _imageWidth;
  late final int _imageHeight;

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

    await _engine
        .getMediaEngine()
        .setExternalVideoSource(enabled: true, useTexture: false);

    await _engine.enableVideo();

    await _loadImageByteData();

    await _engine.startPreview(sourceType: VideoSourceType.videoSourceCustom);

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

  Future<void> _loadImageByteData() async {
    ByteData data = await rootBundle.load("assets/agora-logo.png");
    Uint8List bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    ui.Image image = await decodeImageFromList(bytes);

    final byteData =
        await image.toByteData(format: ui.ImageByteFormat.rawStraightRgba);

    _imageByteData = byteData!.buffer.asUint8List();
    _imageWidth = image.width;
    _imageHeight = image.height;
    image.dispose();
  }

  Future<void> _pushVideoFrame({ColorSpace? colorSpace}) async {
    VideoPixelFormat format = VideoPixelFormat.videoPixelRgba;
    if (kIsWeb) {
      // TODO(littlegnal): https://github.com/flutter/flutter/issues/135409
      // The `Image.toByteData(format: ui.ImageByteFormat.rawStraightRgba)` return
      // bgra at this time.
      format = VideoPixelFormat.videoPixelBgra;
    }
    await _engine.getMediaEngine().pushVideoFrame(
            frame: ExternalVideoFrame(
          type: VideoBufferType.videoBufferRawData,
          format: format,
          buffer: _imageByteData,
          stride: _imageWidth,
          height: _imageHeight,
          colorSpace: colorSpace,
          timestamp: DateTime.now().millisecondsSinceEpoch,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ExampleActionsWidget(
          displayContentBuilder: (context, isLayoutHorizontal) {
            if (!_isReadyPreview) return Container();
            return AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: _engine,
                useFlutterTexture: _isUseFlutterTexture,
                canvas: const VideoCanvas(
                  uid: 0,
                  sourceType: VideoSourceType.videoSourceCustom,
                ),
              ),
            );
          },
          // actionsBuilder: (context, isLayoutHorizontal) {
          //   return Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       TextField(
          //         controller: _controller,
          //         decoration: const InputDecoration(hintText: 'Channel ID'),
          //       ),
          //       Row(
          //         children: [
          //           Expanded(
          //             flex: 1,
          //             child: ElevatedButton(
          //               onPressed: isJoined ? _leaveChannel : _joinChannel,
          //               child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
          //             ),
          //           ),
          //           const SizedBox(width: 10),
          //           ElevatedButton(
          //             onPressed: () => setState(() => _isUseFlutterTexture = !_isUseFlutterTexture),
          //             child: Text('Use Flutter Texture: $_isUseFlutterTexture'),
          //           ),
          //         ],
          //       ),

          //       const SizedBox(
          //         height: 20,
          //       ),
          //       SizedBox(
          //         height: 100,
          //         width: 100,
          //         child: Image.asset('assets/agora-logo.png'),
          //       ),
          //       const Text('Push Image as Video Frame'),
          //       Column(
          //         children: [
          //           ElevatedButton(
          //             onPressed:
          //                 isJoined ? () => _pushVideoFrame(colorSpace: null) : null,
          //             child: const Text('Push Video Frame'),
          //           ),
          //           ElevatedButton(
          //             onPressed: isJoined
          //                 ? () => _pushVideoFrame(
          //                         colorSpace: const ColorSpace(
          //                       primaries: PrimaryID.primaryidBt709,
          //                       transfer: TransferID.transferidBt709,
          //                       matrix: MatrixID.matrixidBt709,
          //                       range: RangeID.rangeidFull,
          //                     ))
          //                 : null,
          //             child: const Text('Push Video Frame With Color Space'),
          //           ),
          //         ],
          //       ),
          //     ],
          //   );
          // },
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: isJoined ? _leaveChannel : _joinChannel,
                    child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                  ElevatedButton(
                    onPressed: () => setState(
                        () => _isUseFlutterTexture = !_isUseFlutterTexture),
                    child: Text('Use Flutter Texture: $_isUseFlutterTexture'),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () => _pushTestFrameWithColorSpace(
                        matrix: MatrixID.matrixidBt709,
                        range: RangeID.rangeidFull,
                      ),
                      child: const Text('BT.709'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                    ),
                    ElevatedButton(
                      onPressed: () => _pushTestFrameWithColorSpace(
                        matrix: MatrixID.matrixidBt2020Ncl,
                        range: RangeID.rangeidFull,
                      ),
                      child: const Text('BT.2020'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                    ),
                    ElevatedButton(
                      onPressed: () => _pushTestFrameWithColorSpace(
                        matrix: MatrixID.matrixidSmpte170m,
                        range: RangeID.rangeidFull,
                      ),
                      child: const Text('SMPTE170M'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange),
                    ),
                    ElevatedButton(
                      onPressed: () => _pushTestFrameWithColorSpace(
                        matrix: MatrixID.matrixidBt709,
                        range: RangeID.rangeidLimited,
                      ),
                      child: const Text('Limited Range'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Add this method to your State class
  void _pushTestFrameWithColorSpace({
    required MatrixID matrix,
    required RangeID range,
  }) {
    if (isJoined) {
      print(
          'Preparing to push color space test frame: Matrix=$matrix, Range=$range');

      // 1. Generate more significant RGBA color block image data (for testing)
      final rgbaData =
          _generateEnhancedColorBarFrame(matrix: matrix, range: range);

      // 2. Create ExternalVideoFrame (use RGBA format with more significant color differences)
      final frame = ExternalVideoFrame(
        type: VideoBufferType.videoBufferRawData,
        format: kIsWeb
            ? VideoPixelFormat.videoPixelBgra
            : VideoPixelFormat.videoPixelRgba,
        buffer: rgbaData['buffer'],
        stride: rgbaData['width'],
        height: rgbaData['height'],
        timestamp: DateTime.now().millisecondsSinceEpoch,
        // 3. Apply your selected ColorSpace
        colorSpace: ColorSpace(
          primaries:
              PrimaryID.primaryidBt709, // Fixed use of BT.709 as baseline
          transfer: TransferID.transferidBt709,
          matrix: matrix,
          range: range,
        ),
      );

      // 4. Push video frame
      _engine.getMediaEngine().pushVideoFrame(frame: frame);

      print('Push video frame completed - RGBA test frame');
      print('    Format: ${kIsWeb ? "BGRA" : "RGBA"}');
      print('    Size: ${rgbaData['width']}x${rgbaData['height']}');
      print('   Matrix: $matrix');
      print('   Range: $range');
      print('    Expected effect: ${_getExpectedEffect(matrix, range)}');
    } else {
      print('Please join the channel first');
    }
  }

  String _getExpectedEffect(MatrixID matrix, RangeID range) {
    String matrixEffect = "";
    switch (matrix) {
      case MatrixID.matrixidBt709:
        matrixEffect = "Blue enhanced";
        break;
      case MatrixID.matrixidBt2020Ncl:
        matrixEffect = "Green enhanced";
        break;
      case MatrixID.matrixidSmpte170m:
        matrixEffect = "Red enhanced";
        break;
      default:
        matrixEffect = "Default";
    }

    String rangeEffect =
        range == RangeID.rangeidLimited ? "Brightness offset" : "Full range";
    return "$matrixEffect + $rangeEffect";
  }

  // Generate enhanced RGBA color block image (320x240, specifically for testing ColorSpace, adapted for mobile screens)
  Map<String, dynamic> _generateEnhancedColorBarFrame({
    required MatrixID matrix,
    required RangeID range,
  }) {
    const int width = 240; // Adjust to a size more suitable for mobile devices
    const int height = 360;
    const int bytesPerPixel = 4; // RGBA
    final buffer = Uint8List(width * height * bytesPerPixel);

    // Create a more complex test pattern with various colors
    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        final int offset = (y * width + x) * bytesPerPixel;
        int r = 0, g = 0, b = 0;

        // Upper half: 8 vertical bars of basic colors
        if (y < height / 2) {
          int section = x ~/ (width / 8);
          switch (section) {
            case 0:
              r = 255;
              g = 255;
              b = 255;
              break; // White
            case 1:
              r = 255;
              g = 255;
              b = 0;
              break; // Yellow
            case 2:
              r = 0;
              g = 255;
              b = 255;
              break; // Cyan
            case 3:
              r = 0;
              g = 255;
              b = 0;
              break; // Green
            case 4:
              r = 255;
              g = 0;
              b = 255;
              break; // Magenta
            case 5:
              r = 255;
              g = 0;
              b = 0;
              break; // Red
            case 6:
              r = 0;
              g = 0;
              b = 255;
              break; // Blue
            case 7:
              r = 0;
              g = 0;
              b = 0;
              break; // Black
          }
        }
        // Lower half: gradient colors, easier to see color space differences
        else {
          int section = x ~/ (width / 4);
          switch (section) {
            case 0: // Red gradient
              r = (x % (width / 4)) * 255 ~/ (width / 4);
              g = 0;
              b = 0;
              break;
            case 1: // Green gradient
              r = 0;
              g = (x % (width / 4)) * 255 ~/ (width / 4);
              b = 0;
              break;
            case 2: // Blue gradient
              r = 0;
              g = 0;
              b = (x % (width / 4)) * 255 ~/ (width / 4);
              break;
            case 3: // Grayscale gradient
              int gray = (x % (width / 4)) * 255 ~/ (width / 4);
              r = gray;
              g = gray;
              b = gray;
              break;
          }
        }

        // Handle byte order according to different formats
        if (kIsWeb) {
          // Web platform uses BGRA format
          buffer[offset] = b.toUnsigned(8); // B
          buffer[offset + 1] = g.toUnsigned(8); // G
          buffer[offset + 2] = r.toUnsigned(8); // R
          buffer[offset + 3] = 255; // A
        } else {
          // Other platforms use RGBA format
          buffer[offset] = r.toUnsigned(8); // R
          buffer[offset + 1] = g.toUnsigned(8); // G
          buffer[offset + 2] = b.toUnsigned(8); // B
          buffer[offset + 3] = 255; // A
        }
      }
    }

    // Draw text information on the image
    String matrixName = matrix.toString().split('.').last;
    String rangeName = range.toString().split('.').last;
    // _drawTextOnBuffer(buffer, width, height, '$matrixName-$rangeName');

    return {
      'width': width,
      'height': height,
      'buffer': buffer,
    };
  }

  // Draw text on RGBA buffer
  void _drawTextOnBuffer(Uint8List buffer, int width, int height, String text) {
    // Text position: top center, leave some margin
    const int textY = 150;
    const int textHeight = 24;
    const int textStartX = 50;

    // Create text background (black semi-transparent rectangle)
    for (int y = textY - 5; y < textY + textHeight + 5; y++) {
      for (int x = textStartX - 10;
          x < width - textStartX + 10 && x < width;
          x++) {
        if (y >= 0 && y < height && x >= 0) {
          final int offset = (y * width + x) * 4;
          if (offset + 3 < buffer.length) {
            buffer[offset] = 0; // R
            buffer[offset + 1] = 0; // G
            buffer[offset + 2] = 0; // B
            buffer[offset + 3] = 180; // A (semi-transparent)
          }
        }
      }
    }

    // Simple pixel font drawing function
    _drawSimpleText(buffer, width, height, text, textStartX, textY);
  }

  // Simple pixel font drawing function
  void _drawSimpleText(Uint8List buffer, int width, int height, String text,
      int startX, int startY) {
    const int charWidth = 8;
    const int charHeight = 12;

    for (int i = 0; i < text.length; i++) {
      final int charX = startX + i * charWidth;
      if (charX + charWidth > width) break;

      _drawChar(
          buffer, width, height, text[i], charX, startY, charWidth, charHeight);
    }
  }

  // Draw single character (simplified version, only draws some basic shapes)
  void _drawChar(Uint8List buffer, int width, int height, String char, int x,
      int y, int charWidth, int charHeight) {
    // For simplicity, we draw character outlines with white pixels
    // This is a very simplified implementation, more complex font rendering can be used in actual applications

    for (int dy = 0; dy < charHeight; dy++) {
      for (int dx = 0; dx < charWidth; dx++) {
        bool shouldDraw = false;

        // Simple character shape definitions (only implement a few commonly used characters and symbols)
        switch (char) {
          case 'M':
            shouldDraw = (dx == 0 ||
                dx == charWidth - 1 ||
                (dy < charHeight / 2 &&
                    (dx == charWidth / 4 || dx == 3 * charWidth / 4)));
            break;
          case 'a':
            shouldDraw = (dy > charHeight / 2 &&
                (dx == 0 ||
                    dx == charWidth - 1 ||
                    dy == charHeight - 1 ||
                    dy == charHeight * 2 / 3));
            break;
          case 't':
            shouldDraw = (dx == charWidth / 2 ||
                (dy == charHeight / 3 && dx < 3 * charWidth / 4));
            break;
          case 'r':
            shouldDraw = (dx == 0 ||
                (dy > charHeight / 2 &&
                    dy < 2 * charHeight / 3 &&
                    dx < charWidth / 2));
            break;
          case 'i':
            shouldDraw =
                (dx == charWidth / 2 || (dy == 0 && dx == charWidth / 2));
            break;
          case 'x':
            shouldDraw = ((dx == 0 && dy == charHeight - 1) ||
                (dx == charWidth - 1 && dy == 0) ||
                dx == dy);
            break;
          case ':':
            shouldDraw = (dx == charWidth / 2 &&
                (dy == charHeight / 3 || dy == 2 * charHeight / 3));
            break;
          case ' ':
            shouldDraw = false;
            break;
          case ',':
            shouldDraw = (dx == charWidth / 2 && dy == charHeight - 2);
            break;
          case 'R':
            shouldDraw = (dx == 0 ||
                (dy < charHeight / 2 && dx == charWidth - 1) ||
                dy == 0 ||
                dy == charHeight / 2);
            break;
          case 'n':
            shouldDraw = (dx == 0 ||
                (dy > charHeight / 2 && dx == charWidth - 1) ||
                (dy == charHeight / 2 && dx < charWidth - 1));
            break;
          case 'g':
            shouldDraw = ((dy > charHeight / 3) &&
                (dx == 0 ||
                    dx == charWidth - 1 ||
                    dy == charHeight - 1 ||
                    (dy == 2 * charHeight / 3 && dx < charWidth - 1)));
            break;
          case 'e':
            shouldDraw = (dx == 0 ||
                dy == charHeight / 2 ||
                dy == 0 ||
                dy == charHeight - 1);
            break;
          default:
            // For undefined characters, draw a simple rectangle
            shouldDraw = (dx == 0 ||
                dx == charWidth - 1 ||
                dy == 0 ||
                dy == charHeight - 1);
        }

        if (shouldDraw) {
          final int pixelX = x + dx;
          final int pixelY = y + dy;
          if (pixelX >= 0 && pixelX < width && pixelY >= 0 && pixelY < height) {
            final int offset = (pixelY * width + pixelX) * 4;
            if (offset + 3 < buffer.length) {
              buffer[offset] = 255; // R (white)
              buffer[offset + 1] = 255; // G
              buffer[offset + 2] = 255; // B
              buffer[offset + 3] = 255; // A
            }
          }
        }
      }
    }
  }
}
