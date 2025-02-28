import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iris_tester/iris_tester.dart';
import '../generated/rtcengine_rtcengineeventhandler_testcases.generated.dart'
    as generated;

import '../testcases/event_ids_mapping.dart';

void testCases(ValueGetter<IrisTester> irisTester) {
  generated.generatedTestCases(irisTester);

  testWidgets(
    'onFacePositionChanged',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));

      final onFacePositionChangedCompleter = Completer<bool>();
      final theRtcEngineEventHandler = RtcEngineEventHandler(
        onFacePositionChanged: (int imageWidth, int imageHeight,
            List vecRectangle, List vecDistance, int numFaces) {
          onFacePositionChangedCompleter.complete(true);
        },
      );

      rtcEngine.registerEventHandler(
        theRtcEngineEventHandler,
      );

// Delay 500 milliseconds to ensure the registerEventHandler call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      {
        const int imageWidth = 10;
        const int imageHeight = 10;
        const List<Rectangle> vecRectangle = [];
        const List<int> vecDistance = [];
        const int numFaces = 10;

        final eventJson = {
          'imageWidth': imageWidth,
          'imageHeight': imageHeight,
          'vecRectangle': vecRectangle,
          'vecDistance': vecDistance,
          'numFaces': numFaces,
        };

        final eventIds =
            eventIdsMapping['RtcEngineEventHandler_onFacePositionChanged'] ??
                [];
        for (final event in eventIds) {
          final ret = irisTester().fireEvent(event, params: eventJson);
          // Delay 200 milliseconds to ensure the callback is called.
          await Future.delayed(const Duration(milliseconds: 200));
          // TODO(littlegnal): Most of callbacks on web are not implemented, we're temporarily skip these callbacks at this time.
          if (kIsWeb && ret) {
            if (!onFacePositionChangedCompleter.isCompleted) {
              onFacePositionChangedCompleter.complete(true);
            }
          }
        }
      }

      final eventCalled = await onFacePositionChangedCompleter.future;
      expect(eventCalled, isTrue);

      {
        rtcEngine.unregisterEventHandler(
          theRtcEngineEventHandler,
        );
      }
// Delay 500 milliseconds to ensure the unregisterEventHandler call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      await rtcEngine.release();
    },
    timeout: const Timeout(Duration(minutes: 1)),
    skip: kIsWeb || !(!kIsWeb && (Platform.isAndroid || Platform.isIOS)),
  );

// It's temporarily removed on 4.3.1
//   testWidgets(
//     'RtcEngineEventHandler.onCameraCapturerConfigurationChanged',
//     (WidgetTester tester) async {
//       RtcEngine rtcEngine = createAgoraRtcEngine();
//       await rtcEngine.initialize(RtcEngineContext(
//         appId: 'app_id',
//         areaCode: AreaCode.areaCodeGlob.value(),
//       ));
//       await rtcEngine.setParameters('{"rtc.enable_debug_log": true}');

//       final onCameraCapturerConfigurationChangedCompleter = Completer<bool>();
//       final theRtcEngineEventHandler = RtcEngineEventHandler(
//         onCameraCapturerConfigurationChanged: (int direction,
//             int focalLengthType, int width, int height, int frameRate) {
//           onCameraCapturerConfigurationChangedCompleter.complete(true);
//         },
//       );

//       rtcEngine.registerEventHandler(
//         theRtcEngineEventHandler,
//       );

// // Delay 500 milliseconds to ensure the registerEventHandler call completed.
//       await Future.delayed(const Duration(milliseconds: 500));

//       {
//         const int direction = 10;
//         const int focalLengthType = 10;
//         const int width = 10;
//         const int height = 10;
//         const int frameRate = 10;

//         final eventJson = {
//           'direction': direction,
//           'focalLengthType': focalLengthType,
//           'width': width,
//           'height': height,
//           'frameRate': frameRate,
//         };

