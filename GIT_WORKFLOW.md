# Git Bash Workflow: From Lab to GitHub

A step-by-step guide to carrying out the lab, documenting it, and pushing it to GitHub with Git Bash.

## Suggested repository details

- **Repository name:** `telnet-vs-ssh-wireshark-lab`
- **Description:** `Beginner network security lab: capturing Telnet and SSH sessions in Wireshark to show plaintext exposure vs encrypted remote access.`
- **Topics:** `wireshark` `network-security` `ssh` `telnet` `packet-analysis` `cybersecurity` `encryption` `linux` `blue-team` `lab`
- **Visibility:** Public (only after every screenshot is redacted)
- Do **not** tick "Add a README", ".gitignore" or "license" on GitHub; they are already in this folder.

---

## Step 0: One-time Git setup

Open **Git Bash**:

```bash
git config --global user.name  "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
git --version
```

Optional SSH key for GitHub (recommended over passwords):

```bash
ssh-keygen -t ed25519 -C "you@example.com"
cat ~/.ssh/id_ed25519.pub     # paste into GitHub > Settings > SSH and GPG keys
ssh -T git@github.com
```

## Step 1: Unzip the project

```bash
cd ~/Documents
unzip telnet-vs-ssh-wireshark-lab.zip
cd telnet-vs-ssh-wireshark-lab
```

## Step 2: Create the GitHub repository

1. Go to https://github.com/new
2. Name: `telnet-vs-ssh-wireshark-lab`
3. Paste the description above
4. Choose Public or Private, leave the "initialize" options **unticked**
5. Click **Create repository** and copy the URL (HTTPS or SSH)

## Step 3: Run the lab (on your Linux VM)

Follow [`docs/lab-guide.md`](docs/lab-guide.md). While you work:

- Record every command in `commands_used.txt`
- Save screenshots in `screenshots/` with the exact names listed in `screenshots/README.md`
- Keep raw `.pcapng` files **outside** the repo (they are git-ignored if you place them inside)
- Fill in `notes/lab-environment.md`, `notes/observations.md` and `notes/reflection-answers.md`

Copy the finished files from your VM into this folder (shared folder, `scp`, or USB).

## Step 4: Redact

Work through the checklist in `screenshots/README.md`. Blur usernames, passwords, hostnames and private IPs.

## Step 5: Edit the README

Fill in the environment table, uncomment the screenshot images, and add your own observations.

## Step 6: Safety check

```bash
bash scripts/check-evidence.sh
```

## Step 7: Publish

Option A, scripted (recommended for the first push):

```bash
bash scripts/publish.sh https://github.com/<your-username>/telnet-vs-ssh-wireshark-lab.git
```

Option B, manual:

```bash
git init -b main
git add .
git status                      # review exactly what will be committed
git commit -m "Initial commit: Telnet vs SSH Wireshark lab"
git remote add origin https://github.com/<your-username>/telnet-vs-ssh-wireshark-lab.git
git push -u origin main
```

## Step 8: Later updates

```bash
git status
git add screenshots/ notes/ README.md
git commit -m "Add redacted SSH stream screenshot and observations"
git push
```

Suggested commit message style:

| Prefix | Use for |
|--------|---------|
| `docs:` | README / notes changes |
| `evidence:` | New screenshots or exports |
| `chore:` | Config, .gitignore, scripts |

## Step 9: Tidy up the lab machine

```bash
sudo deluser --remove-home labuser     # remove the throwaway account
sudo systemctl disable --now inetutils-inetd 2>/dev/null || true   # stop Telnet (service name varies)
```

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `Permission denied (publickey)` | Add your SSH key to GitHub or use the HTTPS URL |
| `remote origin already exists` | `git remote set-url origin <url>` |
| `failed to push some refs` | Repo was created with a README: `git pull --rebase origin main` then push |
| Committed a `.pcap` by mistake | `git rm --cached file.pcapng`, commit, and if already pushed, rewrite history (e.g. `git filter-repo`) and rotate any exposed credentials |
| Git Bash can't find `unzip` | Use Windows Explorer > Extract All, or `7z x` |
