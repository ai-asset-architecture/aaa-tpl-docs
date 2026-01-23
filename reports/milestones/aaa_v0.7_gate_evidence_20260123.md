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
