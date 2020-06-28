import 'dart:async';

import 'package:agora_rtc_engine/rtc_channel.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    RtcEngine platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion =
          await RtcEngine.create('***REMOVED***');
      platformVersion.setEventHandler(RtcEngineEventHandler(warning: (warn) {
        print('engine warn $warn');
      }, rtcStats: (stats) {
        print('engine rtcStats ${stats.toJson()}');
      }));
      await platformVersion.enableVideo();
      await platformVersion.joinChannel(null, '123', null, 0);
    } on PlatformException {
//      platformVersion = 'Failed to get platform version.';
    }

//    RtcChannel channel0 = await RtcChannel.create('456');
//    channel0.setEventHandler(RtcChannelEventHandler(warning: (warn) {
//      print('channel 456 warn $warn');
//    }, rtcStats: (stats) {
//      print('channel 456 rtcStats ${stats.toJson()}');
//    }));
//    await channel0.joinChannel(null, null, 0, ChannelMediaOptions(true, true));
//    await channel0.publish();
//
//    RtcChannel channel1 = await RtcChannel.create('789');
//    channel1.setEventHandler(RtcChannelEventHandler(warning: (warn) {
//      print('channel 789 warn $warn');
//    }, rtcStats: (stats) {
//      print('channel 789 rtcStats ${stats.toJson()}');
//    }));
//    await channel1.joinChannel(null, null, 0, ChannelMediaOptions(true, true));

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
//      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Text('Running on: $_platformVersion\n'),
            Expanded(
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
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  print('----------------------------------- onTap');
                },
                child: RtcRemoteView.SurfaceView(
                  uid: 0,
                  channelId: '456',
                  onPlatformViewCreated: (id) {
                    print('----------------------------------- $id');
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
