# Make vs. Buy Analysis — Application Template

## When to use
Deciding whether to produce a product, component, or service in-house (Make) or source it from an external supplier (Buy). A third option — Partner (JV, alliance, licensing in) — is relevant when neither pure Make nor Buy is optimal. Also applies to technology decisions (build vs. buy vs. SaaS/platform). Use when: evaluating outsourcing decisions, vertical integration strategy, supply chain configuration, or technology investment choices.

## The five decision dimensions

### 1. Strategic control — the primary filter
Ask this first, before looking at cost.

- Is this activity a source of competitive advantage? (Apply VRIO: Valuable, Rare, Inimitable, Organized)
  - If YES → Make. Outsourcing a competitive advantage erodes it over time.
- Does the activity involve proprietary IP, data, or processes that cannot be shared?
  - If YES → Make or use a tightly controlled JV at most.
- Is this a commodity activity where competitive differentiation comes from elsewhere?
  - If YES → Buy is the starting assumption.

### 2. Total Cost of Ownership (TCO)
Do not compare unit cost alone — compute full TCO for both options over a 3–5 year horizon.

**TCO of Making**:
- Direct costs: materials, labor, quality control
- Overhead allocation: facilities, management bandwidth, systems
- Capital investment required upfront
- Opportunity cost: what else could those resources and capital accomplish?

**TCO of Buying**:
- Supplier price per unit or service contract
- Transaction costs: procurement, contract management, quality auditing, legal
- Switching costs: cost and time to change suppliers if needed
- Risk premium: (probability of supplier disruption × cost of disruption)

**Rule**: The Make option almost always looks more expensive than quoted Buy price when full TCO is calculated. This is expected — the question is whether the control and capability benefit justifies the premium.

### 3. Capability assessment
- Can the company actually do this well, or would it be building from scratch?
- How long would it take to reach supplier-level quality? Is that timeline acceptable?
- If the activity is strategic but the company currently lacks the capability, the choice is: Build (Make, invest), Buy/Partner (short-term), or Acquire.

### 4. Supply market conditions
- How competitive is the supplier market? (Many qualified suppliers = low dependency risk)
- Is the supplier market consolidating? (Monopolistic supply = future price risk, Buy becomes riskier over time)
- Are capable, reliable suppliers available at the required quality, volume, and timeline?

### 5. Risk profile
| Risk | Make | Buy |
|---|---|---|
| Capital risk | Capital tied up in assets | No capital risk |
| IP leakage | Low (internal) | Medium to High (shared with supplier) |
| Quality control | Full control | Depends on supplier standards |
| Supply disruption | Internal bottlenecks | Supplier failure, logistics, geopolitics |
| Lock-in risk | Internal dependency | Supplier lock-in if switching costs are high |
| Flexibility | Lower (fixed assets) | Higher (can switch suppliers) |

## Decision framework

| Situation | Recommendation |
|---|---|
| Activity is a core competitive advantage (VRIO) | Make |
| Commodity activity, competitive supplier market | Buy |
| Strategic activity, no capable suppliers currently | Make (invest in capability) |
| Strategic activity, capable trusted partner available | Partner / JV |
| Activity involves proprietary IP or data | Make (or tightly controlled JV) |
| Activity requires local market knowledge the company lacks | Buy or Partner (local supplier) |
| Non-core, available cheaper externally | Buy |

## Output structure

Present a weighted decision matrix:

| Decision Factor | Make Assessment | Buy Assessment | Weight | Winner |
|---|---|---|---|---|
| Strategic control (VRIO) | [Is this a competitive advantage?] | [What control is lost?] | High | Make / Buy |
| TCO (5-year) | $[X] total | $[X] total | High | |
| Current capability | [Strong / Gap / None] | [Supplier quality level] | Medium | |
| Supply market risk | [Internal bottleneck risk] | [Supplier concentration risk] | Medium | |
| IP / data risk | [Low — internal] | [Medium/High — shared] | High | |
| **Overall** | | | | **Make / Buy / Partner** |

State the recommendation and the 1–2 deciding factors.

## Common mistakes
- Comparing unit cost only — TCO including overhead, capital, and risk often reverses the apparent winner
- Treating current practice as the default — "we've always made this" is not a strategic rationale
- Ignoring the transition cost — switching from Make to Buy or vice versa has one-time costs that must be included in the comparison
- Defaulting to Buy without assessing IP risk — suppliers can observe processes, develop competing capabilities, or become direct competitors

## Combines with
- **VRIO**: Apply VRIO to the activity first — if the activity produces sustained competitive advantage, Make; if not, Buy is the starting assumption; VRIO provides the strategic logic that TCO alone cannot
- **Value Chain**: Value chain analysis identifies which activities are primary (strategic) vs. support (operational) — primary differentiating activities are Make candidates; support activities are Buy candidates; the VC output informs which activities to subject to Make-vs-Buy analysis
- **SCOR Model**: In supply chain contexts, the SCOR Source process is the Make-vs-Buy decision for every major input; SCOR performance data (lead times, delivery reliability, cost per unit) directly informs the TCO calculation
