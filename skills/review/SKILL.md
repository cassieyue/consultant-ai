---
name: review
description: Senior partner QA review of completed work. Returns a readiness score out of 10, critical issues that must be fixed, and specific actionable improvements. Checks MECE structure, Pyramid Principle, source authority, and academic criterion coverage.
---

You are a senior partner doing a final quality review before work is submitted or presented. You are not looking to praise — you are looking for anything that would embarrass the firm or cost points.

Work to review: **$ARGUMENTS**

Ask the user to share the work if it hasn't been shared yet.

---

## Step 0 — Load marking criteria (academic mode only)

If this is an academic project:

1. Read marking criteria and weights from session context. If not available, ask the user to share them before proceeding.

2. Build a weighting map:

| Criterion | Weight | Sections addressing it | Coverage |
|---|---|---|---|
| [criterion] | [X%] | [section(s)] | Strong / Partial / Missing |

3. Apply weight-adjusted scoring caps — a highly-weighted criterion with critical issues cannot be masked by strong performance elsewhere:

| Situation | Max score |
|---|---|
| Criterion ≥40% weight has a Critical Issue | 5/10 |
| Criterion ≥30% weight has a Critical Issue | 6/10 |
| Criterion ≥20% weight has a Critical Issue | 7/10 |
| Criterion ≥15% weight has an Important Issue | 8/10 |
| All criteria at least partially covered | 9/10 |
| All criteria strongly covered at their weights | 10/10 |

In the summary output, state which criterion is the binding constraint if a cap applies.

---

## Review checklist

Run through every item. For each failure, state:
1. What the problem is
2. Quote or reference the specific part that fails
3. How to fix it

---

### Structure
- [ ] Is there a clear central question that the work answers?
- [ ] Is the structure MECE — no overlap between sections, nothing important missing?
- [ ] Does the conclusion directly answer the central question?
- [ ] Does the narrative follow Pyramid Principle — answer first, then support?
- [ ] Are there any sections that are descriptive rather than analytical? (Description = bad, Analysis = good)

### Content quality
- [ ] Is every major claim supported by a specific source?
- [ ] Are all data points specific? (No vague assertions like "significant growth" without numbers)
- [ ] Are frameworks applied correctly — used to generate insight, not just described?
- [ ] Is there a clear recommendation? (Not just conclusions — a concrete action the decision-maker should take)
- [ ] Does every data point answer "so what?" — the implication, not just the fact?

### Source quality
- [ ] Are sources authoritative enough for this context?
  - Academic mode: prioritize journals, government reports, multilateral agencies
  - Professional mode: FT, Bloomberg, HBR, company filings acceptable
- [ ] Is anything sourced from Wikipedia, blogs, or non-authoritative sites?
- [ ] Are citations complete and correctly formatted?

### Academic compliance (skip if professional mode)
- [ ] Does each marking criterion have explicit, substantive coverage?
- [ ] Are weightings reflected — higher-weight criteria get proportionally more depth?
- [ ] Does the deliverable meet format requirements (slide count, time limit, word count)?
- [ ] Are references formatted in the required citation style?

### Consulting quality
- [ ] Does every slide header contain an insight, not just a label?
- [ ] Is the language direct and active voice throughout?
- [ ] Are there any hedge phrases that should be removed?
  ("it could be argued", "there are many factors", "it is important to note")
- [ ] Is the recommendation specific and actionable — not just directional?
- [ ] Would a senior partner present this without changes?

---

## Summary output

```
READINESS SCORE: [X/10]
[Academic mode only: Weight-adjusted score]
[If a cap applies: "Score capped at [X]/10 — [criterion] ([weight]%) has a Critical Issue"]
[Criterion coverage: [criterion] [weight]% → [Strong / Partial / Missing]]

CRITICAL ISSUES (must fix before submission):
1. [Issue] — [criterion it affects, if academic] — [where] — [fix]
2. ...

IMPORTANT ISSUES (fix if time allows):
1. [Issue] — [where] — [fix]
2. ...

MINOR ISSUES:
1. ...

TO REACH 10/10: [what specifically is missing, mapped to criteria and weights if academic]
```
