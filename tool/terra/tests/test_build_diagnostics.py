"""Exercise the real generation script without running Terra or installing deps."""
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest

BUILD = Path(__file__).resolve().parents[1] / 'build.sh'


class BuildDiagnosticsTest(unittest.TestCase):
    def run_build(self, output, status=0):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            terra = root / 'tool' / 'terra'
            terra.mkdir(parents=True)
            shutil.copyfile(BUILD, terra / 'build.sh')
            (terra / 'prepare.sh').write_text('exit 0\n')
            (terra / 'toolchain.sh').write_text('return 0\n')
            (terra / 'stage_headers.py').write_text('pass\n')
            (terra / 'terra_config_main.yaml').write_text('headers: rtc_4.5.3.8\n')
            bins = root / 'bin'
            bins.mkdir()
            (bins / 'npm').write_text('#!/bin/bash\nprintf "%s\\n" "$TEST_OUTPUT"\nexit "$TEST_STATUS"\n')
            (bins / 'dart').write_text('#!/bin/bash\ntouch "$DART_CALLED"\n')
            for name in ['npm', 'dart']:
                (bins / name).chmod(0o755)
            called = root / 'formatted'
            result = subprocess.run(['bash', str(terra / 'build.sh'), 'rtc_4.5.3.8'],
                env={**os.environ, 'PATH': str(bins) + os.pathsep + os.environ['PATH'],
                     'TEST_OUTPUT': output, 'TEST_STATUS': str(status), 'DART_CALLED': str(called)},
                stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True)
            return result.returncode, called.exists()

    def test_parser_errors_block_zero_exit_and_formatting(self):
        for diagnostic in ['[libclang] [error] unknown type name __decay',
                           '[libclang parser] [fatal] invalid header', '20 errors generated.']:
            with self.subTest(diagnostic=diagnostic):
                self.assertEqual(self.run_build(diagnostic), (1, False))

    def test_nonzero_terra_exit_is_not_hidden_by_tee(self):
        self.assertEqual(self.run_build('failed', 7), (1, False))

    def test_warning_and_clean_generation_can_continue(self):
        for output in ['[libclang] [warning] ignored attribute', 'generation complete']:
            with self.subTest(output=output):
                self.assertEqual(self.run_build(output), (0, True))


if __name__ == '__main__':
    unittest.main()
