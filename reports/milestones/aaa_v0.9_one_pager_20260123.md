---
summary_zh: '對外成果：合規率儀表板 MVP、治理信任鏈閉環，並發布 v0.9.1。'
summary_en: 'External summary: compliance dashboard MVP, governance trust chain closure, and v0.9.1 release.'
---

# AAA v0.9 One-Pager (2026-01-23)

## 核心成果（對外版）
- **合規率儀表板 MVP 上線**：Nightly governance 產生 JSON 快照，並同步輸出 Markdown 稽核底稿與 GitHub Pages 靜態看板。
- **治理信任鏈閉環**：合規率採 repo-based，archived 自動排除；threshold gate 直接影響 nightly 成敗，避免「只看報表不落地」。
- **工程落地證據完整**：Nightly 成功產出 `reports/audits/` 與 `docs/dashboard/index.html`，並附 Gate evidence + completion report。

## 對外價值（一句話）
AAA v0.9 將「治理檢查」轉為「可視化 KPI + 可稽核證據」，使治理從工程流程升級為管理指標。

## Release 對齊
- `aaa-tools`, `aaa-actions`, `aaa-evals`, `aaa-tpl-docs` 已發布 `v0.9.1`。
