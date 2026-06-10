# DCF Valuation — Application Template

## When to use
Estimating the intrinsic value of a company, business unit, or investment project based on expected future cash flows. Use when: evaluating an acquisition or investment decision, comparing project alternatives, assessing whether a business is over- or under-valued relative to asking price, or making capital allocation decisions.

**Note**: This template covers the analytical framework. Actual computation requires a spreadsheet model with numerical inputs — the output here is the structure, assumptions, and interpretation, not the number.

## Core concept

An asset is worth the present value of all future cash flows it will generate, discounted at a rate that reflects the risk of those cash flows.

DCF Enterprise Value = Σ [FCFt ÷ (1 + WACC)^t] + Terminal Value ÷ (1 + WACC)^n

Where: FCFt = Free Cash Flow in year t, WACC = discount rate, Terminal Value = value of cash flows beyond the explicit forecast period.

## Step 1 — Project Free Cash Flow (FCF)

**Free Cash Flow = EBIT × (1 − Tax Rate) + Depreciation − Capital Expenditure − Change in Net Working Capital**

**Revenue projection**: Market size × market share assumption. Both must be justified with evidence — market size from PESTEL/industry research, market share from competitive analysis (Porter's Five Forces, VRIO).

**Margin projection**: Start from current operating margin; adjust for: scale effects (margins typically expand as revenue grows), competitive intensity (Porter's Five Forces), and planned strategic investments.

**CapEx and Working Capital**: Based on industry norms (CapEx as % of revenue, DSO, inventory days).

**Projection period**: 5 years for high-uncertainty situations; up to 10 years for stable, predictable businesses. Do not project beyond what can be reasonably justified.

## Step 2 — Calculate WACC

**WACC = (E/V × Re) + (D/V × Rd × (1 − Tax Rate))**

Where: E = market value of equity, D = market value of debt, V = E + D

**Cost of equity (Re)** — use CAPM:
Re = Risk-free rate (Rf) + Beta (β) × Equity Risk Premium (ERP)
- Rf: 10-year government bond yield (home country or target currency)
- ERP: 4–6% for developed markets; higher for emerging markets
- β: systematic risk vs. market (use comparable public companies)

**Emerging market / private company adjustments**:
- Add country risk premium (Damodaran's country risk data)
- Add size premium for small companies (typically 2–4%)

**Cost of debt (Rd)**: Average pre-tax interest rate on outstanding debt.

## Step 3 — Calculate Terminal Value

**Gordon Growth Model** (preferred for stable businesses):
TV = FCF_(n+1) ÷ (WACC − g)
Where g = long-term sustainable growth rate (typically 2–3%, no higher than long-run nominal GDP growth)

**Exit Multiple** (useful for M&A contexts):
TV = EBITDA_n × EV/EBITDA comparable company multiple

**Warning**: Terminal value typically represents 60–80% of total DCF value. This makes it the most sensitive and most important assumption in the model. Test it aggressively in sensitivity analysis.

## Step 4 — Calculate enterprise and equity value

Sum the PV of each projected FCF and the Terminal Value = Enterprise Value.

Equity Value = Enterprise Value − Net Debt (total debt − cash and equivalents)

Per-share value = Equity Value ÷ diluted shares outstanding.

## Step 5 — Sensitivity analysis (required)

Build a two-variable sensitivity table (typically WACC and terminal growth rate):

| | WACC: 8% | WACC: 10% | WACC: 12% |
|---|---|---|---|
| Terminal growth: 2% | $X | $X | $X |
| Terminal growth: 3% | $X | $X | $X |
| Terminal growth: 4% | $X | $X | $X |

A well-done DCF presents a valuation range, not a single number. The base case is the center; the sensitivity table shows the realistic bounds.

## Output structure

> **DCF Result**: Under base case assumptions (WACC: [X]%, terminal growth: [Y]%, [N]-year explicit forecast period), enterprise value is $[X]M, implying an equity value of $[Y]M (or $[Z] per share). Sensitivity analysis indicates a range of $[low] to $[high]M depending on growth and discount rate assumptions. The current asking price / market price of $[P]M implies a [discount/premium] of [Z%] to intrinsic value.

State key assumptions explicitly (top 3–5) and flag which are most sensitive.

## Common mistakes
- Circular reasoning: projecting cash flows to hit a target valuation rather than working from market evidence
- Treating the point estimate as precise — the output is always a range; present the sensitivity table prominently
- Under-scrutinizing terminal value — if it's >70% of total value, the terminal growth assumption is effectively the entire model; stress-test it
- Using book value of debt rather than market value in WACC
- Ignoring working capital changes — for capital-intensive or inventory-heavy businesses, working capital requirements consume significant cash as the business grows

## Combines with
- **Financial Ratio Analysis**: Historical ratios establish the baseline for margin and efficiency assumptions; ratio benchmarks against competitors validate whether the projected margins are realistic or overly optimistic
- **Porter's Five Forces**: Competitive intensity is the primary driver of sustainable margin assumptions — high rivalry, strong buyer power, and easy substitution all compress long-run margins; use Five Forces to sense-check the margin trajectory in the projection
- **CVP / Break-even**: Break-even analysis establishes the minimum revenue at which the business is viable — the DCF should show the business comfortably exceeding break-even by year 2–3; if not, the investment case is weak
