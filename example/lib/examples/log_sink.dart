import 'package:flutter/material.dart';

class LogActionWidget extends StatefulWidget {
  const LogActionWidget({Key? key}) : super(key: key);

  @override
  _LogActionWidgetState createState() => _LogActionWidgetState();
}

class _LogActionWidgetState extends State<LogActionWidget> {
  bool _isOverlayShowed = false;

  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();

    super.dispose();
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          if (_isOverlayShowed) {
            _removeOverlay();
          } else {
            _overlayEntry = OverlayEntry(builder: (c) {
              return Positioned(
                left: 0,
                top: 0,
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  color: Colors.black87,
                  child: SafeArea(
                    bottom: false,
                    child: Material(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              TextButton(
                                onPressed: () {
                                  logSink.clear();
                                },
                                child: Text(
                                  'Clear log',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      color: Colors.transparent,
                                      onPressed: () {
                                        _removeOverlay();
                                        _isOverlayShowed = !_isOverlayShowed;
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: _LogActionInner(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
            Overlay.of(context)?.insert(_overlayEntry!);
          }
          _isOverlayShowed = !_isOverlayShowed;
          // setState(() {

          // });
        },
        child: Text(
          'Log',
          style: TextStyle(color: Colors.white),
        ));
  }
}

class _LogActionInner extends StatefulWidget {
  const _LogActionInner({Key? key}) : super(key: key);

  @override
  __LogActionInnerState createState() => __LogActionInnerState();
}

class __LogActionInnerState extends State<_LogActionInner> {
  VoidCallback? _listener;

  @override
  void initState() {
    super.initState();

    _listener ??= () {
      setState(() {});
    };

    logSink.addListener(_listener!);
  }

  @override
  void dispose() {
    if (_listener != null) {
      logSink.removeListener(_listener!);
      _listener = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      logSink.output(),
      style: TextStyle(fontSize: 15, color: Colors.white),
    ));
  }
}

class LogSink extends ChangeNotifier {
  final StringBuffer stringBuffer = StringBuffer();
  void log(String log) {
    stringBuffer.writeln(log);
    notifyListeners();
  }

  String output() {
    return stringBuffer.toString();
  }

  void clear() {
    stringBuffer.clear();
    notifyListeners();
  }
}

final LogSink logSink = LogSink();
