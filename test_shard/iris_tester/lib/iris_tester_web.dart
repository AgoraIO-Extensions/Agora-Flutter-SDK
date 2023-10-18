// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

class IrisTesterWeb {
  IrisTesterWeb();

  // ignore: public_member_api_docs
  static void registerWith(Registrar registrar) {
    // const irisWebUrl =
    //     'https://download.agora.io/staging/iris-web-rtc_0.1.2-dev.1.js';
    // const irisWebFakeUrl =
    //     'https://download.agora.io/staging/iris-web-rtc-fake_0.1.2-dev.1.js';

    // final element = ScriptElement()
    //   ..src = irisWebUrl
    //   ..type = 'application/javascript';
    // // late StreamSubscription<Event> loadSubscription;
    // // loadSubscription = 
    // element.onLoad.listen((event) {
    //   print('lllllllll');
    // });
    // document.body!.append(element);

    // final element2 = ScriptElement()
    //   ..src = irisWebFakeUrl
    //   ..type = 'application/javascript';
    // // late StreamSubscription<Event> loadSubscription;
    // // loadSubscription = 
    // element2.onLoad.listen((event) {
    //   print('mmmmmm');
    // });
    // document.body!.append(element2);
  }
}
