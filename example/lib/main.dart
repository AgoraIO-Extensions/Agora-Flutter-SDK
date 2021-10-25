import 'package:flutter/material.dart';

import 'examples/advanced/index.dart';
import 'examples/basic/index.dart';
import 'config/agora.config.dart' as config;

void main() => runApp(MyApp());

/// This widget is the root of your application.
class MyApp extends StatelessWidget {
  final _DATA = [...Basic, ...Advanced];

  bool _isConfigInvalid() {
    return config.appId == '<YOUR_APP_ID>' ||
        config.token == '<YOUR_TOEKN>' ||
        config.channelId == '<YOUR_CHANNEL_ID>';
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
        body: _isConfigInvalid()
            ? InvalidConfigWidget()
            : ListView.builder(
                itemCount: _DATA.length,
                itemBuilder: (context, index) {
                  return _DATA[index]['widget'] == null
                      ? Ink(
                          color: Colors.grey,
                          child: ListTile(
                            title: Text(_DATA[index]['name'] as String,
                                style: TextStyle(
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
                                                _DATA[index]['name'] as String),
                                          ),
                                          body:
                                              _DATA[index]['widget'] as Widget?,
                                        )));
                          },
                          title: Text(
                            _DATA[index]['name'] as String,
                            style: TextStyle(fontSize: 24, color: Colors.black),
                          ),
                        );
                },
              ),
      ),
    );
  }
}

class InvalidConfigWidget extends StatelessWidget {
  const InvalidConfigWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Text(
          'Make sure you set the correct appId, token, channelId, etc.. in the lib/config/agora.config.dart file.'),
    );
  }
}
