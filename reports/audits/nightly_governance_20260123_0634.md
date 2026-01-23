# Nightly Governance Report (20260123_0634 UTC)

## Nightly Test Cases
- Reindex Drift Check: aaa run runbook --runbook-file ./aaa-tools/runbooks/ops/reindex-all-assets.yaml
  - ZH-TW: 確保索引與實際資產同步，避免治理數據漂移。
  - EN: Ensures indexes match real assets to prevent governance drift.
- Org Audit: python3 ./aaa-evals/runner/run_github_audit.py
  - ZH-TW: 組織級治理稽核，檢查分支保護與 required checks 落地。
  - EN: Org-level audit for branch protection and required checks compliance.
- Repo Checks (Governance Suite): aaa init repo-checks --suite governance
  - Checks: readme, workflow, repo_type_consistency, checks_manifest_alignment, orphaned_assets
  - ZH-TW: 逐 repo 驗證文件與治理規則一致性，避免類型誤判。
  - EN: Per-repo governance validation to avoid repo-type mismatches.
- Agent Safety: python3 ./aaa-evals/runner/run_repo_checks.py --check agent_safety --repo <workspace>
  - ZH-TW: 驗證安全攔截與邊界限制是否有效。
  - EN: Validates safety blocks and boundary enforcement.

## Repo Checks (Governance)
{"event": "start", "ts": "2026-01-23T06:34:30.171507+00:00", "command": "aaa init repo-checks", "step_id": "repo_evals", "status": "start"}
{"event": "result", "ts": "2026-01-23T06:34:30.915033+00:00", "command": "aaa init repo-checks", "step_id": "repo_evals", "status": "ok", "data": {"repo": "aaa-tpl-docs", "suite": "governance", "checks": [{"id": "readme", "status": "pass", "message": []}, {"id": "workflow", "status": "fail", "message": [".github/workflows/nightly-trigger.yaml"]}, {"id": "repo_type_consistency", "status": "fail", "message": [".aaa/metadata.json missing"]}, {"id": "checks_manifest_alignment", "status": "fail", "message": ["checks.manifest.json missing"]}, {"id": "orphaned_assets", "status": "fail", "message": [{"type": "orphaned_asset", "path": "/home/runner/work/aaa-tpl-docs/aaa-tpl-docs/aaa-tpl-docs/reports/audits/nightly_governance_20260123_0634.md", "suggested_fix": "Run `aaa run ops/reindex-all-assets` to update index.json"}, {"type": "orphaned_asset", "path": "/home/runner/work/aaa-tpl-docs/aaa-tpl-docs/aaa-tpl-docs/reports/github_audit_report_20260123_0634.md", "suggested_fix": "Run `aaa run ops/reindex-all-assets` to update index.json"}]}]}}
{"event": "result", "ts": "2026-01-23T06:34:31.633806+00:00", "command": "aaa init repo-checks", "step_id": "repo_evals", "status": "ok", "data": {"repo": "aaa-tpl-service", "suite": "governance", "checks": [{"id": "readme", "status": "pass", "message": []}, {"id": "workflow", "status": "pass", "message": []}, {"id": "repo_type_consistency", "status": "fail", "message": [".aaa/metadata.json missing"]}, {"id": "checks_manifest_alignment", "status": "fail", "message": ["checks.manifest.json missing"]}, {"id": "orphaned_assets", "status": "pass", "message": []}]}}
{"event": "result", "ts": "2026-01-23T06:34:32.370532+00:00", "command": "aaa init repo-checks", "step_id": "repo_evals", "status": "ok", "data": {"repo": "aaa-tpl-frontend", "suite": "governance", "checks": [{"id": "readme", "status": "pass", "message": []}, {"id": "workflow", "status": "pass", "message": []}, {"id": "repo_type_consistency", "status": "fail", "message": [".aaa/metadata.json missing"]}, {"id": "checks_manifest_alignment", "status": "fail", "message": ["checks.manifest.json missing"]}, {"id": "orphaned_assets", "status": "pass", "message": []}]}}
{"event": "error", "ts": "2026-01-23T06:34:32.370950+00:00", "command": "aaa init repo-checks", "step_id": "repo_evals", "status": "error", "code": 44, "message": "repo checks failed", "data": {"failures": [{"repo": "aaa-tpl-docs", "check": "workflow", "message": [".github/workflows/nightly-trigger.yaml"]}, {"repo": "aaa-tpl-docs", "check": "repo_type_consistency", "message": [".aaa/metadata.json missing"]}, {"repo": "aaa-tpl-docs", "check": "checks_manifest_alignment", "message": ["checks.manifest.json missing"]}, {"repo": "aaa-tpl-docs", "check": "orphaned_assets", "message": [{"type": "orphaned_asset", "path": "/home/runner/work/aaa-tpl-docs/aaa-tpl-docs/aaa-tpl-docs/reports/audits/nightly_governance_20260123_0634.md", "suggested_fix": "Run `aaa run ops/reindex-all-assets` to update index.json"}, {"type": "orphaned_asset", "path": "/home/runner/work/aaa-tpl-docs/aaa-tpl-docs/aaa-tpl-docs/reports/github_audit_report_20260123_0634.md", "suggested_fix": "Run `aaa run ops/reindex-all-assets` to update index.json"}]}, {"repo": "aaa-tpl-service", "check": "repo_type_consistency", "message": [".aaa/metadata.json missing"]}, {"repo": "aaa-tpl-service", "check": "checks_manifest_alignment", "message": ["checks.manifest.json missing"]}, {"repo": "aaa-tpl-frontend", "check": "repo_type_consistency", "message": [".aaa/metadata.json missing"]}, {"repo": "aaa-tpl-frontend", "check": "checks_manifest_alignment", "message": ["checks.manifest.json missing"]}]}}

## Agent Safety
{"check": "agent_safety", "repo": "/home/runner/work/aaa-tpl-docs/aaa-tpl-docs", "pass": true, "details": []}
