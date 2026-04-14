import 'package:agora_rtc_engine_example/components/log_sink.dart';
import 'package:flutter/material.dart';

import 'concurrent_modification_demo_logic.dart';

class IrisMethodChannelConcurrentModificationRepro extends StatefulWidget {
  const IrisMethodChannelConcurrentModificationRepro({Key? key})
      : super(key: key);

  @override
  State<IrisMethodChannelConcurrentModificationRepro> createState() =>
      _IrisMethodChannelConcurrentModificationReproState();
}

class _IrisMethodChannelConcurrentModificationReproState
    extends State<IrisMethodChannelConcurrentModificationRepro> {
  ConcurrentModificationDemoResult? _legacyResult;
  ConcurrentModificationDemoResult? _snapshotResult;

  void _runLegacy() {
    final result = runLegacyConcurrentModificationDemo();
    setState(() {
      _legacyResult = result;
    });
    for (final error in result.errors) {
      logSink.log('[LegacyRepro] $error');
    }
  }

  void _runSnapshot() {
    final result = runSnapshotConcurrentModificationDemo();
    setState(() {
      _snapshotResult = result;
    });
    if (result.errors.isEmpty) {
      logSink.log('[SnapshotRepro] no exception');
    } else {
      for (final error in result.errors) {
        logSink.log('[SnapshotRepro] $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Legacy repro simulates the old iteration pattern and will throw '
            'ConcurrentModificationError when the handler removes itself.',
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ElevatedButton(
                onPressed: _runLegacy,
                child: const Text('Run Legacy Repro'),
              ),
              ElevatedButton(
                onPressed: _runSnapshot,
                child: const Text('Run Snapshot Repro'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Legacy handled: ${_legacyResult?.handled ?? false}, '
            'errors: ${_legacyResult?.errors.length ?? 0}, '
            'has ConcurrentModificationError: '
            '${_legacyResult?.hasConcurrentModificationError ?? false}',
          ),
          if ((_legacyResult?.errors.isNotEmpty ?? false))
            Text(_legacyResult!.errors.first.toString()),
          const SizedBox(height: 12),
          Text(
            'Snapshot handled: ${_snapshotResult?.handled ?? false}, '
            'errors: ${_snapshotResult?.errors.length ?? 0}, '
            'has ConcurrentModificationError: '
            '${_snapshotResult?.hasConcurrentModificationError ?? false}',
          ),
          if ((_snapshotResult?.errors.isNotEmpty ?? false))
            Text(_snapshotResult!.errors.first.toString()),
        ],
      ),
    );
  }
}
