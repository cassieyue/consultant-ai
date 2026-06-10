---
name: status
description: Show a completion checklist for the current project — which phases are done, which are pending, and what to run next. Works within a session or after loading a saved project with /load.
---

Show the current project's completion status.

---

## Step 1 — Read project state

Check two sources in order:

1. **Loaded project file**: If `~/.claude/memory/consultant-ai-active-project.md` exists, read it to get the active project name, then read `~/.claude/projects/consultant-ai/[name].md` for saved state.

2. **Session context**: Supplement (or replace if no file exists) with what has been established in this conversation.

When both are available, session context takes precedence for fields that may have changed since the last `/save`.

---

## Step 2 — Build the checklist

Assess the status of each phase:
- ✓ = complete
- ◐ = partially complete (note what's done vs. remaining)
- ○ = not started

---

## Step 3 — Output the status

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PROJECT STATUS[: project-name if loaded]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SETUP
[✓/○] Course registered (/add-course)
[✓/○] Brief decoded (/brief)

PROBLEM STRUCTURE
[✓/○] Issue tree built (/structure)
      [If ✓: show central question in one line]
      [If ✓: show hypothesis in one line]

RESEARCH                    [N complete / M total branches]
[✓/◐/○] [Branch 1] — [finding in one line, or "pending"]
[✓/◐/○] [Branch 2] — ...
[If pending: → run `/research [branch description]`]

FRAMEWORKS                  [N applied]
[✓/○] [Framework name] — [key conclusion in one line, or not applied]
[If not applied: → run `/framework [name]`]

DRAFT                       [N/M sections complete]
[✓/◐/○] [Section name] — [complete / pending]
[If pending: → run `/draft [section]` or `/draft full`]

WORD / SLIDE COUNT
[N words used / limit: M — within limit]
  OR
[N words — N over M-word limit (see /draft output for cuts)]
  OR
[No constraint set]

QA
[✓/○] Review — [score/10 or not run → run `/review`]
[✓/○] Critique — [run or not run → run `/critique`]
[If issues outstanding: list top 2]

OUTPUT
[✓/○] Report published — [path or not generated → run `/publish`]
[✓/○] References page — [path or not generated → run `/references`]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NEXT STEP
[Single most important action to take, with the exact command to run]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Next step logic

Pick the earliest incomplete phase:
1. Course not registered → `/add-course`
2. Brief not decoded → `/brief`
3. Issue tree missing → `/structure`
4. Research branches pending → `/research [branch]` (name the specific branch)
5. No frameworks applied and research complete → `/framework [recommended]`
6. Draft not started → `/draft full`
7. Draft sections pending → `/draft [section name]`
8. Over word/slide limit → "Trim draft — see count details from last `/draft` run"
9. Review not run → `/review`
10. Critique not run → `/critique`
11. Outputs not generated → `/publish` then `/references`
12. Everything complete → "Run `/save [name]` to preserve this session before closing"
