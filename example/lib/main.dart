import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'examples/advanced/index.dart';
import 'examples/basic/index.dart';
import 'config/agora.config.dart' as config;
import 'components/log_sink.dart';

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

  bool _showPerformanceOverlay = false;

  bool _isConfigInvalid() {
    return config.appId == '<YOUR_APP_ID>' ||
        config.token == '<YOUR_TOKEN>' ||
        config.channelId == '<YOUR_CHANNEL_ID>';
  }

  @override
  void initState() {
    super.initState();

    _requestPermissionIfNeed();
  }

  Future<void> _requestPermissionIfNeed() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      await [Permission.microphone, Permission.camera].request();
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
        body: _isConfigInvalid()
            ? const InvalidConfigWidget()
            : ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  return _data[index]['widget'] == null
                      ? Ink(
                          color: Colors.grey,
                          child: ListTile(
                            title: Text(_data[index]['name'] as String,
                                style: const TextStyle(
                                    fontSize: 24, color: Colors.white)),
                          ),
                        )
                      : ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          appBar: AppBar(
                                            title: Text(
                                                _data[index]['name'] as String),
                                            // ignore: prefer_const_literals_to_create_immutables
                                            actions: [const LogActionWidget()],
                                          ),
                                          body:
                                              _data[index]['widget'] as Widget?,
                                        )));
                          },
                          title: Text(
                            _data[index]['name'] as String,
                            style: const TextStyle(
                                fontSize: 24, color: Colors.black),
                          ),
                        );
                },
              ),
      ),
    );
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
