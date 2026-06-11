---
name: workbook
description: Generate a research journal HTML that shows every stage of the consulting analysis — brief decode, issue tree, framework sequence, research findings by sub-question, claim validation confidence tiers, and synthesis. Run at any point during a /consult session to snapshot progress. Run at the end to produce the complete process record alongside the final deliverable.
---

You are compiling a research journal for this consulting project. The journal shows how the answer was reached — every stage from brief to synthesis — so the reasoning is transparent and auditable.

Output path: `~/Documents/projects/[project-name]/[project-name]-workbook.html`

Infer the project name from the session context. If unclear, ask.

---

## Step 1 — Collect what exists

Scan the entire conversation for content from each of these stages. For each stage, note whether it is **complete** (fully done), **partial** (in progress), or **not started** (not yet reached).

| Stage | What to collect |
|---|---|
| Brief & framing | Domain, mode, deliverable, constraints, core question, marking criteria if academic, initial hypothesis |
| Framework sequence | Each framework in the proposed chain, why it was selected, what it feeds into |
| Research findings | Each sub-question, key findings with sources, one "so what" per sub-question |
| Claim validation | Each validated claim, Contrarian verdict, First Principles verdict, confidence tier assigned |
| Synthesis | The Pyramid structure — answer first, each supporting argument, key evidence |
| Deliverable | File path and brief description of the final output (deck, report, memo) |

Do not invent content for incomplete stages — mark them clearly as "In progress" or "Not yet reached."

---

## Step 2 — Write the HTML file

