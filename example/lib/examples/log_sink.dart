import 'package:flutter/material.dart';

/// [AppBar] action that shows a [Overlay] with log.
class LogActionWidget extends StatefulWidget {
  /// Construct the [LogActionWidget]
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
                                child: const Text(
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
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                          const Expanded(
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
        child: const Text(
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
    return Text(
      logSink.output(),
      style: const TextStyle(fontSize: 15, color: Colors.white),
    );
  }
}

/// Class that add and update the log in [LogActionWidget]
class LogSink extends ChangeNotifier {
  final StringBuffer _stringBuffer = StringBuffer();

  /// Add log to [LogActionWidget]
  void log(String log) {
    _stringBuffer.writeln(log);
    notifyListeners();
  }

  /// Get all logs
  String output() {
    return _stringBuffer.toString();
  }

  /// Clear logs
  void clear() {
    _stringBuffer.clear();
    notifyListeners();
  }
}

/// The global [LogSink]
final LogSink logSink = LogSink();
