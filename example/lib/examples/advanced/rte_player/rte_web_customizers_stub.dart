/// Stub for non-web platforms. Never called at runtime (guarded by kIsWeb).
class RteWebCustomizers {
  RteWebCustomizers._();

  static void wrapper(dynamic wrapper) {}
  static void style(dynamic style, String wrapperId) {}
  static void video(dynamic video) {}
}
