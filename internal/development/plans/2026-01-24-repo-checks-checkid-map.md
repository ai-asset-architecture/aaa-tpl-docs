# Repo Checks Check-ID Map Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 在 repo-checks 集中頁加入「suite ↔ check id」對照欄位，覆蓋所有列出的 suites。

**Architecture:** 讀取 `aaa-evals/evals/suites/*.yml` 與 `aaa-evals/runner/run_repo_checks.py`，萃取 suite 對應的 check id，更新 `aaa-tpl-docs/docs/repo-checks-guide.md` 表格與範例說明，並同步更新 findings/progress。

**Tech Stack:** Markdown 純文件更新。

### Task 1: 盤點 suite ↔ check id

**Files:**
- Read: `aaa-evals/evals/suites/*.yml`
- Read: `aaa-evals/runner/run_repo_checks.py`

**Step 1: 建立 suite/check id 對照**

### Task 2: 更新集中指南表格

**Files:**
- Modify: `aaa-tpl-docs/docs/repo-checks-guide.md`

**Step 1: 增加 check id 欄位與內容**

### Task 3: 更新紀錄

**Files:**
- Modify: `findings.md`
- Modify: `progress.md`

**Step 1: 記錄更新內容**

