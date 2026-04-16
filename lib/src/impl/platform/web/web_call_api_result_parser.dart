import 'dart:convert';

import 'package:iris_method_channel/iris_method_channel.dart';

CallApiResult parseWebCallApiResult({
  required int irisReturnCode,
  required String rawData,
}) {
  final normalizedRawData = rawData.trim();
  return CallApiResult(
    irisReturnCode: irisReturnCode,
    data: normalizedRawData.isEmpty
        ? const {}
        : jsonDecode(rawData) as Map<String, dynamic>,
    rawData: rawData,
  );
}