Use the Write tool. All CSS and JavaScript must be inline. Use this exact structure:

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>[PROJECT NAME] — Research Journal</title>
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
  body { font-family: system-ui, -apple-system, sans-serif; background: #f4f6f9; color: #1a1a2e; font-size: 14px; line-height: 1.6; }

  header { background: #0d1b2a; color: #fff; padding: 36px 48px 28px; }
  header .eyebrow { font-size: 10px; letter-spacing: 3px; text-transform: uppercase; color: #7fbbda; margin-bottom: 10px; }
  header h1 { font-size: 24px; font-weight: normal; font-family: Georgia, serif; margin-bottom: 6px; }
  header p { font-size: 13px; color: #b0c4d8; }

  .progress-bar { background: #122338; padding: 0 48px; display: flex; gap: 0; border-bottom: 1px solid #1e3a55; }
  .stage-pill { padding: 12px 20px; font-size: 11px; letter-spacing: 1px; text-transform: uppercase; color: #4a6a8a; border-bottom: 3px solid transparent; cursor: default; white-space: nowrap; }
  .stage-pill.done { color: #7fbbda; border-bottom-color: #1e6fa5; }
  .stage-pill.partial { color: #f59e0b; border-bottom-color: #f59e0b; }
  .stage-pill.pending { color: #4a6a8a; }

  main { max-width: 900px; margin: 0 auto; padding: 40px 48px 80px; }

  .stage-block { margin-bottom: 40px; }
  .stage-header { display: flex; align-items: center; gap: 14px; margin-bottom: 14px; padding-bottom: 10px; border-bottom: 2px solid #e0e4eb; }
  .stage-num { font-size: 11px; font-weight: 700; letter-spacing: 2px; text-transform: uppercase; color: #aaa; min-width: 24px; }
  .stage-title { font-size: 17px; font-weight: 600; color: #0d1b2a; }
  .stage-badge { font-size: 10px; padding: 2px 10px; border-radius: 12px; font-weight: 700; letter-spacing: 0.5px; }
  .badge-done { background: #d1fae5; color: #065f46; }
  .badge-partial { background: #fef3c7; color: #92400e; }
  .badge-pending { background: #f1f5f9; color: #94a3b8; }

  .content-card { background: #fff; border: 1px solid #e0e4eb; border-left: 3px solid #0d1b2a; padding: 20px 24px; margin-bottom: 12px; }
  .content-card h3 { font-size: 12px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; color: #1e6fa5; margin-bottom: 10px; }
  .content-card p { font-size: 13px; color: #333; margin-bottom: 8px; line-height: 1.6; }
  .content-card ul { padding-left: 20px; font-size: 13px; color: #333; }
  .content-card li { margin-bottom: 6px; line-height: 1.5; }

  .finding-card { background: #fff; border: 1px solid #e0e4eb; padding: 18px 22px; margin-bottom: 10px; }
  .finding-card .sq-label { font-size: 10px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; color: #888; margin-bottom: 6px; }
  .finding-card .sq-title { font-size: 14px; font-weight: 600; color: #0d1b2a; margin-bottom: 12px; line-height: 1.35; }
  .finding-card ul { padding-left: 18px; font-size: 13px; color: #333; }
  .finding-card li { margin-bottom: 5px; line-height: 1.5; }
  .finding-card .implication { background: #eef5fb; border-left: 3px solid #1e6fa5; padding: 8px 14px; margin-top: 12px; font-size: 13px; color: #1a1a2e; font-style: italic; }
  .finding-card .implication strong { font-style: normal; color: #1e6fa5; font-size: 10px; letter-spacing: 1px; text-transform: uppercase; display: block; margin-bottom: 3px; }

  /* Confidence badges */
  .conf { display: inline-block; font-size: 10px; font-weight: 700; padding: 1px 8px; border-radius: 10px; letter-spacing: 0.5px; vertical-align: middle; }
  .conf-high { background: #d1fae5; color: #065f46; }
  .conf-medium { background: #dbeafe; color: #1e40af; }
  .conf-flag { background: #fef3c7; color: #92400e; }
  .conf-disputed { background: #fee2e2; color: #991b1b; }
  .conf-unverified { background: #f1f5f9; color: #64748b; }

  .validation-table { width: 100%; border-collapse: collapse; font-size: 13px; margin-top: 4px; }
  .validation-table thead th { background: #0d1b2a; color: #fff; padding: 9px 14px; text-align: left; font-size: 10px; letter-spacing: 1px; text-transform: uppercase; }
  .validation-table tbody td { padding: 10px 14px; border-bottom: 1px solid #e5e9ef; vertical-align: top; line-height: 1.45; }
  .validation-table tbody tr:nth-child(even) td { background: #f8f9fc; }

  .pyramid { border: 1px solid #e0e4eb; }
  .pyramid-level { padding: 16px 22px; border-bottom: 1px solid #e0e4eb; }
  .pyramid-level:last-child { border-bottom: none; }
  .pyramid-level .plabel { font-size: 10px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; color: #888; margin-bottom: 6px; }
  .pyramid-level .ptext { font-size: 14px; color: #1a1a2e; line-height: 1.55; }
  .pyramid-level.answer { background: #0d1b2a; }
  .pyramid-level.answer .plabel { color: #7fbbda; }
  .pyramid-level.answer .ptext { color: #fff; font-size: 15px; }
  .pyramid-level.argument { background: #eef5fb; }
  .pyramid-level.argument .plabel { color: #1e6fa5; }

  .framework-chain { display: flex; flex-direction: column; gap: 0; }
  .fw-step { display: flex; gap: 16px; padding: 14px 16px; background: #fff; border: 1px solid #e0e4eb; border-bottom: none; }
  .fw-step:last-child { border-bottom: 1px solid #e0e4eb; }
  .fw-num { font-size: 20px; font-weight: 800; color: #e0e4eb; min-width: 28px; }
  .fw-body h4 { font-size: 13px; font-weight: 700; color: #0d1b2a; margin-bottom: 3px; }
  .fw-body p { font-size: 12.5px; color: #555; margin-bottom: 3px; line-height: 1.5; }
  .fw-body .feeds { font-size: 11.5px; color: #1e6fa5; }

  .deliverable-link { display: flex; align-items: center; gap: 14px; background: #fff; border: 1px solid #e0e4eb; border-left: 3px solid #1a7f4b; padding: 18px 22px; }
  .deliverable-link .dl-icon { font-size: 28px; }
  .deliverable-link h4 { font-size: 14px; font-weight: 600; color: #0d1b2a; margin-bottom: 3px; }
  .deliverable-link p { font-size: 12.5px; color: #555; margin: 0; }
  .deliverable-link a { color: #1e6fa5; font-size: 12px; word-break: break-all; }

  .pending-block { background: #f8f9fc; border: 1px dashed #c8cdd6; padding: 20px 24px; color: #94a3b8; font-size: 13px; font-style: italic; }

  /* Sources table (Stage 3) */
  .sources-section { margin-top: 24px; }
  .sources-section h3 { font-size: 12px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; color: #888; margin-bottom: 10px; }
  .sources-table { width: 100%; border-collapse: collapse; font-size: 12.5px; }
  .sources-table thead th { background: #f1f5f9; color: #555; padding: 8px 12px; text-align: left; font-size: 10px; letter-spacing: 1px; text-transform: uppercase; border-bottom: 2px solid #e0e4eb; font-weight: 700; }
  .sources-table tbody td { padding: 9px 12px; border-bottom: 1px solid #edf0f4; vertical-align: top; line-height: 1.45; color: #333; }
  .sources-table tbody tr:hover td { background: #f8f9fc; }
  .sources-table a { color: #1e6fa5; text-decoration: none; }
  .sources-table a:hover { text-decoration: underline; }
  .sq-tag { display: inline-block; font-size: 10px; font-weight: 700; padding: 1px 7px; border-radius: 10px; background: #eef5fb; color: #1e6fa5; white-space: nowrap; }

  footer { max-width: 900px; margin: 0 auto; padding: 0 48px 40px; font-size: 12px; color: #aaa; display: flex; justify-content: space-between; }
</style>
</head>
<body>

<header>
  <div class="eyebrow">[PROJECT NAME] — Research Journal</div>
  <h1>Analysis Workbook</h1>
  <p>Generated [DATE] · [N of N stages complete]</p>
</header>

<!-- Stage progress pills -->
<div class="progress-bar">
  <div class="stage-pill [done|partial|pending]">01 Brief</div>
  <div class="stage-pill [done|partial|pending]">02 Frameworks</div>
  <div class="stage-pill [done|partial|pending]">03 Research</div>
  <div class="stage-pill [done|partial|pending]">04 Validation</div>
  <div class="stage-pill [done|partial|pending]">05 Synthesis</div>
  <div class="stage-pill [done|partial|pending]">06 Deliverable</div>
</div>

<main>

  <!-- ══ STAGE 1: BRIEF & PROBLEM FRAMING ══ -->
  <div class="stage-block">
    <div class="stage-header">
      <span class="stage-num">01</span>
      <span class="stage-title">Brief &amp; Problem Framing</span>
      <span class="stage-badge badge-[done|partial|pending]">[Complete|In progress|Not started]</span>
    </div>

    <div class="content-card">
      <h3>Brief Decode</h3>
      <ul>
        <li><strong>Domain:</strong> [domain]</li>
        <li><strong>Mode:</strong> [Academic | Professional | Learning]</li>
        <li><strong>Deliverable:</strong> [what needs to be produced]</li>
        <li><strong>Constraints:</strong> [word/slide count, deadline, source requirements]</li>
        <li><strong>Core question:</strong> [the central question]</li>
      </ul>
    </div>

    <div class="content-card">
      <h3>MECE Issue Tree</h3>
      <p><strong>Central question:</strong> [How should X do Y to achieve Z?]</p>
      <ul>
        <li><strong>Sub-question 1:</strong> [SQ1]</li>
        <li><strong>Sub-question 2:</strong> [SQ2]</li>
        <li><strong>Sub-question 3:</strong> [SQ3]</li>
      </ul>
      <div style="margin-top:12px;background:#f8f9fc;border-left:3px solid #f59e0b;padding:10px 14px;">
        <div style="font-size:10px;letter-spacing:1px;text-transform:uppercase;color:#b45309;margin-bottom:4px;">Initial hypothesis</div>
        <p style="font-size:13px;color:#333;margin:0;">[The provisional answer stated before research began]</p>
      </div>
    </div>
  </div>

  <!-- ══ STAGE 2: FRAMEWORK SEQUENCE ══ -->
  <div class="stage-block">
    <div class="stage-header">
      <span class="stage-num">02</span>
      <span class="stage-title">Framework Sequence</span>
      <span class="stage-badge badge-[done|partial|pending]">[Complete|In progress|Not started]</span>
    </div>

    <div class="framework-chain">
      <!-- Repeat fw-step for each framework -->
      <div class="fw-step">
        <div class="fw-num">1</div>
        <div class="fw-body">
          <h4>[Framework Name]</h4>
          <p>[Why it applies to this specific problem]</p>
          <div class="feeds">→ Output feeds: [what it passes to the next framework]</div>
        </div>
      </div>
      <!-- more steps -->
    </div>
  </div>

  <!-- ══ STAGE 3: RESEARCH FINDINGS ══ -->
  <div class="stage-block">
    <div class="stage-header">
      <span class="stage-num">03</span>
      <span class="stage-title">Research Findings</span>
      <span class="stage-badge badge-[done|partial|pending]">[Complete|In progress|Not started]</span>
    </div>

    <!-- Repeat finding-card for each sub-question -->
    <div class="finding-card">
      <div class="sq-label">Sub-question 1</div>
      <div class="sq-title">[The sub-question that was researched]</div>
      <ul>
        <li>[Finding 1] — <em>[Source, Year]</em></li>
        <li>[Finding 2] — <em>[Source, Year]</em></li>
        <li>[Finding 3] — <em>[Source, Year]</em></li>
      </ul>
      <div class="implication">
        <strong>So what</strong>
        [One sentence: the implication of these findings for the central question]
      </div>
    </div>

    <!-- Sources table — one row per source cited across all sub-questions -->
    <div class="sources-section">
      <h3>Sources</h3>
      <table class="sources-table">
        <thead>
          <tr>
            <th>Source</th>
            <th>Publication</th>
            <th>Year</th>
            <th>Used to establish</th>
            <th>Sub-Q</th>
          </tr>
        </thead>
        <tbody>
          <!-- Repeat for each source. If URL exists, wrap title in <a href>. -->
          <tr>
            <td><a href="[URL]" target="_blank" rel="noopener">[Title]</a></td>
            <td>[Publication / outlet]</td>
            <td>[Year]</td>
            <td>[One sentence: what claim this source supports]</td>
            <td><span class="sq-tag">SQ[N]</span></td>
          </tr>
        </tbody>
      </table>
    </div>

  </div>

  <!-- ══ STAGE 4: CLAIM VALIDATION ══ -->
  <div class="stage-block">
    <div class="stage-header">
      <span class="stage-num">04</span>
      <span class="stage-title">Claim Validation — 5 Advisors</span>
      <span class="stage-badge badge-[done|partial|pending]">[Complete|In progress|Not started]</span>
    </div>

    <table class="validation-table">
      <thead>
        <tr>
          <th style="width:35%">Claim</th>
          <th>Contrarian</th>
          <th>First Principles</th>
          <th>Confidence</th>
          <th>Used in analysis</th>
        </tr>
      </thead>
      <tbody>
        <!-- Repeat for each validated claim -->
        <tr>
          <td>[Claim text]</td>
          <td>HOLDS / UNCERTAIN / REFUTED</td>
          <td>PRIMARY-VERIFIED / SECONDARY-ONLY / UNVERIFIABLE</td>
          <td><span class="conf conf-[high|medium|flag|disputed|unverified]">[HIGH|MEDIUM|FLAG|DISPUTED|UNVERIFIED]</span></td>
          <td>Yes / No (excluded)</td>
        </tr>
      </tbody>
    </table>
  </div>

  <!-- ══ STAGE 5: SYNTHESIS ══ -->
  <div class="stage-block">
    <div class="stage-header">
      <span class="stage-num">05</span>
      <span class="stage-title">Synthesis — Pyramid Principle</span>
      <span class="stage-badge badge-[done|partial|pending]">[Complete|In progress|Not started]</span>
    </div>

    <div class="pyramid">
      <div class="pyramid-level answer">
        <div class="plabel">Answer first</div>
        <div class="ptext">[The recommendation or conclusion — one or two sentences]</div>
      </div>
      <!-- Repeat argument level for each supporting argument -->
      <div class="pyramid-level argument">
        <div class="plabel">Argument 1</div>
        <div class="ptext">[Supporting argument with evidence reference]</div>
      </div>
      <div class="pyramid-level argument">
        <div class="plabel">Argument 2</div>
        <div class="ptext">[Supporting argument with evidence reference]</div>
      </div>
      <div class="pyramid-level argument">
        <div class="plabel">Argument 3</div>
        <div class="ptext">[Supporting argument with evidence reference]</div>
      </div>
      <div class="pyramid-level" style="background:#fff;">
        <div class="plabel">Hypothesis verdict</div>
        <div class="ptext">[Was the initial hypothesis confirmed, partially confirmed, or overturned? What changed?]</div>
      </div>
    </div>
  </div>

  <!-- ══ STAGE 6: DELIVERABLE ══ -->
  <div class="stage-block">
    <div class="stage-header">
      <span class="stage-num">06</span>
      <span class="stage-title">Final Deliverable</span>
      <span class="stage-badge badge-[done|partial|pending]">[Complete|In progress|Not started]</span>
    </div>

    <!-- If deliverable exists: -->
    <div class="deliverable-link">
      <div class="dl-icon">📄</div>
      <div>
        <h4>[Deliverable title — e.g. "Strategy Slide Deck"]</h4>
        <p>[Brief description of what was produced]</p>
        <a href="[relative path to file]">[filename]</a>
      </div>
    </div>

    <!-- If deliverable not yet produced: -->
    <!-- <div class="pending-block">Deliverable not yet produced. Run /draft or /publish to generate it.</div> -->

  </div>

</main>

<footer>
  <span>[PROJECT NAME] — Research Journal</span>
  <span>Generated [DATE]</span>
</footer>

</body>
</html>
```

---

## Step 3 — Populate the template

Replace every placeholder with real content from the session:

- Use `badge-done` + `done` pill class for stages that are fully complete
- Use `badge-partial` + `partial` pill class for stages in progress
- Use `badge-pending` + `pending` pill class for stages not yet reached
- For pending stages, replace the content area with a `<div class="pending-block">` with a short note explaining what will appear here
- For research findings: list each finding as a bullet with its source inline. Include at least 4–6 findings per sub-question if available — do not summarise away the detail.
- For validation: include every claim that was submitted to the 5 Advisors, not just the HIGH-confidence ones. Show what was excluded and why.
- For the synthesis Pyramid: quote the exact recommendation from Step 6 of the analysis.
- For the deliverable: if a file was produced, include its relative path. If multiple files were produced (deck + references), add a link row for each.

---

## Step 4 — Confirm

After writing the file, tell the user:
- The file path
- How many stages are complete vs. total
- How to open it: `open [path]`
