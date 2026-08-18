# Your Daily Loop - Dependency Audit Automation

This project implements a fully automated daily dependency audit with budget guards, maker-checker verification, and observability logging.

## What This Loop Does

Every day, this loop:
1. Checks project dependencies for security vulnerabilities and outdated packages
2. Creates PRs with safe updates (after maker-checker verification)
3. Logs all activity for observability
4. Escalates if budget exceeded instead of continuing unsupervised

## Budget Limits

- **Token budget:** 50,000 tokens per run
- **Turn budget:** 10 turns per run
- **Action:** Stop and log escalation if either exceeded

## Maker-Checker Pattern

### Maker (Implementer)
- Scans dependencies via `npm audit` / `npm outdated`
- Identifies vulnerabilities and updates
- Creates branch, applies changes
- Runs tests
- Creates PR

### Checker (Reviewer)
- Reviews the actual `git diff`
- Verifies each change is intentional
- Confirms tests pass
- Approves or requests changes

## Observability

All runs logged to `logs/daily-loop.jsonl` with:
- Timestamp and run ID
- Tokens/turns used
- Outcome (success/escalated/no_changes)
- Changes made
- PR URL (if created)

## Usage

Start the daily loop:
```
/loop 1d /daily-loop
```

Check logs:
```
cat logs/daily-loop.jsonl
```

## Rules for Claude

1. Always check budget before starting work
2. If budget exceeded, log escalation and STOP - do not continue
3. Run maker phase first, then checker phase on the SAME changes
4. Log outcome regardless of success or failure
5. Never merge PRs automatically - let humans review
6. If tests fail, log the failure and do not create PR

## Project Context

This is a capstone project combining all Loop Engineering concepts. The goal is trustworthy unattended operation over time.
