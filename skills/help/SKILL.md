---
name: help
description: Show all available skills with syntax and examples, grouped by workflow stage. Run this to find the right command for what you need next.
---

Print the following reference. Do not modify or summarize it — output it exactly as written.

---

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CONSULTANT AI — SKILL REFERENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

── SETUP ────────────────────────────────────────────────

/add-course [course name or description]
  Register a course and its frameworks. Run once per course.
  Stores: domain, frameworks, citation style, professor notes.
  Example: /add-course International Business and Global Responsibility

── DECODE ───────────────────────────────────────────────

/brief [file path or pasted text]
  Decode an assignment brief before starting analysis.
  Extracts: domain, deliverable format, marking criteria with weights,
  examiner intent, recommended frameworks, gaps and ambiguities.
  Example: /brief ~/Documents/ae1-brief.pdf
  Example: /brief  (then paste brief text)

── STRUCTURE ────────────────────────────────────────────

/structure [problem description]
  Build a MECE issue tree and initial hypothesis.
  Returns: central question, 2–4 MECE branches, evidence needed per
  branch, framework mapping, and research priority order.
  Example: /structure Should MG Motors enter the Mauritius market?

── RESEARCH ─────────────────────────────────────────────

/research [topic or question]
  Structured research using parallel agents — one per sub-question.
  Includes 5 Advisors validation (Contrarian + First Principles).
  Returns findings with HIGH/MEDIUM/FLAG/DISPUTED/UNVERIFIED confidence.
  Example: /research Nigeria regulatory environment for automotive companies

/framework [framework name]
  Apply a specific framework using the application template.
  Reads course context to flag your current course's frameworks.
  Example: /framework pestel
  Example: /framework porter's five forces
  Example: /framework hofstede
  Available: PESTEL · Porter's Five Forces · CAGE · Hofstede · VRIO ·
  BCG Matrix · Ansoff Matrix · McKinsey 7S · STP · MECE ·
  Pyramid Principle · SCOR · Financial Ratio Analysis · Modes of Entry

── ORCHESTRATE ──────────────────────────────────────────

/consult
  Full project orchestrator. Paste your brief and it handles everything:
  decodes brief → structures problem → selects frameworks → spawns
  research agents → validates with 5 Advisors → synthesizes → drafts.
  Shows a confirmation gate before any long-running step.
  Example: /consult  (then paste brief)

── DRAFT ────────────────────────────────────────────────

/draft [section or "full"]
  Produce a consultant-quality deliverable.
  Formats: slides (insight headers) · written report (SCQA) · memo
  Applies Pyramid Principle. In academic mode: maps to marking criteria,
  applies registered citation style, enforces word/slide count.
  Example: /draft full
  Example: /draft executive summary
  Example: /draft market entry recommendation

/compare [framework-a] [framework-b]
  Synthesize two framework outputs. Finds agreement, resolves conflicts,
  and produces a single combined implication for the central question.
  Example: /compare pestel hofstede
  Example: /compare porter's cage

── QUALITY ASSURANCE ────────────────────────────────────

/review
  Senior partner QA review. Checks: MECE structure · Pyramid Principle ·
  source authority · academic criterion coverage (weight-adjusted score).
  Returns a readiness score /10 with specific fixes.
  Example: /review

/critique
  5 Modes stress-test. Adversarial pressure on the recommendation.
  Modes: Devil's Advocate · Contrarian Investor · Founder Thinking ·
  First Principles · Therapist CEO
  Returns: weakest link · top 3 fixes · what survives scrutiny.
  Example: /critique
  Example: /critique [paste recommendation text]

── OUTPUT ───────────────────────────────────────────────

/publish [output path]
  Compile everything into a self-contained HTML report.
  Applies registered citation style to the works cited section.
  Example: /publish
  Example: /publish ~/Documents/byd-nigeria.html

/references [output path]
  Generate a standalone HTML page with every source, tiered by authority.
  Sources are clickable; search and filter by tier.
  Example: /references
  Example: /references ~/Documents/byd-nigeria-references.html

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TYPICAL WORKFLOW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

New project, fully automated:
  /add-course → /brief → /consult → /review → /critique → /publish

New project, step by step:
  /add-course → /brief → /structure → /research → /framework
  → /draft → /compare → /review → /critique → /publish + /references

Quick draft (no research):
  /brief → /draft → /review → /publish

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
