import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


class StartupSmokeCommandTest(unittest.TestCase):
    def run_case(self, platform, fail=False):
        with tempfile.TemporaryDirectory(prefix="SDK smoke ") as directory:
            root = Path(directory)
            (root / "ci").mkdir()
            source = Path(__file__).with_name("run_sdk_startup_smoke.sh")
            shutil.copy(source, root / "ci" / source.name)
            (root / "test_shard/integration_test_app").mkdir(parents=True)
            (root / "bin").mkdir()
            flutter = root / "bin/flutter"
            flutter.write_text("""#!/usr/bin/env python3
import json
import os
from pathlib import Path
import sys
args = sys.argv[1:]
with open(os.environ['COMMAND_LOG'], 'a') as output:
    output.write(json.dumps(args) + '\\n')
if args[:2] == ['build', 'windows']:
    path = Path('build/windows/x64/runner/Debug')
    path.mkdir(parents=True)
    (path / 'integration_test_app.exe').touch()
if args[:1] == ['test'] and os.environ['FAIL_SMOKE'] == 'true':
    raise SystemExit(7)
""")
            flutter.chmod(0o755)
            log = root / "commands"
            env = dict(os.environ, PATH=str(root / "bin") + os.pathsep + os.environ["PATH"],
                       TEST_APP_ID="smoke-fixture", COMMAND_LOG=str(log),
                       FAIL_SMOKE=str(fail).lower())
            result = subprocess.run(["bash", str(root / "ci" / source.name), platform],
                                    env=env, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                    timeout=15)
            commands = [json.loads(line) for line in log.read_text().splitlines()] if log.exists() else []
            return result, commands

    def test_native_platforms_run_one_startup_target(self):
        for platform in ("android", "macos", "windows"):
            with self.subTest(platform=platform):
                result, commands = self.run_case(platform)
                self.assertEqual(result.returncode, 0, result.stdout)
                tests = [command for command in commands if command[:1] == ["test"]]
                self.assertEqual(len(tests), 1)
                self.assertEqual(tests[0][1], "integration_test/smoke/sdk_startup_test.dart")
                if platform in ("macos", "windows"):
                    self.assertEqual(tests[0][-2:], ["-d", platform])

    def test_real_sdk_failure_is_propagated_without_retry(self):
        result, commands = self.run_case("android", fail=True)
        self.assertEqual(result.returncode, 7, result.stdout)
        self.assertEqual(sum(command[:1] == ["test"] for command in commands), 1)

    def test_unknown_platform_fails_before_running_flutter(self):
        result, commands = self.run_case("unknown")
        self.assertEqual(result.returncode, 2, result.stdout)
        self.assertEqual(commands, [])


if __name__ == "__main__":
    unittest.main()
