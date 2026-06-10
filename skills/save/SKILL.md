---
name: save
description: Save the current project state to a named file so it can be resumed in a future session. Captures the central question, hypothesis, research findings, frameworks applied, draft status, review score, and constraints. Run at the end of any session you want to continue later.
---

Save this project to disk so it can be resumed with `/load` in a future session.

Project name: **$ARGUMENTS**

---

## Step 1 — Determine the project name

If $ARGUMENTS provides a name, use it (lowercase, hyphens for spaces — e.g., "byd-nigeria").

If $ARGUMENTS is empty, ask the user: "What should this project be saved as?" Suggest a name derived from the company and topic (e.g., "mg-mauritius-entry").

---

## Step 2 — Collect all session artifacts

Review the entire session and extract every available field. Leave a field as "none" if it was not established — do not invent content.

**Core**:
- Central question (exact wording from the issue tree or brief)
- Initial hypothesis (stated before research)
- Mode: Academic / Professional / Learning
- Course name (if academic mode)

**Constraints**:
- Word limit or slide count (state "none" if not given)
- Deadline (convert to YYYY-MM-DD format; state "none" if not given)
- Citation style (from course context or stated in session; state "none" if not set)

**Marking criteria** (academic mode only):
- Each criterion with its weight percentage

**Issue tree**:
- Each branch (sub-question) and whether it was researched (complete / pending)

**Research**:
- For each researched branch: key finding in one sentence + overall confidence (HIGH/MEDIUM/FLAG)

**Frameworks applied**:
- Framework name + key finding or conclusion in one sentence

**Draft**:
- Each section and its status (complete / pending / not started)
- Estimated word or slide count if known

**QA**:
- Review score (N/10 or "not run")
- Critique run (yes / no)
- Key issues flagged (brief list or "none")

**Outputs generated**:
- Publish path (or "not generated")
- References path (or "not generated")

---

## Step 3 — Write the project file

Use the Write tool to save to: `~/.claude/projects/consultant-ai/[project-name].md`

Create the directory if it does not exist: `mkdir -p ~/.claude/projects/consultant-ai`

Use exactly this format:

```markdown
# [Project Name]
Last updated: [YYYY-MM-DD]
Mode: [Academic / Professional / Learning]
Course: [course name or none]

## Core
Central question: [question]
Hypothesis: [hypothesis or none]

## Constraints
Word limit: [N words / N slides / none]
Deadline: [YYYY-MM-DD or none]
Citation style: [style or none]

## Marking criteria
[- Criterion name: weight% (one per line, or "none" if not academic)]

## Issue tree
[- Branch description — status: complete / pending (one per line)]

## Research findings
[- Branch/topic: key finding in one sentence — confidence: HIGH/MEDIUM/FLAG (one per line)]

## Frameworks applied
[- Framework name: key conclusion in one sentence (one per line)]

## Draft
[- Section name — status: complete / pending / not started (one per line)]
Estimated length: [N words / N slides / unknown]

## QA
Review score: [N/10 or not run]
Critique run: [yes / no]
Key issues: [brief list or none]

## Outputs
Publish: [path or not generated]
References: [path or not generated]
```

---

## Step 4 — Append to the run log

Append one line to `~/.claude/memory/consultant-ai-run-log.md` (create the file if it doesn't exist):

```
[YYYY-MM-DD] | [project-name] | [company or market] | [central question, max 80 chars] | [recommendation in one sentence or "in progress"] | [comma-separated list of frameworks used]
```

Then prune any entries older than 6 months from the run log — remove lines where the date is more than 180 days before today.

---

## Step 5 — Confirm

Tell the user:
- File saved to: `~/.claude/projects/consultant-ai/[project-name].md`
- What was captured (checklist: ✓ core, ✓ research N branches, ✓ N frameworks, ✓ draft status, ✓ QA, ✓ run log)
- How to resume: `/load [project-name]`
- How to see all saved projects: `/project list`
