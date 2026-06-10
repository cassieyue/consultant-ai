---
name: references
description: Generate a standalone HTML references page with every source from the session as a clickable link. Grouped by authority tier, shows what each source was used to claim. Run after /consult or /research to verify sources before submitting.
---

You are compiling a verification-ready references list from all sources cited in this session. The goal is to give the user one page where they can click through to every source and confirm it actually says what was claimed.

Output path: **$ARGUMENTS**

If $ARGUMENTS is empty, save to `~/Documents/[project-name]-references.html`. Infer the project name from the session context. If unclear, ask.

---

## Step 1 — Collect all sources

Scan the entire session for every source cited anywhere — research findings, framework analyses, the recommendation, the draft, anywhere.

For each source, record:
- **Title**: the article, report, or page title
- **Publication**: journal name, news outlet, organization, or website
- **Author(s)**: surname(s) and initials if known; organization name if no individual author
- **Year**: publication year
- **URL**: the full URL if one was cited or can be inferred from context. If no URL is available, leave blank — do not invent URLs.
- **Claim**: one sentence summarizing what this source was specifically used to establish (e.g. "Supports claim that Nigeria new car sales grew 47.1% in 2025")
- **Tier**: classify each source into one of four tiers:
  - **Tier 1 — Academic**: peer-reviewed journals, academic textbooks, university working papers
  - **Tier 2 — Institutional**: government publications, multilateral agencies (World Bank, IMF, OECD, UN), regulatory bodies
  - **Tier 3 — Specialist press**: FT, Bloomberg, HBR, Economist, industry trade publications, company annual reports, major consultancy reports (McKinsey, Deloitte, etc.)
  - **Tier 4 — General press**: news outlets, websites, blog posts, other web sources

---

## Step 2 — Write the HTML file

Use the Write tool to create the file. All CSS and JavaScript must be inline — no external dependencies.

Use exactly this structure:

