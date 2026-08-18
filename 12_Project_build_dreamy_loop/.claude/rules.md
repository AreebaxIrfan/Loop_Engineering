# Dreaming Loop Rules

## Loop Configuration

- **Cadence:** Weekly (every 7 days)
- **Source:** All `progress.md` files in the repository
- **State file:** `dreaming-state.md` (tracks last analyzed timestamp)
- **Output:** PR on `claude/dreaming-proposal` branch (never direct commit)
- **Human gate:** PR must be approved and merged by human

## Analysis Rules

1. Read `dreaming-state.md` to get `last_analyzed` timestamp
2. Scan all `progress.md` files for entries newer than `last_analyzed`
3. Identify failures/corrections that appear **more than once** (recurring)
4. For each recurring pattern, draft the **smallest rule/skill change** that would prevent it
5. Cite exact evidence: which runs, how often, and why this line stops it
6. Also propose **one deletion**: a rule no recent run needed
6. Write proposal as PR on `claude/dreaming-proposal` branch
7. Update `dreaming-state.md` with new `last_analyzed` timestamp

## Proposal Requirements

- Change must trace to real, cited log entries (no guessing)
- Must be minimal — the smallest change that fixes the recurring pattern
- Must propose one deletion of an unused rule
- Never merge automatically — human approval required

## Planting Test

The system must catch a deliberately planted repeated failure in the logs and turn it into a proposal.