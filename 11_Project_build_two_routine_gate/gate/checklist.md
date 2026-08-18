# Routine A6 checklist — the human gate, checked at build time

Run this checklist over BOTH routines when the gate is built, and note the
result next to each item. "Pruned" / "off" / "on" / "set" are the answers the
build must actually produce, not the defaults.

| # | Check | Routine A (gate-draft) | Routine B (gate-approve) |
|---|-------|------------------------|--------------------------|
| 1 | **Connectors pruned** — every connector except the ones the routine genuinely needs is removed. Both routines here need ZERO connectors. | ☐ empty | ☐ empty |
| 2 | **Unrestricted pushes off** — the routine can only write to `claude/…` branches, never `main`/other branches. (Platform-side git grants must be narrowed.) | ☐ claude/… only | ☐ claude/… only |
| 3 | **Environments closed** — the routine runs in a trusted sandbox, not a full shell over the repo. | ☐ | ☐ |
| 4 | **State file chosen** — same file both sides read/write: `gate/state.md`, a gitignorable, human-readable, append-only file. | ☐ gate/state.md | ☐ gate/state.md |
| 5 | **No global identities** — no MCP/Dashboard global secrets reachable from the routine. | ☐ | ☐ |

After checking: record here *who reviewed, on what date, and any deviations*.
The transcript of Routine B must corroborate item 4 (it writes the state line).