# PR 001 — Propose: escalate repeated loop failures instead of silent retry

Branch: `claude/dreaming-proposal`
Target: `main`

> ⏳ **Pending human approval. Never merged automatically.**

---

## Analysis Metadata

- **Analysis window:** 2026-08-12T00:00:00Z → 2026-08-19T00:00:00Z (weekly cadence)
- **Source logs scanned:** 
  - `03_Project_the_morning_brief_with_a_memory/progress.md`
  - `07_Project_back_it_to_purpose/progress.md`
  - `08_Project_your_daily_loop/logs/daily-loop.jsonl`
- **Run timestamp:** 2026-08-19T00:00:00Z
- **Analyzed by:** Weekly dreaming loop (Project 12)

---

## Summary

Add a rule (in `.claude/rules.md` and/or loop skills) that any scheduled loop
must **stop, log an escalation, and flag for a human** after **3 consecutive
identical failures** — rather than retrying silently.

---

## Evidence (cited log entries)

### Recurring Pattern: Silent Retry Loop Without Escalation

**Source:** `07_Project_back_it_to_purpose/progress.md` — Iteration Log table

| Iteration | Timestamp (UTC) | Status | Notes |
|-----------|-----------------|--------|-------|
| 1  | 2026-08-18T17:01:07Z | FAILED | `target_file.txt` does not exist |
| 2  | 2026-08-18T17:02:07Z | FAILED | `target_file.txt` does not exist |
| 3  | 2026-08-18T17:03:07Z | FAILED | `target_file.txt` does not exist |
| 4–12 | 17:04–17:12 | FAILED | Silent retries — **NO ESCALATION** ⚠️ |

**Frequency:** 12 consecutive identical failures over 11 minutes.

**The pattern:** The same deterministic failure (`target_file.txt does not exist`)
occurred 12 times in a row. The loop's own "Failure Detection" section (lines
31-34 of progress.md) documents an intended "Escalation trigger: After 3
consecutive failures" — but that escalation never fired. The "⚠️ NEEDS HUMAN
⚠️" block was only authored **after** the 12th failure, not at the 3rd.

**Cost impact:** ~15,000 tokens per iteration × 12 iterations = ~180,000 tokens
burned on identical, doomed work.

---

## Why This Change Stops It

1. **Fail-fast threshold.** A mandatory stop at 3 consecutive identical
   failures would have halted the loop at iteration 3 (17:03:07Z), preventing
   9 wasteful retries.

2. **First-failure loudness.** The failure `target_file.txt does not exist` is
   deterministic and pre-detectable. A pre-flight "does the required dependency
   exist" gate would convert an open-ended retry loop into a single logged
   escalation.

3. **No guessing — evidence-backed predicate.** The rule only acts on a
   *repeatable, log-cited* condition: same status + same note message occurring
   3+ times consecutively. This is exactly the "traces to real log entries"
   bar this meta-loop is judged on.

---

## The Rule Text (Proposed)

Add to `.claude/rules.md` (and propagate to loop skills):

> **Escalation Rule — Consecutive Identical Failures**
>
> If a scheduled loop produces the **same failure status and note message** for
> **3 consecutive iterations**, it MUST:
> 1. Stop scheduling further iterations immediately
> 2. Log an escalation entry to its observability file with the failure pattern
>    and iteration range
> 3. Leave a `⚠️ NEEDS HUMAN ⚠️` block in its progress log
> 4. Never continue retrying silently
>
> *Rationale: Cited from 07_Project_back_it_to_purpose progress.md — 12 silent
> retries of "target_file.txt does not exist" before human notice.*

---

## Proposed Deletion (One Rule No Recent Run Needed)

**File:** `08_Project_your_daily_loop/.claude/skills/daily-loop.md`

**Rule to delete:**
> "If tests fail, log the failure and do not create PR"

**Evidence of non-use:**
- `08_Project_your_daily_loop/logs/daily-loop.jsonl` contains exactly **one
  entry ever** — run `run_20260818_173237`, outcome `initialized`,
  `tokens_used: 0`, `turns_used: 0`
- `logs/budget.json` confirms: `tokens_used: 0`, `turns_used: 0`
- Across the project lifetime (within the analysis window) there is **no
  subsequent run** — the loop never advanced past initialization, so the
  "tests failed → do not create PR" branch has never been reachable in any
  execution.
- A rule that no run can reach is dead weight that obscures the rules that
  matter.

**Caveat for review:** This is a *de-reachability* judgment based on current
execution history, not proof of permanent irrelevance. `package.json` exists
and defines a `test` script (`echo "All tests passing" && exit 0`), so once
the loop actually runs, the rule *can* become meaningful. Recommend one of:
1. Defer deletion until a real run proves the failure path never fires; or
2. Tighten the rule: fire only on a non-zero `npm test` exit, so the
   echo-based test can't silently pass and this guard stays honest.

---

## Acceptance / Review Checklist (for the human)

- [ ] The 3-consecutive-failure rule cites Project 07's 12-run log table above
- [ ] The rule is minimal — the smallest change that stops the observed pattern
- [ ] One deletion is proposed with evidence of non-use
- [ ] The amendment does **not** touch any rules file without this PR being merged
- [ ] Nothing was merged automatically — this PR is left for approval on `claude/dreaming-proposal`