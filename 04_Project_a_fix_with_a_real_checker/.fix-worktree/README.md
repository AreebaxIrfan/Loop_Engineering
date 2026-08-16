# Project 4 Worktree — A Fix with a Real Checker

> **Difficulty:** Medium–Hard · **Concepts:** Concept 8 (Worktree), Concept 9 (Skill), Concept 11 (Maker-Checker)

This is the isolated worktree used by Project 4. It contains a copy of the skill and reviewer agent definitions so the maker-checker loop can run in its own checkout.

## Build

1. Write a short **skill** with your fix steps, and a **reviewer agent** that replies `PASS` or `FAIL`.
2. Take one real bug. Have the implementer draft a fix in this isolated checkout.
3. Let the reviewer grade it. **Open a PR only on `PASS`.**

## Definition of Done

- [ ] A good fix gets a `PASS` and a PR.
- [ ] A deliberately bad fix you plant gets a `FAIL` with reasons.

> **The lesson:** a checker that approves everything is no checker. If the reviewer passes the bad fix, tighten it.