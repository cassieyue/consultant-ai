---
name: load
description: Load a saved project file into the current session, restoring all context so work can continue exactly where it left off. Run at the start of a session when continuing a previous project.
---

Load a saved project into this session.

Project to load: **$ARGUMENTS**

---

## Step 1 — Identify the project

If $ARGUMENTS provides a project name, proceed directly to Step 2.

If $ARGUMENTS is empty:
1. Read `~/.claude/memory/consultant-ai-active-project.md` — if a project name is stored there, offer to load it: "Your last active project was [name] — load that, or choose a different one?"
2. List all files in `~/.claude/projects/consultant-ai/` and show the user their saved projects (name + last updated date from the file header)
3. Ask which to load

---

## Step 2 — Read the project file

Read `~/.claude/projects/consultant-ai/[project-name].md`.

If the file does not exist, tell the user clearly: "No saved project found with that name. Run `/project list` to see what's available."

---

## Step 3 — Set as active project

Write the project name to `~/.claude/memory/consultant-ai-active-project.md` (single line, just the name).

Also read `~/.claude/memory/consultant-ai-courses.md` if it exists — course context applies to this session.

---

## Step 4 — Present the restored context

Display a structured summary so the user and the model both have full context:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PROJECT LOADED: [Project Name]
Last saved: [date]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MODE: [Academic / Professional / Learning]
COURSE: [course name or —]

CENTRAL QUESTION
[question]

HYPOTHESIS
[hypothesis or — if none set]

CONSTRAINTS
[Word/slide limit, deadline, citation style — or "none set"]

MARKING CRITERIA
[list with weights, or — if not academic]

ISSUE TREE
[each branch with complete/pending status]

RESEARCH STATUS
[each completed branch: key finding + confidence]
[pending branches: listed as outstanding]

FRAMEWORKS APPLIED
[each with key conclusion]

DRAFT STATUS
[each section: complete / pending / not started]
[estimated length if known]

QA
Review: [score or not run]
Critique: [yes / no]
Key issues: [list or none]

OUTPUTS
[publish and references paths or not generated]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Step 5 — Recommend the next step

Based on the project state, identify the most logical next action and state it directly:

- If research branches are pending → "Next: `/research [pending branch]`"
- If research is complete but no frameworks applied → "Next: `/framework [recommended framework]`"
- If frameworks applied but no draft → "Next: `/draft full`"
- If draft exists but review not run → "Next: `/review`"
- If review done but critique not run → "Next: `/critique`"
- If QA complete but no outputs → "Next: `/publish` and `/references`"
- If everything done → "This project looks complete. Run `/status` for a full checklist."

State only the single most important next step — do not list all options.
