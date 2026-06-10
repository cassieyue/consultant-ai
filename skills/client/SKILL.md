---
name: client
description: Register a client so the plugin calibrates tone, recommendation specificity, and risk framing for professional mode work. Analogous to /add-course for academic mode. Run once per client engagement at the start of a project.
---

You are helping the user register a client so the Consultant AI plugin can adapt its output for professional mode work — tone, risk framing, and recommendation detail all depend on knowing who the audience is.

Client details: **$ARGUMENTS**

---

## Steps

### 1. Gather client information

Use $ARGUMENTS as a starting point if provided. Otherwise, ask for:

- **Client name**: Organisation name (use a codename or abbreviation if confidentiality requires)
- **Industry**: Primary sector and sub-sector (e.g., "Automotive — EV manufacturing", "Financial Services — retail banking")
- **Engagement type**: What kind of work this is (market entry, cost reduction, growth strategy, due diligence, other)
- **Risk tolerance**: How does this client typically respond to recommendations?
  - *Conservative*: Prefers incremental moves, high certainty required, averse to bold bets
  - *Balanced*: Weighs risk and reward, accepts moderate uncertainty, pragmatic
  - *Aggressive*: Appetite for bold moves, tolerates uncertainty, values speed over caution
- **Key stakeholders**: Who will read or be affected by the output? (e.g., "CFO focused on payback period", "Board wants strategic narrative, not operational detail", "CEO comfortable with ambiguity")
- **Constraints and context**: Anything that shapes what can be recommended (budget limits, regulatory environment, existing commitments, internal politics, confidential context)
- **Engagement history** (optional): Any prior work with this client that's relevant — past recommendations, known sensitivities, topics to avoid

### 2. Read existing client file

Read `~/.claude/memory/consultant-ai-clients.md` if it exists. Append the new client without overwriting existing entries.

### 3. Save the updated file

```
# Consultant AI — Client Context

## [Client Name]
Added: [today's date]
Industry: [sector and sub-sector]
Engagement type: [type]
Risk tolerance: [Conservative / Balanced / Aggressive]

Stakeholders:
- [Role]: [what they care about and how they consume recommendations]
- [Role]: ...

Constraints and context:
[Free text — anything that shapes what can be recommended]

Engagement history:
[Free text — prior work, known sensitivities, relevant decisions already made]

---
```

### 4. Confirm to the user

- What was saved
- How it affects professional mode: `/consult` will read client context and calibrate — tone, level of certainty in recommendations, risk framing, and how recommendations are structured for the stated audience
- Remind them: run `/client` again to add more clients or update this entry as the engagement evolves
- To switch active client: run `/consult` and specify the client name, or add a "Active client: [name]" note to `~/.claude/memory/consultant-ai-clients.md`
