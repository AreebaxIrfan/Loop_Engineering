# Your Daily Loop - Capstone Project

**Difficulty:** capstone · **Uses:** all six parts

## Overview

This capstone project combines every concept from Loop Engineering into one production-ready daily automation:

1. **Scheduled Heartbeat** - Runs on a daily interval
2. **Budget Guard** - Stops before exceeding token/turn limits
3. **Maker-Checker** - Implementer produces change, reviewer verifies against real diff
4. **Observability** - Logs cost and outcome per run
5. **Worktree** - Isolated workspace for each run
6. **Connector/Spine** - Integrates with project systems

## The Chore: Dependency Audit

We'll automate a **weekly dependency audit** - checking for:
- Outdated dependencies with security vulnerabilities
- Breaking changes in major version updates
- Unused dependencies that can be removed

## Implementation

### Daily Routine Structure

```
/loop 1d run the daily routine:
  1. Check token/turn budget (escalate if exceeded)
  2. Run maker-checker task:
     - Maker: Check dependencies, create update PR if needed
     - Checker: Review the actual diff, verify changes are correct
  3. Log cost and outcome to observability file
  4. If budget exceeded, stop and escalate instead of continuing
```

### Budget Guards

- **Token budget:** 50,000 tokens per run
- **Turn budget:** 10 turns per run
- **Escalation:** Stop and notify if either exceeded

### Maker-Checker Pattern

**Maker Phase:**
1. Scan `package.json` for dependencies
2. Run `npm audit` and `npm outdated`
3. Identify security vulnerabilities and major updates
4. Create a branch and apply updates
5. Run tests to verify nothing breaks

**Checker Phase:**
1. Review the actual `git diff` of changes
2. Verify each update is intentional and safe
3. Check that tests pass
4. Approve or request changes

### Observability Log

Each run logs to `logs/daily-loop.jsonl`:
```json
{
  "timestamp": "2026-08-18T17:00:00Z",
  "run_id": "run_20260818",
  "tokens_used": 12345,
  "turns_used": 5,
  "outcome": "success|escalated|no_changes",
  "changes_made": ["updated lodash to 4.17.21"],
  "pr_url": "https://github.com/..."
}
```

## Setup

1. Copy the `daily-loop-skill.md` to `.claude/skills/`
2. Run `/loop 1d /daily-loop` to start the daily routine
3. Monitor `logs/daily-loop.jsonl` for outcomes

## Files

- `CLAUDE.md` - Project context for Claude
- `.claude/skills/daily-loop.md` - The skill definition
- `logs/daily-loop.jsonl` - Observability log (created on first run)
- `package.json` - Dependencies to audit (if applicable)

## Done When

- [ ] The loop runs unattended for a week
- [ ] You trust what it ships because you read the logs
- [ ] Budget guards prevent runaway execution
- [ ] Maker-checker catches bad changes before merge
- [ ] Observability provides clear audit trail

## Reflection (Concept 15)

After a week of running, answer honestly:

> Did your understanding of the project keep up with what the loop changed?

If not, slow the loop down until it does. When it fails overnight (and it will), work through "When an unattended loop fails" before blaming the model.
