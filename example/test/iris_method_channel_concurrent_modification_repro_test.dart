import 'package:agora_rtc_engine_example/examples/advanced/iris_method_channel_concurrent_modification_repro/concurrent_modification_demo_logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('legacy iteration throws ConcurrentModificationError on self-unregister',
      () {
    final result = runLegacyConcurrentModificationDemo();

    expect(result.handled, isTrue);
    expect(result.hasConcurrentModificationError, isTrue);
  });

  test('snapshot iteration does not throw on self-unregister', () {
    final result = runSnapshotConcurrentModificationDemo();

    expect(result.handled, isTrue);
    expect(result.hasConcurrentModificationError, isFalse);
  });
}
