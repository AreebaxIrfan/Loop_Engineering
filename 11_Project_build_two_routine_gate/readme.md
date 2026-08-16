# Project 11: Build a Two-Routine Gate

> **Difficulty:** Medium–Hard · **Concepts:** A3 (The API Trigger), A4 (The Gate), A6 (The Checklist)

## Overview

This is the human gate from Part 5, built out of real parts: one routine drafts, a second routine approves via an API trigger, and you fire the approval yourself.

## Build

1. **Routine A** — on a one-off schedule — drafts something reviewable: a `claude/` branch, or a short summary posted through a connector.
2. **Routine B** — has an **API trigger** and performs one small follow-up action.
3. **Store B's bearer token the moment it is shown**, because it is shown once.
4. **Review A's draft yourself**. Then **approve it by firing B** with the `curl` call from A3.

## Definition of Done

Three things must all be true:

- [ ] B ran **only because you fired it**.
- [ ] B's transcript shows the action **actually happened**.
- [ ] You have run the **A6 checklist** over both routines, with connectors pruned, unrestricted pushes off, and a state file chosen.

> **The lesson:** this is the human gate from Part 5, and now you have built it out of real parts.