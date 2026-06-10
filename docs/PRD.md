# Product Requirements Document
# Consultant AI — Claude Code Plugin

**Version**: 1.1  
**Status**: Active  
**Last updated**: 2026-06-09

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
6. **Confirmation gate**: show research plan (sub-questions, agent count, estimated time); offer Full research / Quick draft / Edit scope
7. Spawn parallel research agents — one per issue tree branch
8. **Error recovery**: if agents fail partially, surface which sub-questions are missing and ask retry / continue / abort; do not synthesize with fewer than 2 usable findings
9. **5 Advisors validation**: extract 5–8 key claims; spawn Contrarian agent (tries to refute each claim) and First Principles agent (verifies primary source traceability) in parallel; score claims HIGH / MEDIUM / FLAG / DISPUTED / UNVERIFIED
10. Synthesize only HIGH and MEDIUM findings using Pyramid Principle; surface DISPUTED/UNVERIFIED claims in a separate Caveats block
11. Draft deliverable in required format

**Output**: Complete analysis and draft deliverable with per-claim confidence scores and a caveats block for disputed findings

**Acceptance criteria**:
- Correctly identifies domain in ≥1 of: strategy, marketing, finance, supply chain, IS, international business, operations
- Produces a MECE issue tree with 2–4 branches
- States a hypothesis before researching (not after)
- Confirmation gate fires before any agent is spawned — user always approves
- Spawns ≥2 parallel agents for multi-branch problems
- Validation agents run after research; every key claim has a confidence tier
- Synthesis cites only HIGH/MEDIUM claims; DISPUTED/UNVERIFIED appear in Caveats
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
**What it does**: Conducts structured research on a specific question using parallel agents, then validates key claims before synthesis.

**Inputs**: Research question or topic

**Process**:
1. Decompose question into 3–5 sub-questions
2. **Confirmation gate**: show sub-question list; offer Start research / Edit sub-questions
3. Spawn one agent per sub-question simultaneously
4. **Error recovery**: if agents fail partially, surface missing sub-questions and ask retry / continue / abort; minimum 2 usable sub-questions before synthesis
5. **5 Advisors validation**: extract key claims; run Contrarian and First Principles agents in parallel; score each claim HIGH / MEDIUM / FLAG / DISPUTED / UNVERIFIED
6. Synthesize only HIGH/MEDIUM findings; surface DISPUTED/UNVERIFIED in a Caveats block

**Source priority**: Academic journals/textbooks → Government/multilateral reports (World Bank, IMF, OECD) → Specialist press (FT, Bloomberg, HBR) → Quality news

**Output**: Per sub-question: finding, key data, sources, confidence tier, so what. Overall: validated answer, confidence, gaps, caveats.

**Acceptance criteria**:
- Confirmation gate fires before agents are spawned
- ≥2 agents spawned in parallel for any multi-part question
- Every data point attributed to a specific source with confidence tier
- DISPUTED and UNVERIFIED claims isolated in Caveats, not used in synthesis
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

### 5.8 `/brief` — Brief decoder
**What it does**: Decodes any assignment brief or project description into a structured analysis before any research begins.

**Inputs**: File path (PDF) or pasted text via `$ARGUMENTS`; falls back to asking if empty

**Process**:
1. Read the brief (file or text)
2. Load course context to identify currently-studied frameworks
3. Extract and present: domain, mode, deliverable format, constraints, central question, examiner intent, marking criteria with weights, recommended frameworks (flagging course-registered ones), gaps and ambiguities
4. Close with a one-line next-step recommendation

**Output**: Structured breakdown + recommended next command

**Acceptance criteria**:
- Extracts marking criteria with percentage weights when present
- Flags course-registered frameworks as priority
- Surfaces ambiguities that affect analytical approach (e.g. no country specified, weighting not given)
- "Examiner intent" goes beyond restating the brief — reads what a high mark actually requires

---

### 5.9 `/critique` — Adversarial stress-test
**What it does**: Applies the 5 Modes framework to find specific weaknesses in a recommendation or plan before submission.

**Inputs**: Recommendation, plan, or draft section via `$ARGUMENTS` or pasted after invocation

