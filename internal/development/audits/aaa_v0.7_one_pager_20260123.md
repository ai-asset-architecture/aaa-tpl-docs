---
summary_zh: 'v0.7 一頁式完成摘要。'
summary_en: 'v0.7 one-pager completion summary.'
---

# AAA v0.7 One-Pager Summary (2026-01-23)

## 定位一句話
v0.7 將治理從「啟發式判斷」升級為「明確宣告 + 可驗證」的執行標準。

## 關鍵交付
- `checks.manifest.json` 成為 required checks SSOT，支援 `applies_to` 過濾。
- `repo_type` 固化在 `.aaa/metadata.json`，CI 能穩定判讀 repo 類型。
- `repo-checks` 對齊新治理檢查（repo_type_consistency / checks_manifest_alignment / orphaned_assets）。
- 新增治理 Prompt：repo_type 缺失即 BLOCK，避免 AI 猜測。

## 可驗證證據
- Gate A：verify-ci 依 manifest + repo_type 過濾 required checks（測試 PASS）。
- Gate B：repo_type 一致性檢查 + manifest alignment 檢查（測試 PASS）。

## 業務價值
- **治理穩定**：checks 名稱不再漂移、CI 紅綠燈可信。
- **誤判下降**：docs/fe/service 不再被要求 skills/prompts。
- **審計可追溯**：repo 類型治理可長期稽核。

## 3 個使用場景
1. 新案啟動：快速繼承合規 checks，不再靠人工對齊。
2. CI 防線：repo 類型錯配即被阻擋。
3. 組織稽核：manifest + metadata 成為審計基準。
