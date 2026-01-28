# AAA 資產回饋流程（草案）

這份文件說明：成員在新專案中產生的 Evals / Templates / Prompts，如何回饋到 AAA。
本流程與 `../internal/development/architecture/aaa-architecture.md` 保持一致，後續可再擴充細節。

## 1) 先判斷資產類型與落點
- Evals → `aaa-evals`
- Templates → `aaa-tpl-docs`
- Prompts → `aaa-prompts`

## 2) 在專案端完成最小可用版本
- 可重複使用、可驗證（避免一次做太大）
- 附上最小說明：用途、輸入/輸出、適用範圍

## 3) 回到 AAA 開 PR
- 在對應 repo 開 branch/PR
- 同步更新 README / baselines / schema / 範例清單（依 repo 規範）
- 如新增治理規則，更新 `../internal/development/architecture/aaa-architecture.md`

## 4) 走資產升級流程（Promotion）
- 依 `aaa-evals/ASSET_PROMOTION.md` 的流程審核與標記
- 需要時打 tag / release

## 5) 產出記錄
- 在 `aaa-tpl-docs/reports/` 留存簡短報告（新增哪些資產、影響範圍）

---

> 注意：不要直接在新專案內改 AAA。請透過 PR 回饋到 AAA 對應 repo。
