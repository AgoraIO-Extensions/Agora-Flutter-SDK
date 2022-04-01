import 'dart:convert';

import 'package:agora_rtc_engine/src/media_recorder.dart';

import 'event_handler_json.dart';

// ignore_for_file: public_member_api_docs

extension MediaRecorderObserverExt on MediaRecorderObserver {
  void process(String methodName, dynamic data) {
    switch (methodName) {
      case 'onRecorderStateChanged':
        if (onRecorderStateChanged != null) {
          final dataMap = jsonDecode(data as String);

          final json = OnRecorderStateChangedJson.fromJson(dataMap);
          onRecorderStateChanged!(json.state, json.error);
        }

        break;
      case 'onRecorderInfoUpdated':
        if (onRecorderInfoUpdated != null) {
          final dataMap = jsonDecode(data as String);

          final json = OnRecorderInfoUpdatedJson.fromJson(dataMap);
          onRecorderInfoUpdated!(json.info);
        }
        break;
      default:
        // do nothing
        break;
    }
  }
}
