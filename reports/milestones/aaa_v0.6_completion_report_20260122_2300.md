# AAA v0.6 Completion Report (2026-01-22 23:00)

## Scope
完成 v0.6 Agent Safety 基線：Action Registry 安全錯誤碼、Runbook CLI JSON/檔案執行、Path Traversal 防護、攻擊型 Evals 套件與 CI 接入。

## Changes
- `aaa run runbook` 支援 `--json` 與 `--runbook-file`，輸出結構化結果與錯誤碼。
- Action Registry 回傳標準錯誤碼（`SCOPE_VIOLATION`）。
- `fs_write` 增加 repo root 路徑防護，違規回報 `PATH_TRAVERSAL`。
- 新增 agent_safety suite/cases 與攻擊型 runbooks。
- `aaa-actions` eval workflow 新增 `agent_safety` 及 `orphaned_assets` step。
- `repo-checks` 支援非 agent repo 跳過 `skills` / `prompt` 檢查。

## Verification
- 單元測試（aaa-tools）：
  - `python3 -m unittest tests.test_runbook_actions_fs tests.test_runbook_cli_exec -v` → OK
- Repo 檢查（aaa-evals）：
  - `AAA_TOOLS_ROOT=/private/tmp/aaa-tools-v0.6-agent-safety python3 runner/run_repo_checks.py --check agent_safety --repo /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE` → PASS
- Gate A 演練（dummy repo）：
  - `ai-asset-architecture-docs#1` PR 建立完成
  - Checks: `ci/lint`, `ci/test`, `ci/eval` → PASS
- Gate B1（orphaned_assets）：
  - `python3 runner/run_repo_checks.py --check orphaned_assets --repo /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE` → PASS
- Gate B1 回填（索引修復）：
  - `ops/reindex-all-assets@1.0.0` runbook 執行 → OK
- Gate B1（repo-checks governance）：
  - `AAA_EVALS_ROOT=... WORKSPACE_DIR=/tmp/aaa-gateB-repos aaa init repo-checks --from-plan /tmp/aaa_plan_v0.1_ref_v0.2.0.filled.json --org ai-asset-architecture --suite governance` → PASS（skills/prompt skipped for non-agent repos）
- Evals 單元測試：
  - `python3 -m unittest runner.tests.test_check_agent_safety -v` → OK
- Workflow YAML：
  - `ruby -e "require 'yaml'; YAML.load_file('aaa-actions/.worktrees/v0.6-agent-safety/.github/workflows/eval.yml')"` → OK

## Impact
- 安全測試可透過 CI 重複執行，驗證 scope 與 path traversal 防護。
- CLI 以 JSON 回傳結果，利於 agent 與 evals 自動判斷。
- 形成可擴展的安全紅隊測試基線。

## Files
- `aaa-tools/aaa/action_registry.py`
- `aaa-tools/aaa/cli.py`
- `aaa-tools/aaa/runbook_registry.py`
- `aaa-tools/aaa/runbook_runtime.py`
- `aaa-tools/tests/test_runbook_actions_fs.py`
- `aaa-tools/tests/test_runbook_cli_exec.py`
- `aaa-evals/evals/cases/agent_safety.jsonl`
- `aaa-evals/evals/fixtures/runbooks/security/attack-scope-violation.yaml`
- `aaa-evals/evals/fixtures/runbooks/security/attack-path-traversal.yaml`
- `aaa-evals/evals/suites/agent_safety.yml`
- `aaa-evals/runner/checks/check_agent_safety.py`
- `aaa-evals/runner/run_repo_checks.py`
- `aaa-evals/runner/tests/test_check_repo_type_heuristics.py`
- `aaa-evals/runner/tests/test_check_agent_safety.py`
- `aaa-actions/.github/workflows/eval.yml`

---

## Appendix: Release Notes

### aaa-tools
- `feat: add json output and error codes to runbook cli`
- `feat: support runbook-file execution in cli`
- `feat: block path traversal in fs_write`

### aaa-evals
- `test: add security attack runbooks`
- `test: add agent safety eval suite`
- `feat: add agent safety check with expected failure logic`
- `fix: resolve agent safety case discovery and path handling`
- `fix: skip skills/prompt checks for non-agent repos`

### aaa-actions
- `ci: add agent safety evals`
