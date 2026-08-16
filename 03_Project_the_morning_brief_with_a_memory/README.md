# Project 3: The Morning Brief with a Memory

> **Difficulty:** Medium · **Concepts:** Concept 6 (Unattended Schedule), Concept 12 (The Spine)

## Overview

An unattended loop is only useful if it builds on what it did before. This project adds a **spine** — a persistent progress file — so each scheduled run continues where the last one left off instead of restarting from zero.

## Build

1. Make a scheduled loop that runs **once** per beat.
2. It reads `progress.md`, gathers something simple from the repo (open `TODO` comments, or the last day's commits), writes a short summary, and updates `progress.md` with what it found and the date.

## Definition of Done

- [ ] You run it **twice**, and the second run clearly builds on the first — it does not repeat what it already recorded.
- [ ] That proves your spine works. If the second run starts from nothing, your loop has no memory yet.

> **The lesson:** a loop with no spine restarts from zero every beat. The spine is what turns a script into a continuing agent.
