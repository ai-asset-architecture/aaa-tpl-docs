---
summary_zh: 'v0.4 雙層合約與 post-init audit 完成。'
summary_en: 'v0.4 dual contract and post-init audit completion.'
---

# AAA v0.4 Completion Report (2026-01-21 21:28)

## Scope
完成 v0.4 治理核心與 CLI 合約雙層對齊，建立 post-init audit 的閉環治理與一致性檢查與 runbook。

## Changes
- 新增使用者版 CLI 合約文件，定義 SOP 與 post-init 稽核步驟。
- 更新新專案 SOP，加入合約引用與 post-init repo-checks。
- 強化技術版 CLI 合約：CI 必須無狀態、`aaa init --plan` 必須包含 post-init audit。
- 新增 `cli_contract_sync` eval（含 tests/suites/cases/baselines）。
- `aaa-evals/README.md` 補上 `cli_contract_sync` 描述與指令。
- 新增 post-init audit runbook（`POST_INIT_AUDIT.md`）與 runbooks README 連結。
- SOP 與使用者合約補上 post-init runbook 連結。
- 新增 `post_init_audit_required` eval（含 tests/suites/cases/baselines）。
- `aaa-evals/README.md` 補上 `post_init_audit_required` 描述與指令。

## Verification
- 單元測試：
  - `python3 -m unittest runner.tests.test_cli_contract_sync -v` → OK
  - `python3 -m unittest runner.tests.test_post_init_audit_required -v` → OK
- Repo 檢查：
  - `python3 runner/run_repo_checks.py --check cli_contract_sync --repo /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE` → PASS
  - `python3 runner/run_repo_checks.py --check post_init_audit_required --repo /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE` → PASS

## Impact
- SOP 與 CLI contract 對齊可被自動驗證，避免文件與實作漂移。
- 初始化流程完成後強制 post-init audit，治理閉環可稽核。

## Files
- `aaa-tpl-docs/docs/contracts/aaa-cli-contract.md`
- `aaa-tpl-docs/docs/new-project-sop.md`
- `aaa-tools/specs/CLI_CONTRACT.md`
- `aaa-tools/runbooks/init/POST_INIT_AUDIT.md`
- `aaa-evals/runner/run_repo_checks.py`
- `aaa-evals/runner/tests/test_cli_contract_sync.py`
- `aaa-evals/runner/tests/test_post_init_audit_required.py`
- `aaa-evals/evals/cases/cli_contract_sync.jsonl`
- `aaa-evals/evals/suites/cli_contract_sync.yml`
- `aaa-evals/evals/baselines/cli_contract_sync.baseline.json`
- `aaa-evals/evals/cases/post_init_audit_required.jsonl`
- `aaa-evals/evals/suites/post_init_audit_required.yml`
- `aaa-evals/evals/baselines/post_init_audit_required.baseline.json`
- `aaa-evals/README.md`

---

## Appendix: Release Notes

### aaa-tpl-docs
- `docs(contract): add user-facing CLI contract` (77b9acf)
- `docs(sop): link post-init audit runbook` (fdb3f49)

### aaa-tools
- `docs(cli): add post-init audit and stateless CI contract` (eb1cb0b)
- `docs(runbook): add post-init audit` (259b285)

### aaa-evals
- `feat(evals): add cli contract sync check` (0732ced)
- `docs(evals): document cli contract sync` (a82bd44)
- `feat(evals): add post-init audit required check` (608a582)
- `docs(evals): document post-init audit required` (88fa96d)
