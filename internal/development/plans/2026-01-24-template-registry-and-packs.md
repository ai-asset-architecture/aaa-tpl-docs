# Template Registry + Packs Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** 在 `ai-asset-architecture-registry` 增加 Template Registry，並新增至少 2 個 packs（基礎治理/行業特化）。

**Architecture:** 在 registry repo 中新增 `template_registry.json` 與說明文件；新增兩個 pack 目錄與 registry 索引條目，保持 registry_index.json 一致。

**Tech Stack:** JSON + Markdown 純文件更新。

### Task 1: Template Registry 基線

**Files:**
- Create: `ai-asset-architecture-registry/template_registry.json`
- Create: `aaa-tpl-docs/docs/registry/template_registry.md`
- Modify: `ai-asset-architecture-registry/README.md`

**Step 1: 定義 template_registry.json 結構**

**Step 2: 撰寫 registry 說明文件**

### Task 2: 新增 2 個 packs

**Files:**
- Create: `ai-asset-architecture-registry/packs/base-governance/README.md`
- Create: `ai-asset-architecture-registry/packs/industry-saas/README.md`
- Modify: `ai-asset-architecture-registry/registry_index.json`

**Step 1: 建立 pack 目錄與描述**

**Step 2: 更新 registry_index.json packs 條目**

### Task 3: 更新 docs 索引

**Files:**
- Modify: `aaa-tpl-docs/docs/registry/README.md` (if exists)

**Step 1: 加入 template registry 連結**

### Task 4: 更新紀錄

**Files:**
- Modify: `findings.md`
- Modify: `progress.md`

**Step 1: 記錄產出內容與路徑**

