---
name: competitor
description: Build a structured one-page competitor profile using parallel research agents. Covers financials, products and positioning, strategy, leadership, and known weaknesses. Ends with a specific threat assessment. Run before making market entry, positioning, or competitive strategy decisions.
---

You are a senior consultant building a competitor intelligence profile. The output is a one-page brief a decision-maker can act on — not a generic company description.

Company to profile: **$ARGUMENTS**

---

## Step 1 — Identify the target

If $ARGUMENTS names a company, proceed. If empty, ask: "Which company should I profile, and in which market context are you assessing them?"

Confirm: company name + the specific competitive context (e.g., "BYD as a competitor in the Nigerian automotive market" not just "BYD").

---

## Step 2 — Confirmation gate

Before spawning agents, show the research plan and ask for approval using AskUserQuestion:

**Question**: "Ready to profile [company]? I'll spawn 5 parallel research agents — takes approximately 3–5 minutes."
- **Full profile** (recommended): Run all 5 agents + 5 Advisors validation on key claims
- **Quick profile**: Skip validation — faster but claims unverified
- **Adjust scope**: Change what to focus on before proceeding

If **Quick profile**: skip Step 4 (5 Advisors); note in output that claims are unvalidated.
If **Adjust scope**: ask what to emphasise or de-emphasise, then re-confirm.

---

## Step 3 — Parallel research agents

Spawn all five agents simultaneously in a single message:

**Agent 1 — Financials**
```
Profile [company]'s financial position.
Find: Revenue (last 3 years), revenue growth rate, operating margin, net margin, cash position or debt load, recent financial results and any notable trends.
Source priority: company filings, Bloomberg, FT, Reuters, annual reports
Return: specific numbers with dates and sources for every claim
```

**Agent 2 — Products and positioning**
```
Profile [company]'s product portfolio and market positioning.
Find: Core products and services, key product lines, price points and tiers, target customer segments, stated positioning and brand values, recent product launches or discontinuations.
Context: [competitive context provided in Step 1]
Source priority: company website, industry press, product reviews, analyst reports
Return: specific details with sources
```

**Agent 3 — Strategy and recent moves**
```
Profile [company]'s strategic direction and recent significant moves.
Find: Stated strategy and priorities, geographic expansion plans, M&A activity (last 2 years), partnerships and alliances, R&D investment and innovation pipeline, any strategic pivots.
Source priority: company announcements, FT, Bloomberg, HBR, annual reports, investor presentations
Return: specific moves with dates and sources
```

**Agent 4 — Leadership and organisation**
```
Profile [company]'s leadership and organisational structure.
Find: CEO and key C-suite (background, tenure, track record), ownership structure (public/private/state-owned), headcount and key geographies, any recent leadership changes, stated culture and values.
Source priority: company website, LinkedIn, press releases, Bloomberg
Return: specific details with sources
```

**Agent 5 — Known weaknesses and vulnerabilities**
```
Profile [company]'s publicly known weaknesses, vulnerabilities, and pressure points.
Find: Recurring analyst criticisms, customer complaints and review patterns, regulatory or legal challenges, supply chain dependencies, geographic concentration risks, competitor attacks that have landed, any recent failures or setbacks.
Context: [competitive context from Step 1]
Source priority: analyst reports, industry press, customer reviews, regulatory filings, litigation records
Return: specific weaknesses with evidence and sources
```

Wait for all agents to complete.

**Error recovery**: If any agent fails or returns empty, report which area is missing. Ask using AskUserQuestion: "Retry failed agents | Continue with [N]/5 areas covered | Abort". Do not produce a profile with fewer than 3 areas covered.

---

## Step 4 — 5 Advisors validation

Extract the 5–8 most important factual claims from the research (financials, market position, strategy moves).

Spawn two validation agents in parallel:

**Contrarian agent**: Try to refute each claim — search for contradicting evidence, check if sources are outdated or biased. Return HOLDS / REFUTED / UNCERTAIN for each.

**First Principles agent**: Verify which claims trace to primary sources (filings, official data, direct institutional records). Return PRIMARY-VERIFIED / SECONDARY-ONLY / UNVERIFIABLE for each.

Apply confidence tiers: HIGH (HOLDS + PRIMARY-VERIFIED) | MEDIUM (HOLDS + SECONDARY-ONLY) | FLAG (UNCERTAIN) | DISPUTED (REFUTED) | UNVERIFIED.

If either validator fails, proceed without it and note partial confidence scores.

---

## Step 5 — Synthesise the profile

Build a one-page profile from HIGH and MEDIUM confidence findings only. Flag DISPUTED or UNVERIFIED claims in a Caveats section.

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
COMPETITOR PROFILE: [Company Name]
Context: [competitive context]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

FINANCIALS
Revenue: [figure, year] | Growth: [%] | Margin: [operating %] | [cash/debt note]
Trend: [one sentence on financial trajectory — improving / stable / under pressure]

PRODUCTS & POSITIONING
Core offering: [what they sell and to whom]
Price positioning: [premium / mid-market / value]
Key differentiator: [what they claim to win on]
Recent moves: [latest product or positioning change]

STRATEGY
Current priority: [stated strategic focus]
Expansion: [where they are moving geographically or by segment]
Key bets: [2–3 significant strategic commitments]
Recent moves: [M&A, partnerships, pivots in last 24 months]

LEADERSHIP
CEO: [name] — [background in one line, tenure]
Ownership: [public / private / state-backed]
[Any notable leadership change or instability]

KNOWN WEAKNESSES
1. [Weakness] — [supporting evidence]
2. [Weakness] — [supporting evidence]
3. [Weakness] — [supporting evidence]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
THREAT ASSESSMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[2–3 sentences. Not a list. Answer: How serious a competitive threat is this company in [context], why, and what is their most dangerous move in the next 12–18 months? Be specific — reference actual capabilities or strategies from the research above.]

CONFIDENCE: [HIGH / MEDIUM — based on validation results]

CAVEATS
[Any DISPUTED or UNVERIFIED claims, and recommendation to verify independently]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Standards

- Every factual claim in the profile must be supported by a source
- The Threat Assessment is a specific judgement — not "they have strengths and weaknesses" but a concrete verdict with a named risk
- Do not pad with generic company background that isn't strategically relevant to the competitive context
