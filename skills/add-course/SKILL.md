---
name: add-course
description: Register a course and its frameworks so the plugin prioritizes them in future projects. Run once per course at the start of a semester or when covering new topics.
---

You are helping the user register a course so the Consultant AI plugin can prioritize the right frameworks for their projects.

## Steps

1. Gather the following — use $ARGUMENTS as a starting point if provided, otherwise ask:
   - Course name
   - Business domain (strategy, marketing, finance, supply chain, IS, international business, operations)
   - Frameworks and topics currently being covered
   - Any notes on how the professor teaches or emphasizes specific frameworks

2. Read `~/.claude/memory/consultant-ai-courses.md` if it exists. Append the new course without overwriting existing entries.

3. Save the updated file in this format:

```
# Consultant AI — Course Context

## [Course Name]
Added: [today's date]
Domain: [domain(s)]
Frameworks being studied:
- [Framework name]: [any professor-specific notes, e.g. "professor emphasizes applying to emerging markets"]
- [Framework name]: ...
Topics covered so far: [comma-separated list]
Notes: [anything else relevant — assignment types, source requirements, etc.]

---
```

4. Confirm to the user:
   - What was saved
   - How it affects `/consult` — the orchestrator will now prioritize these frameworks when it detects a project in this domain
   - Remind them they can run `/add-course` again to update as the course progresses
