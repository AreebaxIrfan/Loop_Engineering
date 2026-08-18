---
name: daily-loop
description: Daily dependency audit with budget guard, maker-checker, and observability logging
---

# Daily Dependency Audit Loop

You are running a daily dependency audit loop. Follow this workflow exactly.

## Budget Guard (FIRST)

Before doing ANY work:

1. Check if budget tracking file exists: `logs/budget.json`
2. If not, initialize it:
   ```json
   {"run_id": "run_TIMESTAMP", "tokens_used": 0, "turns_used": 0}
   ```
3. After each turn, update the file with current usage
4. If tokens > 50,000 OR turns > 10:
   - Log escalation to `logs/daily-loop.jsonl`
   - STOP immediately - do not continue

## Phase 1: Maker (Implementer)

1. Check if `package.json` exists in current directory
2. Run `npm audit --json` to find vulnerabilities
3. Run `npm outdated --json` to find outdated packages
4. Analyze results:
   - HIGH/CRITICAL vulnerabilities: MUST update
   - Outdated with security fixes: SHOULD update
   - Major version bumps: REVIEW changelog first
5. If updates needed:
   - Create branch: `git checkout -b dep-update-YYYYMMDD`
   - Apply updates: `npm update <package>` or `npm install <package>@latest`
   - Run tests: `npm test`
   - If tests pass, create PR draft
6. If no updates needed, log "no_changes" and exit

## Phase 2: Checker (Reviewer)

1. Get the actual diff: `git diff main`
2. For each changed `package.json` / `package-lock.json` line:
   - Verify the change matches what maker intended
   - Check version is valid semver
   - Confirm no unexpected additions/removals
3. Run tests again: `npm test`
4. If all checks pass, log "success" and mark PR ready
5. If issues found, log details and request changes

## Phase 3: Observability Logging

Append to `logs/daily-loop.jsonl`:

```json
{
  "timestamp": "ISO-8601 timestamp",
  "run_id": "run_YYYYMMDD_HHMMSS",
  "tokens_used": number,
  "turns_used": number,
  "outcome": "success|escalated|no_changes|failed",
  "changes_made": ["list of changes"],
  "pr_url": "url or null",
  "notes": "any relevant notes"
}
```

## Escalation Protocol

If budget exceeded OR unexpected error:
1. Log the escalation immediately
2. DO NOT continue work
3. DO NOT create or merge PRs
4. Wait for human review

## Important Rules

- Never merge PRs automatically
- Always run tests before creating PR
- Log regardless of outcome
- Stop on first unhandled error
- Preserve git worktree state for debugging
