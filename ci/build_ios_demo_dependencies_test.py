import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[1]
WORKFLOW = ROOT / '.github/workflows/run_build_example.yml'
SCRIPT = ROOT / 'ci/build_ios_demo_dependencies.sh'

FAKE_COMMAND = '''#!/usr/bin/env python3
import json, os, sys
from pathlib import Path
root = Path(os.environ['DEMO_TEST_ROOT'])
plugin = os.environ.get('DEMO_TEST_PLUGIN_NAME', 'agora_rtc_engine')
args = sys.argv[1:]
command = Path(sys.argv[0]).name
mode_file = root / 'mode'
mode = mode_file.read_text() if mode_file.exists() else ''
with (root / 'calls').open('a') as log:
    log.write(json.dumps([command, mode, args]) + '\\n')
if command == 'pod':
    sys.exit(0)
if args[0] == 'config':
    mode_file.write_text('cocoapods' if args[1].startswith('--no-') else 'swiftpm')
elif args[0] == 'clean':
    import shutil
    shutil.rmtree('build', ignore_errors=True)
elif args[0] == 'build':
    if os.environ.get('DEMO_TEST_FAILURE') == mode:
        print('checksum mismatch' if mode == 'swiftpm' else 'CocoaPods build failed')
        sys.exit(42)
    if mode == 'swiftpm':
        assert not Path('ios/Pods').exists(), 'CocoaPods frameworks leaked into SwiftPM'
        assert not Path('ios/Podfile.lock').exists(), 'CocoaPods lockfile was reused'
    if mode == 'cocoapods' or os.environ.get('DEMO_TEST_FALLBACK'):
        Path('ios/Pods').mkdir(exist_ok=True)
        Path('ios/Podfile.lock').write_text(f'  - {plugin} (6.6.4):\\n  - iris_method_channel (2.2.6):\\n')
    if mode == 'swiftpm' and os.environ.get('DEMO_TEST_MISSING_PACKAGE') != '1':
        manifest = Path('ios/Flutter/ephemeral/Packages/FlutterGeneratedPluginSwiftPackage/Package.swift')
        manifest.parent.mkdir(parents=True, exist_ok=True)
        manifest.write_text(f'.package(name: "{plugin}", path: "a"),\\n.package(name: "iris_method_channel", path: "b"),\\n')
    output = Path('build/ios/iphoneos/Runner.app/Runner')
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(mode)
'''


def workflow():
    return json.loads(subprocess.check_output([
        'ruby', '--disable-gems', '-ryaml', '-rjson', '-e',
        'puts YAML.load_file(ARGV[0]).to_json', str(WORKFLOW),
    ], text=True))


class DemoDependencyChecks(unittest.TestCase):
    def run_checks(self, **overrides):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            example = root / 'example'
            (example / 'ios').mkdir(parents=True)
            (example / 'ios/Podfile').touch()
            (example / 'pubspec.yaml').touch()
            plugin = overrides.get('DEMO_TEST_PLUGIN_NAME', 'agora_rtc_engine')
            (root / 'pubspec.yaml').write_text(f'name: {plugin}\n')
            (root / 'bin').mkdir()
            for command in ['flutter', 'pod']:
                stub = root / 'bin' / command
                stub.write_text(FAKE_COMMAND)
                stub.chmod(0o755)
            env = dict(os.environ, PATH=str(root / 'bin') + os.pathsep + os.environ['PATH'],
                       DEMO_TEST_ROOT=str(root), GITHUB_STEP_SUMMARY=str(root / 'summary'), **overrides)
            result = subprocess.run(['bash', str(SCRIPT), '--dart-define=TEST_APP_ID=test'],
                                    cwd=example, env=env, capture_output=True, text=True)
            calls = [json.loads(line) for line in (root / 'calls').read_text().splitlines()]
            output = example / 'build/ios/iphoneos/Runner.app/Runner'
            return result, calls, output.read_text() if output.exists() else None

    def test_both_managers_build_and_leave_only_swiftpm_app(self):
        result, calls, app = self.run_checks()
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        builds = [call for call in calls if call[0] == 'flutter' and call[2][0] == 'build']
        self.assertEqual([call[1] for call in builds], ['cocoapods', 'swiftpm'])
        self.assertTrue(all('--dart-define=TEST_APP_ID=test' in call[2] for call in builds))
        self.assertTrue(any(call[0] == 'pod' and call[2] == ['deintegrate'] for call in calls))
        self.assertEqual(app, 'swiftpm')

    def test_shengwang_plugin_is_checked_using_its_pubspec_name(self):
        result, _, app = self.run_checks(DEMO_TEST_PLUGIN_NAME='shengwang_rtc_engine')
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
        self.assertEqual(app, 'swiftpm')

    def test_cocoapods_failure_stops_before_swiftpm(self):
        result, calls, app = self.run_checks(DEMO_TEST_FAILURE='cocoapods')
        self.assertEqual(result.returncode, 42)
        self.assertFalse(any(call[1] == 'swiftpm' for call in calls))
        self.assertIsNone(app)

    def test_checksum_failure_leaves_no_previous_app_to_archive(self):
        result, _, app = self.run_checks(DEMO_TEST_FAILURE='swiftpm')
        self.assertEqual(result.returncode, 42)
        self.assertIn('checksum mismatch', result.stdout)
        self.assertIsNone(app)

    def test_swiftpm_fallback_is_rejected_even_with_generated_manifest(self):
        result, _, _ = self.run_checks(DEMO_TEST_FALLBACK='1')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('unexpectedly fell back to CocoaPods', result.stdout)

    def test_missing_swiftpm_plugin_manifest_is_rejected(self):
        result, _, _ = self.run_checks(DEMO_TEST_MISSING_PACKAGE='1')
        self.assertNotEqual(result.returncode, 0)
        self.assertIn('not integrated through SwiftPM', result.stdout)

    def test_ios_uses_swiftpm_capable_flutter_without_changing_android(self):
        step = workflow()['jobs']['build-matrix']['steps'][0]
        with tempfile.NamedTemporaryFile() as output:
            env = dict(os.environ, platforms='["ios","android"]', flutter_versions='3.24.5,3.38.5',
                       ios_flutter_version='3.44.4', app_id_secrets='MY_APP_ID', GITHUB_OUTPUT=output.name)
            result = subprocess.run(['bash', '-c', step['run']], env=env, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            rows = json.loads(Path(output.name).read_text().removeprefix('include='))
        self.assertEqual([(row['platform'], row['version']) for row in rows],
                         [('ios', '3.44.4'), ('android', '3.24.5'), ('android', '3.38.5')])


if __name__ == '__main__':
    unittest.main()
