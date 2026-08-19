# ⏱️ Project 1: The Watcher Loop

> **Heartbeat:** In-Session Loop · **Difficulty:** 🟢 Easy · **Time:** ~15 min

---

## 🎬 The Scene

You kick off a 3-minute background task. You *could* sit there running `ls` every 30 seconds. Or... you spin up a loop that watches for you and taps you on the shoulder when it's done.

**This is the "kitchen timer" loop.** It only rings while you're in the kitchen (session open). Close the laptop? The timer dies with it. That's not a bug — it's the whole lesson.

---

## 🧠 What You'll Build

```mermaid
flowchart LR
    A[Start long-task.sh] --> B[/loop 1m check result.txt/]
    B --> C{result.txt == "done"?}
    C -- No --> B
    C -- Yes --> D[Report once → Cancel loop]
```

| Component | What It Does |
|-----------|--------------|
| `long-task.sh` | Sleeps 180s, writes `"done"` → `result.txt` |
| `/loop 1m ...` | In-session cron: checks file every minute |
| **You** | Walks away. Comes back to a notification. |

---

## 🚀 Quick Start

```bash
# 1. Throwaway repo (required!)
mkdir /tmp/watcher-loop && cd /tmp/watcher-loop && git init

# 2. Open Claude
claude
```

> **Inside Claude:**
```
Create a script called long-task.sh that sleeps for 3 minutes, 
then writes "done" into a file called result.txt. Run it in the background.
```

Then immediately:
```
/loop 1m check if result.txt exists and contains "done". 
If it does, tell me the task finished and cancel this loop yourself.
```

---

## ✅ Definition of Done

| ✓ | Requirement | How You'll Know |
|---|-------------|-----------------|
| | Loop detects completion autonomously | Reads `result.txt` on schedule |
| | Reports **once** | No spam — cancels itself after |
| | Stops cleanly | `show my running loops` → empty |
| | You didn't watch the terminal | You stepped away — loop did the work |

---

## 💡 The Lesson You'll Take Away

> **In-session loops die with the session.**
>
> If you close the terminal before the task finishes, the loop stops. Nothing fires. Nothing reports.
>
> **That's why Concepts 6 & 7 exist:** for anything that must survive a closed laptop, you need *Scheduled* or *Event-Driven* heartbeats.

---

## 🧹 Cleanup

```bash
cancel my running loop
rm -f result.txt long-task.sh
# Delete or reuse the throwaway repo
```

---

## 🔗 What's Next?

→ [Project 2: The Test-Then-Stop Loop](../02_Project_the_test_then_stop/) — where the loop stops because **tests pass**, not because you said so.