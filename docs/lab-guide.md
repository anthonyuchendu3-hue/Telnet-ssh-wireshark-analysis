# Lab Guide: Comparing Telnet and SSH Traffic in Wireshark

**Skill level:** Beginner | **Focus:** Network security, packet capture, encryption

## Goal

Capture two local remote-access sessions with Wireshark and compare what can be observed with Telnet versus SSH. Telnet exposes application data in plaintext; SSH protects the session with encryption.

## Requirements

- Linux VM or lab workstation with Wireshark installed
- A working local Telnet service
- A working local SSH service
- A terminal permitted to start Wireshark and connect to localhost

## Important

Use accounts and passwords created specifically for this lab. Never place real credentials or production secrets in packet captures or screenshots.

## Part 1: Observe a Telnet session

1. Launch Wireshark: `wireshark &`
2. Select the loopback interface (`lo`) and start capturing.
3. In a second terminal: `telnet localhost`
4. Sign in with the lab account and run `whoami`.
5. Stop the capture.
6. Apply the display filter `telnet`.
7. Right-click a Telnet packet, then **Follow → TCP Stream**.
8. Note the readable application data. Close the stream and type `exit`.

## Part 2: Observe an SSH session

1. Start a fresh capture on `lo`.
2. In a second terminal: `ssh localhost`
3. Review the host-key prompt; accept it only for this lab.
4. Authenticate with the lab account and run `whoami`.
5. Stop the capture.
6. Apply the display filter `ssh`.
7. Right-click an SSH packet, then **Follow → TCP Stream**.
8. Compare with the Telnet stream.

## Part 3: Compare the evidence

| Observation | Telnet | SSH |
|-------------|--------|-----|
| Traffic identification | `telnet` filter | `ssh` filter |
| Application data readable? | Typically plaintext | Encrypted |
| Credential exposure risk | High on untrusted networks | Protected |
| Recommended for secure administration? | No | Yes |

## Part 4: Reflection

See [`../notes/reflection-answers.md`](../notes/reflection-answers.md).

## Safety and ethics

Perform captures only on systems and accounts you are authorized to use. The purpose is to understand network security and the protection provided by encryption.
