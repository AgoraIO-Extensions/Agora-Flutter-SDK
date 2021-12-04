import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// ScreenSharing Example
class ScreenSharing extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<ScreenSharing> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  bool isJoined = false, screenSharing = false;
  List<int> remoteUid = [];
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: channelId);
    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _engine.destroy();
  }

  _initEngine() async {
    _engine = await RtcEngine.createWithContext(RtcEngineContext(config.appId));
    _addListeners();

    await _engine.enableVideo();
    await _engine.startPreview();
    await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await _engine.setClientRole(ClientRole.Broadcaster);
  }

  _addListeners() {
    _engine.setEventHandler(RtcEngineEventHandler(
      warning: (warningCode) {
        print('warning ${warningCode}');
      },
      error: (errorCode) {
        print('error ${errorCode}');
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        print('joinChannelSuccess ${channel} ${uid} ${elapsed}');
        setState(() {
          isJoined = true;
        });
      },
      userJoined: (uid, elapsed) {
        print('userJoined  ${uid} ${elapsed}');
        if (uid == config.screenSharingUid) {
          return;
        }
        setState(() {
          remoteUid.add(uid);
        });
      },
      userOffline: (uid, reason) {
        print('userOffline  ${uid} ${reason}');
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
        });
      },
      leaveChannel: (stats) {
        print('leaveChannel ${stats.toJson()}');
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
    ));
  }

  _joinChannel() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
    }
    await _engine.joinChannel(config.token, channelId, null, config.uid);
  }

  _leaveChannel() async {
    await _engine.leaveChannel();
  }

  _startScreenShare() async {
    final helper = _engine.getScreenShareHelper();
    helper.setEventHandler(RtcEngineEventHandler(
      joinChannelSuccess: (String channel, int uid, int elapsed) {
        print('ScreenSharing joinChannelSuccess ${channel} ${uid} ${elapsed}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'ScreenSharing joinChannelSuccess ${channel} ${uid} ${elapsed}'),
        ));
      },
      localVideoStateChanged:
          (LocalVideoStreamState localVideoState, LocalVideoStreamError error) {
        print(
            'ScreenSharing localVideoStateChanged ${localVideoState} ${error}');
        if (localVideoState == LocalVideoStreamState.Failed) {
          _stopScreenShare();
        }
      },
    ));
    await helper.initialize(RtcEngineContext(config.appId));
    await helper.disableAudio();
    await helper.enableVideo();
    await helper.setChannelProfile(ChannelProfile.LiveBroadcasting);
    await helper.setClientRole(ClientRole.Broadcaster);
    var windowId = 0;
    if (!kIsWeb &&
        (Platform.isWindows || Platform.isMacOS || Platform.isAndroid)) {
      final windows = _engine.enumerateWindows();
      if (windows.isNotEmpty) {
        windowId = windows[0].id;
      }
    }
    await helper.startScreenCaptureByWindowId(windowId);
    setState(() {
      screenSharing = true;
    });
    await helper.joinChannel(
        config.token, channelId, null, config.screenSharingUid);
  }

  _stopScreenShare() async {
    final helper = _engine.getScreenShareHelper();
    await helper.destroy().then((value) {
      setState(() {
        screenSharing = false;
      });
    }).catchError((err) {
      print('_stopScreenShare $err');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: 'Channel ID'),
              onChanged: (text) {
                setState(() {
                  channelId = text;
                });
              },
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
            _renderVideo(),
          ],
        ),
        if (kIsWeb || (Platform.isWindows || Platform.isMacOS))
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed:
                      screenSharing ? _stopScreenShare : _startScreenShare,
                  child:
                      Text('${screenSharing ? 'Stop' : 'Start'} screen share'),
                ),
              ],
            ),
          )
      ],
    );
  }

  _renderVideo() {
    return Expanded(
        child: Stack(
      children: [
        Row(
          children: [
            Expanded(
                flex: 1,
                child: kIsWeb
                    ? RtcLocalView.SurfaceView()
                    : RtcLocalView.TextureView()),
            if (screenSharing)
              Expanded(
                  flex: 1,
                  child: kIsWeb
                      ? RtcLocalView.SurfaceView.screenShare()
                      : RtcLocalView.TextureView.screenShare()),
          ],
        ),
        Align(
          alignment: Alignment.topLeft,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.of(remoteUid.map(
                (e) => Container(
                  width: 120,
                  height: 120,
                  child: kIsWeb
                      ? RtcRemoteView.SurfaceView(
                          uid: e,
                          channelId: channelId,
                        )
                      : RtcRemoteView.TextureView(
                          uid: e,
                          channelId: channelId,
                        ),
                ),
              )),
            ),
          ),
        )
      ],
    ));
  }
}
