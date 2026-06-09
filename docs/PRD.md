# Product Requirements Document
# Consultant AI — Claude Code Plugin

**Version**: 1.0  
**Status**: In development  
**Last updated**: 2026-06-08

---

## 1. Problem Statement

Business students and early-career professionals consistently face the same gap: they know frameworks from class but struggle to apply them rigorously to real problems. The typical workflow — read brief, open browser, write slides — produces descriptive work rather than analytical work. It misses the structure, source rigor, and communication style that separates good business analysis from great consulting.

There is no tool that embeds consulting methodology — hypothesis-driven thinking, MECE structuring, Pyramid Principle communication — into the research and writing process itself. Students spend time formatting and researching in isolation rather than thinking.

---

## 2. Goals

### Primary goal
Produce consultant-quality business analysis — McKinsey, BCG, Deloitte standard — for any business project, regardless of domain or deliverable format.

### Secondary goals
- Reduce the time from brief to first draft
- Help students learn to apply frameworks correctly, not just describe them
- Adapt to academic requirements (marking criteria, source hierarchy, citation format) without requiring manual mapping
- Enable parallel research that would otherwise be done sequentially

### Non-goals
- Generate formatted output files (PowerPoint, PDF, Word) — out of scope for v1
- Replace a student's own thinking — the plugin structures and accelerates, it does not substitute judgment
- Primary research (interviews, surveys) — plugin handles secondary research only
- Real-time collaboration or multi-user features

---

## 3. Users

### Persona 1 — Business student (academic mode)
- Undergraduate or postgraduate business student
- Taking courses across multiple domains: strategy, marketing, finance, supply chain, international business, IS
- Has assignments with marking criteria, source requirements, and specific deliverable formats
- Knows frameworks from class but unsure how to apply them rigorously to a new case
- Needs to produce high-quality work efficiently without always having a tutor available

### Persona 2 — Student learning a framework (learning mode)
- Same as above, but specifically working to understand and apply a framework currently being taught
- Wants to see the framework applied step-by-step with explanation, not just a finished output
- Benefits from seeing why each step follows the framework's logic

### Persona 3 — Early-career professional (professional mode)
- Analyst, associate, or intern at a consulting firm, bank, or corporate strategy team
- Needs to structure problems, research quickly, and produce polished deliverables
- Does not need explanations — needs speed and rigor
- May be working on real client deliverables where quality and citation accuracy matter

---

## 4. Modes

The plugin operates in three modes, detected automatically from the brief and adjustable by the user.

| Mode | Trigger signals | Behavior |
|---|---|---|
| **Academic** | Marking criteria present, rubric referenced, professor/submission mentioned | Applies course-registered frameworks first, maps content to each criterion by weight, enforces source hierarchy, formats citations |
| **Learning** | User is studying a specific framework, course context matches | Applies the framework and explains each step — teaches through doing, connects to course theory |
| **Professional** | No academic signals, internship or work context, no marking criteria | Full hypothesis-driven analysis, MECE, Pyramid Principle, no explanatory hand-holding |

---

## 5. Skills (Features)

### 5.1 `/consult` — Orchestrator
**What it does**: Full end-to-end workflow for a new project. Single entry point that handles everything automatically.

**Inputs**: Business brief (pasted text, uploaded file, or verbal description)

**Process**:
1. Load course context from memory
2. Decode brief: domain, mode, deliverable format, constraints, marking criteria
3. Confirm reading with user
4. Build MECE issue tree and state initial hypothesis
5. Select frameworks (course-prioritized)
6. Spawn parallel research agents — one per issue tree branch
7. Synthesize findings using Pyramid Principle
8. Draft deliverable in required format

**Output**: Complete analysis and draft deliverable

**Acceptance criteria**:
- Correctly identifies domain in ≥1 of: strategy, marketing, finance, supply chain, IS, international business, operations
- Produces a MECE issue tree with 2–4 branches
- States a hypothesis before researching (not after)
- Spawns ≥2 parallel agents for multi-branch problems
- Draft follows Pyramid Principle: answer first, arguments, evidence
- In academic mode: every marking criterion is explicitly addressed

---

### 5.2 `/add-course` — Course context registration
**What it does**: Registers a course and its frameworks so the plugin can prioritize them in future sessions.

**Inputs**: Course name, topics, frameworks being studied, professor-specific notes (optional)

**Process**: Appends course entry to `~/.claude/memory/consultant-ai-courses.md`

**Output**: Confirmation of what was saved; explanation of how it affects `/consult` and `/framework`

