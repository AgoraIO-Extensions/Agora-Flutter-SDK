import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'log_sink.dart';
import 'package:flutter/material.dart';

mixin KeepRemoteVideoViewsMixin<T extends StatefulWidget> on State<T> {
  final GlobalKey _keepRemoteVideoViewsKey = GlobalKey();
  GlobalKey get keepRemoteVideoViewsKey => _keepRemoteVideoViewsKey;
}

class RemoteVideoViewsWidget extends StatefulWidget {
  const RemoteVideoViewsWidget(
      {Key? key,
      required this.rtcEngine,
      required this.channelId,
      this.connectionUid})
      : super(key: key);

  final RtcEngine rtcEngine;

  final String channelId;

  final int? connectionUid;

  @override
  State<RemoteVideoViewsWidget> createState() => _RemoteVideoViewsWidgetState();
}

class _RemoteVideoViewsWidgetState extends State<RemoteVideoViewsWidget> {
  late final RtcEngineEventHandler _eventHandler;
  final Set<RtcConnection> _localRtcConnection = {};
  final Map<int, RtcConnection> _remoteUidsMap = {};

  @override
  void initState() {
    super.initState();

    _init();
  }

  void _init() {
    _eventHandler = RtcEngineEventHandler(
      onJoinChannelSuccess: (connection, elapsed) {
        _localRtcConnection.add(connection);
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        _localRtcConnection
            .removeWhere((e) => e.localUid == connection.localUid);
        _remoteUidsMap
            .removeWhere((key, value) => value.localUid == connection.localUid);
      },
      onUserJoined: (connection, remoteUid, elapsed) {
        logSink.log(
            '[onUserJoined] connection: ${connection.toJson()}, remoteUid: $remoteUid, elapsed: $elapsed');
        setState(() {
          if (!_localRtcConnection.any((e) => e.localUid == remoteUid)) {
            _remoteUidsMap.putIfAbsent(remoteUid, () => connection);
          }
        });
      },
      onUserOffline: (RtcConnection connection, int remoteUid,
          UserOfflineReasonType reason) {
        logSink.log(
            '[onUserOffline] connection: ${connection.toJson()}, remoteUid: $remoteUid');
        setState(() {
          _remoteUidsMap.remove(remoteUid);
        });
      },
    );
    widget.rtcEngine.registerEventHandler(_eventHandler);
  }

  @override
  void dispose() {
    widget.rtcEngine.unregisterEventHandler(_eventHandler);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];
    debugPrint('_remoteUidsMap: $_remoteUidsMap');
    _remoteUidsMap.forEach((key, value) {
      widgets.add(
        SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            children: [
              AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: widget.rtcEngine,
                  canvas: VideoCanvas(uid: key),
                  connection: RtcConnection(
                      channelId: widget.channelId,
                      localUid: widget.connectionUid),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.connectionUid != null
                        ? 'localuid: ${widget.connectionUid}'
                        : '',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  Text(
                    'remoteuid: $key',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }
}
