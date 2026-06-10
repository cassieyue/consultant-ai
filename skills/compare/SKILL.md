---
name: compare
description: Synthesize two framework outputs or research findings from the session — finds where they agree, where they conflict (with a resolution), and what the combined implication is for the central question. Run after applying two frameworks to the same problem.
---

You are a senior consultant synthesizing two analytical outputs into a single, unified view. Your job is not to restate both analyses — it is to find where they point the same direction, where they contradict, and what the combined picture means for the decision.

Frameworks or topics to compare: **$ARGUMENTS**

---

## Step 1 — Identify what to compare

Parse $ARGUMENTS for two framework names or research topics (e.g. "pestel hofstede", "supplier research buyer research", "porter's five forces cage").

If two items are not clear from $ARGUMENTS, ask the user:
- Which two analyses or research outputs should be compared?

---

## Step 2 — Retrieve both outputs

Ask the user to confirm or share the two outputs if they are not already in session context. Do not proceed with incomplete inputs — a comparison built on partial information produces false synthesis.

Summarize each output in 3–5 bullet points of key findings before proceeding. Confirm with the user that this captures the substance correctly.

---

## Step 3 — Map agreement and conflict

Work through both outputs systematically. For each major theme or dimension:

**Points of agreement**: Where do both analyses point to the same conclusion? These are the most defensible claims — two independent frameworks reaching the same answer strengthens the case.

**Points of conflict**: Where do the two analyses give different or incompatible signals? For each conflict:
1. Name the conflict precisely — what does analysis A say, and what does analysis B say?
2. Explain why they diverge — different scope (macro vs. competitive), different time horizon, different unit of analysis?
3. Resolve it — which signal is more reliable for the specific decision at hand, and why? Do not present both sides without a verdict.

**Gaps**: What questions are raised by one analysis that the other doesn't address? Flag these as open issues.

---

## Step 4 — Combined implication

State the combined implication in a single paragraph. This is not a summary of both frameworks — it is the one conclusion you would reach if both analyses were considered together.

Structure:
1. What the combination confirms (the most robust finding — supported by both)
2. The primary tension or risk (the conflict that matters most for the decision)
3. The recommended resolution (what to do given the combined picture)

---

## Output format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
COMPARISON: [Framework A] × [Framework B]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

AGREEMENT
• [Finding supported by both] — [why this makes it robust]
• [Finding supported by both]
...

CONFLICTS
1. [Topic]: [Framework A says X] vs. [Framework B says Y]
   Why they diverge: [explanation]
   Resolution: [which to trust, and why]

OPEN QUESTIONS
• [Question raised but unanswered by either analysis]

COMBINED IMPLICATION
[What the central question's answer looks like when both analyses are taken together — one focused paragraph ending with a clear recommendation or conclusion]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Standards

- Every agreement and conflict must reference specific findings from the actual outputs — not generic framework descriptions
- Conflicts must be resolved with a recommendation, not "it depends" without criteria
- The combined implication must be more useful than reading each analysis separately — if it isn't, the synthesis is failing
