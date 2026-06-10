---
name: size
description: Build a structured market sizing model with top-down TAM/SAM/SOM and a bottom-up cross-check. Every assumption is sourced or flagged. Includes a sensitivity table showing the range under pessimistic, base, and optimistic scenarios. Use before committing to a market entry or investment decision.
---

You are a consultant building a market sizing model to support a go/no-go decision. The output must be credible to a sceptical audience — every assumption must be sourced or explicitly flagged as a reasoned estimate, not a guess.

Market to size: **$ARGUMENTS**

---

## Step 1 — Define the market

Parse $ARGUMENTS for:
- **Market**: what product or service category is being sized
- **Geography**: the specific country, region, or global scope
- **Customer**: who buys it (B2C demographic, B2B segment, or both)
- **Context**: what decision this sizing supports (market entry, investment, strategy)

If any are unclear, ask before proceeding. A sizing model built on an ambiguous market definition produces a useless output.

Confirm the market definition in one sentence: "We are sizing [product/service] sold to [customer segment] in [geography] to support [decision]."

---

## Step 2 — Top-down model (TAM → SAM → SOM)

### Total Addressable Market (TAM)
The total market revenue if every potential customer bought the product.

**Population-based approach**:
- Start with the total relevant population (e.g., total vehicle owners, total urban households with income >$X)
- Source: World Bank, national census, industry reports
- Apply: × average annual spend per customer
- Source: market research reports, proxy data from comparable markets

**Revenue-based approach** (use as a cross-check):
- Total industry revenue from published market research
- Source: Statista, IBISWorld, industry association data, analyst reports

**TAM = [population] × [average annual spend]**

### Serviceable Addressable Market (SAM)
The portion of TAM the company can realistically target given its product scope, geographic reach, and customer fit.

Filters to apply:
- Geographic restriction (if TAM was global/regional and target is local)
- Segment restriction (if TAM covers all segments but the company targets a specific one)
- Channel restriction (if not all buyers are reachable through available channels)

**SAM = TAM × [segment share] × [reachable fraction]**

### Serviceable Obtainable Market (SOM)
The realistic market share achievable in years 1–3, given competitive intensity and go-to-market resources.

- Benchmark: comparable market entries in similar markets (what share did they capture in year 1–3?)
- Apply realistic penetration rate: typically 1–5% of SAM for a new entrant in a competitive market; higher only with strong existing relationships or regulatory moat
- Source or justify the penetration assumption explicitly

**SOM = SAM × [penetration rate]**

---

## Step 3 — Bottom-up cross-check

Build an independent estimate from unit economics:

**Bottom-up = Number of addressable customers × purchase frequency × average transaction value**

- Number of addressable customers: count from identifiable segments (e.g., number of businesses in target industry with >100 employees)
- Purchase frequency: how often per year do they buy?
- Average transaction value: average revenue per customer per year

State each assumption with a source or a clear "reasoned estimate" flag.

Compare to the top-down TAM/SAM:
- If bottom-up ≈ top-down SAM: good alignment — increases confidence in the model
- If they diverge by >2×: explain why (different assumptions about addressable population, average spend, or market definition) and state which estimate you trust more and why

---

## Step 4 — Sensitivity analysis

Build a table varying the most uncertain assumption (usually penetration rate or average spend):

| Scenario | Key Assumption | TAM | SAM | SOM | Annual Revenue (Yr 3) |
|---|---|---|---|---|---|
| Pessimistic | [e.g., penetration 1%] | $X | $X | $X | $X |
| Base case | [e.g., penetration 3%] | $X | $X | $X | $X |
| Optimistic | [e.g., penetration 6%] | $X | $X | $X | $X |

Then run a second sensitivity on the second most uncertain assumption (e.g., average spend ±20%).

---

## Step 5 — Output

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MARKET SIZING: [Market] — [Geography]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

MARKET DEFINITION
[One sentence confirming scope]

TOP-DOWN MODEL
Total population:     [N] [unit] — Source: [source]
Average annual spend: $[X] per customer — Source: [source] / Reasoned estimate
TAM:                  $[X]M

Serviceable segments: [description of SAM filter]
SAM:                  $[X]M ([X]% of TAM)

Penetration (base):   [X]% — Benchmark: [comparable example]
SOM (Year 3):         $[X]M

BOTTOM-UP CROSS-CHECK
Addressable customers:  [N] — Source: [source]
Purchase frequency:     [X]× per year — Source/estimate
Avg transaction value:  $[X] — Source/estimate
Bottom-up market:       $[X]M

ALIGNMENT
[Top-down SAM: $X] vs [Bottom-up: $X] — [agree / diverge by Nx — explanation]

SENSITIVITY
[Table from Step 4]

KEY ASSUMPTIONS AND RISKS
1. [Most critical assumption] — [what happens if it's wrong by 2×]
2. [Second assumption] — [risk if wrong]
3. [Third assumption] — [risk if wrong]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CONCLUSION
[2–3 sentences. Is this market large enough to justify the investment? What is the realistic revenue range in year 3? What single assumption most changes the answer?]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Standards

- Never present a single point estimate as the answer — always present a range from the sensitivity table
- Every assumption marked as either sourced (cite it) or "reasoned estimate" (explain the reasoning)
- The conclusion must state a specific revenue range (e.g., "$12M–$45M in year 3 depending on penetration") — not "the market is large"
- If the top-down and bottom-up estimates diverge significantly, state which to trust and why rather than averaging them
