---
summary_zh: 'v0.7 Gate 證據鏈摘要。'
summary_en: 'v0.7 gate evidence summary.'
---

# AAA v0.7 Gate Evidence Summary (2026-01-23)

## Scope
v0.7 以 SSOT + repo_type 做治理對齊，Gate 重點在「required checks 名稱穩定」與「repo-checks 情境正確」。

## Gate A (Checks SSOT + verify-ci)
- SSOT 檔案：`aaa-actions/checks.manifest.json`（含 `applies_to`）。
- `verify-ci` 依 manifest + repo_type 過濾 required checks。

**Evidence (Command + Output)**
```bash
python3 -m unittest tests.test_verify_ci_manifest -v
test_load_checks_manifest_reads_manifest (tests.test_verify_ci_manifest.TestVerifyCiManifest.test_load_checks_manifest_reads_manifest) ... ok
test_validate_checks_flags_missing (tests.test_verify_ci_manifest.TestVerifyCiManifest.test_validate_checks_flags_missing) ... ok

----------------------------------------------------------------------
Ran 2 tests in 0.002s

OK
```

## Gate B (repo_type persistence + repo-checks)
- `repo_type` 寫入 repo 根目錄 `.aaa/metadata.json`（AAA tooling managed）。
- `repo-checks` 讀取 `.aaa/metadata.json` 的 `repo_type` 判斷治理檢查。

**Evidence (Command + Output)**
```bash
AAA_EVALS_ROOT="/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-evals" \
WORKSPACE_DIR="/tmp/aaa-gateB-repos" \
/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/.venv-aaa/bin/aaa \
  init repo-checks \
  --from-plan "/tmp/aaa_plan_v0.1_ref_v0.2.0.filled.json" \
  --org "ai-asset-architecture" \
  --suite "governance" \
  --jsonl --log-dir /tmp/aaa-gateB1
{"event": "start", "ts": "2026-01-23T02:01:31.711241+00:00", "command": "aaa init repo-checks", "step_id": "repo_evals", "status": "start"}
{"event": "result", "ts": "2026-01-23T02:01:32.835138+00:00", "command": "aaa init repo-checks", "step_id": "repo_evals", "status": "ok", "data": {"repo": "ai-asset-architecture-docs", "suite": "governance", "checks": [{"id": "readme", "status": "pass", "message": []}, {"id": "workflow", "status": "pass", "message": []}, {"id": "skills", "status": "pass", "message": ["skipped: non-agent repo"]}, {"id": "prompt", "status": "pass", "message": ["skipped: non-agent repo"]}]}}
{"event": "result", "ts": "2026-01-23T02:01:33.525466+00:00", "command": "aaa init repo-checks", "step_id": "repo_evals", "status": "ok", "data": {"repo": "ai-asset-architecture-svc-core", "suite": "governance", "checks": [{"id": "readme", "status": "pass", "message": []}, {"id": "workflow", "status": "pass", "message": []}, {"id": "skills", "status": "pass", "message": ["skipped: non-agent repo"]}, {"id": "prompt", "status": "pass", "message": ["skipped: non-agent repo"]}]}}
{"event": "result", "ts": "2026-01-23T02:01:34.213619+00:00", "command": "aaa init repo-checks", "step_id": "repo_evals", "status": "ok", "data": {"repo": "ai-asset-architecture-fe-web", "suite": "governance", "checks": [{"id": "readme", "status": "pass", "message": []}, {"id": "workflow", "status": "pass", "message": []}, {"id": "skills", "status": "pass", "message": ["skipped: non-agent repo"]}, {"id": "prompt", "status": "pass", "message": ["skipped: non-agent repo"]}]}}
```

```bash
AAA_TOOLS_ROOT="/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools" \
/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/.venv-aaa/bin/python3 \
  /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-evals/runner/run_repo_checks.py \
  --check agent_safety \
  --repo /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE
{"check": "agent_safety", "repo": "/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE", "pass": true, "details": []}
```

**Nightly Governance (Green)**
- Run: https://github.com/ai-asset-architecture/aaa-tpl-docs/actions/runs/21272984109

**Nightly Test Cases**
- Reindex Drift Check: `aaa run runbook --runbook-file ./aaa-tools/runbooks/ops/reindex-all-assets.yaml`
  - ZH-TW: 確保索引與實際資產同步，避免治理數據漂移。
  - EN: Ensures indexes match real assets to prevent governance drift.
- Org Audit: `python3 ./aaa-evals/runner/run_github_audit.py`
  - ZH-TW: 組織級治理稽核，檢查分支保護與 required checks 落地。
  - EN: Org-level audit for branch protection and required checks compliance.
- Repo Checks (Governance Suite): `aaa init repo-checks --suite governance`
  - Checks: `readme`, `workflow`, `repo_type_consistency`, `checks_manifest_alignment`, `orphaned_assets`
  - ZH-TW: 逐 repo 驗證文件與治理規則一致性，避免類型誤判。
  - EN: Per-repo governance validation to avoid repo-type mismatches.
- Agent Safety: `python3 ./aaa-evals/runner/run_repo_checks.py --check agent_safety --repo <workspace>`
  - ZH-TW: 驗證安全攔截與邊界限制是否有效。
  - EN: Validates safety blocks and boundary enforcement.
```bash
python3 -m unittest runner.tests.test_repo_type_consistency -v
test_repo_type_consistency_missing (runner.tests.test_repo_type_consistency.TestRepoTypeConsistency.test_repo_type_consistency_missing) ... ok
test_repo_type_consistency_pass (runner.tests.test_repo_type_consistency.TestRepoTypeConsistency.test_repo_type_consistency_pass) ... ok

----------------------------------------------------------------------
Ran 2 tests in 0.073s

OK
```

```bash
python3 -m unittest runner.tests.test_checks_manifest_alignment -v
test_checks_manifest_alignment_full (runner.tests.test_checks_manifest_alignment.TestChecksManifestAlignment.test_checks_manifest_alignment_full) ... ok
test_checks_manifest_alignment_pass (runner.tests.test_checks_manifest_alignment.TestChecksManifestAlignment.test_checks_manifest_alignment_pass) ... ok

----------------------------------------------------------------------
Ran 2 tests in 0.007s

OK
```

## Key Artifacts
- `aaa-actions/checks.manifest.json`
- `aaa-tools/runbooks/init/plan.v0.7.json`
- `aaa-tools/aaa/init_commands.py`
- `aaa-tools/aaa/verify_ci.py`
- `aaa-evals/runner/run_repo_checks.py`
- `aaa-evals/runner/checks/check_repo_type_consistency.py`
- `aaa-evals/runner/checks/check_checks_manifest_alignment.py`
- `aaa-evals/runner/tests/test_repo_type_consistency.py`
- `aaa-evals/runner/tests/test_checks_manifest_alignment.py`

---
