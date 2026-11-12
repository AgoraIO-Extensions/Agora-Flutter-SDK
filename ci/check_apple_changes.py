#!/usr/bin/env python3
"""Select Apple packaging checks from git diff --no-renames --name-only -z."""
from pathlib import PurePosixPath
import sys


def needs_apple_packages(paths):
    prefixes = ("ios/", "macos/", "src/", "example/", "ci/",
                ".github/workflows/", ".github/actions/", "test_shard/integration_test_swiftpm/")
    manifests = {"pubspec.yaml", "pubspec.lock", "Package.swift", "Podfile",
                 "Podfile.lock", ".pubignore", ".gitignore", ".gitattributes",
                 ".gitmodules"}
    return any(path.startswith(prefixes) or PurePosixPath(path).name in manifests
               or path.endswith(".podspec") for path in paths)


if __name__ == "__main__":
    paths = [path.decode("utf-8", "surrogateescape")
             for path in sys.stdin.buffer.read().split(b"\0") if path]
    print("apple_packages=" + str(needs_apple_packages(paths)).lower())
