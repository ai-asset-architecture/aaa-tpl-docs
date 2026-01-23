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

**Evidence**
```bash
python3 -m unittest tests.test_verify_ci_manifest -v
# PASS (load_checks_manifest + validate_checks with applies_to filtering)
```

## Gate B (repo_type persistence + repo-checks)
- `repo_type` 寫入 repo 根目錄 `index.json`。
- `repo-checks` 讀取 `index.json` 的 `repo_type` 判斷是否需要 skills/prompt。

**Evidence**
```bash
python3 -m unittest runner.tests.test_repo_type_governance -v
# PASS (docs skips, agent requires)
```

## Key Artifacts
- `aaa-actions/checks.manifest.json`
- `aaa-tools/runbooks/init/plan.v0.7.json`
- `aaa-tools/aaa/init_commands.py`
- `aaa-tools/aaa/verify_ci.py`
- `aaa-evals/runner/run_repo_checks.py`
- `aaa-evals/runner/tests/test_repo_type_governance.py`

---
