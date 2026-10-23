# Evidence

Supporting material for the lab, **redacted before committing**.

```
evidence/
├── telnet/   # redacted stream exports, packet summaries, notes
└── ssh/
```

## What can go here

- Redacted text exports of a followed TCP stream
- Packet-list summaries (e.g. protocol, packet counts) with sensitive fields removed
- Short notes about what each artifact shows

## What must NOT go here

- Raw `.pcap` / `.pcapng` files (blocked by `.gitignore`)
- Real credentials, tokens, keys, hostnames or private IPs
- Any unredacted capture output

Store raw captures outside the repository, or in `evidence/raw/` (git-ignored), and delete them when the project is finished.

Run `bash scripts/check-evidence.sh` before every commit.