//         final eventIds = eventIdsMapping[
//                 'RtcEngineEventHandler_onCameraCapturerConfigurationChanged'] ??
//             [];
//         for (final event in eventIds) {
//           final ret = irisTester().fireEvent(event, params: eventJson);
//           // Delay 200 milliseconds to ensure the callback is called.
//           await Future.delayed(const Duration(milliseconds: 200));
//           // TODO(littlegnal): Most of callbacks on web are not implemented, we're temporarily skip these callbacks at this time.
//           if (kIsWeb && ret) {
//             if (!onCameraCapturerConfigurationChangedCompleter.isCompleted) {
//               onCameraCapturerConfigurationChangedCompleter.complete(true);
//             }
//           }
//         }
//       }

//       final eventCalled =
//           await onCameraCapturerConfigurationChangedCompleter.future;
//       expect(eventCalled, isTrue);

//       {
//         rtcEngine.unregisterEventHandler(
//           theRtcEngineEventHandler,
//         );
//       }
// // Delay 500 milliseconds to ensure the unregisterEventHandler call completed.
//       await Future.delayed(const Duration(milliseconds: 500));

//       await rtcEngine.release();
//     },
//     timeout: const Timeout(Duration(minutes: 2)),
//     skip: kIsWeb || !Platform.isAndroid,
//   );

  testWidgets(
    'RtcEngineEventHandler.onDownlinkNetworkInfoUpdated',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      await rtcEngine.setParameters('{"rtc.enable_debug_log": true}');

      final onDownlinkNetworkInfoUpdatedCompleter = Completer<bool>();
      final theRtcEngineEventHandler = RtcEngineEventHandler(
        onDownlinkNetworkInfoUpdated: (DownlinkNetworkInfo info) {
          onDownlinkNetworkInfoUpdatedCompleter.complete(true);
        },
      );

      rtcEngine.registerEventHandler(
        theRtcEngineEventHandler,
      );

// Delay 500 milliseconds to ensure the registerEventHandler call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      {
        const int infoLastmileBufferDelayTimeMs = 1;
        const int infoBandwidthEstimationBps = 1;
        const int infoTotalDownscaleLevelCount = 1;
        const List<PeerDownlinkInfo> infoPeerDownlinkInfo = [
          PeerDownlinkInfo(
            userId: '123',
            streamType: VideoStreamType.videoStreamLow,
            currentDownscaleLevel:
                RemoteVideoDownscaleLevel.remoteVideoDownscaleLevel1,
            expectedBitrateBps: 1,
          ),
        ];
        const int infoTotalReceivedVideoCount = 1;
        const DownlinkNetworkInfo info = DownlinkNetworkInfo(
          lastmileBufferDelayTimeMs: infoLastmileBufferDelayTimeMs,
          bandwidthEstimationBps: infoBandwidthEstimationBps,
          totalDownscaleLevelCount: infoTotalDownscaleLevelCount,
          peerDownlinkInfo: infoPeerDownlinkInfo,
          totalReceivedVideoCount: infoTotalReceivedVideoCount,
        );

        final eventJson = {
          'info': info.toJson(),
        };

        final eventIds = eventIdsMapping[
                'RtcEngineEventHandler_onDownlinkNetworkInfoUpdated'] ??
            [];
        for (final event in eventIds) {
          final ret = irisTester().fireEvent(event, params: eventJson);
          // Delay 200 milliseconds to ensure the callback is called.
          await Future.delayed(const Duration(milliseconds: 200));
          // TODO(littlegnal): Most of callbacks on web are not implemented, we're temporarily skip these callbacks at this time.
          if (kIsWeb && ret) {
            if (!onDownlinkNetworkInfoUpdatedCompleter.isCompleted) {
              onDownlinkNetworkInfoUpdatedCompleter.complete(true);
            }
          }
        }
      }

      final eventCalled = await onDownlinkNetworkInfoUpdatedCompleter.future;
      expect(eventCalled, isTrue);

      {
        rtcEngine.unregisterEventHandler(
          theRtcEngineEventHandler,
        );
      }
