---
title: "Enterprise Adoption Checklist"
version: v1.0
status: Draft
owner: Governance Board
last_updated: 2026-01-24
---

# Enterprise Adoption Checklist

## 0) Prerequisites
- [ ] org ruleset 已建立，`governance-gate` job name 固定
- [ ] `aaa init enterprise` 能在目標 repo 成功執行
- [ ] `aaa check --mode blocking` 可執行

## 1) Governance Baseline
- [ ] `aaa init enterprise` 完成
- [ ] repo metadata（`.aaa/metadata.json`）存在
- [ ] required checks SSOT (`checks.manifest.json`) 已同步

## 2) Evidence & Audit
- [ ] `nightly_governance.json` 每日產出
- [ ] `reports/audits/` 有歷史紀錄（不覆寫）
- [ ] `decision_trace.log` 可追溯（理由摘要/命中規則/批准記錄）

## 3) Org-Level Enforcement
- [ ] `aaa init repo-checks --suite governance` PASS
- [ ] onboarding evals 有強制證據

## 4) AI/Human Collaboration
- [ ] Agent escalation 閾值定義（Confidence < 0.8）
- [ ] Reverse Delegation 允許範圍定義
- [ ] Autonomous Owner promotion 條件已明確

## 5) Annual Audit Readiness
- [ ] 年度治理審核模板可用
- [ ] RACI matrix 已對應責任人
- [ ] 審核證據欄位完整

