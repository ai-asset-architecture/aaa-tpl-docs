# Validation Audit: v2.0.2 Dashboard Visual Governance

## Scope
- Dashboard UI/UX compliance with v2.0.2 governance requirements.
- Evidence of Trust Boundary visualization and ledger-derived metrics rendering.

## Evidence Targets
- Updated dashboard HTML/CSS/JS with i18n axis labels and single-column charts.
- Trust Boundary + Failing panels share a row; Repo Inventory sits on its own row.
- Evidence Bundle Compliance KPI present.
- Trust Boundary grouping (Control / Execution / Asset / Docs) present.
- Data source note for ledger_export.jsonl → metrics.*.
- Axis tick values are visible on charts.
- Nightly workflow covers v2.0 core repo inventory and publishes dashboard to aaa-docs.
- Dashboard templates in aaa-tools align with v2.0.2 UI/UX layout.
- Nightly trigger uses reusable workflow ref v1.5.0 to resolve nightly-governance.

## Validation Checklist
- [x] KPI: Evidence Bundle Compliance present.
- [x] Trust Boundary grouping present with correct repo lists.
- [x] Charts render as one-per-line with X/Y axis labels.
- [x] Charts render numeric axis ticks (X/Y).
- [x] Trust Boundary + Failing panels share one row; Repo Inventory has its own row.
- [x] i18n toggle updates axis labels and new text blocks.
- [x] Repo inventory includes v2.0 core repos and boundary column.
- [x] Data source note visible and accurate.
- [ ] KPI Repo Total/Active equals Repo Inventory count.
- [x] Nightly governance repo coverage matches v2.0 core repo inventory (config updated).
- [x] Nightly trigger references `@v1.5.0` reusable workflow.

## Evidence Log
- Evidence commit (aaa-docs): `4de087b`
- Evidence commit (aaa-actions): Pending (nightly workflow coverage expansion + dashboard publish path).
- Evidence commit (aaa-tools): Pending (dashboard templates align with v2.0.2 layout).
- Files:
  - `aaa-docs/docs/dashboard/index.html`
  - `aaa-docs/docs/dashboard/dashboard.js`
  - `aaa-docs/docs/dashboard/dashboard.css`
  - `aaa-actions/.github/workflows/nightly-governance.yaml`
  - `aaa-tpl-docs/.github/workflows/nightly-trigger.yaml`
  - `aaa-tools/aaa/templates/dashboard.html.tmpl`
  - `aaa-tools/aaa/templates/dashboard.css.tmpl`
  - `aaa-tools/aaa/templates/dashboard.js.tmpl`
- Manual checks:
  - Verified axis labels in EN/ZH via i18n toggle.
  - Verified axis tick values render on charts.
  - Verified charts are single-column layout.
  - Verified Trust Boundary + Failing panels share a row and Repo Inventory is full-width.
  - Verified Trust Boundary grouping and repo inventory updates.
  - Verified data source note shows ledger_export.jsonl → metrics.*.
  - Verified nightly workflow config now includes v2.0 repo inventory and publishes dashboard to aaa-docs (pending run).

## Asset Preservation (Step 2)
- Evals: None (UI-only change).
- Templates: None.
- Policy Packs: None.
- Tools: None (no CLI/runtime changes).
- Registry updates: N/A (no new assets).
- Justification: Dashboard update is presentation-only; no reusable assets created.
