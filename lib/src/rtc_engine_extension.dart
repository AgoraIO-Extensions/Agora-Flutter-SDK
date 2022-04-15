import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'classes.dart';
import 'impl/rtc_engine_impl.dart';
import 'rtc_engine.dart';

// ignore_for_file: non_constant_identifier_names

class _Rect extends Struct {
  @Double()
  external double x;
  @Double()
  external double y;
  @Double()
  external double width;
  @Double()
  external double height;

  Rectangle toRectangle() {
    return Rectangle(
      x: x.toInt(),
      y: y.toInt(),
      width: width.toInt(),
      height: height.toInt(),
    );
  }
}

class _Display extends Struct {
  @Uint32()
  external int id;
  @Float()
  external double scale;
  external _Rect bounds;
  external _Rect work_area;
  @Int32()
  external int rotation;
}

/// @nodoc
class Display {
  /// @nodoc
  int id;

  /// @nodoc
  double scale;

  /// @nodoc
  Rectangle bounds;

  /// @nodoc
  Rectangle workArea;

  /// @nodoc
  int rotation;

  Display._(this.id, this.scale, this.bounds, this.workArea, this.rotation);

  /// @nodoc
  factory Display.from(_Display _display) => Display._(
      _display.id,
      _display.scale,
      _display.bounds.toRectangle(),
      _display.work_area.toRectangle(),
      _display.rotation);
}

class _DisplayCollection extends Struct {
  external Pointer<_Display> displays;
  @Uint32()
  external int length;
}

const _kBasicResultLength = 512;

class _Window extends Struct {
  @Uint32()
  external int id;
  @Array(_kBasicResultLength)
  external Array<Uint8> name;
  @Array(_kBasicResultLength)
  external Array<Uint8> owner_name;
  external _Rect bounds;
  external _Rect work_area;
}

/// @nodoc
class Window {
  /// @nodoc
  int id;

  /// @nodoc
  String name;

  /// @nodoc
  String ownerName;

  /// @nodoc
  Rectangle bounds;

  /// @nodoc
  Rectangle workArea;

  Window._(this.id, this.name, this.ownerName, this.bounds, this.workArea);

  /// @nodoc
  factory Window.from(_Window _window) {
    final name =
        utf8.decode(Iterable<int>.generate(_kBasicResultLength, (index) {
      return _window.name[index];
    }).where((element) => element != 0).toList());
    final owner_name =
        utf8.decode(Iterable<int>.generate(_kBasicResultLength, (index) {
      return _window.owner_name[index];
    }).where((element) => element != 0).toList());
    return Window._(_window.id, name, owner_name, _window.bounds.toRectangle(),
        _window.work_area.toRectangle());
  }
}

class _WindowCollection extends Struct {
  external Pointer<_Window> windows;
  @Uint32()
  external int length;
}

final DynamicLibrary _nativeLib = Platform.isMacOS
    ? DynamicLibrary.process()
    : DynamicLibrary.open('AgoraRtcWrapper.dll');

final Pointer<_DisplayCollection> Function() _EnumerateDisplays = _nativeLib
    .lookup<NativeFunction<Pointer<_DisplayCollection> Function()>>(
        'EnumerateDisplays')
    .asFunction();

final void Function(Pointer<_DisplayCollection>) _FreeDisplayCollection =
    _nativeLib
        .lookup<NativeFunction<Void Function(Pointer<_DisplayCollection>)>>(
            'FreeIrisDisplayCollection')
        .asFunction();

final Pointer<_WindowCollection> Function() _EnumerateWindows = _nativeLib
    .lookup<NativeFunction<Pointer<_WindowCollection> Function()>>(
        'EnumerateWindows')
    .asFunction();

final void Function(Pointer<_WindowCollection>) _FreeWindowCollection =
    _nativeLib
        .lookup<NativeFunction<Void Function(Pointer<_WindowCollection>)>>(
            'FreeIrisWindowCollection')
        .asFunction();

///
/// The RtcEngineExtension class.
///
///
extension RtcEngineExtension on RtcEngine {
  ///
  /// Gets the actual absolute path of the asset through the relative path of the asset.
  ///
  ///
  /// Param [assetPath] The resource path configured in the flutter -> assets field of pubspec.yaml, for example: assets/Sound_Horizon.mp3.
  ///
  /// **return** The actual path of the asset.
  ///
  Future<String?> getAssetAbsolutePath(String assetPath) {
    return RtcEngineImpl.methodChannel
        .invokeMethod('getAssetAbsolutePath', assetPath);
  }

  ///
  /// Enumerates the information of all the screens in the system.
  ///
  ///
  /// **return** The information of the screen for screen-sharing.
  ///
  List<Display> enumerateDisplays() {
    final list = <Display>[];
    final collection = _EnumerateDisplays();
    for (var i = 0; i < collection.ref.length; ++i) {
      final display = collection.ref.displays.elementAt(i).ref;
      list.add(Display.from(display));
    }
    _FreeDisplayCollection(collection);
    return list;
  }

  ///
  /// Enumerates the information of all the windows in the system.
  ///
  ///
  /// **return** The information of the window for screen-sharing.
  ///
  List<Window> enumerateWindows() {
    final list = <Window>[];
    final collection = _EnumerateWindows();
    for (var i = 0; i < collection.ref.length; ++i) {
      final window = collection.ref.windows.elementAt(i).ref;
      list.add(Window.from(window));
    }
    _FreeWindowCollection(collection);
    return list;
  }
}
