# Project 5: Codify the Body

> **Difficulty:** Medium–Hard · **Concepts:** Dynamic Workflows interlude, Concepts 8 & 11

## Overview

Take the fix loop you built in Project 4 and **codify its body** — turn the step-by-step prompting into a single reusable engine.

## Build

### On the Claude Code approach

Describe it in plain words:

> "Use a workflow to draft fixes for these three issues in parallel worktrees, and have a reviewer grade each one."

Let the runtime write and run the script. When a run does what you want, save it from the `/workflows` view as a `/command`.

### On the OpenCode approach

Write the same thing as a shell script: a `for` loop over the candidates, `&`/`wait` for the fan-out, and the reviewer's exit code as the checker. Run it twice.

## Definition of Done

Two things must both be true:

1. **One command (or one script) runs the whole draft-and-review body** — meaning several candidates, isolated checkouts, and a verdict for each, with no step-by-step prompting from you.
2. **You have proved the interlude's warning on your own machine:** start a fresh session (or a fresh shell) and confirm the workflow remembers nothing from its last run. Then name what it would need to become a loop: a heartbeat to fire it, and a progress file its agents write.

> **The lesson:** if you can name those two things, you understand the difference between an engine and a loop. (Dynamic workflows are a research preview, so where this project and the live docs disagree, the docs win.)