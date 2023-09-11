@JS()
library iris_web_rtc;

import 'package:iris_method_channel/iris_method_channel_bindings_web.dart';
import 'package:js/js.dart';

@JS('AgoraWrapper.initIrisRtc')
external void initIrisRtc(IrisApiEngine irisApiEngine);