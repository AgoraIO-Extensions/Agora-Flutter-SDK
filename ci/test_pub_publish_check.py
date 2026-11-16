import os
from pathlib import Path
import subprocess
import tempfile
import unittest


class PubPublishCheckTest(unittest.TestCase):
    def run_check(self, pubspec, dart_exit=0):
        with tempfile.TemporaryDirectory(prefix="pub check ") as directory:
            root = Path(directory)
            (root / "pubspec.yaml").write_text(pubspec)
            dart = root / "dart"
            dart.write_text("""#!/usr/bin/env python3
import os
from pathlib import Path
import sys
Path(os.environ['DART_CALL_LOG']).write_text(' '.join(sys.argv[1:]))
raise SystemExit(int(os.environ['DART_EXIT_CODE']))
""")
            dart.chmod(0o755)
            log = root / "dart-command"
            env = dict(os.environ, PATH=str(root) + os.pathsep + os.environ["PATH"],
                       DART_CALL_LOG=str(log), DART_EXIT_CODE=str(dart_exit))
            result = subprocess.run(
                ["bash", str(Path(__file__).with_name("dart_pub_publish_check.sh").resolve())],
                cwd=root, env=env, capture_output=True, text=True, timeout=15)
            return result, log.read_text() if log.exists() else None

    def test_tag_only_versions_skip_pub_even_without_a_changelog(self):
        for value in ("6.5.5-sp.4539", "'6.5.5-rc.1'", '"6.5.5+build.123"',
                      "6.5.5-sp.4539+build.2 # internal release"):
            with self.subTest(version=value):
                result, command = self.run_check("name: fixture\nversion: " + value + "\n", dart_exit=65)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertIn("Skipping pub.dev publication check", result.stdout)
                self.assertIsNone(command)

    def test_standard_versions_keep_the_publication_check_and_failures(self):
        for value in ("6.5.5", "'6.5.5' # public release"):
            for dart_exit in (0, 65):
                with self.subTest(version=value, dart_exit=dart_exit):
                    result, command = self.run_check("name: fixture\nversion: " + value + "\n", dart_exit)
                    self.assertEqual(result.returncode, 0 if dart_exit == 0 else 1, result.stderr)
                    self.assertEqual(command, "pub publish --dry-run")

    def test_missing_or_invalid_yaml_version_fails_before_pub(self):
        for pubspec in ("name: fixture\n", "version: ''\n", "version: null\n",
                        "version: [broken\n"):
            with self.subTest(pubspec=pubspec):
                result, command = self.run_check(pubspec)
                self.assertNotEqual(result.returncode, 0)
                self.assertIsNone(command)


if __name__ == "__main__":
    unittest.main()
