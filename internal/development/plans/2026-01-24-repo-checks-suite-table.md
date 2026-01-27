# Repo Checks Suite Table Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 在集中指南加入「常用治理相關 suites」表格，提供一行說明。

**Architecture:** 從 `aaa-evals/evals/suites/*.yml` 讀取常用治理 suites 的定義，萃取一句話摘要，更新 `aaa-tpl-docs/docs/repo-checks-guide.md`，並同步更新 findings/progress。

**Tech Stack:** Markdown 純文件更新。

### Task 1: 盤點常用治理 suites

**Files:**
- Read: `aaa-evals/evals/suites/*.yml`

**Step 1: 選出常用治理 suites**

### Task 2: 更新集中指南表格

**Files:**
- Modify: `aaa-tpl-docs/docs/repo-checks-guide.md`

**Step 1: 加入表格與一行說明**

### Task 3: 更新紀錄

**Files:**
- Modify: `findings.md`
- Modify: `progress.md`

**Step 1: 記錄更新內容**

