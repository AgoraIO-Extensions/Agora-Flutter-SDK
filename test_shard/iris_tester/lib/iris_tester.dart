export 'src/platform/iris_tester_expect.dart'
    if (dart.library.io) 'src/platform/io/iris_tester_actual_io.dart'
    if (dart.library.js) 'src/platform/web/iris_tester_actual_web.dart';

export 'src/platform/iris_tester_interface.dart';
