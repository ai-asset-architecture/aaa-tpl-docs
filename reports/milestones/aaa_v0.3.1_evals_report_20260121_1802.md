# AAA v0.3.1 Evals Update Report (2026-01-21 18:02)

## Scope
補齊 onboarding 必要 Evals：指令一致性與 plan/schema ref 同步檢查，並納入 suites/cases/baselines 與 README。

## Changes
- 新增 `onboarding_command_integrity`：檢查 Profile README 與 SOP 的安裝指令與 plan ref 一致性。
- 新增 `plan_schema_ref_sync`：檢查 SOP 內 plan/schema 的 tag 是否一致。
- 補齊對應 suites / cases / baselines。
- README 範例指令新增兩個檢查。

## Verification
- `python3 -m unittest runner.tests.test_onboarding_command_integrity -v` → OK
- `python3 -m unittest runner.tests.test_plan_schema_ref_sync -v` → OK
- `python3 runner/run_repo_checks.py --check onboarding_command_integrity --repo <workspace>` → PASS
- `python3 runner/run_repo_checks.py --check plan_schema_ref_sync --repo <workspace>` → PASS

## Impact
- onboarding 文件與指令漂移風險降低，可在治理流程中 fail-fast。
- eval pipeline 擁有可重用 suites/cases/baselines，便於報告化與版本化。

## Files
- `aaa-evals/runner/run_repo_checks.py`
- `aaa-evals/runner/tests/test_onboarding_command_integrity.py`
- `aaa-evals/runner/tests/test_plan_schema_ref_sync.py`
- `aaa-evals/evals/cases/onboarding_command_integrity.jsonl`
- `aaa-evals/evals/cases/plan_schema_ref_sync.jsonl`
- `aaa-evals/evals/suites/onboarding_command_integrity.yml`
- `aaa-evals/evals/suites/plan_schema_ref_sync.yml`
- `aaa-evals/evals/baselines/onboarding_command_integrity.baseline.json`
- `aaa-evals/evals/baselines/plan_schema_ref_sync.baseline.json`
- `aaa-evals/README.md`

---

## Appendix: Release Notes
- `test(evals): add onboarding command/plan-schema tests` (b73a96b)
- `feat(evals): add onboarding command and plan/schema checks` (54abb92)
- `feat(evals): add onboarding integrity suites` (754a412)
- `docs(evals): document onboarding integrity checks` (9fb7021)
