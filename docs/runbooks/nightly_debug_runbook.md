---
title: "Nightly Debug Runbook"
version: v2.0.2
status: Active
owner: AAA Governance
last_updated: 2026-01-29
---

# Nightly Debug Runbook

## Purpose
Provide a deterministic recovery path when nightly governance fails.

## Inputs
- `reports/audits/nightly_governance_YYYYMMDD_HHMM.json`
- `reports/audits/repo_checks_YYYYMMDD_HHMM.jsonl`

## Step-by-Step
1. **Locate latest run artifacts**
   - Check `reports/audits/` for the latest JSON + JSONL pair.

2. **Extract failing checks**
   ```bash
   grep -n '"status": "fail"' reports/audits/repo_checks_YYYYMMDD_HHMM.jsonl
   ```

3. **Classify root cause**
   - `repo_type_consistency`: missing `.aaa/metadata.json`
   - `workflow`: missing versioned AAA actions in workflows
   - `readme`: missing required sections or CODEOWNERS

4. **Apply fixes**
   - For repo_type: add `.aaa/metadata.json` and commit.
   - For workflow: ensure `uses: ai-asset-architecture/aaa-actions/.github/workflows/...@vX`.
   - For readme: add required sections + CODEOWNERS.

5. **Re-run nightly**
   ```bash
   gh workflow run nightly-trigger.yaml -R ai-asset-architecture/aaa-tpl-docs
   ```

6. **Validate dashboard sync**
   ```bash
   gh workflow run dashboard-sync.yaml -R ai-asset-architecture/aaa-docs
   ```

## Evidence Output
- `repo_checks_YYYYMMDD_HHMM.jsonl`
- `nightly_governance_YYYYMMDD_HHMM.json`

## Notes
- Always persist JSONL before failing the job.
- Do not use cross-repo push for dashboard updates.
