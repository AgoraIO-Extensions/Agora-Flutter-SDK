import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isInChannel = false;
  String infoString = 'hello';

  @override
  void initState() {
    super.initState();
    initAgoraRtcEngine();
    addAgoraEventHandlers();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initAgoraRtcEngine() async {
    AgoraRtcEngine.createEngine('YOUR APP ID');
    AgoraRtcEngine.enableVideo();
  }

  void addAgoraEventHandlers() {
    AgoraRtcEngine.didJoinChannelHandler =
        (String channel, int uid, int elapsed) {
      setState(() {
        infoString = 'didJoinChannel: ' + channel + ', uid: ' + uid.toString();
      });
    };

    AgoraRtcEngine.didLeaveChannelHandler = () {
      setState(() {
        infoString = 'didLeaveChannel';
      });
    };
  }

  void _toggleChannel() {
    setState(() {
      if (_isInChannel) {
        _isInChannel = false;
        AgoraRtcEngine.leaveChannel();
        AgoraRtcEngine.stopPreview();
      } else {
        _isInChannel = true;
        AgoraRtcEngine.startPreview();
        AgoraRtcEngine.joinChannel(null, 'flutter', null, 122);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agora Flutter SDK'),
        ),
        body: ListView(
          children: [
            Text(infoString),
            OutlineButton(
              child: Text(_isInChannel ? 'Leave Channel' : 'Join Channel',
                  style: textStyle),
              onPressed: _toggleChannel,
            ),
            SizedBox(width: 100, height: 100, child: localView),
            SizedBox(width: 100, height: 200, child: remoteView),
          ],
        ),
      ),
    );
  }

  UiKitView localView = UiKitView(
    key: new ObjectKey('localView'),
    viewType: 'AgoraRendererView',
    onPlatformViewCreated: (viewId) {
      AgoraRtcEngine.setupLocalVideo(viewId, 1);
    },
    creationParams: 'local',
    creationParamsCodec: const StandardMessageCodec(),
  );

  UiKitView remoteView = UiKitView(
    key: new ObjectKey('remoteView'),
    viewType: 'AgoraRendererView',
    onPlatformViewCreated: (viewId) {
      AgoraRtcEngine.setupRemoteVideo(viewId, 1, 12);
    },
    creationParams: 'remote',
    creationParamsCodec: const StandardMessageCodec(),
  );

  static TextStyle textStyle =
      TextStyle(fontSize: 18, color: Color.fromRGBO(100, 100, 255, 1));
}