**Process**:
1. Classify the decision type: recommendation logic / market selection / strategic direction / plan feasibility / root cause analysis
2. Select 2–3 modes based on decision type and explain the selection
3. Apply each mode analytically (no agent spawning — reasoning lenses on existing work):
   - **Devil's Advocate**: logical gaps, unaddressed alternatives, examiner attack vector
   - **Contrarian Investor**: downside scenario, probability-weighted risk, opportunity cost, bet verdict
   - **Founder Thinking**: patch vs. solve, first-best solution, real vs. assumed constraints
   - **First Principles**: established facts vs. inferences vs. assumptions, where the evidence chain breaks
   - **Therapist CEO**: stated vs. actual problem, structural reasons the recommendation may fail
4. Produce a verdict: weakest link (one sentence), top 3 fixes, what survives scrutiny

**Output**: Per-mode structured critique + combined verdict

**Acceptance criteria**:
- Mode selection is explained before critique runs
- Every finding references a specific claim or section in the work — no generic consulting observations
- "Weakest link" is a single, specific sentence
- "What survives scrutiny" is honest — not softened praise

---

### 5.10 `/references` — Source verification page
**What it does**: Generates a standalone HTML page with every source from the session as a clickable link, grouped by authority tier, with a live search filter.

**Inputs**: Optional output path; defaults to `~/Documents/[project]-references.html`

**Process**:
1. Scan session for all cited sources
2. Classify each into: Tier 1 Academic / Tier 2 Institutional / Tier 3 Specialist press / Tier 4 General press
3. For each source: record title, publication, author, year, URL (only if real — never invented), and what claim it was used to establish
4. Write self-contained HTML with sticky search bar, tier filter buttons, and color-coded source cards

**Output**: HTML file at specified path

**Acceptance criteria**:
- Every source has a "used to establish" note — not just a citation
- URLs are only included when genuinely known; no invented URLs
- Search and tier filter work without external dependencies
- Unlinked sources are clearly labelled as such

---

### 5.11 `/publish` — HTML report
**What it does**: Compiles all session analysis into a self-contained HTML report with cover page, table of contents, all framework outputs, recommendation block, and alphabetically sorted works cited.

**Inputs**: Optional output path; defaults to `~/Documents/[project]-report.html`

**Process**:
1. Collect all session content: executive summary, research findings, framework analyses, recommendation, sources
2. Compile works cited — deduplicated, alphabetically sorted, formatted by source type
3. Write self-contained HTML (all CSS inline, no external dependencies, no JavaScript required)

**Output**: HTML file openable in any browser; printable to PDF

**Acceptance criteria**:
- Every specific data point in the body has an inline citation number
- Section headings are insights, not labels
- Works cited is complete, deduplicated, and alphabetically sorted
- File has no external dependencies — opens in any browser with no network access

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
| Root orchestrator | `SKILL.md` → symlinked to `~/.claude/commands/consult.md` | `/consult` — full end-to-end workflow |
| Skills (slash commands) | `skills/[name]/SKILL.md` → symlinked to `~/.claude/commands/` | 10 individual skills: brief, add-course, structure, research, framework, draft, critique, review, publish, references |
| Shared agent rules | `agents/shared-rules.md` | Cross-cutting consultant standards applied by all spawned agents |
| Framework templates | `reference/frameworks/*.md` → symlinked to `~/.claude/consultant-ai/frameworks/` | Application guides read by the `/framework` skill |
| Framework index | `reference/frameworks/index.md` | Maps domains to frameworks; read by `/consult` and `/structure` |
| Output templates | `templates/slides.md`, `report.md`, `memo.md` | Format guides read by `/draft` |
| Course context | `~/.claude/memory/consultant-ai-courses.md` | User-specific, not tracked in repo |
| Setup script | `setup.sh` | Creates all symlinks on installation |

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

## 10. Limitations (v1.1)

- **No native formatted file output**: Does not generate PowerPoint, PDF, or Word files. `/publish` produces a self-contained HTML report printable to PDF from any browser; user must manually format slides.
- **Secondary research only**: Uses web search for published sources. Cannot conduct interviews, surveys, or access paywalled databases (JSTOR, EBSCO, ProQuest).
- **Single user**: No collaboration, sharing, or multi-user state.
- **No persistent project memory across sessions**: Research, findings, and drafts are not automatically saved between Claude Code sessions. Use `/publish` and `/references` to write outputs to disk before closing a session.
- **Framework library is curated, not exhaustive**: Templates cover the most common business school domains. Niche or advanced frameworks fall back to Claude's training knowledge without a calibrated application guide.

---

## 11. Gap Analysis

A structured review of missing capabilities across all dimensions of the plugin. Each gap is rated by complexity (Low / Medium / High) and impact (High / Medium).

