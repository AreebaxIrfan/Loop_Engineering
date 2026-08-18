# Project 1: In-Session Loop — Watch a Background Task Finish

**Difficulty:** Easy · **Uses:** Concept 4 (In-Session Loop) from Loop Engineering

A tiny hands-on project that proves the simplest heartbeat in loop engineering: a
loop that repeats on a timer **while your session stays open**, and dies the
moment you close it.

---

## What This Does

1. A long-running background task (`long-task.sh`) sleeps for 3 minutes, then
   writes `"done"` to `result.txt`.
2. An in-session loop (`/loop`) checks **every minute** whether `result.txt`
   exists and contains `"done"`.
3. The moment it does, the loop reports it to you **once** and cancels
   itself — no polling by hand, no sitting and watching the terminal.

This is the "kitchen timer" heartbeat: it only rings while you're in the
kitchen (session open). Close the session, and the watching dies with it —
that's not a bug, it's the whole lesson of Concept 4.

---

## Prerequisites

- Claude Code CLI installed and updated (`claude update`)
- A throwaway git repo — **do not** run this in a repo you care about, since
  the agent will create/delete files and run background processes on its own.

---

## Setup

```bash
mkdir loop-practice-1
cd loop-practice-1
git init
claude
```

Say **yes** when Claude asks whether you trust the folder — this switches on
the permissions the session needs so the loop never has to stop and ask you.

---

## Step-by-Step

### 1. Start the long-running task
Ask Claude, in plain language:

```
Create a script called long-task.sh that sleeps for 3 minutes, then writes
"done" into a file called result.txt. Then run it in the background.
```

Claude creates the script and starts it with something like:

```bash
nohup bash -c "sleep 180 && echo done > result.txt" > /dev/null 2>&1 &
```

and reports back a PID. The process now runs independently of your
conversation.

### 2. Set the in-session loop — immediately, before the task finishes

```
/loop 1m check if result.txt exists and contains "done". If it does, tell me
the task finished and then cancel this loop yourself.
```

Claude turns this into a scheduled job (visible via `CronList` under the
hood) that fires every minute, checks the file, and reports back only when
the condition is actually true.

### 3. Confirm the loop registered

```
show my running loops
```

You should see one active job, its schedule (`* * * * *` / every minute),
and the exact prompt it's running.

### 4. Walk away

Don't check `result.txt` or `ps aux` yourself. Don't re-run `show my running
loops` out of curiosity. Leave the terminal open and go do something else for
a few minutes — this is the part that actually proves the loop, not you.

### 5. Let it report

Within ~3 minutes, Claude sends an unprompted message like:

> "Task finished! result.txt now contains 'done'. Cancelling the loop now."

### 6. Verify it stopped cleanly

```
show my running loops
```

The list should now be **empty** — Claude cancelled the job itself, as
instructed. If it's still listed for any reason, cancel it manually:

```
cancel the <job-id> loop
```

---

## Definition of Done

| Requirement | How it's satisfied |
|---|---|
| Loop notices when the task finished | It reads `result.txt` on its own schedule, every minute |
| Reports it once | The prompt explicitly says "tell me... then cancel," so it doesn't repeat |
| Can be stopped cleanly | `show my running loops` returns empty after completion (or manual `cancel`) |
| You never sat watching the terminal | You stepped away between steps 3 and 5 — the loop did the watching |

---

## The One Thing to Remember

This loop's timer lives **inside your open session**. If you close the
terminal or end the session before the task finishes, the loop stops too —
nothing fires, nothing reports back. That limitation is exactly why
Concept 6 (scheduled Routines / cron) and Concept 7 (event-driven loops)
exist: for anything that needs to survive a closed laptop, an in-session
loop is the wrong tool.

---

## Cleanup

```
cancel my running loop
rm -f result.txt long-task.sh
```

Then delete or reuse the throwaway repo as you like.