# AI Context Configuration
> 本文件為 AI Agent（Codex/Antigravity）在 AAA 工作區的核心行為準則（AI Constitution）。

## 1. Mandatory Knowledge Loading (Pre-flight)
在執行任何計畫或編碼前，**必須**讀取：
- `aaa-tpl-docs/public/bootstrap/WORKSPACE_ARCHITECTURE.md` (基礎架構)
- `aaa-tpl-docs/PROJECT_PLAYBOOK.md` (專案憲法)

## 2. Milestone Lifecycle Workflow (vx.y)
任何版本 (vx.y) 的開發必須遵循以下三個步驟（3-Step Lifecycle）。

> **⚠️ 嚴格執行紀律 (Strict Discipline)**：
> 1.  **禁止有損壓縮 (No Lossy Compression)**：在建立 `task.md` 時，嚴禁將下方列出的任何交付項目「合併」或「簡化」。每一項要求（如「摘要文件」與「詳細報告」）都必須轉換為獨立的 Checkbox。
> 2.  **分段批准 (Step-by-Step Approval)**：每完成一個步驟 (Step 1 / 2 / 3)，**必須暫停 (STOP)**，向指揮官回報該步驟的總結，並等待獲得明確批准後，才可進入下一個步驟。


### Step 1: Initialization (啟動與追蹤)
- **要求**: 在開始開發前或開發中，必須初始化以下兩類文件：
  - **Implementation Plans**: `aaa-tpl-docs/internal/development/plans/YYYY-MM-DD-<feature>-plan.md`
  - **Validation Audits**: `aaa-tpl-docs/internal/development/audits/YYYY-MM-DD-<name>.md`
- **Debt Check (Stop the Line)**:
  - Before starting new features, ensure Core Component coverage > 90%.
  - If < 80%, **STOP** and repay debt first.
- **一致性要求 (Consistency Policy)**:
  - **Naming**: Ensure filenames match the patterns defined above.
  - **Format**: **必須** 使用以下 `<template id="plan">`：
    ```markdown
    <template id="plan">
    # Implementation Plan: {Milestone} {Title}

    ## Goal Description
    {Brief description of what and why}

    ## User Review Required
    > [!IMPORTANT]
    > {Critical decisions, standards, or breaking changes}

    ## Proposed Changes
    ### [{repo-name}]
    #### [NEW/MODIFY] {path/to/file}
    - {Description of change}

    ## Triple-Summary Protocol ({Milestone})
    ### 1. Strategic Plan (戰略計畫摘要)
    ### 2. Schema Evolution (結構演進摘要)
    ### 3. Component Architecture (組件架構摘要)

    ## Verification Plan
    ### Automated Tests
    ### Manual Verification
    </template>
    ```
- **通訊**: 計畫必須包含 **Triple-Summary Protocol**。
  - **Requirement**: Content must be concise and focus on **Architectural Decisions**. Avoid fluff. No strict word count.

### Step 2: Asset Preservation (資產保存)
- **Goal**: 確保每次迭代都累積可復用的價值 (Reusable Value)。
- **Mandatory Value Check (價值檢查)**:
  - 結案前 **必須** 盤點產出的 Evals, Templates, Policy Packs, Tools。
  - **Zero-Asset Trap**: 如果清單為空，**禁止結案**，除非提供明確的 Reasoning (Justification)。
- **Action**: **必須**將其註冊至對應的資產目錄 (Catalog) 或 `ai-asset-architecture-registry/registry_index.json`。
- **Nightly Promotion Criteria**:
  - Promote tests that cover **Critical User Flows** or **Core Logic** (>20% impact).
  - Do **NOT** promote trivial UI tests or flaky tests.
- **產出**: 在結案報告 template 中填寫 `Asset Preservation` 章節。

### Step 3: Completion Documentation (結案存檔)
- **要求**: 當版本項目的完成度達到 100% 時，**必須**產出兩份正式文件：
  - **摘要文件**: `aaa-tpl-docs/milestones/YYYYMMDD_vX.Y_<name>.md`
  - **詳細報告**: `aaa-tpl-docs/internal/development/milestones/completion-reports/aaa_vX.Y_completion_report_YYYYMMDD.md`
- **一致性要求 (Consistency Policy)**:
  - **Naming**: 檔案命名必須嚴格參考目標資料夾內既有文件的命名慣例。
  - **Format**: **必須** 使用以下 `<template id="completion-report">`：
    ```markdown
    <template id="completion-report">
    # Milestone Completion Report: {Milestone} {Title}

    ## Metadata
    *   **Milestone**: {vX.Y}
    *   **Release Name**: {Name}
    *   **Status**: COMPLETED
    *   **Date**: {YYYY-MM-DD}
    *   **Hash**: {Commit Hash}

    ## 1. Executive Summary
    {High-level achievement summary}

    ## 2. Deliverables Status
    ### A. {Component Area}
    | Component | Function | Status | Coverage |
    | :--- | :--- | :--- | :--- |
    | `{path}` | {desc} | ✅ Done | {N}% |

    ## 3. Verification Evidence
    *   **Snapshot Tests**: ...
    *   **Unit Tests**: ...
    *   **Manual Verification**: ...

    ## 4. Asset Preservation (Nightly Candidates)
    1.  `{test_path}` ({reason})

    ## 5. Next Steps
    *   **{Next Version}**: ...
    *   **Backlog**: ...
    </template>
    ```

## 3. Agent Behavior Profile

### Mode: ARCHITECT (Planning Phase)
- **Primary Goal**: Cross-repo consistency & long-term stability.
- **Mandatory Action**: Draft implementation plans to `internal/development/plans/` first.
- **Constraint**: No implementation until plan approval.

### Mode: BUILDER (Implementation Phase)
- **Primary Goal**: Solid implementation & automated verification.
- **Mandatory Action**: Record proof-of-work/audit evidence to `internal/development/audits/`.
- **Constraint**: Follow 1+2+1 Test Coverage Rule.

## 4. Single Source of Truth (SSOT)
- **Registry**: `ai-asset-architecture-registry/registry_index.json`
- **Assets**: All metadata must be indexed in `internal/index.json`.

---
*Last updated: 2026-01-28 13:05*
