export '/src/impl/platform/agora_pip_controller_expect.dart'
    if (dart.library.io) '/src/impl/platform/io/agora_pip_controller_actual_io.dart'
    if (dart.library.js) '/src/impl/platform/web/agora_pip_controller_actual_web.dart';