---

### 11.1 Output & Delivery

| Gap | Why it matters | Complexity | Impact | Status |
|---|---|---|---|---|
| **No file output** — draft content is text only, user must copy-paste into Google Slides, Word, etc. | Breaks flow; formatting is lost in translation; adds 30+ minutes of manual work per project | High (MCP + library like `python-pptx` or Pandoc) | High | Open |
| ~~**No HTML export**~~ | ~~Solves 70% of the file output problem with Low complexity~~ | ~~Low~~ | ~~High~~ | **Resolved** — `/publish` writes self-contained HTML report; `/references` writes clickable source verification page |
| **No Markdown tables for quantitative frameworks** — ratio analysis, Porter's force ratings, BCG positioning are described in prose instead of rendered as tables | Tables are standard in consulting deliverables; prose versions are harder to read and weaker analytically | Low (prompt update) | Medium | Open |
| ~~**No citation file export**~~ | ~~Students need a clean, copyable reference list; manual extraction is error-prone~~ | ~~Low~~ | ~~High~~ | **Resolved** — `/references` generates a full source verification HTML page with clickable links grouped by authority tier |

---

### 11.2 Project Management & Session Persistence

| Gap | Why it matters | Complexity | Impact |
|---|---|---|---|
| **No project state saved between sessions** — issue tree, research findings, framework outputs, and drafts are lost when Claude Code closes | Projects span days or weeks; students cannot pick up where they left off without re-running everything | Medium (`/save` and `/load` commands writing to a project file) | High |
| **No `/status` command** — no way to see which branches have been researched, which frameworks applied, whether a draft exists | Users lose track of progress on multi-day projects; no checklist or completion view | Low/Medium (requires project state persistence) | High |
| **No multi-project support** — course context is global; a student with 3 concurrent assignments has no way to context-switch cleanly | Business students routinely run 3–5 assignments in parallel across different courses | Medium (namespaced project files + `/project new/list/switch`) | Medium |
| **No deadline or constraint persistence** — word count, slide limit, and submission deadline are extracted but not saved | Users must re-state constraints each session; academic format errors are a direct mark loss | Low (structured constraints block in project state file) | Medium |

---

### 11.3 Research Quality

| Gap | Why it matters | Complexity | Impact | Status |
|---|---|---|---|---|
| ~~**No contradiction detection**~~ | ~~Conflicting GDP figures or market sizes passed to synthesis create inaccurate analysis~~ | ~~Low~~ | ~~Medium~~ | **Resolved** — 5 Advisors Contrarian agent actively tries to refute each key claim; DISPUTED claims are excluded from synthesis |
| ~~**No source authority validation**~~ | ~~Outdated or secondary-only sources cited as fact undermine credibility~~ | ~~Low~~ | ~~Medium~~ | **Resolved** — 5 Advisors First Principles agent verifies primary source traceability; SECONDARY-ONLY and UNVERIFIABLE claims are confidence-scored and surfaced in Caveats |
| **No access to paywalled academic databases** — WebSearch returns open-web results; institutional databases (JSTOR, EBSCO, ProQuest) are inaccessible | Academic mode requires journal citations; web search may not surface sufficient tier-1a sources | High (browser automation or library API) | Medium | Open |
| **No structured company financial data source** — `/framework ratio-analysis` requires the user to supply the numbers | Applying ratio analysis without actual financials is a framework template, not analysis | High (API); Medium (agents scraping annual reports and IR pages) | High | Open |
| **No primary research scaffolding** — plugin handles secondary research only; no interview guides, survey templates, or qualitative synthesis | Professional consulting frequently requires primary research; some academic cases do too | Medium (new `/research-guide` skill) | Medium | Open |

---

### 11.4 Framework Coverage

| Gap | Why it matters | Complexity | Impact |
|---|---|---|---|
| **Frameworks listed in `index.md` but missing template files** — SWOT, Value Chain, 4Ps, DuPont, DCF, Blue Ocean, Make-vs-Buy, TCO, BCG (partial), Balanced Scorecard, Customer Journey, Business Model Canvas, and IS frameworks have no `.md` file | `/framework swot` falls back to generic Claude knowledge instead of a calibrated application guide; inconsistent quality | Low (each template ~1 hour to write) | High |
| **No framework combination guidance** — when PESTEL feeds Porter's Five Forces, or VRIO informs Modes of Entry, there is no guidance on connecting their outputs | Students apply frameworks in silos, producing disconnected sections rather than integrated analysis | Low (add "when to combine" section to templates + prompt in `/consult`) | Medium |
| **Missing frameworks for common domains** — Balanced Scorecard, Stakeholder Analysis, Business Model Canvas, DMAIC/Lean Six Sigma, CVP analysis, Risk Matrix, RACI | Standard in MBA curricula; encountering them falls back to generic Claude knowledge | Low per framework | Medium |

