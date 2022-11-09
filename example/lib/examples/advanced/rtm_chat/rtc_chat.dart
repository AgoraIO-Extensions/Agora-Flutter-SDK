import 'dart:convert';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtc_engine_example/config/agora.config.dart' as config;
import 'package:agora_rtc_engine_example/components/example_actions_widget.dart';
import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void _logCall(String func, Future<void> Function() call) async {
  try {
    await call();
  } catch (e) {
    logSink.log('[$func] error code: ${(e as AgoraRtcException).code}');
  }
}

class StreamChannelInfo {
  StreamChannelInfo(
    this.channelName,
    this.streamChannel,
    this.joined,
    this.joinedTopic,
    this.subscribeTopic,
    this.userList,
    this.receivedMessages,
  );

  final String channelName;
  final StreamChannel streamChannel;
  final bool joined;
  final Set<String> joinedTopic;
  final Set<String> subscribeTopic;
  final Set<String> userList;
  final List<MessageEvent> receivedMessages;

  StreamChannelInfo copyWith({
    String? channelName,
    StreamChannel? streamChannel,
    bool? joined,
    Set<String>? joinedTopic,
    Set<String>? subscribeTopic,
    Set<String>? userList,
    List<MessageEvent>? receivedMessages,
  }) {
    return StreamChannelInfo(
      channelName ?? this.channelName,
      streamChannel ?? this.streamChannel,
      joined ?? this.joined,
      joinedTopic ?? this.joinedTopic,
      subscribeTopic ?? this.subscribeTopic,
      userList ?? this.userList,
      receivedMessages ?? this.receivedMessages,
    );
  }
}

class StreamChannelInfoMap
    extends StateNotifier<Map<String, StreamChannelInfo>> {
  StreamChannelInfoMap() : super(<String, StreamChannelInfo>{});

  StreamChannelInfo getStreamChannelInfo(String channelName) {
    return state[channelName]!;
  }

  void put(String channelName, StreamChannel streamChannel) {
    final pre = state;

    state = {
      ...pre,
      channelName:
          StreamChannelInfo(channelName, streamChannel, false, {}, {}, {}, []),
    };
  }

  void remove(String channelName) {
    final pre = state;
    pre.remove(channelName);
    state = Map.from(pre);
  }

  void updateStreamChannelInfo(
    String channelName, {
    StreamChannel? streamChannel,
    bool? joined,
    Set<String>? joinedTopic,
    Set<String>? subscribeTopic,
    Set<String>? userList,
    List<MessageEvent>? receivedMessages,
  }) {
    final pre = state;
    final preInfo = state[channelName]!;
    pre[channelName] = preInfo.copyWith(
      joined: joined,
      joinedTopic: joinedTopic,
      subscribeTopic: subscribeTopic,
      userList: userList,
      receivedMessages: receivedMessages,
    );

    state = Map.from(pre);
  }
}

class RtmChatModel {
  RtmChatModel(this.ref);

  final WidgetRef ref;

  final streamChannelInfoListProvider = StateNotifierProvider<
      StreamChannelInfoMap, Map<String, StreamChannelInfo>>((ref) {
    return StreamChannelInfoMap();
  });

  final isRtmClientInit = StateProvider<bool>((_) => false);
  void setRtmClientInit(bool isInit) {
    ref.read(isRtmClientInit.notifier).state = true;
  }

  StreamChannelInfo getStreamChannelInfo(String channelName) {
    return ref
        .read(streamChannelInfoListProvider.notifier)
        .getStreamChannelInfo(channelName);
  }

  void put(String channelName, StreamChannel streamChannel) {
    ref
        .read(streamChannelInfoListProvider.notifier)
        .put(channelName, streamChannel);
  }

  void remove(String channelName) {
    ref.read(streamChannelInfoListProvider.notifier).remove(channelName);
  }

  void updateStreamChannelInfo(
    String channelName, {
    StreamChannel? streamChannel,
    bool? joined,
    Set<String>? joinedTopic,
    Set<String>? subscribeTopic,
    Set<String>? userList,
    List<MessageEvent>? receivedMessages,
  }) {
    ref.read(streamChannelInfoListProvider.notifier).updateStreamChannelInfo(
          channelName,
          streamChannel: streamChannel,
          joined: joined,
          joinedTopic: joinedTopic,
          subscribeTopic: subscribeTopic,
          userList: userList,
          receivedMessages: receivedMessages,
        );
  }
}

