# P2-1 Observability (Drift/Repo Health + Alerts) Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add drift rate and repo health time series to the governance dashboard and enforce alert thresholds in nightly governance.

**Architecture:** Extend `aaa-tools` dashboard pipeline to compute new metrics from nightly JSON, emit a richer `metrics.json` time series, and render new KPI + trend blocks in HTML/MD. Update CLI thresholds and nightly workflow to fail on drift/health breaches.

**Tech Stack:** Python (`aaa-tools`), JSON metrics, GitHub Actions YAML (`aaa-actions`), dashboard templates (HTML/CSS/JS/MD).

### Task 1: Add metrics computation in `render_dashboard`

**Files:**
- Modify: `aaa-tools/aaa/ops/render_dashboard.py`
- Test: `aaa-tools/tests/test_render_dashboard.py`

**Step 1: Write failing test for new metrics**

```python
from aaa.ops import render_dashboard

payload = {
    "repos": [
        {"name": "a", "archived": False, "checks": [{"id": "orphaned_assets", "status": "fail"}]},
        {"name": "b", "archived": False, "checks": [{"id": "orphaned_assets", "status": "pass"}]},
    ]
}
metrics = render_dashboard.compute_metrics(payload)
self.assertAlmostEqual(metrics["drift_rate"], 0.5)
```

**Step 2: Run test to verify it fails**

Run:
```bash
python3 -m unittest aaa-tools/tests/test_render_dashboard.py
```
Expected: FAIL (missing compute_metrics).

**Step 3: Implement minimal computation**

Add to `render_dashboard.py`:
- `DRIFT_CHECKS = {"orphaned_assets", "checks_manifest_alignment"}`
- `compute_metrics(payload)` returns `{drift_rate, repo_health}` for eligible repos.
  - drift_rate = drift_repos / eligible
  - repo_health = average(pass_count / total_checks)
- Extend `render_dashboard()` to call `compute_metrics` and pass metrics into render functions.

**Step 4: Update tests**

Add assertions for `repo_health` and ensure `render_markdown`/`render_html` include new KPI labels.

**Step 5: Run tests to verify pass**

Run:
```bash
python3 -m unittest aaa-tools/tests/test_render_dashboard.py
```
Expected: PASS.

### Task 2: Expand dashboard templates for drift/health

**Files:**
- Modify: `aaa-tools/aaa/templates/dashboard.html.tmpl`
- Modify: `aaa-tools/aaa/templates/dashboard.md.tmpl`
- Modify: `aaa-tools/aaa/templates/dashboard.js.tmpl`
- Modify: `aaa-tools/aaa/templates/dashboard.css.tmpl`

**Step 1: Add KPI cards + trend panels**

Add new KPI cards for:
- Drift Rate (alert style when high)
- Repo Health (good when high)

Add two new trend blocks (similar to compliance trend) that read from `metrics.json` and render:
- Drift rate trend
- Repo health trend

**Step 2: Update JS to load `metrics.json`**

- Replace `trends.json` usage with `metrics.json` entries containing:
  - `date`, `compliance_rate`, `drift_rate`, `repo_health`
- Render 3 charts using a shared helper (`renderTrend(metricKey, domIds)`)

**Step 3: Update MD template**

- Add a short metrics section showing compliance, drift, repo health (latest values)

**Step 4: Manual render check**

Run:
```bash
python3 -m aaa.cli ops render-dashboard \
  --input /tmp/nightly.json \
  --md-out /tmp/dashboard.md \
  --html-out /tmp/index.html
```
Expected: outputs include drift/repo health blocks.

### Task 3: Add CLI thresholds for drift/health (Post-Mortem visibility)

**Files:**
- Modify: `aaa-tools/aaa/cli.py`
- Modify: `aaa-tools/aaa/ops/render_dashboard.py`
- Test: `aaa-tools/tests/test_render_dashboard.py`

**Step 1: Extend CLI options**

Add options:
- `--drift-threshold` (default 0.05)
- `--health-threshold` (default 0.9)

**Step 2: Return metrics from render_dashboard**

Have `render_dashboard()` return `(compliance_rate, metrics)` so CLI can validate thresholds **after** all files are written. Ensure `render_dashboard()` writes outputs before any exit path is triggered in CLI.

**Step 3: Update tests**

Add a CLI test to ensure drift/health thresholds fail when exceeded.

**Step 4: Run tests**

Run:
```bash
python3 -m unittest aaa-tools/tests/test_render_dashboard.py
```
Expected: PASS.

### Task 4: Update nightly governance workflow alerts (Post-Mortem visibility)

**Files:**
- Modify: `aaa-actions/.github/workflows/nightly-governance.yaml`

**Step 1: Pass new thresholds**

Update render step:
```bash
aaa ops render-dashboard \
  --input /tmp/aaa-nightly/nightly_governance.json \
  --md-out "${REPORT_PATH}" \
  --html-out aaa-tpl-docs/docs/dashboard/index.html \
  --threshold 0.8 \
  --drift-threshold 0.05 \
  --health-threshold 0.9
```

**Step 2: Ensure dashboard deploy runs even on failure**

Add `if: ${{ success() || failure() }}` (or `always()`) to Pages deploy or artifact upload steps so red dashboards still publish.

**Step 3: Document in report**

Add a short bullet to nightly report header describing drift/health thresholds.

### Task 5: Final verification

**Step 1: Run unit tests**

```bash
python3 -m unittest aaa-tools/tests/test_render_dashboard.py
```
Expected: PASS.

**Step 2: Lint workflow (if available)**

```bash
yamllint aaa-actions/.github/workflows/nightly-governance.yaml
```
If `yamllint` is unavailable, note and skip.

---

## Notes
- If drift checks should include additional IDs, list them explicitly in `DRIFT_CHECKS`.
- Keep `metrics.json` bounded (e.g., last 90 days), matching existing trend behavior.
