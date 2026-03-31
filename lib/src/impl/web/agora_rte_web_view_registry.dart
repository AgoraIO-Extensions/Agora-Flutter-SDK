import 'package:web/web.dart' as web;

/// Global registry mapping viewPtr (int key) to HTMLElement.
/// AgoraRteVideoView registers elements here; AgoraRteCanvasWebImpl reads them.
class AgoraRteWebViewRegistry {
  AgoraRteWebViewRegistry._();

  static final Map<int, web.HTMLElement> _registry = {};

  static void register(int key, web.HTMLElement element) {
    _registry[key] = element;
  }

  static web.HTMLElement? get(int key) => _registry[key];

  static void unregister(int key) => _registry.remove(key);
}