/// RtmChat Example
class RtmChat extends StatelessWidget {
  const RtmChat({Key? key}) : super(key: key);

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case '/':
        page = const RtmChatConsumerWidget();
        break;
      case 'StreamChannelPage':
        final arguments = settings.arguments as Map<String, dynamic>;
        final channelName = arguments['channelName'];
        final rtmChatModel = arguments['rtmChatModel'];
        final token = arguments['token'];
        page = StreamChannelPage(
            channelName: channelName, rtmChatModel: rtmChatModel, token: token);
        break;
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(child: Builder(builder: (cc) {
      return Navigator(
        initialRoute: '/',
        onGenerateRoute: _onGenerateRoute,
      );
    }));
  }
}

class RtmChatConsumerWidget extends ConsumerStatefulWidget {
  /// Construct the [RtmChat]
  const RtmChatConsumerWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RtmChatConsumerWidgetState();
}

class _RtmChatConsumerWidgetState extends ConsumerState<RtmChatConsumerWidget> {
  late final RtcEngine _engine;
  late final RtmClient _rtmClient;

  bool isJoined = false, switchCamera = true, switchRender = true;
  Set<int> remoteUid = {};
  late TextEditingController _userIdController;
  late TextEditingController _tokenController;
  late TextEditingController _rtmChannelNameController;

  final Map<String, StreamChannel> _streamChannel = {};

  late final RtmChatModel _rtmChatModel;

  @override
  void initState() {
    super.initState();

    _userIdController = TextEditingController();

    _tokenController = TextEditingController(text: config.rtmToken);
    _rtmChannelNameController = TextEditingController();

    _rtmChatModel = RtmChatModel(ref);

    _init();
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }

  Future<void> _dispose() async {
    _userIdController.dispose();
    _tokenController.dispose();
    _rtmChannelNameController.dispose();

    for (final sc in _streamChannel.values) {
      await sc.release();
    }
    await _rtmClient.release();
    await _engine.release();
  }

  Future<void> _init() async {
    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(
      appId: config.appId,
    ));
    await _engine.setParameters('{"rtc.vos_list":["114.236.138.120:4052"]}');

