---
name: project
description: Manage saved projects — create, list, switch between, or delete named project files. Use to context-switch between concurrent assignments or to see all work in progress.
---

Manage your saved consultant-ai projects.

Command: **$ARGUMENTS**

---

## Parse the command

Read $ARGUMENTS and route to the matching action:

- `new [name]` → Step A
- `list` (or empty) → Step B
- `switch [name]` → Step C
- `delete [name]` → Step D

If $ARGUMENTS is empty or unrecognized, default to Step B (list projects) and show the available commands.

---

## Step A — New project

Create a new named project and set it as active.

1. Extract the project name from $ARGUMENTS (lowercase, hyphens for spaces). If no name is given after "new", ask: "What should this project be called?"

2. Check whether `~/.claude/projects/consultant-ai/[name].md` already exists. If it does, ask: "A project named [name] already exists (last updated [date]). Overwrite it, or use a different name?"

3. Write a blank project file to `~/.claude/projects/consultant-ai/[name].md`:

```markdown
# [Project Name]
Last updated: [YYYY-MM-DD]
Mode: [not set]
Course: none

## Core
Central question: none
Hypothesis: none

## Constraints
Word limit: none
Deadline: none
Citation style: none

## Marking criteria
none

## Issue tree
none

## Research findings
none

## Frameworks applied
none

## Draft
none
Estimated length: unknown

## QA
Review score: not run
Critique run: no
Key issues: none

## Outputs
Publish: not generated
References: not generated
```

4. Write the project name to `~/.claude/memory/consultant-ai-active-project.md`.

5. Confirm: "Project '[name]' created and set as active. Run `/consult` or `/brief` to start."

---

## Step B — List projects

1. List all `.md` files in `~/.claude/projects/consultant-ai/` — if the directory doesn't exist or is empty, say so.

2. For each file, read the `Last updated` line and `Central question` line.

3. Read `~/.claude/memory/consultant-ai-active-project.md` to identify the currently active project.

4. Display:

```
SAVED PROJECTS
─────────────────────────────────────────
[→ active] project-name        Last saved: YYYY-MM-DD
           Central question: [question, truncated to 70 chars]

           project-name-2      Last saved: YYYY-MM-DD
           Central question: [question]
─────────────────────────────────────────
[N] projects total

Commands: /project new [name] · /project switch [name] · /project delete [name]
To continue a project: /load [name]
```

---

## Step C — Switch project

1. Extract the project name from $ARGUMENTS.

2. Check that `~/.claude/projects/consultant-ai/[name].md` exists. If not, list available projects.

3. Write the new name to `~/.claude/memory/consultant-ai-active-project.md`.

4. Confirm: "Active project switched to '[name]'. Run `/load [name]` to restore full context."

Note: switching the active project does not automatically load it into context — run `/load` to do that.

---

## Step D — Delete project

1. Extract the project name from $ARGUMENTS.

2. Read the project file to confirm it exists and show the user: project name, last updated date, and central question.

3. Ask for confirmation using AskUserQuestion before deleting:
   - **Delete** — permanently remove `~/.claude/projects/consultant-ai/[name].md`
   - **Cancel** — do nothing

4. If confirmed: delete the file. If the deleted project was the active one, clear `~/.claude/memory/consultant-ai-active-project.md`.

5. Confirm deletion and remind the user to run `/project list` to see remaining projects.
