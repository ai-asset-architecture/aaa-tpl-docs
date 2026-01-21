# AAA v0.3 Completion Report (2026-01-21 17:37)

## Scope
完成 v0.3 的 onboarding 文件一致性治理、版本對齊與 CI 穩定性補強。

## Changes
- 新增 `onboarding_doc_drift` 檢查（跨 `.github` 與 `aaa-tpl-docs` 文件版本一致性）。
- SOP 對齊 `v0.2.0` 安裝與 plan/schema 下載 ref。
- Playbook 標題改為「Maximal Set」避免固定 repo 數量誤解。
- Onboarding prompt schema 強制 `runbook_path` 必填。
- 新增 onboarding review prompts（drift review / SOP integrity）。
- 新增 onboarding templates（SOP 模板 / Start Here 區塊模板）。
- `aaa-actions` eval workflow 加入 `actions/setup-python@v5` 並改用 `python3 -m pip`。

## Verification
- 單元測試：
  - `python3 -m unittest runner.tests.test_onboarding_doc_drift -v` → OK
- Drift check：
  - `python3 runner/run_repo_checks.py --check onboarding_doc_drift --repo <workspace>` → PASS

## Impact
- 新成員 onboarding 指令與版本一致性可自動檢測，降低漂移風險。
- 治理檢查可擴充，形成 v0.3 的 docs/流程一致性基線。
- CI 可靠性提升，避免 eval 依賴未配置 Python 的失敗。

## Follow-ups
- v0.4：對 SOP 與 CLI contract 進一步一致性驗證。
- v0.5：核心技能測試從 smoke 擴展到功能級驗證。
- v1.0：完整 onboarding 自動化與治理門檻上 CI。

## Files
- `aaa-evals/runner/run_repo_checks.py`
- `aaa-evals/runner/tests/test_onboarding_doc_drift.py`
- `aaa-evals/README.md`
- `aaa-tpl-docs/docs/new-project-sop.md`
- `aaa-tpl-docs/PROJECT_PLAYBOOK.md`
- `aaa-prompts/prompts/onboarding/bootstrap_codex_brief_v0.1.json`
- `aaa-prompts/prompts/onboarding/onboarding_drift_review_v0.1.json`
- `aaa-prompts/prompts/onboarding/sop_integrity_check_v0.1.json`
- `aaa-actions/.github/workflows/eval.yml`
- `aaa-tpl-docs/templates/onboarding/Member-Start-SOP-Template.md`
- `aaa-tpl-docs/templates/onboarding/Start-Here-Block-Template.md`

---

## Appendix: Release Notes

### aaa-evals
- `feat(evals): add onboarding doc drift check` (cce0859)
- `docs(evals): document onboarding doc drift check` (5c223bb)

### aaa-tpl-docs
- `docs(sop): align v0.2.0 onboarding refs` (d4cad20)
- `docs(playbook): label repo map as maximal set` (ffa6f21)

### aaa-prompts
- `fix(prompts): require runbook_path in onboarding schema` (00dba96)
- `feat(prompts): add onboarding review prompts` (ef345da)

### aaa-actions
- `chore(ci): setup python for eval workflow` (6ee3a63)

### aaa-tpl-docs
- `docs(templates): add onboarding SOP and Start Here templates` (9f184fa)