**Acceptance criteria**:
- Adds entry without overwriting existing courses
- Stored in structured, human-readable format
- Course context is loaded and applied correctly in subsequent `/consult` and `/framework` invocations

---

### 5.3 `/structure` — MECE issue tree builder
**What it does**: Frames any business problem as a structured issue tree before research begins.

**Inputs**: Problem description or question

**Output**:
- Central question (formatted as "How should X do Y to achieve Z?")
- Initial hypothesis (provisional answer)
- 2–4 MECE branches with sub-questions
- Evidence needed per branch
- Framework mapping per branch
- Research priority order (parallel vs. sequential)

**Acceptance criteria**:
- Branches pass MECE test (no overlap, collectively exhaustive)
- Hypothesis is stated before evidence is gathered
- Framework recommendations match the branch's analytical need

---

### 5.4 `/framework` — Framework application
**What it does**: Applies a named business framework to the current project context.

**Inputs**: Framework name (supports common shorthand: "pestel", "5 forces", "hofstede", etc.)

**Process**:
1. Identify framework and read application template from `~/.claude/consultant-ai/frameworks/`
2. Load course context for professor-specific emphasis
3. Collect project context if not already known
4. Work through each dimension: data → implication → so what
5. Use WebSearch to fill data gaps
6. Synthesize: overall finding, key insights, limitations

**Output**: Fully applied framework with dimension-by-dimension analysis, synthesis, and actionable insights

**Supported frameworks**: See Section 6

**Acceptance criteria**:
- Each dimension produces a "so what" — not just a description
- Data gaps are flagged, not silently omitted
- In learning mode: explains the logic of each step after applying it
- Synthesis states 1–2 actionable insights, not just observations

---

### 5.5 `/research` — Parallel research
**What it does**: Conducts structured research on a specific question using parallel agents.

**Inputs**: Research question or topic

**Process**:
1. Decompose question into 3–5 sub-questions
2. Spawn one agent per sub-question simultaneously
3. Each agent searches for authoritative sources and extracts specific data points
4. Evaluate source authority and flag weak sources
5. Synthesize across all agents: finding, confidence level, gaps

**Source priority**: Academic journals/textbooks → Government/multilateral reports (World Bank, IMF, OECD) → Specialist press (FT, Bloomberg, HBR) → Quality news

**Output**: Per sub-question: finding, key data points with attribution, source citations, so what. Overall: answer, confidence, gaps.

**Acceptance criteria**:
- ≥2 agents spawned in parallel for any multi-part question
- Every data point attributed to a specific source
- Source authority is assessed, not assumed
- Gaps are explicitly surfaced

---

### 5.6 `/draft` — Deliverable production
**What it does**: Produces polished, consultant-quality output in the required format.

**Inputs**: Section name or "full"; deliverable format (slides, report, memo)

**Format behaviors**:

*Slides*: Each header is an insight sentence (not a label). Bullets support the header. 3–5 bullets max. Charts/visuals described. References included.

*Report*: SCQA opening. Each section leads with the key finding. Short paragraphs, active voice, specific numbers. Executive summary first.

*Memo*: Situation → Complication → Question → Answer. 1–3 pages. Decision-maker focused.

**Acceptance criteria**:
- No slide header is a label — every header contains a claim
- No vague assertions — all data points are specific and attributed
- Active voice throughout
- In academic mode: marking criteria mapped to sections; citation format matches course requirements
- No filler phrases ("it can be argued that", "in conclusion", "there are many factors")

---

### 5.7 `/review` — Quality review
**What it does**: Senior partner QA of completed work before submission.

**Checks**:
- Structure: MECE, Pyramid Principle, central question answered
- Content: claims supported, data specific, frameworks correctly applied, clear recommendation
- Sources: authority level appropriate, citations complete
- Academic compliance: criteria coverage, weighting, format requirements
- Consulting writing: insight headers, active voice, no hedging, specific recommendation

**Output**: Readiness score (1–10), critical issues, important issues, minor issues, what it takes to reach 10/10

**Acceptance criteria**:
- Every finding references a specific part of the work
- Distinguishes critical (must fix) from minor (nice to fix)
- Provides actionable fix for each issue, not just identification

---

## 6. Framework Library

### v1 frameworks (15 templates)

