---
summary_zh: 'v0.9 觀測升級：新增漂移率與 repo 健康度指標，nightly 加入門檻與 post-mortem 發佈。'
summary_en: 'v0.9 observability upgrade: added drift/repo health metrics and post-mortem publishing in nightly.'
---

# AAA v0.9 Observability Upgrade Report (2026-01-24)

## Summary
強化 v0.9 觀測能力：在 dashboard 增加 drift rate 與 repo health 指標，產出 `metrics.json` 時序資料；nightly workflow 加入 drift/health 門檻，並確保即使超標失敗也會發布最新 dashboard（post-mortem 可視性）。

## Key Deliverables
- `aaa-tools`：dashboard 指標計算與 `metrics.json` 輸出
- `aaa-tools`：dashboard HTML/MD/JS/CSS 擴充（新增 KPI + 趨勢）
- `aaa-actions`：nightly governance 加入 drift/health threshold + always publish

## Evidence
- `aaa-tools/aaa/ops/render_dashboard.py`
- `aaa-tools/aaa/templates/dashboard.html.tmpl`
- `aaa-tools/aaa/templates/dashboard.js.tmpl`
- `aaa-actions/.github/workflows/nightly-governance.yaml`
- `docs/plans/2026-01-24-v1.0-remediation-plan.md`

## Notes
- CLI threshold 失敗時仍會完成輸出，避免紅燈日報被舊數據覆蓋。
- `metrics.json` 與原 `trends.json` 同樣保留 90 日滾動視窗。