---

### 11.5 User Workflow

| Gap | Why it matters | Complexity | Impact | Status |
|---|---|---|---|---|
| **No iterative issue tree revision** — if research overturns the hypothesis, there is no `/structure update` flow | Consulting is iterative; the current flow treats the issue tree as immutable | Low (prompt update to `/structure`) | Medium | Open |
| **No `/compare` command** — after applying two frameworks to the same problem, there is no synthesis of where they agree or conflict | Students produce adjacent frameworks instead of integrated analysis; this is the most common quality gap in academic work | Low (new skill reading previous outputs) | Medium | Open |
| ~~**No PDF brief parsing**~~ | ~~Most academic assignments are delivered as PDFs; auto-parsing eliminates manual re-typing of criteria~~ | ~~Low~~ | ~~High~~ | **Resolved** — `/brief` reads PDFs and text, extracts domain/mode/marking criteria/examiner intent/recommended frameworks |
| **No `/help` command** — new users must exit to the README to find command syntax | Plugin discoverability drops without in-context help | Low (static markdown skill) | Medium | Open |
| **`/draft` requires manual context supply** — user must paste previous research and framework outputs if they used step-by-step skills | Significant friction after a manual workflow; breaks the step-by-step path | Medium (requires session state persistence) | High | Open |
| **No word/slide count enforcement** — `/draft` mentions constraints but does not flag when output exceeds them | Academic submissions have hard limits; over-length drafts require manual cutting | Low (prompt update) | Medium | Open |

---

### 11.6 Academic Use Case

| Gap | Why it matters | Complexity | Impact |
|---|---|---|---|
| **No citation style enforcement** — the plugin flags that style should match the course requirement but does not actively format citations | Citation formatting is directly marked in most business school courses | Low (`/add-course` captures style; `/draft` and `/research` apply it) | High |
| **Rubric not parsed from PDF** — marking criteria are only extracted if the user pastes them; rubric tables in PDF briefs are not auto-read | Misinterpreting a 30% criterion vs. a 10% one is a significant quality risk | Low (prompt fix to read attached PDF and extract rubric table) | High |
| **`/review` not weighted by rubric** — the review checklist is fixed regardless of the actual marking criteria percentages | A 7/10 score means nothing without knowing whether the highest-weighted criterion was addressed proportionally | Medium (review skill must weight its assessment against actual rubric weights) | High |
| **No learning scaffolding for exam prep** — learning mode explains framework application but does not support studying: no summaries, no framework comparisons, no practice questions | Students use the tool not just for assignments but to study; exam prep is a high-value adjacent use case | Low/Medium (new `/learn` skill or mode extension) | Medium |

---

### 11.7 Professional Use Case

| Gap | Why it matters | Complexity | Impact |
|---|---|---|---|
| **No client context system** — professional mode has no concept of a named client with persistent context (industry, risk tolerance, preferences) | Every session starts from scratch; a real engagement spans weeks and accumulates context | Medium (new `/client` command analogous to `/add-course`) | Medium |
| **No `/competitor` skill** — no structured way to profile a competitor (financials, strategy, products, leadership, recent moves) | Competitor profiling is one of the most common early consulting tasks | Low/Medium (parallel agent set per topic area) | High |
| **No market sizing skill** — TAM/SAM/SOM and bottom-up sizing models are referenced but not computable | Telling a client "the market is approximately $X" without a defensible model is not consulting | Medium (new `/size [market]` skill with structured top-down arithmetic) | High |
| **No quantitative modeling** — break-even, scenario modeling, sensitivity analysis, DCF cannot be computed | Professional consulting work always involves numbers; the plugin can structure but not calculate | High (requires computational tools or MCP) | High |
| **Limited deliverable formats** — only slides, report, and memo; missing board briefings, status updates, steering committee decks, Issue-Action logs | Interns and analysts on real engagements need these formats | Low (additional format options in `/draft`) | Medium |

---

### 11.8 Platform & Integration

