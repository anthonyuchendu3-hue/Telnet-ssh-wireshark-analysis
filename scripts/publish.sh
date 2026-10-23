#!/usr/bin/env bash
# publish.sh - first-time publish of the lab repo to GitHub using Git Bash.
# Usage:
#   bash scripts/publish.sh https://github.com/<your-username>/telnet-vs-ssh-wireshark-lab.git
#
# Create the EMPTY repository on GitHub first (no README, no .gitignore, no license).

set -euo pipefail

REMOTE_URL="${1:-}"
BRANCH="main"
COMMIT_MSG="${2:-Initial commit: Telnet vs SSH Wireshark lab scaffold}"

if [[ -z "$REMOTE_URL" ]]; then
  echo "Usage: bash scripts/publish.sh <github-repo-url> [commit message]"
  exit 1
fi

# Run from the repo root regardless of where the script is called from.
cd "$(dirname "$0")/.."

command -v git >/dev/null || { echo "git is not installed."; exit 1; }

# Identity check
if [[ -z "$(git config user.name || true)" || -z "$(git config user.email || true)" ]]; then
  echo "Git identity not set. Run:"
  echo '  git config --global user.name  "Your Name"'
  echo '  git config --global user.email "you@example.com"'
  exit 1
fi

# Initialise repo if needed
if [[ ! -d .git ]]; then
  git init -b "$BRANCH"
else
  git checkout -B "$BRANCH" 2>/dev/null || true
fi

# Safety check before staging anything
echo "Running evidence safety check..."
bash scripts/check-evidence.sh || { echo "Safety check failed. Fix the issues above and re-run."; exit 1; }

echo
read -r -p "Have you redacted all screenshots and evidence? (yes/no): " ANSWER
if [[ "$ANSWER" != "yes" ]]; then
  echo "Aborting. Redact first, then re-run."
  exit 1
fi

git add .
echo
git status --short
echo
read -r -p "Commit and push these files? (yes/no): " GO
[[ "$GO" == "yes" ]] || { echo "Aborted."; exit 1; }

git commit -m "$COMMIT_MSG"

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi

git push -u origin "$BRANCH"

echo
echo "Done. Your repository is live: ${REMOTE_URL%.git}"
