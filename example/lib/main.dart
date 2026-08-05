import 'package:agora_rtc_engine_example/components/config_override.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'examples/advanced/index.dart';
import 'examples/basic/index.dart';
import 'config/agora.config.dart' as config;
import 'examples/log_sink.dart';

void main() => runApp(const MyApp());

/// This widget is the root of your application.
class MyApp extends StatefulWidget {
  /// Construct the [MyApp]
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _data = [...basic, ...advanced];

  bool _isWebSetup = false;

  bool _isConfigInvalid() {
    return _isMissingRequiredValue(config.appId, appIdPlaceholder) ||
        _isMissingRequiredValue(config.channelId, channelIdPlaceholder) ||
        config.token.trim() == tokenPlaceholder;
  }

  @override
  void initState() {
    super.initState();
    _isWebSetup = !kIsWeb;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('APIExample'),
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    if (!_isWebSetup) {
      return _WebSetupPage(
        setupCompleted: () {
          setState(() {
            _isWebSetup = true;
          });
        },
      );
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
                  title: Text(
                    _data[index]['name'] as String,
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              )
            : ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text(_data[index]['name'] as String),
                          // ignore: prefer_const_literals_to_create_immutables
                          actions: [const LogActionWidget()],
                        ),
                        body: _data[index]['widget'] as Widget?,
                      ),
                    ),
                  );
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

bool _isMissingRequiredValue(String value, String placeholder) {
  final normalizedValue = value.trim();
  return normalizedValue.isEmpty || normalizedValue == placeholder;
}

String _editableValue(String value, String placeholder) {
  return value == placeholder ? '' : value;
}

class _WebSetupPage extends StatefulWidget {
  const _WebSetupPage({required this.setupCompleted});

  final VoidCallback setupCompleted;

  @override
  State<_WebSetupPage> createState() => _WebSetupPageState();
}

class _WebSetupPageState extends State<_WebSetupPage> {
  late final TextEditingController _appIdController;
  late final TextEditingController _channelIdController;
  late final TextEditingController _tokenController;

  final ExampleConfigOverride _configOverride = ExampleConfigOverride();

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _appIdController = TextEditingController(
      text: _editableValue(_configOverride.getAppId(), appIdPlaceholder),
    );
    _channelIdController = TextEditingController(
      text: _editableValue(
        _configOverride.getChannelId(),
        channelIdPlaceholder,
      ),
    );
    _tokenController = TextEditingController(
      text: _editableValue(_configOverride.getToken(), tokenPlaceholder),
    );

    _appIdController.addListener(_validate);
    _channelIdController.addListener(_validate);
    _validate();
  }

  void _validate() {
    final isValid =
        !_isMissingRequiredValue(_appIdController.text, appIdPlaceholder) &&
            !_isMissingRequiredValue(
              _channelIdController.text,
              channelIdPlaceholder,
            );
    if (_isValid != isValid) {
      setState(() {
        _isValid = isValid;
      });
    }
  }

  void _completeSetup() {
    _configOverride.set(keyAppId, _appIdController.text.trim());
    _configOverride.set(keyChannelId, _channelIdController.text.trim());
    _configOverride.set(keyToken, _tokenController.text.trim());
    widget.setupCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Input Your APP ID'),
              TextField(
                controller: _appIdController,
                decoration: const InputDecoration(
                  labelText: 'APP ID can not be empty',
                ),
              ),
              const SizedBox(height: 12),
              const Text('Input Your Channel ID'),
              TextField(
                controller: _channelIdController,
                decoration: const InputDecoration(
                  labelText: 'Channel ID can not be empty',
                ),
              ),
              const SizedBox(height: 12),
              const Text('Input Your Token (Optional)'),
              TextField(controller: _tokenController),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _isValid ? _completeSetup : null,
                child: const Text('Done'),
              ),
            ],
          ),
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

/// This widget is used to indicate the configuration is invalid
class InvalidConfigWidget extends StatelessWidget {
  /// Construct the [InvalidConfigWidget]
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
