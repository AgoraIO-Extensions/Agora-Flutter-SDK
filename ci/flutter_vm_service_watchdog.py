#!/usr/bin/env python3
"""Bound Flutter's VM-service discovery wait, without timing out test execution."""
import argparse
import datetime
import math
import os
import re
import selectors
import signal
import subprocess
import sys
import time

WAITING = b"Waiting for VM Service port to be available"
CONNECTED = re.compile(
    rb"(?:Connecting to (?:the )?VM Service|Connected to (?:the )?VM Service|"
    rb"VM Service (?:URL|URI)|A Dart VM Service on)", re.IGNORECASE
)


def stop_group(process):
    # This session/process group belongs to the foreground child created below.
    for sig, grace in ((signal.SIGINT, 3), (signal.SIGTERM, 2), (signal.SIGKILL, 1)):
        try:
            os.killpg(process.pid, sig)
        except ProcessLookupError:
            break
        until = time.monotonic() + grace
        while time.monotonic() < until:
            process.poll()
            try:
                os.killpg(process.pid, 0)
            except ProcessLookupError:
                return
            time.sleep(0.05)
    process.wait()


def run(command, timeout):
    process = subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                               start_new_session=True, bufsize=0)
    started = datetime.datetime.now(datetime.timezone.utc).isoformat()
    print(f"[vm-watchdog] pid={process.pid} started={started} cwd={os.getcwd()}", flush=True)
    deadline = None
    pending = b""
    with selectors.DefaultSelector() as selector:
        selector.register(process.stdout, selectors.EVENT_READ)
        try:
            while selector.get_map():
                for key, _ in selector.select(timeout=0.2):
                    chunk = os.read(key.fileobj.fileno(), 65536)
                    if not chunk:
                        selector.unregister(key.fileobj)
                        break
                    sys.stdout.buffer.write(chunk)
                    sys.stdout.buffer.flush()
                    pending += chunk
                    lines = re.split(rb"[\r\n]", pending)
                    pending = lines.pop()
                    for line in lines:
                        if WAITING in line:
                            deadline = time.monotonic() + timeout
                        elif CONNECTED.search(line):
                            deadline = None
                if deadline is not None and time.monotonic() >= deadline:
                    print(f"[vm-watchdog] VM_SERVICE_DISCOVERY_TIMEOUT after {timeout}s", flush=True)
                    stop_group(process)
                    return 124
            return process.wait()
        finally:
            if process.poll() is None:
                stop_group(process)
            process.stdout.close()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--timeout", type=float, default=120)
    parser.add_argument("command", nargs=argparse.REMAINDER)
    args = parser.parse_args()
    command = args.command[1:] if args.command[:1] == ["--"] else args.command
    if not math.isfinite(args.timeout) or args.timeout <= 0 or not command:
        parser.error("a positive timeout and a command are required")
    sys.exit(run(command, args.timeout))
