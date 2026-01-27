# Milestones Index + v0.9 Evidence Summary Update Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 補齊 v0.9 gate evidence/one-pager 摘要，並同步更新 milestones 與 reports 的 index.json。

**Architecture:** 先讀取 v0.9 gate evidence 與 one-pager 正文萃取 ZH-TW/EN 摘要，再回填 `reports/milestones/README.md` 對應列；接著更新 `milestones/index.json` 與 `reports/milestones/index.json` 的摘要欄位以保持一致。

**Tech Stack:** Markdown + JSON 純文件更新。

### Task 1: 讀取 v0.9 evidence/one-pager 正文

**Files:**
- Read: `aaa-tpl-docs/reports/milestones/aaa_v0.9_gate_evidence_20260123.md`
- Read: `aaa-tpl-docs/reports/milestones/aaa_v0.9_one_pager_20260123.md`

**Step 1: 讀取 gate evidence 正文**
- 產出 1 句 ZH-TW 摘要 + 1 句 EN 摘要

**Step 2: 讀取 one-pager 正文**
- 產出 1 句 ZH-TW 摘要 + 1 句 EN 摘要

### Task 2: 回填 reports/milestones/README.md 摘要

**Files:**
- Modify: `aaa-tpl-docs/reports/milestones/README.md`

**Step 1: 回填 v0.9 gate evidence Summary (ZH-TW/EN)**

**Step 2: 回填 v0.9 one-pager Summary (ZH-TW/EN)**

### Task 3: 更新 milestones/index.json

**Files:**
- Modify: `aaa-tpl-docs/milestones/index.json`

**Step 1: 確認 v0.8~v1.0 摘要欄位已同步 README**

**Step 2: 更新摘要與 README 對齊**

### Task 4: 更新 reports/milestones/index.json

**Files:**
- Modify: `aaa-tpl-docs/reports/milestones/index.json`

**Step 1: 更新 v0.8~v1.0 completion report 摘要**

**Step 2: 更新 v0.9 gate evidence 與 one-pager 摘要**

### Task 5: 自檢一致性

**Files:**
- Verify: `aaa-tpl-docs/reports/milestones/README.md`
- Verify: `aaa-tpl-docs/milestones/index.json`
- Verify: `aaa-tpl-docs/reports/milestones/index.json`

**Step 1: 確認 JSON 與 README 摘要一致**

**Step 2: 確認語句精簡、清楚、無拼寫錯誤**

