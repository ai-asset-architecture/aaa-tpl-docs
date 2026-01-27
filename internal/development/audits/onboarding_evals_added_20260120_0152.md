# Onboarding Evals & Assets 更新報告 (2026-01-20 01:52)

## 目的
將「member 模擬開案」的紅隊發現沉澱為可驗證的治理檢查與可重用資產。

## 新增 Evals（aaa-evals）
- `member_bootstrap_prereq`: 檢查 SOP 是否包含 `gh auth setup-git`、正確 pip install、雙路徑（人類/Codex）。
- `private_download_sanity`: 檢查 SOP 是否使用 `gh api` 下載 plan/schema 並含 JSON sanity check。
- `start_here_sync`: 檢查 org profile Start Here 與 SOP 內關鍵步驟對齊。

## 新增 Templates（aaa-tpl-docs）
- `templates/onboarding/Member-Start-Checklist.md`
- `templates/onboarding/Bootstrap-Troubleshooting.md`

## 新增 Prompts（aaa-prompts）
- `prompts/onboarding/onboarding_review_v0.1.json`
- `prompts/onboarding/bootstrap_codex_brief_v0.1.json`

## 對應的風險與緩解
- 私有 repo 下載與認證失敗 → `gh auth setup-git` + `gh api` 檢查
- SOP 與 Start Here 不一致 → `start_here_sync` 檢查
- 變數未替換 / JSON 假檔 → sanity checks

## 影響範圍
- 組織成員 onboarding 成功率提升
- 新專案初始化流程更可重跑與可稽核
