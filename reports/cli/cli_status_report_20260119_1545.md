# AAA CLI Status Report (v0.1)

- Timestamp: 2026-01-19 15:45
- Scope: aaa-tools CLI status and capabilities

## 定位與目的
AAA CLI 是把治理規格文件變成可執行流程的核心工具。提供 deterministic（可重跑、可驗證、可稽核）的一致介面，讓 Codex/人類都能以同一套命令完成 Bootstrap、自動化檢查與治理驗證。

## 核心設計原則
- Script-first, LLM-last
- JSONL stdout（機器可讀事件串流）
- Exit Codes 穩定（可分類錯誤）
- Idempotent（重跑不破壞狀態）
- Dry-run（不修改 repo 仍可完整跑流程）

## 已完成命令

### Plan 驗證
- `aaa init validate-plan --plan <PATH> [--schema <PATH>] [--jsonl]`
- Fail-fast 驗證 `plan.schema.json`
- Exit Code: 10（args/parse）/ 11（schema）/ 0（OK）

### Repo 建立
- `aaa init ensure-repos --org <ORG> --from-plan <PATH> [--dry-run]`
- 已存在 → no-op；不存在 → 建立

### 模板套用
- `aaa init apply-templates --org <ORG> --from-plan <PATH> --aaa-tag <TAG>`
- 套用 `aaa-tpl-*` 到目標 repo，建立 bootstrap branch

### Branch Protection
- `aaa init protect --org <ORG> --from-plan <PATH> [--dry-run]`
- required checks: lint/test/eval

### PR 建立
- `aaa init open-prs --org <ORG> --from-plan <PATH> [--dry-run]`
- 已存在 → no-op；否則建立 PR

### CI 驗證
- `aaa init verify-ci --org <ORG> --from-plan <PATH> [--dry-run]`
- 驗證 lint/test/eval 是否存在並成功

### Repo 治理檢查
- `aaa init repo-checks --org <ORG> --from-plan <PATH> --suite governance`
- 透過 aaa-evals runner 執行治理 evals

## Orchestrator（已完成）
- `aaa init --plan <PATH> [--mode pr|direct] [--dry-run] [--jsonl]`
- 依 plan steps 依序執行：
  - preflight → ensure-repos → apply-templates → sync_assets
  - protect → open-prs → verify-ci → repo-checks

## 最終報告輸出（已完成）
- 每次 `aaa init --plan` 會輸出 `aaa-init-report.json`
- 報告格式符合 `output.schema.json`
- 包含：metadata / inputs / repos / steps / branch_protection / ci / summary

## Dry-run 範例
```bash
WORKSPACE_DIR="/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE" \
  aaa init --plan /tmp/aaa_plan_resolved.json --dry-run --jsonl
```

## 完成狀態
已完成：所有 init 子命令、init --plan orchestrator、JSONL、output.schema.json 報告輸出、dry-run PASS

未做 / 延後：
- continue-on-error（建議 v0.2 以 explicit flag 方式引入）
