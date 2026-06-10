# CVP / Break-even Analysis — Application Template

## When to use
Analysing the relationship between costs, volume, and profit to determine minimum viable scale, evaluate pricing decisions, or stress-test a business case. Use when: evaluating a new product or market entry, understanding operational leverage, setting volume targets, or comparing fixed-cost vs. variable-cost business models.

## Core concepts

### Cost classification

**Fixed costs (FC)**: Do not change with volume within the relevant range
- Rent, insurance, depreciation, management salaries, base marketing spend, R&D
- *Relevant range*: the volume band over which fixed costs stay constant — above it, you need more capacity and fixed costs step up

**Variable costs (VC)**: Change proportionally with volume
- Direct materials, direct labor (if paid per unit), sales commission, packaging, delivery cost per unit
- Variable cost per unit (VCpu) = total variable costs ÷ units produced/sold

**Semi-variable costs**: Have a fixed base plus a variable component (e.g., electricity, phone plans). Split into fixed and variable portions using the high-low method or regression.

### Contribution Margin (CM)

CM per unit = Selling price per unit − Variable cost per unit

CM Ratio = CM per unit ÷ Selling price = (Revenue − Total Variable Costs) ÷ Revenue

**What this tells you**: The CM per unit is what each sale "contributes" first toward covering fixed costs, then toward profit. A higher CM ratio means the business scales more profitably — revenue above break-even converts to profit at the CM% rate.

### Break-even point

Break-even volume = Fixed Costs ÷ CM per unit

Break-even revenue = Fixed Costs ÷ CM Ratio

At break-even: Revenue = Total Costs. Profit = zero.

### Target profit

Units needed for target profit = (Fixed Costs + Target Profit) ÷ CM per unit

### Margin of Safety

Margin of Safety = (Budgeted Revenue − Break-even Revenue) ÷ Budgeted Revenue

Higher margin of safety = more room to absorb a revenue decline before losses begin. A margin of safety below 10% is precarious.

## Sensitivity analysis (always include)

After calculating the base case, test the impact of key assumption changes:

| Scenario | Break-even Units | Break-even Revenue | Δ vs. Base |
|---|---|---|---|
| Base case | X | $X | — |
| Price −10% | | | |
| Variable cost +10% | | | |
| Fixed cost +$X (e.g., new facility) | | | |
| All three adverse simultaneously | | | |

**Present a range, not a point**: The base case break-even is the best guess; the sensitivity table shows the realistic range of outcomes.

## Operational leverage

Operational leverage = CM ÷ Operating Profit (or = % change in profit ÷ % change in revenue)

A high operational leverage means: small revenue increases = large profit increases (above break-even), but small revenue declines = large profit declines. High-fixed-cost businesses (airlines, hotels, SaaS) have high operational leverage.

**What to assess**: Is the cost structure appropriate for the uncertainty in revenue forecasts? A high-leverage model is only sustainable if demand is predictable.

## Output structure

> **CVP Summary**: At a selling price of $[P] and variable cost of $[VCpu], the contribution margin is $[CM] per unit ([CM%]). With fixed costs of $[FC], break-even is [X] units / $[revenue]. At projected volume of [Y] units, the margin of safety is [Z%] and operating profit is $[profit].

Present the sensitivity table. Then state the key risk: which single assumption, if adverse, would most threaten the break-even case and by how much?

## Common mistakes
- Misclassifying fixed vs. variable costs — this invalidates the entire analysis; question every cost item
- Using aggregate revenue rather than unit economics — CVP requires unit-level data (price per unit, VC per unit)
- Treating break-even as the success criterion — the question is whether the business can reach break-even at acceptable scale, within a reasonable timeframe, with a satisfactory margin of safety
- Ignoring the step function in fixed costs — above a certain volume, fixed costs increase (new facility, additional management), which shifts the break-even point upward

## Combines with
- **Porter's Five Forces**: Buyer power and competitive rivalry constrain pricing power (the price input to CVP); supplier power affects variable cost per unit — Five Forces analysis validates whether the pricing and cost assumptions in the CVP model are realistic
- **Make-vs-Buy**: Outsourcing converts a fixed cost to a variable cost, which changes the CM ratio and the break-even structure — model both configurations in the CVP to quantify the financial impact
- **Ansoff Matrix**: Use CVP to assess the financial viability of each Ansoff quadrant — Market Development into a new geography or Market Penetration via price reduction both change the CVP inputs materially