    _rtmClient = createAgoraRtmClient();
  }

  Future<void> _initRtmClient() async {
    if (_userIdController.text.isEmpty) {
      logSink.log('User id can not be empty');
      return;
    }

    final rtmConfig = RtmConfig(
      appId: config.rtmAppId,
      userId: _userIdController.text,
      eventHandler: RtmEventHandler(
        onMessageEvent: (MessageEvent event) {
          logSink.log('[onMessageEvent] event: ${event.toJson()}');

          final info = _rtmChatModel.getStreamChannelInfo(event.channelName!);
          final receivedMessages = info.receivedMessages;
          receivedMessages.add(event);

          _rtmChatModel.updateStreamChannelInfo(event.channelName!,
              receivedMessages: receivedMessages);
        },
        onPresenceEvent: (PresenceEvent event) {
          logSink.log('[onPresenceEvent] event: ${event.toJson()}');
        },
        onJoinResult: (String channelName, String userId,
            StreamChannelErrorCode errorCode) {
          logSink.log(
              '[onJoinResult] channelName: $channelName, userId: $userId, errorCode: $errorCode');
        },
        onLeaveResult: (String channelName, String userId,
            StreamChannelErrorCode errorCode) {
          logSink.log(
              '[onLeaveResult] channelName: $channelName, userId: $userId, errorCode: $errorCode');

          _rtmChatModel.updateStreamChannelInfo(channelName, joined: false);
        },
        onJoinTopicResult: (String channelName, String userId, String topic,
            String meta, StreamChannelErrorCode errorCode) {
          logSink.log(
              '[onJoinTopicResult] channelName: $channelName, userId: $userId, topic: $topic, meta: $meta, errorCode: $errorCode');

          final pre = _rtmChatModel.getStreamChannelInfo(channelName);
          final joinedTopic = {...pre.joinedTopic, topic};

          _rtmChatModel.updateStreamChannelInfo(channelName,
              joinedTopic: joinedTopic);
        },
        onLeaveTopicResult: (String channelName, String userId, String topic,
            String meta, StreamChannelErrorCode errorCode) {
          logSink.log(
              '[onLeaveTopicResult] channelName: $channelName, userId: $userId, topic: $topic, meta: $meta, errorCode: $errorCode');

          final pre = _rtmChatModel.getStreamChannelInfo(channelName);
          final joinedTopic = pre.joinedTopic;
          joinedTopic.removeWhere((element) => element == topic);

          _rtmChatModel.updateStreamChannelInfo(channelName,
              joinedTopic: joinedTopic);
        },
        onTopicSubscribed: (String channelName,
            String userId,
            String topic,
            UserList succeedUsers,
            UserList failedUsers,
            StreamChannelErrorCode errorCode) {
          logSink.log(
              '[onTopicSubscribed] channelName: $channelName, userId: $userId, topic: $topic, succeedUsers: ${succeedUsers.toJson()}, failedUsers: ${failedUsers.toJson()}, errorCode: $errorCode');

          final pre = _rtmChatModel.getStreamChannelInfo(channelName);
          final subscribeTopic = {...pre.subscribeTopic, topic};

          _rtmChatModel.updateStreamChannelInfo(channelName,
              subscribeTopic: subscribeTopic);
        },
        onTopicUnsubscribed: (String channelName,
            String userId,
            String topic,
            UserList succeedUsers,
            UserList failedUsers,
            StreamChannelErrorCode errorCode) {
          logSink.log(
              '[onTopicUnsubscribed] channelName: $channelName, userId: $userId, topic: $topic, succeedUsers: ${succeedUsers.toJson()}, failedUsers: ${failedUsers.toJson()}, errorCode: $errorCode');

          final pre = _rtmChatModel.getStreamChannelInfo(channelName);
          final subscribeTopic = pre.subscribeTopic;
          subscribeTopic.removeWhere((element) => element == topic);

          _rtmChatModel.updateStreamChannelInfo(channelName,
              subscribeTopic: subscribeTopic);
        },
        onConnectionStateChange: (String channelName, RtmConnectionState state,
            RtmConnectionChangeReason reason) {
          logSink.log(
              '[onConnectionStateChange] channelName: $channelName, state: $state, reason: $reason');
        },
      ),
    );

    _logCall('RtmClient.initialize', () async {
      await _rtmClient.initialize(rtmConfig);
      _rtmChatModel.setRtmClientInit(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ExampleActionsWidget(
      displayContentBuilder: (context, isLayoutHorizontal) {
        return Consumer(
          builder: (context, ref, child) {
            final streamChannels =
                ref.watch(_rtmChatModel.streamChannelInfoListProvider);

            return ListView.builder(
              itemCount: streamChannels.length,
              itemBuilder: (context, index) {
                final streamChannel = streamChannels.values.elementAt(index);
                return GestureDetector(
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(child: Text(streamChannel.channelName)),
                        IconButton(
                          onPressed: () async {
                            _logCall('StreamChannel.release', () async {
                              await streamChannel.streamChannel.release();

                              _streamChannel.remove(streamChannel.channelName);

                              _rtmChatModel.remove(streamChannel.channelName);
                            });
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(pageBuilder:
                          (context, animation, secondaryAnimation) {
                        return Scaffold(
                          body: StreamChannelPage(
                            channelName: streamChannel.channelName,
                            rtmChatModel: _rtmChatModel,
                            token: _tokenController.text,
                          ),
                        );
                      }, transitionsBuilder: (BuildContext context,
                          Animation<double> animation,
                          Animation<double> secondaryAnimation,
                          Widget child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.0, 1.0),
                            end: Offset.zero,
                          )
                              .chain(CurveTween(curve: Curves.ease))
                              .animate(animation),
                          child: child,
                        );
                      }),
                    );
                  },
                );
              },
            );
          },
        );
      },
      actionsBuilder: (context, isLayoutHorizontal) {
        return Consumer(
          builder: (context, ref, child) {
            final isInit = ref.watch(_rtmChatModel.isRtmClientInit);

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _tokenController,
                  decoration:
                      const InputDecoration(hintText: 'Input rtm Token'),
                ),
                TextField(
                  controller: _userIdController,
                  decoration: const InputDecoration(hintText: 'Input user id'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: isInit
                            ? null
                            : () {
                                _initRtmClient();
                              },
                        child: const Text('Initialize'),
                      ),
                    )
                  ],
                ),
                TextField(
                  controller: _rtmChannelNameController,
                  decoration:
                      const InputDecoration(hintText: 'Input rtm channel name'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: isInit
                            ? () async {
                                _logCall('RtmClient.createStreamChannel',
                                    () async {
                                  final channelName =
                                      _rtmChannelNameController.text;
                                  final streamChannel = await _rtmClient
                                      .createStreamChannel(channelName);

                                  _rtmChatModel.put(channelName, streamChannel);

                                  _streamChannel[channelName] = streamChannel;
                                });
                              }
                            : null,
                        child: const Text('Create StreamChannel'),
                      ),
                    )
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class StreamChannelPage extends StatefulWidget {
  /// Construct the [StreamChannelPage]
  const StreamChannelPage(
      {Key? key,
      required this.channelName,
      required this.rtmChatModel,
      required this.token})
      : super(key: key);

  final String channelName;

  final RtmChatModel rtmChatModel;

  final String token;

  @override
  State<StatefulWidget> createState() => _StreamChannelPageState();
}

class _StreamChannelPageState extends State<StreamChannelPage> {
  late final String _channelName;
  late final RtmChatModel _rtmChatModel;
  late final String _token;

  bool isJoined = false, switchCamera = true, switchRender = true;

  late TextEditingController _topicController;
  late TextEditingController _topicMessageController;
  late TextEditingController _subscribeTopicController;
  late TextEditingController _subscribeUserController;

  @override
  void initState() {
    super.initState();

    _topicController = TextEditingController();
    _topicMessageController = TextEditingController();
    _subscribeTopicController = TextEditingController();
    _subscribeUserController = TextEditingController();

    _channelName = widget.channelName;
    _rtmChatModel = widget.rtmChatModel;
    _token = widget.token;
  }

  @override
  void dispose() {
    _topicController.dispose();
    _topicMessageController.dispose();
    _subscribeTopicController.dispose();
    _subscribeUserController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              color: Colors.grey[200],
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Consumer(
                builder: (context, ref, child) {
                  final streamChannelInfos =
                      ref.watch(_rtmChatModel.streamChannelInfoListProvider);

                  final streamChannelInfo = streamChannelInfos[_channelName]!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Channel Name: ${streamChannelInfo.channelName}'),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            final message =
                                streamChannelInfo.receivedMessages[index];
                            return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('channelType: ${message.channelType}'),
                                  Text('channelName: ${message.channelName}'),
                                  Text('channelTopic: ${message.channelTopic}'),
                                  Text(
                                      'message: ${utf8.decode(message.message ?? Uint8List(0))}'),
                                  Text(
                                      'messageLength: ${message.messageLength}'),
                                  Text('publisher: ${message.publisher}'),
                                  Container(
                                    color: Colors.black12,
                                    height: 1,
                                  ),
                                ]);
                          },
                          itemCount: streamChannelInfo.receivedMessages.length,
                        ),
                      ),
                    ],
                  );
                },
              ),
            )),
            Expanded(child: SingleChildScrollView(
              child: Consumer(
                builder: (context, ref, child) {
                  final streamChannelInfos =
                      ref.watch(_rtmChatModel.streamChannelInfoListProvider);

                  final streamChannelInfo = streamChannelInfos[_channelName];

                  final streamChannel = streamChannelInfo!.streamChannel;

                  return Container(
                    margin: const EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            if (streamChannelInfo.joined) {
                              _logCall('StreamChannel.leave', () async {
                                await streamChannel.leave();
                                _rtmChatModel.updateStreamChannelInfo(
                                    _channelName,
                                    joined: false);
                              });
                            } else {
                              _logCall('StreamChannel.join', () async {
                                await streamChannel
                                    .join(JoinChannelOptions(token: _token));

                                _rtmChatModel.updateStreamChannelInfo(
                                    _channelName,
                                    joined: true);
                              });
                            }
                          },
                          child: Text(
                              '${streamChannelInfo.joined ? 'Leave' : 'Join'} rtm channel'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Topic Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _topicController,
                                decoration: const InputDecoration(
                                    hintText: 'Input topic name'),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: streamChannelInfo.joined
                                  ? () {
                                      _logCall('StreamChannel.joinTopic',
                                          () async {
                                        streamChannel.joinTopic(
                                            topic: _topicController.text,
                                            options: const JoinTopicOptions());
                                      });
                                    }
                                  : null,
                              child: const Text('Join'),
                            ),
                            ElevatedButton(
                              onPressed: streamChannelInfo.joined
                                  ? () {
                                      _logCall('StreamChannel.leaveTopic',
                                          () async {
                                        streamChannel
                                            .leaveTopic(_topicController.text);
                                      });
                                    }
                                  : null,
                              child: const Text('Leave'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'User List',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _subscribeUserController,
                                decoration: const InputDecoration(
                                    hintText: 'Input user name'),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: streamChannelInfo.joined
                                  ? () {
                                      if (_subscribeUserController
                                          .text.isEmpty) {
                                        logSink.log(
                                            'Subscribe user name can not be empty');
                                        return;
                                      }
                                      final userList =
                                          streamChannelInfo.userList;
                                      userList
                                          .add(_subscribeUserController.text);

                                      ref
                                          .read(_rtmChatModel
                                              .streamChannelInfoListProvider
                                              .notifier)
                                          .updateStreamChannelInfo(
                                              streamChannelInfo.channelName,
                                              userList: userList);
                                    }
                                  : null,
                              child: const Text('Add'),
                            ),
                            ElevatedButton(
                              onPressed: streamChannelInfo.joined
                                  ? () {
                                      if (_subscribeUserController
                                          .text.isEmpty) {
                                        logSink.log(
                                            'Subscribe user name can not be empty');
                                        return;
                                      }

                                      final userList =
                                          streamChannelInfo.userList;
                                      userList.removeWhere((element) =>
                                          element ==
                                          _subscribeUserController.text);

                                      ref
                                          .read(_rtmChatModel
                                              .streamChannelInfoListProvider
                                              .notifier)
                                          .updateStreamChannelInfo(
                                              streamChannelInfo.channelName,
                                              userList: userList);
                                    }
                                  : null,
                              child: const Text('Remove'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          spacing: 10,
                          children: [
                            for (final u in streamChannelInfo.userList)
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.green[200]!,
                                    border: Border.all(
                                      color: Colors.green[200]!,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                padding: const EdgeInsets.all(8),
                                child: Text(u),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Subscribe Topic',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _subscribeTopicController,
                                decoration: const InputDecoration(
                                    hintText: 'Intput subscribe topic name'),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: streamChannelInfo.joined
                                  ? () {
                                      _logCall('StreamChannel.subscribeTopic',
                                          () async {
                                        await streamChannel.subscribeTopic(
                                            topic:
                                                _subscribeTopicController.text,
                                            options: TopicOptions(
                                                users: streamChannelInfo
                                                    .userList
                                                    .toList(),
                                                userCount: streamChannelInfo
                                                    .userList.length));
                                      });
                                    }
                                  : null,
                              child: const Text('Subscribe'),
                            ),
                            ElevatedButton(
                              onPressed: streamChannelInfo.joined
                                  ? () {
                                      _logCall('StreamChannel.unsubscribeTopic',
                                          () async {
                                        await streamChannel.unsubscribeTopic(
                                            topic:
                                                _subscribeTopicController.text,
                                            options: TopicOptions(
                                                users: streamChannelInfo
                                                    .userList
                                                    .toList(),
                                                userCount: streamChannelInfo
                                                    .userList.length));
                                      });
                                    }
                                  : null,
                              child: const Text('Unsubscribe'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Topic message',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextField(
                                controller: _topicMessageController,
                                decoration: const InputDecoration(
                                    hintText: 'Input topic message'),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: streamChannelInfo.joined
                                  ? () {
                                      _logCall(
                                          'StreamChannel.publishTopicMessage',
                                          () async {
                                        final message = Uint8List.fromList(
                                            utf8.encode(
                                                _topicMessageController.text));

                                        await streamChannel.publishTopicMessage(
                                          topic: _topicController.text,
                                          message: message,
                                          length: message.length,
                                        );
                                      });
                                    }
                                  : null,
                              child: const Text('Send'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }
}
