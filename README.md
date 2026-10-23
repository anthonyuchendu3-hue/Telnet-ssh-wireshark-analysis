# Telnet vs SSH: Wireshark Packet Analysis Lab

> A hands-on network security lab that captures Telnet and SSH sessions on a loopback interface with Wireshark, then compares what an observer can see in each.

![Level](https://img.shields.io/badge/level-beginner-green)
![Focus](https://img.shields.io/badge/focus-network%20security-blue)
![Tool](https://img.shields.io/badge/tool-Wireshark-1679A7)
![Platform](https://img.shields.io/badge/platform-Linux-orange)

## Overview

Telnet sends everything, including login credentials and commands, as readable text. SSH encrypts the whole session. In this lab I captured both on the `lo` interface, followed each TCP stream, and documented the difference.

**Key finding:** Telnet exposes application data in plaintext; SSH protects it with encryption, which is why SSH is the standard for remote administration.

## Learning objectives

- Start a Wireshark capture on a loopback interface
- Generate a Telnet session and identify its packets
- Follow a Telnet TCP stream and recognize visible application data
- Generate an SSH session and identify SSH traffic
- Follow an SSH TCP stream and confirm the contents are not readable
- Explain why SSH is preferred for secure remote administration

## Environment

| Item | Value |
|------|-------|
| OS | _e.g. Ubuntu 24.04 LTS VM_ |
| Wireshark version | _fill in_ |
| Telnet service | _e.g. telnetd / inetutils-telnetd_ |
| SSH service | _e.g. OpenSSH server_ |
| Capture interface | `lo` (loopback) |
| Lab account | dedicated throwaway account (not a real credential) |

Full setup notes: [`notes/lab-environment.md`](notes/lab-environment.md)

## Methodology

### Part 1: Telnet session

1. Start Wireshark and capture on `lo`.
2. In a second terminal: `telnet localhost`
3. Log in with the lab account and run `whoami`.
4. Stop the capture, apply display filter `telnet`.
5. Right-click a packet, then **Follow → TCP Stream**.

### Part 2: SSH session

1. Start a fresh capture on `lo`.
2. In a second terminal: `ssh localhost`
3. Authenticate with the lab account and run `whoami`.
4. Stop the capture, apply display filter `ssh`.
5. Right-click a packet, then **Follow → TCP Stream**.

All commands are listed in [`commands_used.txt`](commands_used.txt).

## Evidence

| Evidence | File |
|----------|------|
| Telnet display filter | `screenshots/telnet-filter.png` |
| Telnet TCP stream | `screenshots/telnet-stream.png` |
| SSH display filter | `screenshots/ssh-filter.png` |
| SSH TCP stream | `screenshots/ssh-stream.png` |

<!-- Uncomment once your redacted screenshots are in place
![Telnet filter](screenshots/telnet-filter.png)
![Telnet stream](screenshots/telnet-stream.png)
![SSH filter](screenshots/ssh-filter.png)
![SSH stream](screenshots/ssh-stream.png)
-->

> All screenshots are redacted. Usernames, passwords, hostnames and private IPs were blurred or removed before committing.

## Comparison

| Observation | Telnet | SSH |
|-------------|--------|-----|
| Traffic identification | `telnet` display filter | `ssh` display filter |
| Application data readable? | Typically visible as plaintext | Protected by encryption |
| Credential exposure risk | High on an untrusted network | Designed to protect credentials and session data |
| Recommended for secure administration? | No | Yes |

## Findings

Write your own observations in [`notes/observations.md`](notes/observations.md) and your answers to the reflection questions in [`notes/reflection-answers.md`](notes/reflection-answers.md).

## Repository structure

```
telnet-vs-ssh-wireshark-lab/
├── README.md
├── LICENSE
├── .gitignore
├── commands_used.txt
├── GIT_WORKFLOW.md          # Git Bash step-by-step
├── docs/
│   └── lab-guide.md         # Full lab instructions
├── notes/
│   ├── lab-environment.md
│   ├── observations.md
│   └── reflection-answers.md
├── screenshots/             # Redacted screenshots only
├── evidence/
│   ├── telnet/              # Redacted text exports, notes
│   └── ssh/
└── scripts/
    ├── publish.sh           # Safe first push to GitHub
    └── check-evidence.sh    # Pre-commit sensitive-data check
```

## Security and ethics

- Captures were performed only on systems and accounts I am authorized to use.
- A dedicated lab account was used; no real credentials appear anywhere in this repo.
- Raw packet captures (`.pcap`, `.pcapng`) are **git-ignored** and must never be committed.
- Telnet is demonstrated only as a controlled example of why plaintext administration is insecure.

## Skills demonstrated

Packet capture and analysis · Wireshark display filters · TCP stream reconstruction · Protocol comparison (Telnet vs SSH) · Security documentation and evidence redaction · Git/GitHub workflow

## License

Released under the [MIT License](LICENSE).