| Gap | Why it matters | Complexity | Impact |
|---|---|---|---|
| **No Google Slides / PowerPoint export** — most common destination for slide output | Manually creating 10+ slides from terminal output takes 30+ minutes | High (Google Slides API or `python-pptx` via MCP) | High |
| **No Notion / Google Docs export for reports** — work product stays in the terminal | Students and professionals organize work in collaborative documents, not CLI output | High for real integration; Low for Markdown-to-file output (importable by both) | High |
| **Symlink-based install is high friction** — `git clone`, `chmod +x`, `./setup.sh`, understanding symlinks | Target users are business students and consultants, not developers; drop-off risk is high | Medium (one-line install script, better error messages, a sanity-check command) | High |
| **Single-machine, no sync** — course context and project files live on one machine only | A student on two devices has two separate plugin instances with no shared state | Medium (use cloud-synced folder for `~/.claude/consultant-ai/`) | Medium |

---

### 11.9 Collaboration

| Gap | Why it matters | Complexity | Impact |
|---|---|---|---|
| **No export for sharing** — work produced in a session cannot be shared with teammates or professors in any structured way | Group assignments are extremely common in business school; only one person can use the plugin | Low (`/export` command producing a clean shareable `.md` file) | High |
| **No `/brief-reviewer` skill** — no way to generate a structured summary to guide a professor or senior colleague's feedback | Getting useful feedback requires directing attention; this is itself a consulting skill | Low (new skill producing a 1-page reviewer brief) | Medium |
| **No group contribution tracking** — no ownership of issue tree branches by team member | Group coordination is one of the most painful parts of academic consulting projects | Low (RACI-style ownership in project state file) | Low |

---

## 12. Roadmap

Milestones are sequenced by dependency and impact. Items within a milestone are independent and can be built in any order. v1.4 (session persistence) unlocks several items in v1.5 — do not attempt those before v1.4 is complete.

---

### v1.2 — Academic quality polish
**Goal**: Close the highest-impact gaps for the core academic use case with minimal architectural change. All items are prompt updates or small new skills.

---

#### 12.1 Citation style enforcement
**Gap**: Plugin extracts source requirements but never applies a specific citation style consistently.  
**Files to change**:
- `skills/add-course/SKILL.md` — add a "citation style" slot to the course registration form (Harvard, APA, Chicago, MLA — or "course default")
- `skills/research/SKILL.md` — Step 6 (source formatting) reads the registered style and formats accordingly
- `skills/draft/SKILL.md` — reference list at end of draft uses the registered style
- `skills/publish/SKILL.md` — works cited section uses the registered style

**Acceptance criteria**:
- Running `/add-course` prompts for citation style and saves it to `consultant-ai-courses.md`
- `/research` output formats every citation in the registered style
- `/publish` works cited section matches the registered style exactly

---

#### 12.2 Rubric-weighted `/review`
**Gap**: Review checklist is fixed — a 7/10 score does not account for whether the highest-weighted criterion was actually addressed proportionally.  
**Files to change**:
- `skills/review/SKILL.md` — at start, read marking criteria and weights from session context (or ask user to paste them); weight each checklist section by criterion percentage; score must reflect weighting (a 40% criterion failing = cannot score above 6/10)

**Acceptance criteria**:
- If marking criteria are present, readiness score reflects their weights — not a flat checklist
- Critical issues explicitly reference criterion name and weight
- "To reach 10/10" section maps fixes to specific criteria and weights

---

#### 12.3 Word and slide count enforcement
**Gap**: `/draft` mentions constraints but never checks output length against them.  
**Files to change**:
- `skills/draft/SKILL.md` — after generating each section, track running word count or slide count; at the end, compare against stated constraint; if over, flag specific sections to trim and by how much

**Acceptance criteria**:
- After `/draft full`, output includes a count summary: "1,847 words / 2,000 word limit — 153 words to spare"
- If over limit, names the longest sections and suggests specific cuts
- Slide count tracked per slide; flags if deck exceeds stated limit

---

#### 12.4 Quantitative framework tables
**Gap**: Financial ratios, Porter's force ratings, BCG positioning, and similar frameworks are described in prose instead of structured tables.  
**Files to change**:
- `reference/frameworks/ratio-analysis.md` — replace prose output format with a defined table structure (ratio | formula | company value | industry benchmark | signal)
- `reference/frameworks/porters-five-forces.md` — force | evidence | strength rating (1–5) | implication
- `reference/frameworks/bcg.md` — business unit | market share | growth rate | quadrant | recommendation

