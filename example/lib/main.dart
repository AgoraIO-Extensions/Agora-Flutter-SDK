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

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    try {
      await AgoraRtcEngine.createEngine('YOUR APP ID');
    } on PlatformException {
      print('Failed to create Agora engine.');
    }
  }

  void _toggleChannel() {
    setState(() {
      if (_isInChannel) {
        _isInChannel = false;
        AgoraRtcEngine.leaveChannel();
      } else {
        _isInChannel = true;
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
        body: Center(
          child: OutlineButton(
            child: Text(_isInChannel ? 'Leave Channel' : 'Join Channel',
                style: textStyle),
            onPressed: _toggleChannel,
          ),
        ),
      ),
    );
  }

  static TextStyle textStyle =
      TextStyle(fontSize: 18, color: Color.fromRGBO(100, 100, 255, 1));
}
