# 📅 Project 3: The Morning Brief with a Memory

> **Heartbeat:** Scheduled Loop · **Difficulty:** 🟡 Medium · **Time:** ~45 min
> **Concept:** The **Spine** (`progress.md`) — persistent memory across beats

---

## 🎬 The Scene

A scheduled loop that runs every morning. But here's the catch: **it must not repeat itself.** Each run should pick up where the last one left off — summarizing *new* commits, *new* TODOs, *new* changes.

**This is the "spine" pattern.** Without a spine, every beat is amnesia. With a spine, the loop accumulates knowledge.

---

## 🧠 What You'll Build

```mermaid
flowchart LR
    A[Cron: Daily 9 AM] --> B[Read progress.md]
    B --> C[Gather new data\n(commits, TODOs, etc.)]
    C --> D[Write summary]
    D --> E[Append to progress.md\nwith date]
    E --> F[Next beat starts here]
```

| File | Purpose |
|------|---------|
| `progress.md` | **The Spine** — append-only log of every run |
| `generate_brief.py` | Your data-gathering logic |
| `brief.md` | Today's output (optional) |

---

## 🚀 Quick Start

```bash
mkdir /tmp/morning-brief && cd /tmp/morning-brief && git init
claude
```

> **Inside Claude:**
```
Create a scheduled loop that runs once daily. It should:
1. Read progress.md (the spine)
2. Gather something from the repo (today's commits, open TODOs)
3. Write a short summary
4. Append to progress.md with today's date
```

---

## ✅ Definition of Done

| ✓ | Requirement | The Proof |
|---|-------------|-----------|
| | **Run it twice** | Second run ≠ first run |
| | Second run **builds on first** | `progress.md` shows two dated entries, different content |
| | No repetition | Yesterday's commits don't appear again today |

> **If run 2 starts from zero:** your loop has no spine. Fix `progress.md` read/write.

---

## 💡 The Lesson You'll Take Away

> **A loop without a spine is just a script on a timer.**
>
> The spine (`progress.md`) is what turns "run daily" into "continue daily." It's the difference between:
> - 📝 *Script:* "Here's today's commits" (every day, same logic)
> - 🦴 *Loop:* "Here's what's new since last time" (accumulating context)

---

## 🧪 Try Breaking It

| Sabotage | What You'll Learn |
|----------|-------------------|
| Delete `progress.md` before run 2 | Loop restarts from zero → spine is external, not in-model |
| Corrupt `progress.md` (bad JSON) | Loop crashes → you need validation/guards |
| Run manually with different dates | Time-travel testing → spine must handle gaps |

---

## 🔗 What's Next?

→ [Project 4: A Fix with a Real Checker](../04_Project_a_fix_with_a_real_checker/) — where the loop **writes code** and a **separate checker grades it**.