import 'dart:async';
import 'dart:io';

import 'package:agora_rtc_engine_example/components/android_foreground_service_widget.dart';
import 'package:agora_rtc_engine_example/components/config_override.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'examples/advanced/index.dart';
import 'examples/basic/index.dart';
import 'config/agora.config.dart' as config;
import 'components/log_sink.dart';

const _sentryDsnFromEnv = String.fromEnvironment(
  'SENTRY_DSN',
  defaultValue: '',
);

void _configureSentryOptions(SentryFlutterOptions options, String dsn) {
  options.dsn = dsn;
  options.tracesSampleRate = 1.0;
  options.sampleRate = 1.0;
  options.enableAutoPerformanceTracing = false;
  options.attachScreenshot = true;
  options.experimental.replay.onErrorSampleRate = 1.0;
  options.experimental.replay.sessionSampleRate = 1.0;
  options.experimental.privacy.maskAllText = false;
  options.debug = false;
  options.beforeCaptureScreenshot = (event, hint, shouldDebounce) {
    logSink.log(
      '[sentry] beforeCaptureScreenshot '
      'shouldDebounce=$shouldDebounce '
      'event=${event.eventId}',
    );
    return !shouldDebounce;
  };
}

void _bootstrapApp(Widget app) {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    logSink.log(details.toString());
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    logSink.log(error.toString());
    return true;
  };
  runApp(app);
}

Future<void> main() async {
  final envDsn = _sentryDsnFromEnv.trim();
  if (envDsn.isNotEmpty) {
    await SentryFlutter.init(
      (options) => _configureSentryOptions(options, envDsn),
      appRunner: () {
        _bootstrapApp(
          SentryWidget(child: const MyApp(sentryGateDone: true)),
        );
      },
    );
    return;
  }

  logSink.log(
    '[sentry] No SENTRY_DSN at compile time — show DSN field first, '
    'or pass --dart-define=SENTRY_DSN=...',
  );
  _bootstrapApp(const MyApp(sentryGateDone: false));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, this.sentryGateDone = false}) : super(key: key);

  final bool sentryGateDone;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _data = [...basic, ...advanced];

  bool _showPerformanceOverlay = false;

  late bool _sentryGatePassed;

  bool _isWebSetup = false;

  bool _isConfigInvalid() {
    return config.appId == '<YOUR_APP_ID>' ||
        config.token == '<YOUR_TOKEN>' ||
        config.channelId == '<YOUR_CHANNEL_ID>';
  }

  @override
  void initState() {
    super.initState();

    _sentryGatePassed = widget.sentryGateDone;
    _isWebSetup = !kIsWeb;

    _requestPermissionIfNeed();
  }

  Future<void> _applySentryDsnFromInput(String dsn) async {
    await SentryFlutter.init(
      (options) => _configureSentryOptions(options, dsn),
      appRunner: () {
        _bootstrapApp(
          SentryWidget(child: const MyApp(sentryGateDone: true)),
        );
      },
    );
  }

  Future<void> _requestPermissionIfNeed() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.audio, Permission.microphone, Permission.camera]
          .request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      showPerformanceOverlay: _showPerformanceOverlay,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('APIExample'),
          actions: [
            ToggleButtons(
              color: Colors.grey[300],
              selectedColor: Colors.white,
              renderBorder: false,
              children: const [
                Icon(
                  Icons.data_thresholding_outlined,
                )
              ],
              isSelected: [_showPerformanceOverlay],
              onPressed: (index) {
                setState(() {
                  _showPerformanceOverlay = !_showPerformanceOverlay;
                });
              },
            )
          ],
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    if (!_sentryGatePassed) {
      return _SentryDsnSetupPage(
        setupCompletedWithSentry: _applySentryDsnFromInput,
        setupCompletedSkip: () {
          logSink.log('[sentry] skipped — continuing without sentry_flutter.');
          setState(() {
            _sentryGatePassed = true;
          });
        },
      );
    }

    if (!_isWebSetup) {
      return _WebSetupPage(setupCompleted: () {
        setState(() {
          _isWebSetup = true;
        });
      });
    }

    if (_isConfigInvalid()) {
      return const InvalidConfigWidget();
    }

    return ListView.builder(
      itemCount: _data.length,
      itemBuilder: (context, index) {
        return _data[index]['widget'] == null
            ? Ink(
                color: Colors.grey,
                child: ListTile(
                  title: Text(_data[index]['name'] as String,
                      style:
                          const TextStyle(fontSize: 24, color: Colors.white)),
                ),
              )
            : ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    Widget widget = Scaffold(
                      appBar: AppBar(
                        title: Text(_data[index]['name'] as String),
                        // ignore: prefer_const_literals_to_create_immutables
                        actions: [const LogActionWidget()],
                      ),
                      body: _data[index]['widget'] as Widget?,
                    );

                    if (!kIsWeb && Platform.isAndroid) {
                      widget = AndroidForegroundServiceWidget(child: widget);
                    }

                    return widget;
                  }));
                },
                title: Text(
                  _data[index]['name'] as String,
                  style: const TextStyle(fontSize: 24, color: Colors.black),
                ),
              );
      },
    );
  }
}

