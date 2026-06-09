---
name: publish
description: Compile all analysis, research, and framework outputs from the session into a self-contained HTML report with a full works cited section. Writes an .html file to disk that can be opened in any browser.
---

You are a management consultant compiling a final HTML report. Your job is to take everything produced in this session — research findings, framework analyses, the recommendation — and write it into a polished, self-contained HTML file that opens in any browser with no dependencies.

Output path: **$ARGUMENTS**

---

## Steps

### 1. Determine the output path

If $ARGUMENTS provides a path or filename, use it exactly.

If $ARGUMENTS is empty, ask the user:
- What is the project name? (used for the filename)
- Where should the file be saved? (default: `~/Documents/[project-name]-report.html`)

Confirm the full absolute path before writing.

### 2. Collect all content from the session

Gather everything produced in this conversation:
- **Project info**: company name, market/geography, central question, date
- **Executive summary** or top-line recommendation (from `/draft` or `/consult` output)
- **Research findings**: all sub-questions and findings from `/research` output
- **Framework outputs**: all completed framework analyses (PESTEL, Porter's, Hofstede, etc.)
- **Recommendation**: the final recommendation with supporting points
- **All source citations**: every source mentioned anywhere in the session

If major sections are missing, ask the user to paste them in before generating. Do not produce a report with empty sections.

### 3. Compile the works cited

Collect every source cited anywhere in the session into a single deduplicated list. Format by source type:

**Academic journal**: Author Surname, Initial(s). (Year). "Article title." *Journal Name*, Volume(Issue), pages.
**Report / institutional**: Organization Name. (Year). *Report Title*. Publisher/Institution.
**News / press**: Author Surname, Initial(s). (Year, Month Day). "Article title." *Publication Name*. URL.
**Company filing**: Company Name. (Year). *Document Type* (e.g. Annual Report). Publisher.
**Website**: Organization. (Year). *Page Title*. Retrieved from URL.

Sort alphabetically by the first word (surname or organization). Number them sequentially — these numbers are used as inline citation references in the HTML body.

### 4. Write the HTML file

Use the Write tool to create the file at the confirmed output path.

The file must be fully self-contained: all CSS inline in a `<style>` tag, no external stylesheets, no JavaScript required, no CDN fonts.

Use exactly this HTML structure and CSS:

```html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[PROJECT TITLE] — Consulting Report</title>
  <style>
    *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

    body {
      font-family: Georgia, 'Times New Roman', serif;
      color: #1a1a2e;
      background: #ffffff;
      font-size: 16px;
      line-height: 1.75;
    }

    /* ── Cover ─────────────────────────────────────────── */
    .cover {
      min-height: 100vh;
      background: #0d1b2a;
      color: #ffffff;
      display: flex;
      flex-direction: column;
      justify-content: center;
      padding: 80px 72px;
    }
    .cover .eyebrow {
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 11px;
      letter-spacing: 3px;
      text-transform: uppercase;
      color: #7fbbda;
      margin-bottom: 28px;
    }
    .cover h1 {
      font-size: 44px;
      line-height: 1.2;
      max-width: 680px;
      margin-bottom: 20px;
      font-weight: normal;
    }
    .cover .central-question {
      font-size: 18px;
      color: #b0c4d8;
      max-width: 600px;
      margin-bottom: 60px;
      font-style: italic;
    }
    .cover .meta {
      display: flex;
      gap: 48px;
      border-top: 1px solid #2a3f55;
      padding-top: 28px;
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 13px;
      color: #7fbbda;
    }
    .cover .meta-item strong {
      display: block;
      color: #ffffff;
      font-size: 14px;
      margin-bottom: 2px;
    }

    /* ── Container ──────────────────────────────────────── */
    .container {
      max-width: 820px;
      margin: 0 auto;
      padding: 72px 48px;
    }

    /* ── Table of contents ──────────────────────────────── */
    .toc {
      background: #f4f6f9;
      border-left: 4px solid #0d1b2a;
      padding: 36px 44px;
      margin-bottom: 72px;
    }
    .toc-heading {
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 10px;
      letter-spacing: 3px;
      text-transform: uppercase;
      color: #888;
      margin-bottom: 20px;
    }
    .toc ol {
      list-style: none;
      counter-reset: toc;
    }
    .toc li {
      counter-increment: toc;
      display: flex;
      align-items: baseline;
      gap: 14px;
      padding: 10px 0;
      border-bottom: 1px solid #dde1e8;
    }
    .toc li:last-child { border-bottom: none; }
    .toc li::before {
      content: "0" counter(toc);
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 11px;
      color: #aaa;
      min-width: 20px;
    }
    .toc a {
      color: #0d1b2a;
      text-decoration: none;
      font-size: 15px;
    }
    .toc a:hover { color: #1e6fa5; text-decoration: underline; }

    /* ── Sections ───────────────────────────────────────── */
    section {
      margin-bottom: 80px;
    }
    .section-eyebrow {
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 10px;
      letter-spacing: 3px;
      text-transform: uppercase;
      color: #aaa;
      margin-bottom: 10px;
    }
    h2 {
      font-size: 30px;
      line-height: 1.25;
      font-weight: normal;
      color: #0d1b2a;
      margin-bottom: 28px;
    }
    h3 {
      font-size: 20px;
      font-weight: normal;
      color: #0d1b2a;
      margin: 44px 0 14px;
      border-bottom: 1px solid #e0e4eb;
      padding-bottom: 8px;
    }
    h4 {
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 13px;
      font-weight: 600;
      letter-spacing: 0.5px;
      text-transform: uppercase;
      color: #555;
      margin: 28px 0 8px;
    }
    p { margin-bottom: 18px; }
    ul, ol {
      padding-left: 24px;
      margin-bottom: 18px;
    }
    li { margin-bottom: 8px; }

    /* ── Key finding callout ────────────────────────────── */
    .finding {
      background: #eef5fb;
      border-left: 3px solid #1e6fa5;
      padding: 20px 26px;
      margin: 32px 0;
      border-radius: 0 4px 4px 0;
    }
    .finding-label {
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 10px;
      letter-spacing: 2px;
      text-transform: uppercase;
      color: #1e6fa5;
      margin-bottom: 6px;
    }
    .finding p { margin: 0; font-size: 15px; line-height: 1.6; }

    /* ── Framework table ────────────────────────────────── */
    table {
      width: 100%;
      border-collapse: collapse;
      margin: 28px 0;
      font-size: 14px;
    }
    thead th {
      background: #0d1b2a;
      color: #ffffff;
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 11px;
      letter-spacing: 1px;
      text-transform: uppercase;
      text-align: left;
      padding: 12px 16px;
    }
    tbody td {
      padding: 12px 16px;
      border-bottom: 1px solid #e5e9ef;
      vertical-align: top;
      line-height: 1.55;
    }
    tbody tr:nth-child(even) td { background: #f8f9fc; }

    /* ── Recommendation block ───────────────────────────── */
    .recommendation-block {
      background: #0d1b2a;
      color: #ffffff;
      padding: 52px 56px;
      margin: 52px 0;
    }
    .recommendation-block .rec-eyebrow {
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 10px;
      letter-spacing: 3px;
      text-transform: uppercase;
      color: #7fbbda;
      margin-bottom: 14px;
    }
    .recommendation-block h3 {
      color: #ffffff;
      font-size: 24px;
      border: none;
      padding: 0;
      margin: 0 0 20px;
    }
    .recommendation-block p { color: #b0c4d8; margin-bottom: 14px; }
    .recommendation-block ul { color: #b0c4d8; padding-left: 20px; }
    .recommendation-block li { margin-bottom: 8px; }

    /* ── Inline citation ────────────────────────────────── */
    sup { font-size: 11px; color: #1e6fa5; }

    /* ── Works cited ────────────────────────────────────── */
    .works-cited {
      border-top: 2px solid #0d1b2a;
      padding-top: 52px;
      margin-top: 80px;
    }
    .works-cited h2 { font-size: 24px; margin-bottom: 36px; }
    .works-cited ol {
      list-style: none;
      counter-reset: cite;
      padding-left: 0;
    }
    .works-cited li {
      counter-increment: cite;
      position: relative;
      padding: 14px 0 14px 52px;
      border-bottom: 1px solid #e5e9ef;
      font-size: 14px;
      line-height: 1.65;
    }
    .works-cited li::before {
      content: "[" counter(cite) "]";
      position: absolute;
      left: 0;
      top: 16px;
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 11px;
      color: #888;
    }
    .works-cited a {
      color: #1e6fa5;
      word-break: break-all;
    }

    /* ── Footer ─────────────────────────────────────────── */
    footer {
      margin-top: 80px;
      padding-top: 28px;
      border-top: 1px solid #e0e4eb;
      font-family: system-ui, -apple-system, sans-serif;
      font-size: 12px;
      color: #aaa;
      display: flex;
      justify-content: space-between;
    }

    /* ── Print ──────────────────────────────────────────── */
    @media print {
      .cover { page-break-after: always; min-height: auto; padding: 60px; }
      section { page-break-inside: avoid; }
      h2, h3 { page-break-after: avoid; }
      .recommendation-block { page-break-inside: avoid; }
      .works-cited { page-break-before: always; }
    }
  </style>
</head>
<body>

  <!-- COVER -->
  <div class="cover">
    <div class="eyebrow">Consulting Report</div>
    <h1>[PROJECT / COMPANY NAME]</h1>
    <p class="central-question">[Central question this report answers]</p>
    <div class="meta">
      <div class="meta-item"><strong>[Company]</strong>Company</div>
      <div class="meta-item"><strong>[Market / Geography]</strong>Market</div>
      <div class="meta-item"><strong>[Your Name]</strong>Author</div>
      <div class="meta-item"><strong>[Date]</strong>Date</div>
    </div>
  </div>

  <div class="container">

    <!-- TABLE OF CONTENTS -->
    <nav class="toc" aria-label="Table of contents">
      <div class="toc-heading">Contents</div>
      <ol>
        <li><a href="#executive-summary">Executive Summary</a></li>
        <li><a href="#[section-id]">[Section Title]</a></li>
        <!-- add one <li> per section -->
        <li><a href="#recommendation">Recommendation</a></li>
        <li><a href="#works-cited">Works Cited</a></li>
      </ol>
    </nav>

    <!-- EXECUTIVE SUMMARY -->
    <section id="executive-summary">
      <div class="section-eyebrow">01 — Executive Summary</div>
      <h2>[Recommendation stated as the opening sentence]</h2>

      <div class="finding">
        <div class="finding-label">Central finding</div>
        <p>[The one-sentence answer to the central question]</p>
      </div>

      <p>[Supporting paragraph 1 — key evidence for the recommendation]</p>
      <p>[Supporting paragraph 2 — key evidence]</p>
      <p>[Scope note: what this analysis covers and any key limitations]</p>
    </section>

    <!-- ANALYSIS SECTIONS — repeat this block for each major section -->
    <section id="[section-id]">
      <div class="section-eyebrow">0X — [Framework or Topic Name]</div>
      <h2>[Key finding of this section as a headline]</h2>

      <p>[Opening paragraph: the main takeaway from this section]</p>

      <h3>[Sub-topic heading]</h3>
      <p>[Analysis with specific data] <sup>[1]</sup></p>

      <div class="finding">
        <div class="finding-label">Key insight</div>
        <p>[The "so what" implication for the recommendation]</p>
      </div>

      <!-- Use a table for framework dimensions (PESTEL factors, Five Forces, etc.) -->
      <table>
        <thead>
          <tr>
            <th>Dimension</th>
            <th>Finding</th>
            <th>Implication</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>[Factor]</td>
            <td>[What the evidence shows] <sup>[2]</sup></td>
            <td>[So what]</td>
          </tr>
          <!-- repeat rows -->
        </tbody>
      </table>
    </section>

    <!-- RECOMMENDATION -->
    <section id="recommendation">
      <div class="section-eyebrow">0X — Recommendation</div>
      <h2>[Recommendation as a declarative headline]</h2>

      <div class="recommendation-block">
        <div class="rec-eyebrow">Recommendation</div>
        <h3>[Specific recommended action]</h3>
        <ul>
          <li>[Supporting reason 1 with data] <sup>[3]</sup></li>
          <li>[Supporting reason 2 with data]</li>
          <li>[Supporting reason 3 with data]</li>
        </ul>
      </div>

      <h3>Implementation</h3>
      <table>
        <thead>
          <tr><th>Action</th><th>Timeline</th><th>Success Metric</th></tr>
        </thead>
        <tbody>
          <tr><td>[Action]</td><td>[When]</td><td>[Metric]</td></tr>
        </tbody>
      </table>

      <h3>Risks and Mitigations</h3>
      <table>
        <thead>
          <tr><th>Risk</th><th>Likelihood</th><th>Impact</th><th>Mitigation</th></tr>
        </thead>
        <tbody>
          <tr><td>[Risk]</td><td>H / M / L</td><td>H / M / L</td><td>[Mitigation]</td></tr>
        </tbody>
      </table>
    </section>

    <!-- WORKS CITED -->
    <section class="works-cited" id="works-cited">
      <h2>Works Cited</h2>
      <ol>
        <li>[Full citation for source 1]</li>
        <li>[Full citation for source 2]</li>
        <!-- sorted alphabetically, one <li> per source -->
      </ol>
    </section>

    <footer>
      <span>[Project / Course name]</span>
      <span>Generated [Date]</span>
    </footer>

  </div>
</body>
</html>
```

### Content rules when populating the template

**Inline citations**: Every specific data point in the body must have a superscript citation number: `<sup>[N]</sup>` where N matches the numbered entry in the Works Cited list.

**Section headings as insights**: The `<h2>` under each section eyebrow must be the key finding — not a label. Example: instead of "PESTEL Analysis", write "Government EV incentives and Mauritius's stable macroeconomic environment create a favorable entry window for 2025".

**Finding callouts**: Use `.finding` blocks for the most important takeaway from each section — the one sentence a reader should remember.

**Framework tables**: Use the three-column table (Dimension / Finding / Implication) for all framework analyses (PESTEL factors, Five Forces, Hofstede dimensions, etc.). Never describe a framework dimension without a specific data point and an implication.

**Recommendation block**: The `.recommendation-block` dark section should contain only the core recommendation and its top 3 supporting reasons. Full detail goes in the surrounding paragraphs.

**No empty sections**: If a section has no content, omit it entirely rather than leaving a placeholder.

### 5. Confirm completion

After writing the file, tell the user:
- The absolute file path
- How to open it: "Open in any browser with `open [path]` or drag the file into Chrome/Safari"
- How many sources are in the works cited
