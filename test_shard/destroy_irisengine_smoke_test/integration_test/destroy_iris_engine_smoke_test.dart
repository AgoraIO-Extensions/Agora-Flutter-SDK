import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:destroy_irisengine_smoke_test/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MethodChannel awaitPageCloseChannel;
  Completer? pageClosedCompleter;

    // final channel = const MethodChannel('smoke_test_channel');

  setUp(() {
    pageClosedCompleter = Completer();
    awaitPageCloseChannel = const MethodChannel('await_page_close_channel');
    awaitPageCloseChannel.setMethodCallHandler((call) async {
      if (call.method == "page_closed") {
        debugPrint('page_closed');
        await Future.delayed(Duration(seconds: 3));
        pageClosedCompleter?.complete(null);
        return true;
      }

      return false;
    });
  });

  testWidgets('Destroy iris engine smoke test', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    debugPrint('taptaptaptaptp');
    // await tester.tap(find.text('Open page'));
    // await tester.pump();
    await tester.pumpAndSettle();

    // await Future.delayed(Duration(seconds: 5));

    // await channel.invokeMethod('open_page');

    debugPrint('ppppppppppppppppppp');

    // await pageClosedCompleter?.future;

    await Future.delayed(Duration(seconds: 30));
  });
}