```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>[PROJECT NAME] — References</title>
<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  body {
    font-family: system-ui, -apple-system, sans-serif;
    background: #f4f6f9;
    color: #1a1a2e;
    font-size: 14px;
    line-height: 1.6;
  }

  header {
    background: #0d1b2a;
    color: #fff;
    padding: 36px 48px 32px;
  }
  header .eyebrow {
    font-size: 10px;
    letter-spacing: 3px;
    text-transform: uppercase;
    color: #7fbbda;
    margin-bottom: 10px;
  }
  header h1 { font-size: 26px; font-weight: normal; font-family: Georgia, serif; margin-bottom: 6px; }
  header p { font-size: 13px; color: #b0c4d8; }

  .controls {
    background: #fff;
    border-bottom: 1px solid #dde1e8;
    padding: 16px 48px;
    display: flex;
    align-items: center;
    gap: 16px;
    position: sticky;
    top: 0;
    z-index: 10;
  }
  .controls input {
    flex: 1;
    max-width: 360px;
    border: 1px solid #c8cdd6;
    border-radius: 4px;
    padding: 8px 14px;
    font-size: 13px;
    outline: none;
  }
  .controls input:focus { border-color: #1e6fa5; }
  .tier-btns { display: flex; gap: 8px; flex-wrap: wrap; }
  .tier-btn {
    font-size: 11px;
    letter-spacing: 0.5px;
    padding: 5px 12px;
    border-radius: 20px;
    border: 1px solid #c8cdd6;
    background: #fff;
    cursor: pointer;
    transition: all 0.15s;
  }
  .tier-btn.active { background: #0d1b2a; color: #fff; border-color: #0d1b2a; }
  .count { font-size: 12px; color: #888; margin-left: auto; }

  main { max-width: 960px; margin: 0 auto; padding: 32px 48px 64px; }

  .tier-group { margin-bottom: 40px; }
  .tier-heading {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 14px;
  }
  .tier-heading h2 { font-size: 13px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; color: #555; }
  .tier-badge {
    font-size: 10px;
    padding: 2px 8px;
    border-radius: 10px;
    font-weight: 700;
    letter-spacing: 0.5px;
  }
  .t1 .tier-badge { background: #d1fae5; color: #065f46; }
  .t2 .tier-badge { background: #dbeafe; color: #1e40af; }
  .t3 .tier-badge { background: #fef3c7; color: #92400e; }
  .t4 .tier-badge { background: #fee2e2; color: #991b1b; }

  .source-card {
    background: #fff;
    border: 1px solid #e0e4eb;
    border-left: 3px solid transparent;
    padding: 18px 22px;
    margin-bottom: 8px;
    transition: border-color 0.15s;
  }
  .t1 .source-card { border-left-color: #10b981; }
  .t2 .source-card { border-left-color: #3b82f6; }
  .t3 .source-card { border-left-color: #f59e0b; }
  .t4 .source-card { border-left-color: #ef4444; }
  .source-card:hover { border-color: #c8cdd6; border-left-color: inherit; }

  .source-card.hidden { display: none; }

  .source-title {
    font-size: 14px;
    font-weight: 600;
    color: #0d1b2a;
    margin-bottom: 4px;
  }
  .source-title a {
    color: #0d1b2a;
    text-decoration: none;
  }
  .source-title a:hover { color: #1e6fa5; text-decoration: underline; }
  .source-title .no-link { color: #555; }

  .source-meta {
    font-size: 12px;
    color: #888;
    margin-bottom: 8px;
  }

  .source-claim {
    font-size: 13px;
    color: #444;
    background: #f8f9fc;
    border-left: 2px solid #dde1e8;
    padding: 6px 12px;
    line-height: 1.5;
  }
  .source-claim::before {
    content: "Used to establish: ";
    font-weight: 600;
    color: #888;
    font-size: 11px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
  }

  .url-row {
    margin-top: 8px;
    font-size: 11px;
    color: #1e6fa5;
    word-break: break-all;
  }
  .url-row a { color: #1e6fa5; }

  .no-results {
    text-align: center;
    padding: 48px;
    color: #888;
    font-size: 14px;
    display: none;
  }

  footer {
    max-width: 960px;
    margin: 0 auto;
    padding: 0 48px 40px;
    font-size: 12px;
    color: #aaa;
    display: flex;
    justify-content: space-between;
  }
</style>
</head>
<body>

<header>
  <div class="eyebrow">[PROJECT NAME] — Source Verification</div>
  <h1>References</h1>
  <p>[N] sources · Generated [DATE]</p>
</header>

<div class="controls">
  <input type="text" id="search" placeholder="Search sources..." oninput="filter()">
  <div class="tier-btns">
    <button class="tier-btn active" data-tier="all" onclick="setTier('all', this)">All</button>
    <button class="tier-btn" data-tier="t1" onclick="setTier('t1', this)">Academic</button>
    <button class="tier-btn" data-tier="t2" onclick="setTier('t2', this)">Institutional</button>
    <button class="tier-btn" data-tier="t3" onclick="setTier('t3', this)">Specialist press</button>
    <button class="tier-btn" data-tier="t4" onclick="setTier('t4', this)">General press</button>
  </div>
  <span class="count" id="count">[N] sources</span>
</div>

<main>

  <!-- ── TIER 1: Academic ── -->
  <div class="tier-group t1" data-tier="t1">
    <div class="tier-heading">
      <h2>Tier 1 — Academic</h2>
      <span class="tier-badge">Peer-reviewed</span>
    </div>

    <!-- Repeat this block for each Tier 1 source -->
    <div class="source-card" data-text="[searchable text: title + publication + claim]">
      <div class="source-title">
        <!-- If URL exists: -->
        <a href="[URL]" target="_blank" rel="noopener">[Title]</a>
        <!-- If no URL: -->
        <!-- <span class="no-link">[Title]</span> -->
      </div>
      <div class="source-meta">[Author(s)] · [Publication] · [Year]</div>
      <div class="source-claim">[One sentence on what this source was used to establish]</div>
      <!-- Only include url-row if URL exists -->
      <div class="url-row"><a href="[URL]" target="_blank" rel="noopener">[URL]</a></div>
    </div>

  </div>

  <!-- ── TIER 2: Institutional ── -->
  <div class="tier-group t2" data-tier="t2">
    <div class="tier-heading">
      <h2>Tier 2 — Institutional</h2>
      <span class="tier-badge">Government / Multilateral</span>
    </div>
    <!-- source-card blocks -->
  </div>

  <!-- ── TIER 3: Specialist press ── -->
  <div class="tier-group t3" data-tier="t3">
    <div class="tier-heading">
      <h2>Tier 3 — Specialist press</h2>
      <span class="tier-badge">Trade / Industry</span>
    </div>
    <!-- source-card blocks -->
  </div>

  <!-- ── TIER 4: General press ── -->
  <div class="tier-group t4" data-tier="t4">
    <div class="tier-heading">
      <h2>Tier 4 — General press</h2>
      <span class="tier-badge">News / Web</span>
    </div>
    <!-- source-card blocks -->
  </div>

  <div class="no-results" id="no-results">No sources match your search.</div>

</main>

<footer>
  <span>[PROJECT NAME]</span>
  <span>Generated [DATE]</span>
</footer>

<script>
  let activeTier = 'all';

  function filter() {
    const q = document.getElementById('search').value.toLowerCase();
    const cards = document.querySelectorAll('.source-card');
    const groups = document.querySelectorAll('.tier-group');
    let visible = 0;

    groups.forEach(g => {
      const tier = g.dataset.tier;
      const tierMatch = activeTier === 'all' || activeTier === tier;
      if (!tierMatch) { g.style.display = 'none'; return; }
      g.style.display = '';
      let groupVisible = 0;
      g.querySelectorAll('.source-card').forEach(c => {
        const text = c.dataset.text.toLowerCase();
        const match = !q || text.includes(q);
        c.classList.toggle('hidden', !match);
        if (match) { groupVisible++; visible++; }
      });
      g.style.display = groupVisible ? '' : 'none';
    });

    document.getElementById('count').textContent = visible + ' source' + (visible !== 1 ? 's' : '');
    document.getElementById('no-results').style.display = visible ? 'none' : 'block';
  }

  function setTier(tier, btn) {
    activeTier = tier;
    document.querySelectorAll('.tier-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');
    filter();
  }
</script>
</body>
</html>
```

---

## Step 3 — Populate the template

Replace every placeholder with real content:

- `[PROJECT NAME]`: infer from session context (e.g. "BYD Nigeria Expansion")
- `[DATE]`: today's date
- `[N]`: total source count
- For each source card:
  - `data-text`: lowercase concatenation of title + publication + claim — used by the search filter
  - Include `<a href>` only if a real URL was cited. If no URL, use `<span class="no-link">` for the title and omit the `url-row` div
  - Keep one source per card — do not combine multiple sources

Sources that have no URL but were cited go in as no-link cards. Do not invent URLs.

---

## Step 4 — Confirm

After writing the file, tell the user:
- The file path
- Source count by tier (e.g. "2 academic, 8 institutional, 14 specialist press, 22 general press")
- How to open it: `open [path]`
- Note any sources that had no URL and could not be linked
