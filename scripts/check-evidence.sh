#!/usr/bin/env bash
# check-evidence.sh - pre-commit safety check for the Telnet vs SSH lab repo.
# Fails if raw captures or likely secrets are about to be committed.
# Usage: bash scripts/check-evidence.sh

set -u
cd "$(dirname "$0")/.." || exit 1

status=0

echo "== Checking for raw packet captures =="
if find . -path ./.git -prune -o -type f \( -name '*.pcap' -o -name '*.pcapng' -o -name '*.cap' \) -print | grep -q .; then
  echo "WARNING: capture files exist in the working tree (they are git-ignored, but verify):"
  find . -path ./.git -prune -o -type f \( -name '*.pcap' -o -name '*.pcapng' -o -name '*.cap' \) -print
fi

if git rev-parse --git-dir >/dev/null 2>&1; then
  if git ls-files | grep -Ei '\.(pcap|pcapng|cap)$' | grep -q .; then
    echo "ERROR: capture files are TRACKED by git:"
    git ls-files | grep -Ei '\.(pcap|pcapng|cap)$'
    echo "Remove with: git rm --cached <file>"
    status=1
  else
    echo "OK: no capture files tracked."
  fi
fi

echo
echo "== Scanning text files for likely secrets =="
PATTERN='(password[[:space:]]*[:=]|passwd[[:space:]]*[:=]|api[_-]?key|secret[[:space:]]*[:=]|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY|Authorization: )'
if grep -rEIil --exclude-dir=.git --exclude='check-evidence.sh' --exclude='.gitignore' "$PATTERN" . 2>/dev/null | grep -q .; then
  echo "REVIEW these files for possible secrets:"
  grep -rEIil --exclude-dir=.git --exclude='check-evidence.sh' --exclude='.gitignore' "$PATTERN" .
  echo "(Template text such as 'password' in the docs is expected; confirm no real values.)"
else
  echo "OK: no obvious secret patterns found."
fi

echo
echo "== Reminder =="
echo "Confirm every screenshot is redacted (usernames, passwords, hostnames, private IPs)."

exit $status
