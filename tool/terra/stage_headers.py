"""Stage binding-only headers; never modify the installed SDK snapshot."""
import re
import shutil
import subprocess
from pathlib import Path


def normalize_screen_audio_constructors(text):
    # Terra flattens platform #if branches. These two native constructors then
    # collide, although Dart deliberately leaves their fields nullable so the
    # real SDK still chooses the platform defaults when a field is omitted.
    start = text.find('struct ScreenAudioParameters {')
    if start < 0:
        return text
    end = text.find('\n};', start)
    if end < 0:
        raise ValueError('Unclosed ScreenAudioParameters declaration')
    block = text[start:end]
    constructors = list(re.finditer(r'ScreenAudioParameters\(\)\s*:\s*sampleRate\((\d+)\),\s*channels\(2\),\s*captureSignalVolume\(100\)\s*\{\}', block))
    if len(constructors) < 2:
        return text
    if len(constructors) != 2 or {m.group(1) for m in constructors} != {'16000', '48000'}:
        raise ValueError('Unexpected ScreenAudioParameters platform constructors')
    for i in reversed(range(len(constructors))):
        match = constructors[i]
        block = block[:match.start()] + ('ScreenAudioParameters() {}' if i == 0 else '') + block[match.end():]
    return text[:start] + block + text[end:]


def normalize_screen_capture_constructors(text):
    start = text.find('struct ScreenCaptureSourceInfo {')
    if start < 0:
        return text
    end = text.find('\n};', start)
    if end < 0:
        raise ValueError('Unclosed ScreenCaptureSourceInfo declaration')
    block = text[start:end]
    constructors = list(re.finditer(r'ScreenCaptureSourceInfo\(\)\s*:\s*type\(ScreenCaptureSourceType_Unknown\),\s*sourceId\(0\),\s*sourceName\(nullptr\).*?\{\}', block, re.S))
    if len(constructors) < 2:
        return text
    if len(constructors) != 2:
        raise ValueError('Unexpected ScreenCaptureSourceInfo constructors')
    for i in reversed(range(len(constructors))):
        match = constructors[i]
        block = block[:match.start()] + ('ScreenCaptureSourceInfo() {}' if i == 0 else '') + block[match.end():]
    return text[:start] + block + text[end:]


def stage(package, version, target):
    if not re.fullmatch(r'rtc_\d+\.\d+(?:\.\d+)*', version):
        raise ValueError('Invalid RTC header version')
    source = package / 'headers' / version
    if source.resolve() == target.resolve() or source.resolve() in target.resolve().parents or target.resolve() in source.resolve().parents:
        raise ValueError('Staged headers must be separate from the SDK snapshot')
    if not (source / 'include' / 'AgoraBase.h').is_file():
        raise ValueError('SDK header snapshot missing')
    if target.exists():
        shutil.rmtree(target)
    shutil.copytree(source, target)
    header = target / 'include' / 'AgoraBase.h'
    original = header.read_text()
    header.write_text(normalize_screen_audio_constructors(original))
    engine = target / 'include' / 'IAgoraRtcEngine.h'
    if engine.exists():
        engine.write_text(normalize_screen_capture_constructors(engine.read_text()))
    log = target / 'include' / 'IAgoraLog.h'
    if log.exists():
        # Its #ifndef guards survive Terra's platform flattening. Pick a single
        # enum spelling for binding metadata instead of redefining both branches.
        log.write_text('#define OPTIONAL_ENUM_CLASS enum\n#define OPTIONAL_LOG_LEVEL_SPECIFIER\n' + log.read_text())
    devices = target / 'include' / 'IAudioDeviceManager.h'
    if devices.exists() and 'public RefCountInterface' in devices.read_text():
        # The SDK includes this file via RtcEngine after declaring RefCountInterface;
        # the binding parser also visits it as a standalone translation unit.
        devices.write_text('#include "AgoraRefPtr.h"\n' + devices.read_text())


if __name__ == '__main__':
    root = Path(__file__).resolve().parent
    config = (root / 'terra_config_main.yaml').read_text()
    version = re.search(r'rtc_\d+\.\d+(?:\.\d+)*', config).group(0)
    package = Path(subprocess.check_output(['node', '-p',
        'require("path").dirname(require.resolve("@agoraio-extensions/terra_shared_configs/package.json"))'],
        cwd=str(root), text=True).strip())
    stage(package, version, root / '.binding_headers' / version)
