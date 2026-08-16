# Project 2: The Test-Then-Stop Loop

> **Difficulty:** Easy–Medium · **Concepts:** Concept 5 (Conditional Loop), Concept 11 (Maker-Checker)

## Overview

A conditional loop should keep working **until a real condition is met** — and that condition should be decided by a command, not by the agent guessing. This project builds the canonical "loop until green" pattern: the test runner, not the model, decides when the job is done.

## Build

1. Put two or three small **failing tests** in your repo.
2. Build a loop that keeps working until the tests pass — but let a *command* (the test runner), not the agent, decide when it is done.
3. Cap the loop at, say, **six tries**.

## Definition of Done

- [ ] The loop stops **because the tests actually passed**, not because it hit the cap.
- [ ] If it keeps hitting the cap, your stop condition or your prompt needs work — and fixing that is the lesson.

> **The lesson:** the loop's stop signal must come from the world (a passing test), never from the agent's own opinion that it is finished.
