# Repo Checks Central Doc Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 在 `aaa-tpl-docs/docs/` 建立集中頁，說明 `repo-checks`/plan/suite 的用途與位置，並從多入口連結到該頁。

**Architecture:** 新增一份集中指南（概念 + 常用指令 + 參考連結），再在常見入口文件加入短連結段落，避免資訊分散。

**Tech Stack:** Markdown 純文件更新。

### Task 1: 建立集中指南頁

**Files:**
- Create: `aaa-tpl-docs/docs/repo-checks-guide.md`

**Step 1: 撰寫集中指南內容**
- repo-checks 何時使用（post-init）
- plan 概念與來源（aaa-tools/runbooks/init/plan.v0.7.json）
- suite 概念與套件來源（aaa-evals/evals/suites/*.yml）
- 常用指令範例
- 相關文件連結

### Task 2: 加入多入口連結

**Files:**
- Modify: `aaa-tpl-docs/docs/new-project-sop.md`
- Modify: `aaa-tpl-docs/AI_COMMAND_CENTER.md`
- Modify: `aaa-tools/README.md`

**Step 1: 加入連結段落**
- 提供短描述 + 指向集中指南頁

### Task 3: 自檢一致性

**Files:**
- Verify: `aaa-tpl-docs/docs/repo-checks-guide.md`
- Verify: `aaa-tpl-docs/docs/new-project-sop.md`
- Verify: `aaa-tpl-docs/AI_COMMAND_CENTER.md`
- Verify: `aaa-tools/README.md`

**Step 1: 確認連結可讀、語意一致**

