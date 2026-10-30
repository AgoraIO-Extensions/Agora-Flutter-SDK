import importlib.util
from pathlib import Path
import tempfile
import unittest

spec = importlib.util.spec_from_file_location('stage_headers', Path(__file__).resolve().parents[1] / 'stage_headers.py')
module = importlib.util.module_from_spec(spec)
spec.loader.exec_module(module)

HEADER = '''struct ScreenAudioParameters {
 int sampleRate;
 int channels;
 int captureSignalVolume;
#if defined(__APPLE__) && !TARGET_OS_IOS
 bool excludeCurrentProcessAudio = true;
 ScreenAudioParameters(): sampleRate(48000), channels(2), captureSignalVolume(100) {}
#else
 ScreenAudioParameters(): sampleRate(16000), channels(2), captureSignalVolume(100) {}
#endif
};
'''


class StageHeadersTest(unittest.TestCase):
    def test_staging_preserves_sdk_and_fields(self):
        with tempfile.TemporaryDirectory() as folder:
            root = Path(folder)
            sdk = root / 'sdk' / 'headers' / 'rtc_4.5.3.8' / 'include'
            sdk.mkdir(parents=True)
            original = sdk / 'AgoraBase.h'
            original.write_text(HEADER)
            (sdk / 'IAgoraLog.h').write_text('#pragma once\n#ifndef OPTIONAL_ENUM_CLASS\n#define OPTIONAL_ENUM_CLASS enum class\n#endif\n')
            (sdk / 'IAudioDeviceManager.h').write_text('#pragma once\nclass IAudioDeviceManager : public RefCountInterface {};\n')
            output = root / 'staged'
            module.stage(root / 'sdk', 'rtc_4.5.3.8', output)
            result = (output / 'include' / 'AgoraBase.h').read_text()
            self.assertEqual(original.read_text(), HEADER)
            self.assertEqual(result.count('ScreenAudioParameters()'), 1)
            self.assertTrue((output / 'include' / 'IAgoraLog.h').read_text().startswith('#define OPTIONAL_ENUM_CLASS enum\n'))
            self.assertTrue((output / 'include' / 'IAudioDeviceManager.h').read_text().startswith('#include "AgoraRefPtr.h"'))
            self.assertNotIn('#include "AgoraRefPtr.h"', (sdk / 'IAudioDeviceManager.h').read_text())
            for field in ['int sampleRate;', 'int channels;', 'int captureSignalVolume;', 'bool excludeCurrentProcessAudio = true;']:
                self.assertIn(field, result)

    def test_platform_screen_capture_constructors_keep_all_fields(self):
        text = """struct ScreenCaptureSourceInfo {
 int sourceId;
#if defined(_WIN32)
 bool minimizeWindow;
 ScreenCaptureSourceInfo() : type(ScreenCaptureSourceType_Unknown), sourceId(0), sourceName(nullptr), minimizeWindow(false) {}
#else
 ScreenCaptureSourceInfo() : type(ScreenCaptureSourceType_Unknown), sourceId(0), sourceName(nullptr) {}
#endif
};
"""
        output = module.normalize_screen_capture_constructors(text)
        self.assertEqual(output.count('ScreenCaptureSourceInfo()'), 1)
        self.assertIn('bool minimizeWindow;', output)
        self.assertIn('int sourceId;', output)

    def test_cannot_stage_over_sdk_snapshot(self):
        package = Path('/sdk')
        with self.assertRaises(ValueError):
            module.stage(package, 'rtc_4.5.3.8', package / 'headers' / 'rtc_4.5.3.8')

    def test_single_constructor_is_unchanged(self):
        text = 'struct Other { Other(): value(1) {} int value; };'
        self.assertEqual(module.normalize_screen_audio_constructors(text), text)

    def test_unknown_duplicate_defaults_fail_closed(self):
        with self.assertRaises(ValueError):
            module.normalize_screen_audio_constructors(HEADER.replace('16000', '22050'))


if __name__ == '__main__':
    unittest.main()
