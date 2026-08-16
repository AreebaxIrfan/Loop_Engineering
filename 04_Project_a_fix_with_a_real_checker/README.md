# Project 4: A Fix with a Real Checker

> **Difficulty:** Medium–Hard · **Concepts:** Concept 8 (Worktree), Concept 9 (Skill), Concept 11 (Maker-Checker)

## Overview

A smaller version of the Part 5 loop. You separate the **maker** (who drafts a fix) from the **checker** (who grades it). The fix is drafted in an isolated checkout, and a pull request opens only when the checker passes.

## Build

1. Write a short **skill** with your fix steps, and a **reviewer agent** that replies `PASS` or `FAIL`.
2. Take one real bug. Have the implementer draft a fix in its own checkout (worktree or branch).
3. Let the reviewer grade it. **Open a PR only on `PASS`.**

## Definition of Done

- [ ] A good fix gets a `PASS` and a PR.
- [ ] A deliberately bad fix you plant gets a `FAIL` with reasons.

> **The lesson:** a checker that approves everything is no checker. If the reviewer passes the bad fix, tighten it.
