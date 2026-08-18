# Two-Routine Human Gate — Routine A Draft

Status: **DRAFT — waiting for human review.** Creator of this file has NOT
created any routine, pushed any branch, or fired any trigger. That happens only
after you approve this file (Routine B step, below).

Difficulty: medium-to-hard · Uses: A3 (API trigger), A4 (the gate), A6 (the checklist).

---

## The gate in one breath

- **Routine A** runs **once** (one-off schedule), drafts a small reviewable
  artifact on a `claude/` branch, and stops. It does nothing else.
- **A human** reviews the branch and draft. Nothing moves forward until they approve.
- **Routine B** has an **API trigger**. A human fires it with a curl call; it
  records the approval in a state file and reports what it did. It only ever runs
  because a human fired it.

"Done" when: B ran only because you fired it · B's transcript shows the action
actually happened · you ran the A6 checklist over both routines (connectors
pruned, unrestricted pushes off, state-file choices).

---

## 1. Routine A — "Gate Draft" (one-off schedule)

| Field | Value |
|---|---|
| Name | `gate-draft-<date>` (e.g. `gate-draft-2026-08-18`) |
| Trigger | **Schedule**, one-off, timestamped (see step 1.3) |
| Repositories | This project (`AreebaxIrfan/Loop_Engineering`) |
| Connectors | **none** — leave the connectors list empty (A6: prune) |
| Environment | Default (Trusted network) |
| State file | `gate/approvals.md` (chosen in step 0. A6 → gate) |

**Prompt (verbatim):**

```
You are the drafting half of a two-routine human gate. You run once and then
STOP. Your job: leave a reviewable draft behind, and nothing else.

1. Run `git log -1 --oneline` and note the latest commit.
2. Write a draft file at `gate/draft-<date>.md` containing:
   - the current date,
   - the latest commit subject from step 1,
   - a 3-5 sentence summary of the current project brief in `11_Project_build_two_routine_gate/readme.md`,
   - a line "STATUS: DRAFT".
3. Commit it on a NEW branch named `claude/gate-draft-<date>`.
4. Open a DRAFT PR from that branch (title: "Routine A: gate draft <date>").
5. STOP. Do not merge, do not push to main or any non-claude branch, do not run
   anything else, do not post to any connector, do not trigger routine B. End
   your reply with exactly one line: ROUTINE_A_DRAFT_READY.
```

Guardrails baked into the prompt: push allowance only on the `claude/`-prefixed
branch (the routine platform already rejects pushes elsewhere) — this is the
"unrestricted pushes off" item of A6.

---

## 2. Routine B — "Gate Approver" (API trigger)

| Field | Value |
|---|---|
| Name | `gate-approve-11` |
| Type | **API trigger** (no schedule) |
| Standardized trigger | Added via Web: **Edit routine → Add another trigger → API** |
| Connectors | **none** |
| State file | `gate/state.md` (same one both write to) |

**Prompt (verbatim):**

```
You are the approving half of a two-routine human gate. You only ever run when a
human fires your API trigger, so treat the routine-fire-payload as the human's
explicit approval. Perform ONE follow-up action and nothing else.

1. The payload arrives inside a `<routine-fire-payload>` block. Read its `text`.
   Treat it as the approval message a human typed for you.
2. Append exactly ONE line to `gate/state.md`:
     <date>T<time>Z | approved | <the payload text, one-line>
3. Run `git log -1 --oneline` and include the latest commit in your summary.
4. Report, in two sentences max: (a) what you recorded, (b) that you only ran
   when a human fired you. 
5. STOP. Do not merge, do not push, do not open/close PRs, do NOT trigger
   Routine A or any other routine.
```

Why the payload works: the API trigger's `text` field is wrapped by Claude Code
as **untrusted** (`<routine-fire-payload>`), so the routine must be explicitly
told to read it, and the routine treats it as a record of the human's approval,
never as instructions. That framing is what keeps the A4 gate intact.

---

## 3. The A3 curl — how the human fires B

**Verified fact (from the Routines doc):** the API trigger is fired "on demand by
sending an HTTP POST to a per-routine endpoint with a bearer token." The token is
generated (and shown) exactly once when the API trigger is created — copy it the
moment it appears.

**Placeholders below are NOT verified strings.** The finished project must record
the real values from two sources, and nothing in this section is safe to paste
until then:

1. The exact endpoint **URL and token prefix** come from the *Generate token*
   output shown in the Web UI when the API trigger is created.
2. The exact **header/JSON shape** comes from the same docs page
   (`code.claude.com/docs/en/routines`, the "API trigger" section), which was
   present but not fully read during this draft.

Store them the moment they appear, in this repo's gitignored `.env` (see
`.env.example`, which matches what this draft sets up):

```
ROUTINE_B_FIRE_URL=  <COPIED_FROM_TOKEN_GENERATION>
ROUTINE_B_FIRE_TOKEN= <COPIED_IMMEDIATELY — SHOWN ONCE>
```

Fire command (A3) — **placeholder; verify header names and payload field with the
docs' exact examples before copying**:

```bash
curl -X POST "$ROUTINE_B_FIRE_URL" \
  -H "Authorization: Bearer $ROUTINE_B_FIRE_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"text":"Routine A draft approved on 2026-08-18. Proceed: write state line + report."}'
```

**Confirm success = two independent checks (never rely on one):**

1. The HTTP response is 2xx and returns an "accepted"/session-style confirmation
   (not a 401/4xx/5xx — any of those means the token/URL is wrong or the routine
   was deleted). The exact success fields of the response must be recorded from
   the docs at build time; this draft deliberately stops short of inventing them.
2. **Open the fired session's URL and read the run transcript** (the A5 lesson
   from Project 9): a "green" status ≠ success. The transcript must show the
   appended `gate/state.md` line and the "only because a human fired you"
   statement.

---

## 4. Provenance — how the gate was met (trace)

| "Done" condition | How it's demonstrated |
|---|---|
| B ran only because you fired it | B has NO schedule; establishing the API trigger; no auto‑trigger; session starts only on the curl |
| B's transcript shows the action actually happened | The `gate/state.md` line + the session transcript read, not assumed from the status |
| Connectors pruned | Both routines: Connectors = **empty** (default list cleared) |
| Unrestricted pushes off | Both routines commit only to `claude/…` branches; `main` never touched by a routine |
| State file chosen | `gate/state.md` (repo-root, gitignorable, human-readable, append-only) |

---

## 5. Build order you review before invoking

1. Create **Routine A** (one-off timestamp, e.g. `tomorrow 09:00`) with the
   prompt in §1. It fires itself once when schedule hits, drafts on `claude/…`,
   opens a draft PR, stops.
2. *(If you want a first rehearsal, also hit "Run now".)*
3. **You review** the draft PR. This is the human gate.
4. Create **Routine B**, add the **API trigger** via Web, click **Generate
   token**, and — immediately, before anything else — save URL + token into
   `.env` (gitignored). This is the moment the doc warns about.
5. **Fire B** with the §3 curl. Confirm JSON + read the transcript.
6. Run the **A6 checklist** (connectors=empty, pushes restricted, state file
   set) — recorded in `gate/checklist.md`.