| Framework | File | Domain |
|---|---|---|
| PESTEL Analysis | `pestel.md` | International Business, Strategy |
| Hofstede's Cultural Dimensions | `hofstede.md` | International Business |
| CAGE Distance Framework | `cage.md` | International Business |
| Modes of Entry | `modes-of-entry.md` | International Business |
| Porter's Five Forces | `porters-five-forces.md` | Strategy |
| VRIO Framework | `vrio.md` | Strategy |
| McKinsey 7S | `mckinsey-7s.md` | Strategy, Change Management |
| Ansoff Matrix | `ansoff.md` | Strategy, Marketing |
| BCG Growth-Share Matrix | `bcg.md` | Strategy, Marketing |
| STP Framework | `stp.md` | Marketing |
| Financial Ratio Analysis | `ratio-analysis.md` | Finance |
| SCOR Model | `scor.md` | Supply Chain |
| MECE Structuring | `mece.md` | Consulting Method |
| Pyramid Principle | `pyramid-principle.md` | Consulting Method |

### Each template includes
- When to use this framework
- What data to collect per dimension
- How to structure the analysis
- What the "so what" insight should look like
- Common mistakes to avoid

### Adding frameworks
Create a `.md` file in `frameworks/` following the template structure above. Add an entry to `frameworks/index.md` under the appropriate domain.

---

## 7. Course Context System

Course context allows the plugin to prioritize frameworks the user is currently studying, reducing irrelevant suggestions and enabling learning mode.

**Storage**: `~/.claude/memory/consultant-ai-courses.md`  
**Format**: Structured markdown with course name, domain, frameworks, topics, notes  
**Updated via**: `/add-course` skill  
**Read by**: `/consult` (framework selection step), `/framework` (learning mode detection)

The course context is intentionally stored in Claude's memory system (not the repo) because it is personal to the user and changes frequently as courses progress.

---

## 8. Architecture

### Components

| Component | Location | Purpose |
|---|---|---|
| Skills (slash commands) | `commands/*.md` → symlinked to `~/.claude/commands/` | Prompt files that define each skill's behavior |
| Framework templates | `frameworks/*.md` → symlinked to `~/.claude/consultant-ai/frameworks/` | Application guides read by the `/framework` skill |
| Framework index | `frameworks/index.md` | Maps domains to frameworks; read by `/consult` and `/structure` |
| Course context | `~/.claude/memory/consultant-ai-courses.md` | User-specific, not tracked in repo |
| Setup script | `setup.sh` | Creates symlinks on installation |

### Design decisions

**No MCP server**: All functionality is delivered through skill prompts and Claude's built-in tools (WebSearch, Agent, Read). An MCP server would add build and maintenance overhead without meaningful capability gain for v1.

**Symlink pattern**: Skills and frameworks live in the git repo for version control. Symlinks into `~/.claude/` give Claude Code global access without duplicating files.

**Framework knowledge source**: Claude's training data contains accurate knowledge of all supported frameworks. The template files store *application guidance* — what to collect, how to structure, what to conclude — not framework definitions.

**Parallel agents**: Research and framework application use the Agent tool with parallel spawning. This is the primary performance mechanism — a 5-branch issue tree researched sequentially takes 5x longer than in parallel.

---

## 9. Success Metrics

| Metric | Target |
|---|---|
| Time from brief to first draft | < 30 minutes for a standard 10-slide deck |
| Framework application accuracy | Correct dimension-level analysis with no missing "so what" |
| Academic criterion coverage | 100% of stated marking criteria explicitly addressed in draft |
| Source authority | ≥ 70% of citations from tier 1a/1b sources (academic, government, multilateral) |
| Review readiness score | First draft consistently scores ≥ 7/10 before revision |

---

## 10. Limitations (v1)

- **Text output only**: Does not generate formatted files (PowerPoint, PDF, Word). User copies content into their tool of choice.
- **Secondary research only**: Uses web search for published sources. Cannot conduct interviews, surveys, or access paywalled databases.
- **Single user**: No collaboration, sharing, or multi-user state.
- **No persistent project memory across sessions**: Research and drafts are not automatically saved between Claude Code sessions. User should save outputs manually.
- **Framework library is curated, not exhaustive**: 15 frameworks cover the most common business school domains. Niche or advanced frameworks require manual addition.

---

## 11. Future Opportunities

| Opportunity | Description | Complexity |
|---|---|---|
| Formatted output export | Generate `.pptx`, `.docx`, or `.pdf` from draft content via MCP server | High |
| Project persistence | Save research, outlines, and drafts across sessions automatically | Medium |
| Expanded framework library | Add: DuPont, DCF, Make-vs-Buy, Value Chain, 4Ps, SWOT, Blue Ocean, Balanced Scorecard, and IS frameworks | Low |
| Quantitative analysis | Integrate with data tools for financial modeling, market sizing calculations | High |
| Citation management | Auto-format references in APA, Harvard, Chicago styles | Medium |
| Competitor / company lookup | Structured company and market data via a financial data API | High |
