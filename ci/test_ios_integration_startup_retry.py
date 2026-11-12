import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


class IosIntegrationStartupTest(unittest.TestCase):
    def run_case(self, mode, smoke=False):
        with tempfile.TemporaryDirectory(prefix="ios startup ") as directory:
            root = Path(directory)
            ci = root / "ci"
            ci.mkdir()
            for name in ("run_flutter_integration_test_ios.sh", "flutter_vm_service_watchdog.py",
                         "run_sdk_startup_smoke.sh"):
                shutil.copy(Path(__file__).with_name(name), ci / name)
            tests = root / "test_shard/integration_test_app/integration_test"
            tests.mkdir(parents=True)
            (tests / "case.dart").write_text("// Test fixture.\n")
            (tests / "smoke").mkdir()
            (tests / "smoke/sdk_startup_test.dart").write_text("// Startup fixture.\n")
            commands = root / "bin"
            commands.mkdir()
            flutter = commands / "flutter"
            flutter.write_text("""#!/usr/bin/env python3
import os
from pathlib import Path
import sys
if sys.argv[1:3] == ['packages', 'get']:
    raise SystemExit(0)
counter = Path(os.environ['ATTEMPT_COUNT'])
attempt = int(counter.read_text()) + 1 if counter.exists() else 1
counter.write_text(str(attempt))
with open(os.environ['TARGET_LOG'], 'a') as output:
    output.write(sys.argv[2] + '\\n')
mode = os.environ['FAILURE_MODE']
if mode == 'test_failure':
    raise SystemExit(7)
if mode == 'timeout_always' or (mode == 'timeout_once' and attempt == 1):
    # The watchdog's real timer/process termination has separate unit coverage.
    raise SystemExit(124)
if mode == 'log_reader_once' and attempt == 1:
    print('Error waiting for a debug connection: The log reader failed unexpectedly')
    raise SystemExit(1)
""")
            xcrun = commands / "xcrun"
            xcrun.write_text('#!/bin/sh\nprintf "%s\\n" "$*" >> "$TERMINATION_LOG"\n')
            pause = commands / "sleep"
            pause.write_text("#!/bin/sh\nexit 0\n")
            for command in (flutter, xcrun, pause):
                command.chmod(0o755)
            counter = root / "attempts"
            terminated = root / "terminated"
            env = dict(os.environ, PATH=str(commands) + os.pathsep + os.environ["PATH"],
                       IOS_TEST_MAX_ATTEMPTS="3", TEST_APP_ID="test-app-id",
                       FAILURE_MODE=mode, ATTEMPT_COUNT=str(counter),
                       TERMINATION_LOG=str(terminated), TARGET_LOG=str(root / "targets"))
            command = (["bash", str(ci / "run_sdk_startup_smoke.sh"), "ios"] if smoke
                       else ["bash", str(ci / "run_flutter_integration_test_ios.sh")])
            result = subprocess.run(
                command,
                env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=15,
            )
            self.targets = (root / "targets").read_text().splitlines()
            return result, int(counter.read_text()), (
                terminated.read_text().splitlines() if terminated.exists() else []
            )

    def test_discovery_timeout_retries_and_terminates_the_app(self):
        result, attempts, terminated = self.run_case("timeout_once")
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(attempts, 2)
        self.assertEqual(terminated, [
            "simctl terminate booted io.agora.integrationtestapp.integrationTestApp"
        ])

    def test_real_test_failure_is_not_retried(self):
        result, attempts, terminated = self.run_case("test_failure")
        self.assertEqual(result.returncode, 7, result.stdout)
        self.assertEqual(attempts, 1)
        self.assertEqual(terminated, [])

    def test_exhausted_startup_attempts_still_fail(self):
        result, attempts, terminated = self.run_case("timeout_always")
        self.assertEqual(result.returncode, 124, result.stdout)
        self.assertEqual(attempts, 3)
        self.assertEqual(len(terminated), 3)

    def test_existing_log_reader_failure_remains_retryable(self):
        result, attempts, _ = self.run_case("log_reader_once")
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(attempts, 2)

    def test_smoke_runs_only_the_requested_startup_target(self):
        result, attempts, _ = self.run_case("success", smoke=True)
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertEqual(attempts, 1)
        self.assertEqual(self.targets, ["integration_test/smoke/sdk_startup_test.dart"])

    def test_smoke_sdk_failure_is_not_retried(self):
        result, attempts, _ = self.run_case("test_failure", smoke=True)
        self.assertEqual(result.returncode, 7, result.stdout)
        self.assertEqual(attempts, 1)


if __name__ == "__main__":
    unittest.main()