**Acceptance criteria**:
- `/framework ratio-analysis` produces a table, not a paragraph per ratio
- Every quantitative framework outputs a table as its primary artifact
- Prose explanation follows the table; does not replace it

---

#### 12.5 `/compare` skill
**Gap**: No way to integrate two framework outputs or research findings into a combined synthesis showing where they agree, conflict, and what the combined implication is.  
**Files to change**:
- Create `skills/compare/SKILL.md`
- `setup.sh` — add `compare` to the skill loop
- `README.md` and `docs/PRD.md` — add skill documentation

**Skill behaviour**: Takes two frameworks or research topics as arguments. Reads both outputs from session context. Produces: points of agreement, direct conflicts (with explanation of which to trust and why), combined implication for the central question.

**Acceptance criteria**:
- `/compare pestel hofstede` synthesises both analyses rather than restating them
- Conflicts are resolved with a reasoned recommendation, not both sides presented equally
- Combined implication is a single actionable sentence

---

#### 12.6 `/help` skill
**Gap**: New users must leave the session to find command syntax.  
**Files to change**:
- Create `skills/help/SKILL.md` — static markdown listing all skills with one-line descriptions and example invocations; groups by workflow stage (setup → analyse → draft → QA → output)
- `setup.sh` — add `help` to skill loop

**Acceptance criteria**:
- `/help` lists every skill with syntax and a one-line example
- Output is scannable in under 30 seconds
- Grouped by workflow stage, not alphabetically

---

### v1.3 — Framework library expansion
**Goal**: Write the missing framework template files so `/framework` always uses a calibrated application guide rather than falling back to generic Claude knowledge.

---

#### 12.7 Missing framework templates
**Gap**: 13+ frameworks listed in `reference/frameworks/index.md` have no template file.  
**Files to create** (one `.md` per framework, same structure as existing templates):

| Framework | Domain | Priority |
|---|---|---|
| SWOT Analysis | Strategy | High — most commonly assigned |
| Marketing Mix (4Ps / 7Ps) | Marketing | High |
| Value Chain Analysis | Strategy | High |
| Business Model Canvas | Strategy | High |
| Stakeholder Analysis | Any | High |
| Balanced Scorecard | Strategy, Finance | Medium |
| Blue Ocean Strategy | Strategy | Medium |
| Make-vs-Buy Analysis | Supply Chain, Operations | Medium |
| DuPont Analysis | Finance | Medium |
| CVP / Break-even Analysis | Finance | Medium |
| DCF Valuation (framework only) | Finance | Medium |
| DMAIC / Lean Six Sigma | Operations | Low |
| Risk Matrix | Any | Low |

Each template must include: when to use, data to collect per dimension, output structure, "so what" standard, common mistakes.

**Acceptance criteria**:
- `/framework swot` uses the template, not generic knowledge
- Every template produces a "so what" insight, not just a dimension summary
- `reference/frameworks/index.md` updated with each new entry

---

#### 12.8 Framework combination guidance
**Gap**: Frameworks are applied in silos; no guidance on how PESTEL feeds Porter's Five Forces, or how VRIO informs Modes of Entry.  
**Files to change**:
- Each relevant framework template — add a "Combines with" section: which frameworks to apply next, what output to pass, and what the combined analysis reveals
- `SKILL.md` (`/consult`) — Step 4 (framework selection) recommends framework sequences, not just individual frameworks

