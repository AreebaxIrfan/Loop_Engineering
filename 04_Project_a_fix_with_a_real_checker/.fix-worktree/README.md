# 📦 Project 4 Worktree — Fix with Checker (Isolated Checkout)

> **Part of:** Project 4 · **Difficulty:** 🟠 Medium–Hard
> **Purpose:** Isolated worktree for the maker-checker loop

---

## 🎬 The Scene

This is the **isolated worktree** where Project 4's maker drafts fixes. It contains a copy of the skill and reviewer agent so the loop runs in its own checkout — no pollution of `main`.

---

## 🧠 What Lives Here

| File | Purpose |
|------|---------|
| `.claude/skills/implement-fix.md` | Fix procedure skill |
| `.claude/agents/reviewer.md` | Reviewer agent (PASS/FAIL) |
| `.claude/skills/fix-and-review.md` | Combined skill |

---

## 🚀 Quick Start

```bash
# From Project 4 root:
cd .fix-worktree
# This worktree is created by Project 4's loop automatically
# You don't manually init it — the loop does
```

> **Inside the worktree (when loop runs):**
```
1. Maker reads implement-fix.md skill
2. Drafts fix for the real bug
3. Reviewer agent grades: PASS or FAIL with reasons
4. Only on PASS → PR opens from this worktree
```

---

## ✅ Definition of Done

| ✓ | Requirement | The Test |
|---|-------------|----------|
| | Good fix → `PASS` + PR | PR opens from worktree |
| | Bad fix → `FAIL` + reasons | Planted bug caught |

> **The lesson:** a checker that approves everything is no checker. If it passes the bad fix, tighten the reviewer.

---

## 🔗 Back to Main Project

→ [Project 4: A Fix with a Real Checker](../README.md)