# DMAIC / Lean Six Sigma — Application Template

## When to use
Systematically improving an existing process by identifying and eliminating defects, waste, and variation. Use when: diagnosing operational inefficiencies, reducing error rates, improving cycle times, or reducing costs without capital investment. DMAIC is a data-driven methodology — it requires access to process data, not just descriptions of problems.

## The five phases

### Define
Clearly state the problem and improvement goal before collecting any data.

**Tools**:
- **Project charter**: Problem statement (with current vs. target metric), scope, team, and timeline
- **SIPOC diagram**: Suppliers → Inputs → Process → Outputs → Customers (high-level process map)
- **Voice of the Customer (VoC)**: What do customers need? Translate to CTQs (Critical to Quality requirements)

**Outputs**: Agreed problem statement with a measurable baseline, defined CTQ requirements, scoped project

**Red flags**: Starting DMAIC with a solution in mind; a problem statement that cannot be measured

---

### Measure
Quantify the current state of the process to establish a baseline.

**Tools**:
- **Process map** (flowchart): Every step in the current process, including decision points and handoffs
- **Data collection plan**: What to measure, how, from whom, over what period
- **Baseline measurement**: Current defect rate (DPMO — Defects Per Million Opportunities), cycle time, or error rate
- **Measurement System Analysis (MSA)**: Verify the measurement system itself is accurate before trusting the data

**Outputs**: Validated baseline metrics, confirmed process map, data set ready for analysis

---

### Analyse
Identify the root causes of the defects or variation — not the symptoms.

**Tools**:
- **Fishbone / Ishikawa diagram**: Organise potential causes into categories: Man, Machine, Method, Material, Measurement, Environment (6Ms)
- **Pareto chart**: 80/20 analysis — which 20% of causes produce 80% of defects? Focus improvement effort there.
- **5 Whys**: Ask "why?" five times. Each "why" peels away a symptom to reach the structural root cause.
- **Statistical analysis**: Correlation, regression, hypothesis testing — only if data quality and sample size support it

**Outputs**: Validated root causes (evidence-based, not just suspected), quantified contribution of each root cause

---

### Improve
Design and test solutions that address the validated root causes.

**Tools**:
- **Solution matrix**: Evaluate options on Impact (benefit) × Effort (cost/time) — prioritize high-impact, low-effort solutions
- **Pilot**: Test the solution on a limited scale before full deployment; measure the improvement against the baseline
- **Mistake-proofing (Poka-Yoke)**: Design the process so errors are physically impossible or immediately flagged — removes reliance on human vigilance

**Outputs**: Validated solution (pilot data confirms improvement), full implementation plan

---

### Control
Ensure the improvement is sustained after the project team moves on.

**Tools**:
- **Control chart (SPC — Statistical Process Control)**: Plots the process metric over time with control limits; flags when the process goes out of control before defects escalate
- **Control plan**: Documents who monitors which metric, at what frequency, and what action to take when out-of-control signals appear
- **Updated SOPs**: Standard Operating Procedures capturing the new process, replacing the old documentation
- **Training plan**: All affected employees trained on the new process before the project team disbands

**Outputs**: Process is stable at the improved performance level; accountability assigned; metrics tracked ongoing

## Output structure

For each phase, document:
> **[Phase]**: [What was found or done] → **Key decision**: [What was decided and why] → **Outcome**: [Measurable result or confirmation]

Project summary:
> **Baseline**: [Old defect rate / cycle time / cost] → **Result**: [New metric after improvement] → **Impact**: [Annualised cost saving, revenue impact, or customer satisfaction improvement]

## Common mistakes
- Skipping Define and jumping to solutions — the most common DMAIC failure; the solution becomes the problem statement
- Analysing without sufficient data — DMAIC requires quantitative measurement; qualitative descriptions of problems cannot be validated as root causes
- Not validating root causes before implementing — the most visible cause is rarely the root cause; use the fishbone and 5 Whys to go deeper
- Failing to sustain — most DMAIC gains erode within 12 months without a proper Control phase; the project is not complete until controls are in place

## Combines with
- **McKinsey 7S**: DMAIC improvements often require organizational change (Systems, Structure, Staff) to sustain; use 7S to assess what organizational elements need to change to embed the new process permanently
- **Balanced Scorecard**: Map DMAIC improvement targets to relevant BSC KPIs; the Control phase monitoring cadence should align with the BSC measurement cycle so improvements are visible in the scorecard
- **Value Chain**: Identify which value chain activity is being improved before starting DMAIC — this contextualizes the project, confirms it is targeting a strategically significant process, and ensures the improvement investment is proportionate to the activity's strategic importance
