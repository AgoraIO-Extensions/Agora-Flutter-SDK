import os
from pathlib import Path
import re
import subprocess
import sys
import unittest


class VmServiceWatchdogTest(unittest.TestCase):
    def run_child(self, code):
        script = Path(__file__).with_name("flutter_vm_service_watchdog.py")
        return subprocess.run(
            [sys.executable, str(script), "--timeout", "0.15", "--",
             sys.executable, "-u", "-c", code],
            stdout=subprocess.PIPE, stderr=subprocess.STDOUT, timeout=5,
        )

    def test_only_discovery_wait_is_bounded_and_process_exits(self):
        result = self.run_child(
            "import time; print('Waiting for VM Service port to be available...'); time.sleep(20)"
        )
        self.assertEqual(result.returncode, 124, result.stdout)
        self.assertIn(b"VM_SERVICE_DISCOVERY_TIMEOUT", result.stdout)
        pid = int(re.search(rb"pid=(\d+)", result.stdout).group(1))
        with self.assertRaises(ProcessLookupError):
            os.kill(pid, 0)

    def test_connected_tests_keep_running_beyond_discovery_timeout(self):
        result = self.run_child(
            "import time; print('Waiting for VM Service port to be available...'); "
            "print('VM Service URL on device: http://127.0.0.1:1234/'); time.sleep(0.5)"
        )
        self.assertEqual(result.returncode, 0, result.stdout)

    def test_repeated_waiting_messages_do_not_extend_the_deadline(self):
        result = self.run_child(
            "import time\nfor _ in range(20):\n"
            " print('Waiting for VM Service port to be available...'); time.sleep(0.05)"
        )
        self.assertEqual(result.returncode, 124, result.stdout)

    def test_real_command_failure_is_propagated(self):
        result = self.run_child("raise SystemExit(7)")
        self.assertEqual(result.returncode, 7, result.stdout)


if __name__ == "__main__":
    unittest.main()
