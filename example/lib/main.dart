import 'dart:async';

import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _joined = false;
  int _remoteUid = -1;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    await [Permission.camera, Permission.microphone].request();

    var engine = await RtcEngine.create('***REMOVED***');
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('joinChannelSuccess ${channel} ${uid}');
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }));
    await engine.enableVideo();
//    await engine.joinChannel(null, '123', null, 0);

    RtcChannel channel0 = await RtcChannel.create('456');
    channel0.setEventHandler(RtcChannelEventHandler(warning: (warn) {
      print('channel 456 warn $warn');
    }, rtcStats: (stats) {
      print('channel 456 rtcStats ${stats.toJson()}');
    }, joinChannelSuccess: (int uid, int elapsed) {
      print('channel 456 joinChannelSuccess ${uid}');
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      print('channel 456 userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }));
    await channel0.joinChannel(null, null, 0, ChannelMediaOptions(true, true));
    await channel0.publish();

    RtcChannel channel1 = await RtcChannel.create('789');
    channel1.setEventHandler(RtcChannelEventHandler(warning: (warn) {
      print('channel 789 warn $warn');
    }, rtcStats: (stats) {
      print('channel 789 rtcStats ${stats.toJson()}');
    }));
    await channel1.joinChannel(null, null, 0, ChannelMediaOptions(true, true));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [_renderLocalPreview(), _renderRemoteVideo()],
        ),
      ),
    );
  }

  Widget _renderLocalPreview() {
    if (_joined) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            print('----------------------------------- onTap');
          },
          child: RtcLocalView.SurfaceView(
            channelId: '456',
            onPlatformViewCreated: (id) {
              print('----------------------------------- $id');
            },
          ),
        ),
      );
    } else {
      return Text('Please join channel first');
    }
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != -1) {
      return Expanded(
        child: GestureDetector(
          onTap: () {
            print('----------------------------------- onTap');
          },
          child: RtcRemoteView.SurfaceView(
            uid: _remoteUid,
            channelId: '456',
            onPlatformViewCreated: (id) {
              print('----------------------------------- $id');
            },
          ),
        ),
      );
    } else {
      return Text('Please wait remote user join');
    }
  }
}
