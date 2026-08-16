# Project 7: Back It to Purpose

> **Difficulty:** Medium · **Concepts:** Observability, Concept 13 (Cost), Concept 14 (Failure)

## Overview

You cannot operate a loop you cannot measure or diagnose. This project forces you to quantify your loop's cost and rehearse failure diagnosis using only what the loop left behind.

## Build

1. Take your Project 3 loop. **Measure one beat**: note roughly how many tokens a run reads and writes, and multiply by your cadence to get a **monthly cost** (Concept 13's math on your own loop).
2. **Sabotage it**: point the prompt at a file that does not exist, or give it a success condition it can never meet (with a limit set).
3. Let it fire on schedule and **fail**.
4. **Diagnose the failure using only what the loop left behind** — the log line and `progress.md` — without replaying the full run.

## Definition of Done

Three things must all be true:

- [ ] You can say what failed, and **when**, from the spine alone.
- [ ] The loop left a clear **"needs a human" note** instead of failing silently.
- [ ] You know your loop's **monthly cost** at its current cadence.

> **The lesson:** if it failed silently, fix that before anything else by adding the log line. You are rehearsing the overnight failure now, while it is cheap and you are watching.