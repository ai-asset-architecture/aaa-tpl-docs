# AAA v0.6 Readiness Gate Review (2026-01-22 23:10)

## Scope
本報告將 ChatGPT 的 GitHub 巡檢意見轉為「可驗證 Gate」，並對齊 v0.6 實作（agent_safety / orphaned_assets / CLI JSON）。

## Key Findings (From GitHub Review)
- 組織首頁與各 repo README 的安裝指引可能不一致，需明確 SSOT。
- required checks 若名稱漂移會導致 PR 死鎖或檢查空洞化。
- 模板 repo 必須確實引用 `aaa-actions` 的 workflow。

## v0.6 Alignment (Current State)
- 新增 `agent_safety` suite（預期阻擋視為 PASS）。
- 新增 `orphaned_assets` 治理檢查。
- `aaa run runbook` 支援 `--json` 與 `--runbook-file`。
- `fs_write` 防止 path traversal（回報 `PATH_TRAVERSAL`）。

## Readiness Gates (v0.6)

### Gate A: Init Pipeline 可完整跑通
- 需能執行：validate-plan → ensure-repos → apply-templates → protect → open-prs → verify-ci → repo-checks
- 產出：PR 與檢查記錄（CI 可見）

### Gate B: 治理落地且可稽核
- `orphaned_assets` 必須 PASS（避免暗資料）
- `agent_safety` 必須 PASS（預期阻擋驗證安全機制，回報 `PATH_TRAVERSAL` 或 `SCOPE_VIOLATION`）

### Gate C: Workflow SSOT 與模板繼承
- 模板 repo 的 PR 必須觸發 `aaa-actions` workflow
- required checks 名稱需與 ruleset 完全一致

### Gate D: CLI JSON 最小合約（v0.6）
- `aaa run runbook --json` 輸出必須可解析為 JSON
- 必須包含 `status` 與 `error_code`（安全阻擋時）

## Suggested Verification Steps
1) 用 dummy repo 做演練（如 `aaa-sandbox-YYYYMMDD`）。
2) 跑 `agent_safety` / `orphaned_assets` 檢查並輸出報告。
3) 確認 `agent_safety` 回報阻擋（`PATH_TRAVERSAL` / `SCOPE_VIOLATION`）且 suite 為 PASS。
4) 確認 `--json` 輸出可解析並含 `status`/`error_code`。
5) 確認 PR checks 存在且名稱正確，避免 required checks 空洞化。

## Notes
- 若組織首頁與 `aaa-tools` README 仍有版本落差，請先統一為 v0.2.x + v0.6 gate。
- 本版 v0.6 Gate 不引入 manifest/schema 強制驗證；該類強化留待 v0.7。
- 建議將本 Gate 規範視為「完成」的最低門檻，避免僅以文件宣告結案。
