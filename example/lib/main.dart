import 'package:flutter/material.dart';

import 'examples/advanced/index.dart';
import 'examples/basic/index.dart';

void main() => runApp(MyApp());

/// This widget is the root of your application.
class MyApp extends StatelessWidget {
  final _DATA = [...Basic, ...Advanced];

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
        body: ListView.builder(
          itemCount: _DATA.length,
          itemBuilder: (context, index) {
            return _DATA[index]['widget'] == null
                ? Ink(
                    color: Colors.grey,
                    child: ListTile(
                      title: Text(_DATA[index]['name'] as String,
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                    ),
                  )
                : ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Scaffold(
                                    appBar: AppBar(
                                      title:
                                          Text(_DATA[index]['name'] as String),
                                    ),
                                    body: _DATA[index]['widget'] as Widget?,
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
