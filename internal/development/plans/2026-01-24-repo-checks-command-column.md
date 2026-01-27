# Repo Checks Command Column Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 在 repo-checks 指南表格新增「對應命令範例」欄位，方便直接執行。

**Architecture:** 依 `run_repo_checks.py` 的 check id 產生命令範例，更新 `aaa-tpl-docs/docs/repo-checks-guide.md` 表格，並同步更新 findings/progress。

**Tech Stack:** Markdown 純文件更新。

### Task 1: 更新表格

**Files:**
- Modify: `aaa-tpl-docs/docs/repo-checks-guide.md`

**Step 1: 新增命令範例欄位**

### Task 2: 更新紀錄

**Files:**
- Modify: `findings.md`
- Modify: `progress.md`

**Step 1: 記錄更新內容**

