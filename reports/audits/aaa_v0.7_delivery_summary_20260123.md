---
summary_zh: 'v0.7 對外交付摘要。'
summary_en: 'v0.7 external delivery summary.'
---

# AAA v0.7 External Delivery Summary (2026-01-23)

## 交付範圍 (Scope)
- SSOT required checks（`checks.manifest.json`）與 repo_type 治理落地。
- verify-ci / repo-checks 行為一致化，降低 repo 類型誤判。
- v0.7 計畫與合約文件完成更新。

## 核心價值 (Value)
- **治理穩定**：required checks 名稱單一真相，避免 ruleset 漂移。
- **可追溯**：repo_type 寫入 `.aaa/metadata.json`，治理規則可長期稽核。
- **低誤判**：非 agent repo 不再被要求 skills/prompt。

## Release Links
- aaa-tools v0.7.1: https://github.com/ai-asset-architecture/aaa-tools/releases/tag/v0.7.1
- aaa-actions v0.7.1: https://github.com/ai-asset-architecture/aaa-actions/releases/tag/v0.7.1
- aaa-evals v0.7.1: https://github.com/ai-asset-architecture/aaa-evals/releases/tag/v0.7.1
- aaa-tpl-docs v0.7.1: https://github.com/ai-asset-architecture/aaa-tpl-docs/releases/tag/v0.7.1

## Evidence
- Completion report: `reports/milestones/aaa_v0.7_completion_report_20260123_0915.md`
- Gate evidence: `reports/milestones/aaa_v0.7_gate_evidence_20260123.md`
