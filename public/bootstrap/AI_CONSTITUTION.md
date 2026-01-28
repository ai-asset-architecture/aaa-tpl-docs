# AI Context Configuration
> 本文件為 AI Agent（Codex/Antigravity）在 AAA 工作區的核心行為準則（AI Constitution）。

## 1. Mandatory Knowledge Loading (Pre-flight)
在執行任何計畫或編碼前，**必須**讀取：
- `aaa-tpl-docs/public/bootstrap/WORKSPACE_ARCHITECTURE.md` (基礎架構)
- `aaa-tpl-docs/PROJECT_PLAYBOOK.md` (專案憲法)

## 2. Milestone Lifecycle Workflow (vx.y)
任何版本 (vx.y) 的開發必須遵循以下三個步驟（3-Step Lifecycle）：

### Step 1: Initialization (啟動與追蹤)
- **要求**: 在開始開發前或開發中，必須初始化以下兩類文件：
  - **Implementation Plans**: `aaa-tpl-docs/internal/development/plans/YYYY-MM-DD-<feature>-plan.md`
  - **Validation Audits**: `aaa-tpl-docs/internal/development/audits/YYYY-MM-DD-<name>.md`
- **通訊**: 計畫必須包含 **Triple-Summary Protocol**（Plan/Schema/Component 摘要，每份 200-300 字）。

### Step 2: Completion Documentation (結案存檔)
- **要求**: 當版本項目的完成度達到 100% 時，**必須**產出兩份正式文件：
  - **摘要文件**: `aaa-tpl-docs/milestones/YYYYMMDD_vX.Y_<name>.md`
  - **詳細報告**: `aaa-tpl-docs/internal/development/milestones/completion-reports/aaa_vX.Y_completion_report_YYYYMMDD.md`
- **內容**: 應包含交付物清單、驗證證據、1+2+1 覆蓋率分析與最終狀態。

### Step 3: Asset Preservation (資產保存)
- **要求**: 提取並註冊該版本開發中產生的價值資產（Evals, Templates, Prompts, Runbooks, Checks...）。
- **行為**: **必須**將其註冊至對應的資產目錄 (Catalog) 或 `ai-asset-architecture-registry/registry_index.json`。
- **產出**: 在結案報告中列出「資產保存清單」。

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
