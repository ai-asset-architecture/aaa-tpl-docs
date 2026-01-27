# Frontmatter + Reindex Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 補齊 v0.8~v1.0 里程碑與 v0.8~v1.0/ v0.9 evidence/one-pager 報告的 summary frontmatter，並重新生成 `milestones/index.json` 與 `reports/milestones/index.json`。

**Architecture:** 先把缺失的 `summary_zh/summary_en` frontmatter 加回到對應 Markdown，接著用 `aaa governance update-index` 生成 index.json（使用含 range tags 的模板或既有 README 模板）。

**Tech Stack:** Markdown + JSON 純文件更新（`python3 -m aaa.cli governance update-index`）。

### Task 1: 補齊 milestones frontmatter

**Files:**
- Modify: `aaa-tpl-docs/milestones/20260124_v0.8_architecture_definition.md`
- Modify: `aaa-tpl-docs/milestones/20260124_v0.9_architecture_definition.md`
- Modify: `aaa-tpl-docs/milestones/20260124_v1.0_architecture_definition.md`

**Step 1: 新增 summary_zh/summary_en frontmatter**

### Task 2: 補齊 reports frontmatter

**Files:**
- Modify: `aaa-tpl-docs/reports/milestones/aaa_v0.8_completion_report_20260124.md`
- Modify: `aaa-tpl-docs/reports/milestones/aaa_v0.9_completion_report_20260123.md`
- Modify: `aaa-tpl-docs/reports/milestones/aaa_v1.0_completion_report_20260124.md`
- Modify: `aaa-tpl-docs/reports/milestones/aaa_v0.9_gate_evidence_20260123.md`
- Modify: `aaa-tpl-docs/reports/milestones/aaa_v0.9_one_pager_20260123.md`

**Step 1: 新增 summary_zh/summary_en frontmatter**

### Task 3: 重新生成 milestones/index.json

**Files:**
- Modify: `aaa-tpl-docs/milestones/index.json`

**Step 1: 使用 `python3 -m aaa.cli governance update-index` 更新索引**

### Task 4: 重新生成 reports/milestones/index.json

**Files:**
- Modify: `aaa-tpl-docs/reports/milestones/index.json`

**Step 1: 使用 `python3 -m aaa.cli governance update-index` 更新索引**

### Task 5: 自檢一致性

**Files:**
- Verify: `aaa-tpl-docs/milestones/index.json`
- Verify: `aaa-tpl-docs/reports/milestones/index.json`

**Step 1: 確認 summary 與 README 一致**

**Step 2: 確認生成時間/雜湊已更新**

