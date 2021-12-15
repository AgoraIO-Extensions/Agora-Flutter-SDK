import 'dart:convert';
import 'dart:io';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/examples/log_sink.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

/// DeviceManager Example
class DeviceManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<DeviceManager> {
  late final RtcEngine _engine;
  String channelId = config.channelId;
  bool isJoined = false;
  List<int> remoteUid = [];
  List<MediaDeviceInfo> devices = [];
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
      },
      userJoined: (uid, elapsed) {
        logSink.log('userJoined  ${uid} ${elapsed}');
        if (uid == config.screenSharingUid) {
          return;
        }
        setState(() {
          remoteUid.add(uid);
        });
      },
      userOffline: (uid, reason) {
        logSink.log('userOffline  ${uid} ${reason}');
        setState(() {
          remoteUid.removeWhere((element) => element == uid);
        });
      },
      leaveChannel: (stats) {
        logSink.log('leaveChannel ${stats.toJson()}');
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

  _enumerateVideoDevices() async {
    var devices = await _engine.deviceManager.enumerateVideoDevices();
    logSink.log('_enumerateVideoDevices $devices');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('_enumerateVideoDevices ${jsonEncode(devices)}'),
    ));
    setState(() {
      this.devices = devices;
    });
  }

  _setVideoDevice() async {
    if (devices.isNotEmpty) {
      await _engine.deviceManager.setVideoDevice(devices.last.deviceId);
    }
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
                  onPressed: _enumerateVideoDevices,
                  child: Text('Enumerate video devices'),
                ),
                ElevatedButton(
                  onPressed: _setVideoDevice,
                  child: Text('Set video device'),
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
