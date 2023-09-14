import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AndroidForegroundServiceWidget extends StatefulWidget {
  const AndroidForegroundServiceWidget({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  State<AndroidForegroundServiceWidget> createState() =>
      _AndroidForegroundServiceWidgetState();
}

class _AndroidForegroundServiceWidgetState
    extends State<AndroidForegroundServiceWidget> {
  final MethodChannel _channel =
      const MethodChannel('agora_rtc_ng_example/foreground_service');

  @override
  void initState() {
    super.initState();

    _channel.invokeMethod('start_foreground_service');
  }

  @override
  void dispose() {
    _channel.invokeMethod('stop_foreground_service');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
