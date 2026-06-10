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
  Formats: slides · written report · memo · board brief · issue-action log
  Applies Pyramid Principle. In academic mode: maps to marking criteria,
  applies registered citation style, enforces word/slide count.
  Example: /draft full
  Example: /draft executive summary
  Example: /draft board brief
  Example: /draft issue-action log

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

── PROFESSIONAL MODE ────────────────────────────────────

/client [client name or description]
  Register a client for professional mode work. Saves risk tolerance,
  key stakeholders, constraints, and engagement history.
  /consult reads this to calibrate tone and recommendation framing.
  Example: /client Acme Corp — automotive, conservative risk appetite

/competitor [company name]
  Build a one-page competitor profile using 5 parallel research agents.
  Covers: financials, products/positioning, strategy, leadership,
  weaknesses. Ends with a specific 2–3 sentence threat assessment.
  Includes 5 Advisors validation. Confirmation gate before agents spawn.
  Example: /competitor BYD — in the context of Nigeria market entry
  Example: /competitor Tesla

/size [market description]
  Build a market sizing model: top-down TAM/SAM/SOM + bottom-up
  cross-check. Every assumption sourced or flagged. Sensitivity table
  showing pessimistic/base/optimistic range.
  Example: /size electric vehicles in Nigeria
  Example: /size plant-based food market in the UK

── PROJECT MANAGEMENT ───────────────────────────────────

/save [project-name]
  Save the current session to a named project file for resuming later.
  Captures: central question, hypothesis, research, frameworks, draft
  status, review score, constraints. Also logs to the run log.
  Example: /save byd-nigeria
  Example: /save  (will prompt for a name)

/load [project-name]
  Load a saved project, restoring full context and showing where to resume.
  Example: /load byd-nigeria
  Example: /load  (shows list of saved projects to choose from)

/status
  Show a completion checklist for the current project — what's done,
  what's pending, word/slide count vs. limit, and the single next step.
  Example: /status

/project [command]
  Manage saved projects: create, list, switch, or delete.
  Example: /project list
  Example: /project new mg-mauritius
  Example: /project switch supply-chain-analysis
  Example: /project delete old-project

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TYPICAL WORKFLOW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

New project, fully automated:
  /add-course → /brief → /consult → /review → /critique → /publish → /save

New project, step by step:
  /add-course → /brief → /structure → /research → /framework
  → /draft → /compare → /review → /critique → /publish + /references → /save

Resume a saved project:
  /load [name] → /status → [continue from next step]

Quick draft (no research):
  /brief → /draft → /review → /publish

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
