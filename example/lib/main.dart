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
  final _infoStrings = <String>[];

  @override
  void initState() {
    super.initState();
    _initAgoraRtcEngine();
    _addAgoraEventHandlers();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initAgoraRtcEngine() async {
    AgoraRtcEngine.createEngine('YOUR APP ID');
    AgoraRtcEngine.enableVideo();
  }

  void _addAgoraEventHandlers() {
    AgoraRtcEngine.didJoinChannelHandler =
        (String channel, int uid, int elapsed) {
      setState(() {
        String info = 'didJoinChannel: ' + channel + ', uid: ' + uid.toString();
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.didLeaveChannelHandler = () {
      setState(() {
        _infoStrings.add('didLeaveChannel');
      });
    };

    AgoraRtcEngine.didJoinedOfUidHandler = (int uid, int elapsed) {
      setState(() {
        String info = 'didJoinedOfUid: ' + uid.toString();
        _infoStrings.add(info);
      });
    };

    AgoraRtcEngine.didOfflineOfUidHandler = (int uid, int reason) {
      setState(() {
        String info = 'didOfflineOfUid: ' +
            uid.toString() +
            ' reason: ' +
            reason.toString();
        _infoStrings.add(info);
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
        AgoraRtcEngine.joinChannel(null, 'flutter', null, 0);
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
        body: Container(
          child: Column(
            children: [
              Container(
                  height: 300,
                  child: Row(children: [
                    Expanded(child: Container(child: _localView)),
                    SizedBox(width: 5, height: 5),
                    Expanded(child: Container(child: _remoteView)),
                  ])),
              OutlineButton(
                child: Text(_isInChannel ? 'Leave Channel' : 'Join Channel',
                    style: textStyle),
                onPressed: _toggleChannel,
              ),
              Expanded(child: Container(child: _buildInfoList())),
            ],
          ),
        ),
      ),
    );
  }

  final UiKitView _localView = UiKitView(
    key: new ObjectKey('localView'),
    viewType: 'AgoraRendererView',
    onPlatformViewCreated: (viewId) {
      AgoraRtcEngine.setupLocalVideo(viewId, 1);
    },
  );

  final UiKitView _remoteView = UiKitView(
    key: new ObjectKey('remoteView'),
    viewType: 'AgoraRendererView',
    onPlatformViewCreated: (viewId) {
      AgoraRtcEngine.setupRemoteVideo(viewId, 2, 12);
    },
  );

  static TextStyle textStyle =
      TextStyle(fontSize: 18, color: Color.fromRGBO(100, 100, 255, 1));

  Widget _buildInfoList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemExtent: 24,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(_infoStrings[i]),
        );
      },
      itemCount: _infoStrings.length,
    );
  }
}
