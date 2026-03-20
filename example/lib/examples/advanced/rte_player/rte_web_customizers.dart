import 'package:web/web.dart' as web;

/// Web-only customizers for AgoraRteVideoView elements.
/// Cast `dynamic` params to concrete web types for full property access.
class RteWebCustomizers {
  RteWebCustomizers._();

  /// Customize wrapper div: border-radius, background, etc.
  static void wrapper(dynamic wrapper) {
    final el = wrapper as web.HTMLDivElement;
    el.style.borderRadius = '8px';
    // el.style.border = '2px solid red';
    // el.style.backgroundColor = '#1a1a1a';
    // el.style.boxShadow = '0 4px 12px rgba(0,0,0,0.3)';
  }

  /// Customize style element: full HTMLStyleElement access.
  /// Default CSS is already set on textContent before this is called.
  static void style(dynamic style, String wrapperId) {
    final el = style as web.HTMLStyleElement;
    // Replace default CSS — use cover instead of contain
    /**
     * cover
     * contain
     * fill
     * scale-down
     */
    
    el.textContent = '''
      #$wrapperId > video {
        width: 100% !important;
        height: 100% !important;
        position: absolute !important;
        top: 0 !important;
        left: 0 !important;
        object-fit: scale-down !important;
      }
    ''';
    // el.media = 'screen and (max-width: 600px)';
    // el.disabled = true;
  }

  /// Customize video element: controls, poster, muted, etc.
  static void video(dynamic video) {
    final el = video as web.HTMLVideoElement;
    el.controls = false;
    // el.muted = true;
    // el.poster = 'https://example.com/poster.jpg';
    // el.style.filter = 'brightness(0.9)';
  }
}
