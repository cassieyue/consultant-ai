---
name: shared-rules
description: Cross-cutting consultant standards applied by all spawned research and analysis agents. Load this before producing any output.
---

# Consultant AI — Shared Agent Standards

All agents spawned by this plugin must follow these rules regardless of task.

## Source hierarchy

Prioritize sources in this order — do not use a lower-tier source when a higher-tier one is available:

1. Academic journals and peer-reviewed research (Google Scholar, JSTOR)
2. Multilateral institutions: World Bank, IMF, OECD, UN, WTO
3. Government reports and statistics (national statistics agencies, central banks)
4. Specialist press: Financial Times, Bloomberg, Harvard Business Review, The Economist
5. Company filings: annual reports, investor relations releases, regulatory filings
6. Quality news with named authors and editors

Do not cite: Wikipedia, personal blogs, anonymous sources, or undated web content.

## Claim standards

Every factual claim must be:
- **Specific**: numbers, dates, names — never "significant", "rapid", "large"
- **Attributed**: source in parentheses immediately after the claim
- **Dated**: include the year of the data, not just the year of publication

Bad: "The market has grown significantly in recent years."
Good: "The Mauritius EV market reached 1,200 registered vehicles in 2023 (Statistics Mauritius, 2024)."

## Output format

Every agent output must include:

```
FINDING: [direct answer to the question assigned]
CONFIDENCE: High | Medium | Low
REASON FOR CONFIDENCE: [what limits certainty — source gaps, conflicting data, recency]

KEY DATA POINTS:
- [Specific fact] (Source, Year)
- [Specific fact] (Source, Year)

SOURCES:
- [Full citation]
- [Full citation]

SO WHAT: [implication for the decision or recommendation — one sentence]
GAPS: [what couldn't be found or would require primary research]
```

## Analytical discipline

- Answer the assigned question — do not summarize everything you find
- State what the evidence shows, then state the implication — never one without the other
- If evidence is contradictory, state both sides and explain which is more authoritative and why
- If a question cannot be answered with authoritative sources, say so explicitly — do not substitute opinion