**Acceptance criteria**:
- `/framework pestel` output ends with: "Feed the Political and Economic dimensions into Porter's Five Forces to assess how the macro environment shapes competitive intensity"
- `/consult` recommends 2-framework sequences (e.g. PESTEL → Porter's) for strategy and international business briefs
- At least 5 combination pairs documented across the library

---

### v1.4 — Session persistence
**Goal**: Allow projects to span multiple sessions without re-running research. This milestone is a prerequisite for v1.5 items that depend on project state.

---

#### 12.9 `/save` and `/load` — Project state persistence
**Gap**: All research, issue trees, framework outputs, and drafts are lost when the session closes.  
**Files to change**:
- Create `skills/save/SKILL.md` — collects all session artifacts (central question, hypothesis, issue tree, research findings with confidence scores, framework outputs, draft sections, review score, constraints) and writes them to `~/.claude/projects/consultant-ai/[project-name].md` in a structured format
- Create `skills/load/SKILL.md` — reads the project file and restores context into the working session; confirms what was loaded and what the next logical step is
- `setup.sh` — add `save` and `load` to skill loop

**Project file format** (structured markdown):
```
# [Project name]
Central question: ...
Hypothesis: ...
Mode: Academic / Professional
Constraints: word count, slide count, deadline
Marking criteria: [name] [weight%] ...
Issue tree branches: [list]
Research status: [branch] → [complete/pending]
Framework outputs: [framework] → [summary]
Draft status: [section] → [complete/pending]
Review score: [N]/10
Last updated: [date]
```

**Acceptance criteria**:
- `/save` writes a complete, human-readable project file and confirms the path
- `/load [project-name]` restores context and tells the user exactly where they left off and what to run next
- Project files are stored outside the repo — never committed

---

#### 12.10 `/status` command
**Gap**: No way to see project completion state at a glance.  
**Dependency**: Requires 12.9 (`/save`/`/load`) for multi-session use; works within a single session without it.  
**Files to change**:
- Create `skills/status/SKILL.md` — reads session context (or project file if loaded) and produces a completion checklist: issue tree branches researched (✓/✗), frameworks applied (✓/✗), draft sections complete (✓/✗), review run (✓/✗), /critique run (✓/✗), outputs published (✓/✗)

**Acceptance criteria**:
- `/status` output fits on one screen
- Each incomplete item links to the command that would complete it: "Research: 2/4 branches complete — run `/research [branch 3]` next"
- Shows constraint status: word count used vs. allowed (if draft exists)

---

#### 12.11 Multi-project support
**Gap**: Course context is global; a student running 3 concurrent assignments has no way to context-switch.  
**Dependency**: Requires 12.9 (project state file format).  
**Files to change**:
- Create `skills/project/SKILL.md` — handles `/project new [name]`, `/project list`, `/project switch [name]`, `/project delete [name]`
- `skills/save/SKILL.md` — save defaults to active project
- `skills/load/SKILL.md` — load sets the active project
- `~/.claude/memory/consultant-ai-active-project.md` — one-line file tracking the active project name

**Acceptance criteria**:
- `/project new` creates a named project file and sets it as active
- `/project list` shows all saved projects with last-updated date and status
- `/project switch` loads a different project and confirms what context changed
- `/consult` checks for an active project at startup and offers to continue it or start a new one

---

#### 12.12 Episodic run log
**Gap**: No record of past work; plugin cannot reference what was researched in previous assignments.  
**Dependency**: Requires 12.9 (project state format).  
**Files to change**:
- `skills/save/SKILL.md` — after writing the project file, append a one-line summary to `~/.claude/memory/consultant-ai-run-log.md`: date, project name, central question, recommendation (one sentence), frameworks used
- `SKILL.md` (`/consult`) — Step 1 (load context) also reads the run log; if a prior project covered the same company or market, surface it: "You researched Nigeria's regulatory environment in March — do you want to load those findings?"

**Acceptance criteria**:
- Each `/save` appends a dated entry to the run log
- `/consult` surfaces relevant prior research when company or market overlaps with a previous project
- Run log entries older than 6 months are pruned on `/save`

---

### v1.5 — New skills and professional mode
**Goal**: Add skills that serve both academic and professional users, and extend professional mode with the context system it currently lacks.

---

#### 12.13 `/competitor` skill
**Gap**: No structured way to profile a competitor.  
**Files to change**:
- Create `skills/competitor/SKILL.md` — takes company name as argument; spawns parallel agents covering: financials and recent results, products and positioning, strategy and recent moves, leadership and org, known weaknesses and vulnerabilities; synthesises into a one-page profile with a "threat assessment" concluding section
- `setup.sh`, `README.md`, `docs/PRD.md`

**Acceptance criteria**:
- Profile produced in under 5 minutes with confirmation gate before agents spawn
- Every claim sourced; confidence tier shown for each key fact
- Concluding "threat assessment" is a specific 2–3 sentence judgement, not a list

---

#### 12.14 `/size` — Market sizing skill
**Gap**: No structured market sizing; TAM/SAM/SOM estimates are not defensible without a model.  
**Files to change**:
- Create `skills/size/SKILL.md` — takes market description as argument; builds a top-down sizing model (total addressable population → penetration rate → average spend → TAM) and a bottom-up check (unit economics × addressable customers); shows all assumptions with sources; surfaces sensitivity (what changes if penetration assumption is wrong by 2×)
- `setup.sh`, `README.md`, `docs/PRD.md`

**Acceptance criteria**:
- Every assumption in the model is sourced or explicitly flagged as a reasoned estimate
- Top-down and bottom-up figures are compared; if they diverge >2×, explains why
- Sensitivity table shows TAM range under pessimistic/base/optimistic penetration assumptions

---

#### 12.15 `/client` — Client context system (professional mode)
**Gap**: Professional mode has no persistent client context; every session starts from scratch.  
**Files to change**:
- Create `skills/client/SKILL.md` — analogous to `/add-course`; saves client name, industry, known risk tolerance, key stakeholders, engagement history notes to `~/.claude/memory/consultant-ai-clients.md`
- `SKILL.md` (`/consult`) — in professional mode, reads client context alongside course context
- `setup.sh`, `README.md`, `docs/PRD.md`

**Acceptance criteria**:
- `/client [name]` prompts for industry, risk profile, key stakeholder priorities, notes; saves to memory
- `/consult` in professional mode surfaces relevant client context at Step 1 and uses it to calibrate tone and recommendation specificity
- Multiple clients can be registered; active client can be switched

---

#### 12.16 Additional deliverable formats
**Gap**: `/draft` supports slides, report, and memo only; board briefings and steering committee formats are missing.  
**Files to change**:
- `templates/board-brief.md` — new template: 1-page board briefing format (situation, decision required, recommendation, financial impact, risks, ask)
- `templates/issue-action-log.md` — new template: issue | owner | action | deadline | status
- `skills/draft/SKILL.md` — add both formats to the format selection step

**Acceptance criteria**:
- `/draft board brief` produces a 1-page output matching the template format
- `/draft issue-action log` produces a structured table with all open items from the session

---

### v2.0 — Platform and integration
**Goal**: Solve the remaining high-complexity gaps that require external tools, APIs, or MCP servers. These are not blocked on earlier milestones but require more engineering investment.

---

#### 12.17 PowerPoint / PPTX export
**Gap**: Most important destination for slide output is a formatted deck, not HTML.  
**Implementation approach**: MCP server using `python-pptx`; skill sends structured slide content (title, bullets, speaker notes) to the MCP tool which writes a `.pptx` file. Alternative: Pandoc PPTX output from Markdown.  
**Files to change**: New MCP server (`mcp/pptx-export/`); `skills/publish/SKILL.md` — add `pptx` as an output format option; `setup.sh` — install MCP server on setup.

**Acceptance criteria**:
- `/publish pptx` writes a `.pptx` file with one slide per section
- Each slide has title (insight header), bullet points, and speaker notes
- File opens correctly in PowerPoint and Google Slides

---

#### 12.18 Quantitative modeling
**Gap**: Break-even, scenario analysis, sensitivity, and DCF cannot be computed.  
**Implementation approach**: Python computation via MCP `secure_bash` tool or a dedicated calculation MCP server. Skill prompts for assumptions, passes them to the computation tool, returns formatted output with a data table and a narrative interpretation.  
**Files to change**: `reference/frameworks/dcf.md`, `reference/frameworks/break-even.md` — add computation instructions alongside analytical guidance; `skills/framework/SKILL.md` — detect quantitative frameworks and route to computation path.

**Acceptance criteria**:
- `/framework dcf` prompts for inputs (revenue, growth rate, discount rate, terminal multiple), computes the model, and returns a valuation range with sensitivity table
- `/framework break-even` returns break-even units and revenue given fixed costs, variable cost, and price
- All computation results include a plain-English interpretation

---

#### 12.19 Paywalled database access
**Gap**: Academic mode requires journal citations but WebSearch cannot access JSTOR, EBSCO, or ProQuest.  
**Implementation approach**: Browser automation via MCP (Playwright or Puppeteer) to authenticate with institutional library credentials and retrieve full-text PDFs; alternatively, OpenAlex and Semantic Scholar APIs are free and cover a large portion of academic literature.  
**Files to change**: New MCP tool for academic search; `skills/research/SKILL.md` — in academic mode, route Tier 1 source requests through the academic search MCP before falling back to WebSearch.

**Acceptance criteria**:
- In academic mode, at least one Tier 1 (peer-reviewed) source is attempted per sub-question via the academic search path
- Full citations include DOI and volume/issue/page where available
- Gracefully falls back to WebSearch if the academic search returns no results