// Delay 500 milliseconds to ensure the unregisterEventHandler call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      await rtcEngine.release();
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  testWidgets(
    'RtcEngineEventHandler.onStreamMessage',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      await rtcEngine.setParameters('{"rtc.enable_debug_log": true}');

      final onStreamMessageCompleter = Completer<bool>();
      final theRtcEngineEventHandler = RtcEngineEventHandler(
        onStreamMessage: (RtcConnection connection, int remoteUid, int streamId,
            Uint8List data, int length, int sentTs) {
          onStreamMessageCompleter.complete(true);
        },
      );

      rtcEngine.registerEventHandler(
        theRtcEngineEventHandler,
      );

// Delay 500 milliseconds to ensure the registerEventHandler call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      {
        const String connectionChannelId = "hello";
        const int connectionLocalUid = 10;
        const RtcConnection connection = RtcConnection(
          channelId: connectionChannelId,
          localUid: connectionLocalUid,
        );
        const int remoteUid = 10;
        const int streamId = 10;
        Uint8List data = Uint8List.fromList([1, 2, 3, 4, 5]);
        const int length = 0;
        const int sentTs = 10;

        final eventJson = {
          'connection': connection.toJson(),
          'remoteUid': remoteUid,
          'streamId': streamId,
          // DO not pass data to the event, since it is treated as intptr in iris. But we does not want to adpot this logic.
          // 'data': data.toList(),
          'length': length,
          'sentTs': sentTs,
        };

        final eventIds =
            eventIdsMapping['RtcEngineEventHandler_onStreamMessage'] ?? [];
        for (final event in eventIds) {
          final ret = irisTester().fireEvent(event, params: eventJson);
          // Delay 200 milliseconds to ensure the callback is called.
          await Future.delayed(const Duration(milliseconds: 200));
          // TODO(littlegnal): Most of callbacks on web are not implemented, we're temporarily skip these callbacks at this time.
          if (kIsWeb && ret) {
            if (!onStreamMessageCompleter.isCompleted) {
              onStreamMessageCompleter.complete(true);
            }
          }
        }
      }

      final eventCalled = await onStreamMessageCompleter.future;
      expect(eventCalled, isTrue);

      {
        rtcEngine.unregisterEventHandler(
          theRtcEngineEventHandler,
        );
      }
// Delay 500 milliseconds to ensure the unregisterEventHandler call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      await rtcEngine.release();
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );

  testWidgets(
    'RtcEngineEventHandler.onErrorWithUnkownError',
    (WidgetTester tester) async {
      RtcEngine rtcEngine = createAgoraRtcEngine();
      await rtcEngine.initialize(RtcEngineContext(
        appId: 'app_id',
        areaCode: AreaCode.areaCodeGlob.value(),
      ));
      await rtcEngine.setParameters('{"rtc.enable_debug_log": true}');

      final theRtcEngineEventHandler = RtcEngineEventHandler(
        onError: (ErrorCodeType err, String msg) {
          // do nothing, we just to make sure no exception thrown.
        },
      );

      rtcEngine.registerEventHandler(
        theRtcEngineEventHandler,
      );

      // Delay 500 milliseconds to ensure the registerEventHandler call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      {
        String msg = "hello";

        final eventJson = {
          'err': 9999999, // un existing error code.
          'msg': msg,
        };

        final eventIds = eventIdsMapping['RtcEngineEventHandler_onError'] ?? [];
        for (final event in eventIds) {
          final ret = irisTester().fireEvent(event, params: eventJson);
          // Delay 1000 milliseconds to ensure the callback is called.
          await Future.delayed(const Duration(milliseconds: 1000));
        }
      }

      {
        rtcEngine.unregisterEventHandler(
          theRtcEngineEventHandler,
        );
      }
      // Delay 500 milliseconds to ensure the unregisterEventHandler call completed.
      await Future.delayed(const Duration(milliseconds: 500));

      await rtcEngine.release();
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
