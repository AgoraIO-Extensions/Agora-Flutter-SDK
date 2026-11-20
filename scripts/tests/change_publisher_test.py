import io
from pathlib import Path
import shutil
import subprocess
import tarfile
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]


class PublisherConversion(unittest.TestCase):
    def test_apple_packages_and_ci_follow_the_published_plugin_name(self):
        archive = subprocess.check_output(['git', 'archive', 'HEAD'], cwd=ROOT)
        with tempfile.TemporaryDirectory() as directory:
            checkout = Path(directory)
            with tarfile.open(fileobj=io.BytesIO(archive)) as files:
                files.extractall(checkout, filter='data')
            shutil.copyfile(ROOT / 'scripts/change_publisher.sh', checkout / 'scripts/change_publisher.sh')
            for _ in range(2):
                result = subprocess.run(['bash', 'scripts/change_publisher.sh'], cwd=checkout,
                                        capture_output=True, text=True)
                self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                for platform in ['ios', 'macos']:
                    package = checkout / platform / 'shengwang_rtc_engine'
                    self.assertFalse((checkout / platform / 'agora_rtc_engine').exists())
                    manifest = (package / 'Package.swift').read_text()
                    self.assertIn('name: "shengwang_rtc_engine"', manifest)
                    self.assertIn('name: "shengwang-rtc-engine"', manifest)
                    self.assertTrue((package / 'Sources/shengwang_rtc_engine').is_dir())
                    self.assertTrue((package / 'Sources/shengwang_rtc_engine/include/shengwang_rtc_engine').is_dir())
                    spec = (checkout / platform / 'shengwang_rtc_engine.podspec').read_text()
                    self.assertIn("'shengwang_rtc_engine/Sources/", spec)
                    for link in package.rglob('*'):
                        if link.is_symlink():
                            self.assertTrue(link.exists(), str(link))
                workflow = (checkout / '.github/workflows/run_build_example.yml').read_text()
                self.assertIn('shengwang_rtc_engine_example_', workflow)
                updater = (checkout / 'ci/update_spm_deps.mjs').read_text()
                self.assertIn('ios/shengwang_rtc_engine/Package.swift', updater)
                self.assertIn('macos/shengwang_rtc_engine/Package.swift', updater)
                linkage = checkout / 'ci/run_apple_dependency_linkage.sh'
                if linkage.exists():
                    self.assertNotIn('agora_rtc_engine', linkage.read_text())


if __name__ == '__main__':
    unittest.main()
