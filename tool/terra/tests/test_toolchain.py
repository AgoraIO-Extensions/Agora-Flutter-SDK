"""Verify both AST compilers use one SDK despite inherited include overrides."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

TOOLCHAIN = Path(__file__).resolve().parents[1] / 'toolchain.sh'


class ToolchainTest(unittest.TestCase):
    def test_wrappers_pin_sdk_and_clear_include_overrides(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            bins = root / 'bin'
            bins.mkdir()
            llvm = root / 'llvm'
            (llvm / 'bin').mkdir(parents=True)
            (llvm / 'include/c++/v1').mkdir(parents=True)
            (llvm / 'include/c++/v1/vector').touch()
            scripts = {
                bins / 'uname': 'echo Darwin',
                bins / 'brew': 'echo "$TEST_LLVM"',
                bins / 'xcrun': 'echo "$TEST_SDK"',
                llvm / 'bin/clang': 'printf "%s\\n" "$@"',
                llvm / 'bin/clang++': 'printf "%s\\n" "$@"',
            }
            for path, script in scripts.items():
                path.write_text('#!/bin/bash\n' + script + '\n')
                path.chmod(0o755)
            result = subprocess.run(['bash', '-c',
                'set -e; source "$1"; '
                'test -z "${SDKROOT+x}${CPATH+x}${C_INCLUDE_PATH+x}${CPLUS_INCLUDE_PATH+x}"; '
                'clang input.c; clang++ input.cc; rm -r "$terra_compiler_dir"',
                'test', str(TOOLCHAIN)],
                env={**os.environ, 'PATH': str(bins) + os.pathsep + os.environ['PATH'],
                     'TEST_LLVM': str(llvm), 'TEST_SDK': str(root / 'selected SDK'),
                     **dict.fromkeys(['SDKROOT', 'CPATH', 'C_INCLUDE_PATH', 'CPLUS_INCLUDE_PATH'], '/wrong-sdk')},
                capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout.count('-isysroot\n' + str(root / 'selected SDK') + '\n'), 3)
            self.assertIn('input.c\n', result.stdout)
            self.assertIn('input.cc\n', result.stdout)


if __name__ == '__main__':
    unittest.main()
