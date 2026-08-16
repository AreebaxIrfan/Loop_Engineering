# Loop_Engineering

A hands-on project series for learning **Loop Engineering** — the discipline of building reliable, observable, unattended automation loops with Claude Code.

This repository contains twelve progressive projects. Each one introduces a concept (a "heartbeat") and asks you to build a working loop that demonstrates it. Start at Project 1 and move forward; later projects build on earlier ones.

## The Projects

| # | Project | Difficulty | Core Concepts |
|---|---------|-----------|---------------|
| 1 | [In-Session Loop — Watch a Background Task Finish](01_Project_a_watcher_loop/) | Easy | Concept 4 (In-Session Loop) |
| 2 | [The Test-Then-Stop Loop](02_Project_the_test_then_stop/) | Easy–Medium | Concept 5 (Conditional Loop), Concept 11 (Maker-Checker) |
| 3 | [The Morning Brief with a Memory](03_Project_the_morning_brief_with_a_memory/) | Medium | Concept 6 (Unattended Schedule), Concept 12 (The Spine) |
| 4 | [A Fix with a Real Checker](04_Project_a_fix_with_a_real_checker/) | Medium–Hard | Concept 8 (Worktree), Concept 9 (Skill), Concept 11 (Maker-Checker) |
| 5 | [Codify the Body](05_Project_codify_the_body/) | Medium–Hard | Dynamic Workflows interlude, Concepts 8 & 11 |
| 6 | [The Doorbell Loop](06_Project_the_doorbell_loop/) | Medium | Concept 7 (Event-Driven), Concept 10 (Connectors) |
| 7 | [Back It to Purpose](07_Project_back_it_to_purpose/) | Medium | Observability, Concept 13 (Cost), Concept 14 (Failure) |
| 8 | [Your Daily Loop — Capstone](08_Project_your_daily_loop/) | Capstone | All six parts |
| 9 | [Rehearse a Routine](09_Project_reharease_a_routine_daily/) | Easy | A1, A3 (One-Off Schedules), A5 (Reading Runs) |
| 10 | [Secret Drill](10_Project_secret_drill/) | Hands-on | Secret delivery (local + cloud-runner) |
| 11 | [Build a Two-Routine Gate](11_Project_build_two_routine_gate/) | Medium–Hard | A3 (API Trigger), A4 (The Gate), A6 (The Checklist) |
| 12 | [Build a Dreamy Loop](12_Project_build_dreamy_loop/) | Capstone | Concept 12 (Spine & Improvement Loop), Concept 11, Concept 6, Part 5 (Human Gate) |

## How to Use This Repo

Each project folder is self-contained with its own `README.md`. Most projects ask you to work in a **throwaway git repository** — do not run the loops inside a repository you care about, since the agents create, modify, and delete files on their own.

Work through the projects in order. Where a project states "Done when…", that is your acceptance test: you have finished only once the stated condition actually holds.

## Conventions

- **Difficulty** is a rough guide: *Easy*, *Easy–Medium*, *Medium*, *Medium–Hard*, and *Capstone*.
- **Concepts** map to the Loop Engineering material. Some projects reference a "Part" (a chapter) or an "A" appendix entry rather than a numbered concept; these are preserved as written.
- Projects that list a checklist expect you to tick items off only after the loop has genuinely satisfied them.
