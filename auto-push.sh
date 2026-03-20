#!/usr/bin/env python3
"""
Auto-commit and push to GitHub whenever local files change.
Run once: ./auto-push.sh
Stop with: Ctrl+C
"""

import os
import time
import subprocess
import sys

WATCH_DIR = os.path.dirname(os.path.abspath(__file__))
POLL_INTERVAL = 5  # seconds between checks
DEBOUNCE = 3       # seconds of quiet before committing

def get_snapshot(directory):
    snapshot = {}
    for root, dirs, files in os.walk(directory):
        dirs[:] = [d for d in dirs if d != '.git']
        for f in files:
            if f == 'auto-push.sh':
                continue
            path = os.path.join(root, f)
            try:
                snapshot[path] = os.path.getmtime(path)
            except OSError:
                pass
    return snapshot

def has_git_changes():
    result = subprocess.run(
        ['git', 'status', '--porcelain'],
        cwd=WATCH_DIR, capture_output=True, text=True
    )
    return bool(result.stdout.strip())

def commit_and_push():
    subprocess.run(['git', 'add', '-A'], cwd=WATCH_DIR)
    msg = f"Auto-save: {time.strftime('%Y-%m-%d %H:%M:%S')}"
    result = subprocess.run(
        ['git', 'commit', '-m', msg],
        cwd=WATCH_DIR, capture_output=True, text=True
    )
    if 'nothing to commit' in result.stdout:
        return
    print(f"  Committed: {msg}")
    push = subprocess.run(
        ['git', 'push'],
        cwd=WATCH_DIR, capture_output=True, text=True
    )
    if push.returncode == 0:
        print("  Pushed to GitHub ✓")
    else:
        print(f"  Push failed: {push.stderr.strip()}")

def main():
    print(f"Watching for changes in:\n  {WATCH_DIR}")
    print("Auto-push is ON. Press Ctrl+C to stop.\n")

    last_snapshot = get_snapshot(WATCH_DIR)
    last_change_time = None

    while True:
        time.sleep(POLL_INTERVAL)
        current_snapshot = get_snapshot(WATCH_DIR)

        if current_snapshot != last_snapshot:
            last_snapshot = current_snapshot
            last_change_time = time.time()
            print("  Change detected, waiting for quiet...")

        if last_change_time and (time.time() - last_change_time >= DEBOUNCE):
            last_change_time = None
            if has_git_changes():
                commit_and_push()

if __name__ == '__main__':
    try:
        main()
    except KeyboardInterrupt:
        print("\nAuto-push stopped.")
        sys.exit(0)
