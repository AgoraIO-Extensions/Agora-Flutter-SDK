import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// RtmpStreaming Example
class RtmpStreaming extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RtmpStreamingState();
}

class _RtmpStreamingState extends State<RtmpStreaming> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  bool isJoined = false;
  bool switchCamera = true;
  TextEditingController? _channelIdController;
  late TextEditingController _rtmpUrlController;
  bool _isStreaming = false;
  int _remoteUid = 0;

  @override
  void initState() {
    super.initState();
    _channelIdController = TextEditingController(text: channelId);
    _rtmpUrlController = TextEditingController();
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  Future<void> _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    this._addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  void _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        logSink.log('warning ${warningCode}');
      },
      error: (errorCode) {
        logSink.log('error ${errorCode}');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        logSink.log('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });

        _startTranscoding();
      },
      userJoined: (uid, elapsed) {
        logSink.log('userJoined  ${uid} ${elapsed}');
        if (_remoteUid == 0) {
          setState(() {
            _remoteUid = uid;
          });
        }

        // _startTranscoding(isRemoteUser: true);
      },
      userOffline: (uid, reason) {
        logSink.log('userOffline  ${uid} ${reason}');
        setState(() {
          _remoteUid = 0;
        });
      },
      leaveChannel: (stats) {
        logSink.log('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
      rtmpStreamingStateChanged: (String url, RtmpStreamingState state,
          RtmpStreamingErrorCode errCode) {
        logSink.log(
            'rtmpStreamingStateChanged url: $url, state: $state, errCode: $errCode');
      },
      rtmpStreamingEvent: (String url, RtmpStreamingEvent eventCode) {
        logSink.log(
            'rtmpStreamingEvent url: $url, eventCode: ${eventCode.toString()}');
      },
    ));
  }

  Future<void> _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(config.token, channelId, null, config.uid);
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  void _switchCamera() {
    _engine.switchCamera().then((value) {
      setState(() {
        switchCamera = !switchCamera;
      });
    }).catchError((err) {
      print('switchCamera $err');
    });
  }

  Future<void> _startTranscoding({bool isRemoteUser = false}) async {
    if (_isStreaming && !isRemoteUser) return;
    final streamUrl = _rtmpUrlController.text;
    if (_isStreaming && isRemoteUser) {
      await _engine.removePublishStreamUrl(streamUrl);
    }

    _isStreaming = true;

    final List<TranscodingUser> transcodingUsers = [
      TranscodingUser(
        0,
        x: 0,
        y: 0,
        width: 360,
        height: 640,
        audioChannel: AudioChannel.Channel0,
        alpha: 1.0,
      )
    ];

    int width = 360;
    int height = 640;

    if (isRemoteUser) {
      transcodingUsers.add(TranscodingUser(
        _remoteUid,
        x: 360,
        y: 0,
        width: 360,
        height: 640,
        audioChannel: AudioChannel.Channel0,
        alpha: 1.0,
      ));
      width = 720;
      height = 640;
    }

    final lt = new LiveTranscoding(
      transcodingUsers,
      width: width,
      height: height,
      videoBitrate: 400,
      videoCodecProfile: VideoCodecProfileType.High,
      videoGop: 30,
      videoFramerate: VideoFrameRate.Fps24,
      lowLatency: false,
      audioSampleRate: AudioSampleRateType.Type44100,
      audioBitrate: 48,
      audioChannels: AudioChannel.Channel1,
      audioCodecProfile: AudioCodecProfileType.LCAAC,
    );

    // await _engine.setLiveTranscoding(lt);
    // await _engine.enableEncryption(false, EncryptionConfig());
    try {
      await _engine.addPublishStreamUrl(streamUrl, false);
    } catch (e) {
      logSink.log('addPublishStreamUrl error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: _channelIdController,
              decoration: InputDecoration(hintText: 'Channel ID'),
              onChanged: (text) {
                setState(() {
                  channelId = text;
                });
              },
            ),
            TextField(
              controller: _rtmpUrlController,
              decoration: InputDecoration(hintText: 'Input rtmp url'),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed:
                        isJoined ? this._leaveChannel : this._joinChannel,
                    child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                )
              ],
            ),
            _renderVideo(),
          ],
        ),
        if (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: this._switchCamera,
                  child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
                ),
              ],
            ),
          )
      ],
    );
  }

  Widget _renderVideo() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            child: kIsWeb
                ? RtcLocalView.SurfaceView()
                : RtcLocalView.TextureView(),
          ),
          if (_remoteUid != 0)
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 120,
                height: 120,
                child: kIsWeb
                    ? RtcRemoteView.SurfaceView(
                        uid: _remoteUid,
                        channelId: channelId,
                      )
                    : RtcRemoteView.TextureView(
                        uid: _remoteUid,
                        channelId: channelId,
                      ),
              ),
            ),
        ],
      ),
    );
  }
}
