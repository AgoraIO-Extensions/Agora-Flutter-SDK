from pathlib import Path
import os
import subprocess
import sys
import tempfile
import unittest

from ci.check_apple_changes import needs_apple_packages


class AppleChangesTest(unittest.TestCase):
    def test_dart_docs_and_other_native_platforms_do_not_need_apple_archives(self):
        self.assertFalse(needs_apple_packages([
            "lib/src/agora_rtc_engine_impl.dart", "README.md", "docs/ios/guide.md",
            "test/unit_test.dart", "android/build.gradle", "windows/CMakeLists.txt",
        ]))

    def test_packaging_dependencies_layout_and_ci_changes_select_archives(self):
        for path in ("pubspec.yaml", ".pubignore", ".gitmodules", ".gitattributes",
                     "ios/native.mm", "macos/agora_rtc_engine.podspec",
                     "ios/agora_rtc_engine/Package.swift", "src/binding.cc",
                     "example/lib/main.dart", "test_shard/integration_test_swiftpm/lib/main.dart",
                     "ci/check_apple_changes.py", ".github/workflows/run_test.yml",
                     "test_shard/rendering_test/pubspec.yaml"):
            with self.subTest(path=path):
                self.assertTrue(needs_apple_packages([path]))

    def test_one_relevant_file_is_enough(self):
        self.assertTrue(needs_apple_packages(["README.md", "ios/deleted-file.mm"]))

    def test_cli_uses_nul_delimiters_and_writes_only_a_boolean_output(self):
        script = Path(__file__).with_name("check_apple_changes.py")
        for paths, expected in ((b"docs/file with\nnewline.md\0", b"apple_packages=false\n"),
                                (b"README.md\0ios/file with space.mm\0", b"apple_packages=true\n")):
            result = subprocess.run([sys.executable, str(script)], input=paths,
                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=True)
            self.assertEqual(result.stdout, expected)


class AppleRoutingTest(unittest.TestCase):
    def git(self, root, *args):
        return subprocess.check_output(
            ["git", "-c", "core.hooksPath=/dev/null", "-c", "commit.gpgSign=false", *args],
            cwd=root, stderr=subprocess.DEVNULL, text=True,
        ).strip()

    def select(self, root, base="", head="", full="false"):
        output = root / "output"
        env = dict(os.environ, BASE_SHA=base, HEAD_SHA=head, FULL_COMPATIBILITY=full,
                   GITHUB_OUTPUT=str(output), RUNNER_TEMP=str(root))
        script = Path(__file__).with_name("select_apple_checks.sh")
        subprocess.run(["bash", str(script.resolve())], cwd=root, env=env, check=True,
                       stdout=subprocess.PIPE, stderr=subprocess.PIPE, timeout=10)
        return output.read_text()

    def make_repo(self, root, path):
        self.git(root, "init", "-q")
        self.git(root, "config", "user.name", "CI fixture")
        self.git(root, "config", "user.email", "ci@example.invalid")
        source = root / path
        source.parent.mkdir(parents=True)
        source.write_text("before\n")
        self.git(root, "add", ".")
        self.git(root, "commit", "-qm", "base")
        self.git(root, "remote", "add", "origin", str(root))
        return self.git(root, "rev-parse", "HEAD")

    def test_dart_only_git_diff_skips_apple_archives(self):
        with tempfile.TemporaryDirectory(prefix="ci routing ") as directory:
            root = Path(directory)
            base = self.make_repo(root, "lib/api.dart")
            (root / "lib/api.dart").write_text("after\n")
            self.git(root, "commit", "-qam", "Dart change")
            head = self.git(root, "rev-parse", "HEAD")
            self.assertEqual(self.select(root, base, head), "apple_packages=false\n")

    def test_rename_out_of_ios_still_runs_apple_archives(self):
        with tempfile.TemporaryDirectory(prefix="ci routing ") as directory:
            root = Path(directory)
            base = self.make_repo(root, "ios/native.mm")
            (root / "docs").mkdir()
            self.git(root, "mv", "ios/native.mm", "docs/native.txt")
            self.git(root, "commit", "-qm", "Move native file")
            head = self.git(root, "rev-parse", "HEAD")
            self.assertEqual(self.select(root, base, head), "apple_packages=true\n")

    def test_missing_history_or_full_suite_runs_apple_archives(self):
        for base, head, full in (("a" * 40, "b" * 40, "false"), ("", "", "false"),
                                 ("a" * 40, "b" * 40, "true")):
            with self.subTest(full=full, history=bool(base)):
                with tempfile.TemporaryDirectory(prefix="ci routing ") as directory:
                    self.assertEqual(self.select(Path(directory), base, head, full),
                                     "apple_packages=true\n")


if __name__ == "__main__":
    unittest.main()