class _SentryDsnSetupPage extends StatefulWidget {
  const _SentryDsnSetupPage({
    Key? key,
    required this.setupCompletedWithSentry,
    required this.setupCompletedSkip,
  }) : super(key: key);

  final Future<void> Function(String dsn) setupCompletedWithSentry;
  final VoidCallback setupCompletedSkip;

  @override
  State<_SentryDsnSetupPage> createState() => _SentryDsnSetupPageState();
}

class _SentryDsnSetupPageState extends State<_SentryDsnSetupPage> {
  late final TextEditingController _dsnController;

  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _dsnController = TextEditingController();
    _dsnController.addListener(() => setState(() {}));
  }

  Future<void> _onDone() async {
    final dsn = _dsnController.text.trim();
    if (dsn.isEmpty || _busy) {
      return;
    }
    setState(() => _busy = true);
    try {
      await widget.setupCompletedWithSentry(dsn);
    } catch (e, st) {
      logSink.log('[sentry] init failed: $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sentry init failed: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _busy = false);
      }
    }
  }

  @override
  void dispose() {
    _dsnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final canSubmit = _dsnController.text.trim().isNotEmpty && !_busy;

    return Center(
      child: SizedBox(
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Input Your Sentry DSN'),
            TextField(
              controller: _dsnController,
              decoration: const InputDecoration(
                labelText: 'SENTRY_DSN',
              ),
              autocorrect: false,
              enableSuggestions: false,
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: canSubmit ? _onDone : null,
              child: Text(_busy ? '…' : 'Done'),
            ),
            TextButton(
              onPressed: _busy ? null : widget.setupCompletedSkip,
              child: const Text('Skip (no Sentry)'),
            ),
          ],
        ),
      ),
    );
  }
}

class _WebSetupPage extends StatefulWidget {
  const _WebSetupPage({Key? key, required this.setupCompleted})
      : super(key: key);

  final VoidCallback setupCompleted;

  @override
  State<_WebSetupPage> createState() => _WebSetupPageState();
}

class _WebSetupPageState extends State<_WebSetupPage> {
  late TextEditingController _appIdController;
  late TextEditingController _channelIdController;
  late TextEditingController _tokenController;

  bool _isValid = false;

  late final ExampleConfigOverride _configOverride;

  @override
  void initState() {
    super.initState();

    _configOverride = ExampleConfigOverride();

    _appIdController = TextEditingController(text: _configOverride.getAppId());
    _channelIdController =
        TextEditingController(text: _configOverride.getChannelId());
    _tokenController = TextEditingController(text: _configOverride.getToken());

    _appIdController.addListener(_validCheck);
    _channelIdController.addListener(_validCheck);
  }

  void _validCheck() {
    _isValid = _appIdController.text.isNotEmpty &&
        _channelIdController.text.isNotEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Column(
          children: [
            const Text('Input Your APP ID'),
            TextField(
              controller: _appIdController,
              decoration: const InputDecoration(
                labelText: 'APP ID can not be empty',
                // errorText: _appIdValidate ? "Value Can't Be Empty" : null,
              ),
            ),
            const Text('Input Your Channel ID'),
            TextField(
              controller: _channelIdController,
              decoration: const InputDecoration(
                labelText: 'Channel ID can not be empty',
                // errorText: _appIdValidate ? "Value Can't Be Empty" : null,
              ),
            ),
            const Text('Input Your Token (Optional)'),
            TextField(
              controller: _tokenController,
            ),
            ElevatedButton(
              onPressed: !_isValid
                  ? null
                  : () {
                      _configOverride.set(keyAppId, _appIdController.text);
                      _configOverride.set(
                          keyChannelId, _channelIdController.text);
                      _configOverride.set(keyToken, _tokenController.text);

                      widget.setupCompleted();
                    },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _appIdController.dispose();
    _channelIdController.dispose();
    _tokenController.dispose();
    super.dispose();
  }
}

class InvalidConfigWidget extends StatelessWidget {
  const InvalidConfigWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Text(
          'Make sure you set the correct appId, token, channelId, etc.. in the lib/config/agora.config.dart file.'),
    );
  }
}
