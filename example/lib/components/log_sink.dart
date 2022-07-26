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
                              child: LogWidget(),
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

/// LogWidget
class LogWidget extends StatefulWidget {
  /// Construct the [LogWidget]
  const LogWidget({
    Key? key,
    this.logSink,
    this.textStyle = const TextStyle(fontSize: 15, color: Colors.white),
  }) : super(key: key);

  /// This [LogSink] is used to add log.
  final LogSink? logSink;

  /// The text style of the log.
  final TextStyle textStyle;

  @override
  _LogWidgetState createState() => _LogWidgetState();
}

class _LogWidgetState extends State<LogWidget> {
  VoidCallback? _listener;
  late final LogSink _logSink;

  @override
  void initState() {
    super.initState();

    _logSink = widget.logSink ?? _defaultLogSink;

    _listener ??= () {
      setState(() {});
    };

    _logSink.addListener(_listener!);
  }

  @override
  void dispose() {
    if (_listener != null) {
      _logSink.removeListener(_listener!);
      _listener = null;
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _logSink.output(),
      style: widget.textStyle,
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

final LogSink _defaultLogSink = LogSink();

/// The global [LogSink]
LogSink get logSink => _defaultLogSink;
