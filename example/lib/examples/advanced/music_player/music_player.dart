import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;

class MusicPlayerExample extends StatefulWidget {
  const MusicPlayerExample({Key? key}) : super(key: key);

  @override
  State<MusicPlayerExample> createState() => _MusicPlayerExampleState();
}

class _MusicPlayerExampleState extends State<MusicPlayerExample> {
  bool isJoined = false;

  late final RtcEngine _engine;
  late TextEditingController _controller;
  late TextEditingController _rtmTokenController;
  late final TextEditingController _searchMusicController;
  late final MusicContentCenter _musicContentCenter;
  late final MusicPlayer _musicPlayer;
  late final MediaPlayerSourceObserver _mediaPlayerSourceObserver;
  Completer<void>? _preloadCompleted;
  Completer<String>? _getLyricCompleted;
  bool _initRtmToken = false;
  bool _isPlaying = false;

  List<MusicChartInfo> _musicChartInfos = [];
  MusicCollection? _musicCollection;
  String _currentRequestId = '';
  late Music _selectedMusic;
  MusicCollection? _searchedMusicCollection;
  String _searchMusicRequestId = '';
  String _musicCollectionRequestId = '';
  String _getLyricRequestId = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: config.channelId);
    _rtmTokenController = TextEditingController();
    _searchMusicController = TextEditingController();

    _initEngine();
  }

  @override
  void dispose() {
    super.dispose();
    _dispose();
  }

  Future<void> _dispose() async {
    _musicContentCenter.unregisterEventHandler();
    if (_isPlaying) {
      await _musicPlayer.stop();
      await _engine.destroyMediaPlayer(_musicPlayer);
      await _musicContentCenter.release();
    }
    await _engine.leaveChannel();
    await _engine.release();
  }

  Future<void> _initEngine() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
        appId: config.appId,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        audioScenario: AudioScenarioType.audioScenarioGameStreaming));

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
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        logSink.log(
            '[onLeaveChannel] connection: ${connection.toJson()} stats: ${stats.toJson()}');
        setState(() {
          isJoined = false;
        });
      },
    ));

    _musicContentCenter = _engine.getMusicContentCenter();

    await _engine.enableVideo();
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: config.token,
      channelId: _controller.text,
      uid: config.uid,
      options: ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        autoSubscribeAudio: true,
        autoSubscribeVideo: true,
        publishMicrophoneTrack: true,
        publishCameraTrack: false,
        publishMediaPlayerAudioTrack: true,
        publishMediaPlayerVideoTrack: true,
        enableAudioRecordingOrPlayout: true,
        publishMediaPlayerId: _musicPlayer.getMediaPlayerId(),
      ),
    );
  }

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
  }

  Widget _getChartInfosWidget() {
    if (_musicChartInfos.isEmpty) return Container();

    final listChildren = _musicChartInfos.map(((e) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () async {
          _musicCollectionRequestId =
              await _musicContentCenter.getMusicCollectionByMusicChartId(
                  musicChartId: e.id!, page: 1, pageSize: 10);
        },
        child: Container(
          height: 100,
          alignment: Alignment.center,
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.blue[100]!,
              borderRadius: const BorderRadius.all(Radius.circular(4))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('chartName: ${e.chartName!}'),
              Text('id: ${e.id.toString()}')
            ],
          ),
        ),
      );
    })).toList();

    return SizedBox(
      height: 100,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: listChildren,
      ),
    );
  }

  Widget _getMusicCollectionWidget() {
    final collection = <Music>[];
    if ((_searchedMusicCollection?.getCount() ?? 0) > 0) {
      for (int i = 0; i < _searchedMusicCollection!.getCount(); i++) {
        collection.add(_searchedMusicCollection!.getMusic(i));
      }
    } else if ((_musicCollection?.getCount() ?? 0) > 0) {
      for (int i = 0; i < _musicCollection!.getCount(); i++) {
        collection.add(_musicCollection!.getMusic(i));
      }
    }

    if (collection.isEmpty) {
      return Container();
    }

    final listChildren = collection.map(((e) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.pink[100],
            borderRadius: const BorderRadius.all(Radius.circular(4))),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('songCode: ${e.songCode!}'),
              Text('name: ${e.name}'),
              Text('singer: ${e.singer}')
            ],
          ),
          onTap: () async {
            _selectedMusic = e;

            bool isPreloaded =
                await _musicContentCenter.isPreloaded(_selectedMusic.songCode!);
            if (!isPreloaded) {
              _preloadCompleted = Completer();
              _getLyricCompleted = Completer();
              await _musicContentCenter.preload(_selectedMusic.songCode!);
              _getLyricRequestId = await _musicContentCenter.getLyric(
                  songCode: _selectedMusic.songCode!);
            } else {
              _preloadCompleted = null;
              _getLyricCompleted = null;
            }

            await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return Dialog(
                    child: SizedBox(
                      width: 200,
                      // height: 300,
                      child: Stack(
                        children: [
                          MusicPlayerItem(
                            music: e,
                            onPlayChanged: (v) async {
                              if (v) {
                                await _musicPlayer.openWithSongCode(
                                    songCode: e.songCode!);
                              } else {
                                await _musicPlayer.stop();
                              }
                            },
                            playing: _isPlaying,
                            preloadCompleted: _preloadCompleted,
                            getLyricCompleted: _getLyricCompleted,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () async {
                                  await _musicPlayer.stop();
                                  _isPlaying = false;
                                  _preloadCompleted = null;
                                  _getLyricCompleted = null;
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.close_rounded)),
                          ),
                        ],
                      ),
                    ),
                  );
                });

            // _preloadCompleted = null;
          },
        ),
      );
    })).toList();

    return SizedBox(
      height: 100,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: listChildren,
      ),
    );
  }

  Future<void> _initMusicCenter() async {
    await _musicContentCenter.initialize(MusicContentCenterConfiguration(
      appId: config.musicCenterAppId,
      token: _rtmTokenController.text,
      mccUid: 123,
    ));

    _musicContentCenter.registerEventHandler(MusicContentCenterEventHandler(
      onMusicChartsResult: (String requestId, List<MusicChartInfo> result,
          MusicContentCenterStateReason errorCode) {
        logSink.log(
            '[onMusicChartsResult], requestId: $requestId, errorCode: $errorCode, result: ${result.toString()}');
        if (errorCode ==
            MusicContentCenterStateReason.kMusicContentCenterReasonOk) {
          if (_currentRequestId == requestId) {
            setState(() {
              _musicChartInfos = result;
            });
          }
        }
      },
      onMusicCollectionResult: (String requestId, MusicCollection result,
          MusicContentCenterStateReason errorCode) {
        logSink.log(
            '[onMusicCollectionResult], requestId: $requestId, errorCode: $errorCode, result: ${result.toString()}');

        if (_musicCollectionRequestId == requestId) {
          setState(() {
            _musicCollection = result;
          });
        } else if (_searchMusicRequestId == requestId) {
          setState(() {
            _searchedMusicCollection = result;
          });
        }
      },
      onPreLoadEvent: (
        String requestId,
        int songCode,
        int percent,
        String lyricUrl,
        PreloadState status,
        MusicContentCenterStateReason errorCode,
      ) {
        logSink.log(
            '[onPreLoadEvent], requestId: $requestId songCode: $songCode, percent: $percent status: $status, errorCode: $errorCode, lyricUrl: $lyricUrl');
        if (_selectedMusic.songCode == songCode &&
            status == PreloadState.kPreloadStateCompleted) {
          _preloadCompleted?.complete();
          _preloadCompleted = null;
        }
      },
      onLyricResult: (
        String requestId,
        int songCode,
        String lyricUrl,
        MusicContentCenterStateReason errorCode,
      ) {
        logSink.log(
            '[onLyricResult], requestId: $requestId songCode: $songCode, lyricUrl: $lyricUrl errorCode: $errorCode');
        if (_getLyricRequestId == requestId) {
          _getLyricCompleted?.complete(lyricUrl);
          _getLyricCompleted = null;
        }
      },
    ));

    _musicPlayer = (await _musicContentCenter.createMusicPlayer())!;

    _mediaPlayerSourceObserver = MediaPlayerSourceObserver(
      onPlayerSourceStateChanged:
          (MediaPlayerState state, MediaPlayerReason ec) async {
        logSink.log('[onPlayerSourceStateChanged] state: $state ec: $ec');
        if (state == MediaPlayerState.playerStateOpenCompleted) {
          _isPlaying = !_isPlaying;

          await _musicPlayer.play();

          setState(() {});
        }
      },
    );

    _musicPlayer.registerPlayerSourceObserver(_mediaPlayerSourceObserver);

    setState(() {
      _initRtmToken = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              if (_musicChartInfos.isNotEmpty)
                const Text(
                  'Chart Infos',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              _getChartInfosWidget(),
              const SizedBox(height: 16),
              if (_musicCollection != null || _searchedMusicCollection != null)
                const Text(
                  'Music Collection',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              _getMusicCollectionWidget(),
            ],
          ),
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _rtmTokenController,
              decoration: const InputDecoration(hintText: 'Rtm token'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: !_initRtmToken
                        ? () async {
                            _initMusicCenter();
                          }
                        : null,
                    child: const Text('Init Rtm Token'),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: _initRtmToken
                  ? () async {
                      _searchedMusicCollection = null;
                      _currentRequestId =
                          await _musicContentCenter.getMusicCharts();
                    }
                  : null,
              child: const Text('GetMusicCharts'),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _searchMusicController,
              decoration:
                  const InputDecoration(hintText: 'Search music Keyword'),
            ),
            ElevatedButton(
              onPressed: _initRtmToken
                  ? () async {
                      _musicChartInfos.clear();
                      _musicCollection = null;
                      _searchMusicRequestId =
                          await _musicContentCenter.searchMusic(
                              keyWord: _searchMusicController.text,
                              page: 1,
                              pageSize: 10);
                    }
                  : null,
              child: const Text('SearchMusic'),
            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Channel ID'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: _initRtmToken
                        ? (isJoined ? _leaveChannel : _joinChannel)
                        : null,
                    child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}

class MusicPlayerItem extends StatefulWidget {
  const MusicPlayerItem({
    Key? key,
    required this.music,
    required this.onPlayChanged,
    required this.playing,
    required this.preloadCompleted,
    required this.getLyricCompleted,
  }) : super(key: key);

  final Music music;

  final ValueChanged<bool> onPlayChanged;

  final bool playing;

  final Completer<void>? preloadCompleted;

  final Completer<String>? getLyricCompleted;

  @override
  State<MusicPlayerItem> createState() => _MusicPlayerItemState();
}

class _MusicPlayerItemState extends State<MusicPlayerItem> {
  bool _isPlaying = false;

  bool _isLoading = false;

  String _lyricUrl = '';

  @override
  void initState() {
    super.initState();

    _isPlaying = widget.playing;
    _preload();
  }

  Future<void> _preload() async {
    if (widget.preloadCompleted == null) {
      return;
    }

    setState(() {
      _isLoading = true;
    });
    await widget.preloadCompleted?.future;

    _lyricUrl = await widget.getLyricCompleted?.future ?? '';

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    if (_isLoading) {
      child = const CircularProgressIndicator();
    } else {
      child = IconButton(
          onPressed: () async {
            _isPlaying = !_isPlaying;

            widget.onPlayChanged(_isPlaying);

            setState(() {});
          },
          icon: Icon(_isPlaying
              ? Icons.stop_circle_rounded
              : Icons.play_arrow_rounded));
    }
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text('name: ${widget.music.name}'),
            if ((widget.music.poster ?? '').isNotEmpty)
              Image.network(
                widget.music.poster ?? '',
                fit: BoxFit.cover,
              ),
            Text('lyricUrl: $_lyricUrl'),
            Center(
              child: child,
            ),
          ],
        )
      ],
    );
  }
}
