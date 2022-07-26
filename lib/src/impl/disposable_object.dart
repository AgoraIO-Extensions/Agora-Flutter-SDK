abstract class AsyncDisposableObject {
  Future<void> disposeAsync();
}

abstract class DisposableObject {
  void dispose();
}
