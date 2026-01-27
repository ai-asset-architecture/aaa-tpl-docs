# ops/init-milestone + Action Catalog Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 新增 `ops/init-milestone` runbook 與 actions reference 輸出模板，並在 docs 產出 actions-reference.md。

**Architecture:** 在 `aaa-tools` 增加 runbook 與 template，再在 `aaa-tpl-docs` 產出對應的 actions-reference.md（以 registry 為來源）。

**Tech Stack:** YAML + Markdown + minimal Python helper (if needed).

### Task 1: ops/init-milestone runbook

**Files:**
- Create: `aaa-tools/runbooks/ops/init-milestone.yaml`
- Modify: `aaa-tools/runbooks/README.md`

**Step 1: 新增 runbook 定義（輸入 milestone_id/definition_path/approver）**

**Step 2: 更新 runbook index**

### Task 2: actions-reference template

**Files:**
- Create: `aaa-tools/templates/actions-reference.md.tmpl`

**Step 1: 定義模板欄位與渲染規則**

### Task 3: actions-reference docs output

**Files:**
- Create: `aaa-tpl-docs/docs/actions-reference.md`

**Step 1: 產出初版 actions reference（列出 registry entries）**

### Task 4: 更新紀錄

**Files:**
- Modify: `findings.md`
- Modify: `progress.md`

**Step 1: 記錄產出內容與路徑**

