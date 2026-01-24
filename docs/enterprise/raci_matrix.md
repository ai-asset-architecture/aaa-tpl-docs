---
title: "Enterprise RACI Matrix: AI-Native Governance"
version: v1.0
status: Draft
owner: Governance Board
last_updated: 2026-01-24
---

# Enterprise RACI Matrix: AI-Native Governance

## Roles
- **HO**: Human Owner
- **AO**: Autonomous Owner (Agent, promotion-gated)
- **AG**: AI Agent (Builder/Guardian)
- **GA**: Governance Auditor
- **OA**: Org Admin

## Dynamic Entitlement Rules
- **AO** 需通過 Promotion 門檻（連續 N 週 Gate 全綠、0 次 P0/P1、audit pass、變更類型受限）。
- **AO** 權限僅限已授權範圍，不覆蓋高風險/政策外操作。

## RACI Table
| Activity | HO | AO | AG | GA | OA |
| --- | --- | --- | --- | --- | --- |
| 定義治理門檻 (Ruleset/Checks) | A | C | I | R | C |
| `aaa init enterprise` 導入 | A | I | R | C | C |
| Gate 阻擋與修復建議 | I | I | R | C | C |
| Bypass 例外審批 | A | I | C | I | R |
| 重大風險變更（高風險操作） | A | I | C | C | R |
| Policy Packs 套用 | A | C | R | C | C |
| 年度治理稽核 | I | I | C | R | A |
| 內部報告與證據歸檔 | A | I | R | C | C |
| Reverse Delegation 任務指派 | C | R | R | I | I |

## Notes
- AO 僅在 promotion 範圍內擔任 Owner，超出範圍必須回到 HO 決策。
- Reverse Delegation 僅限非生產權限或需人類介入的工作。

