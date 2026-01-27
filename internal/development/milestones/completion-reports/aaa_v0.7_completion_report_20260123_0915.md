---
summary_zh: 'v0.7 SSOT + repo_type 完成。'
summary_en: 'v0.7 SSOT + repo_type completion.'
---

# AAA v0.7 Completion Report (2026-01-23 09:15)

## Scope
完成 v0.7 Governance SSOT 與 repo_type 強制落地：checks.manifest SSOT、verify-ci 依 repo_type 過濾、repo_type 寫入 index.json、repo-checks 依 repo_type 讀取判斷。

## Changes
- 新增 `aaa-actions/checks.manifest.json` 作為 required checks SSOT（支援 `applies_to`）。
- `aaa-tools verify-ci` 依 manifest + repo_type 篩選 required checks。
- `aaa-tools apply-templates` 在 repo 根目錄 `index.json` 寫入 `repo_type`。
- `aaa-evals` 讀取 `index.json` 的 `repo_type` 決定是否要求 `skills/` 與 `prompt.schema.json`。
- 新增 `runbooks/init/plan.v0.7.json`。

## Verification
- aaa-tools：
  - `python3 -m unittest tests.test_verify_ci_manifest -v` → OK
- aaa-evals：
  - `python3 -m unittest runner.tests.test_repo_type_governance -v` → OK

## Impact
- required checks 名稱有 SSOT，避免 ruleset 漂移。
- repo_type 成為可持久化治理上下文，降低 heuristic 誤判。
- verify-ci / repo-checks 行為可預期，適用多 repo 類型。

## Files
- `aaa-actions/checks.manifest.json`
- `aaa-tools/aaa/verify_ci.py`
- `aaa-tools/aaa/init_commands.py`
- `aaa-tools/runbooks/init/plan.v0.7.json`
- `aaa-evals/runner/run_repo_checks.py`
- `aaa-evals/runner/tests/test_repo_type_governance.py`

---
