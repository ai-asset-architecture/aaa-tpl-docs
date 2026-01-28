# AI Context Configuration
> 本文件為 AI Agent（Codex/Antigravity）在 AAA 工作區的核心行為準則（AI Constitution）。

## 1. Mandatory Knowledge Loading (Pre-flight)
在執行任何計畫或編碼前，**必須**讀取：
- `aaa-tpl-docs/public/bootstrap/WORKSPACE_ARCHITECTURE.md` (基礎架構)
- `aaa-tpl-docs/PROJECT_PLAYBOOK.md` (專案憲法)

## 2. Development Artifact Protocol (Mandatory)
當開發新功能 (Feature) 或 執行稽核 (Audit) 時，必須遵守以下路徑規則：

### 2.1 Implementation Plans (計畫)
- **路徑**: `aaa-tpl-docs/internal/development/plans/`
- **命名**: `YYYY-MM-DD-<feature-name>-plan.md`
- **行為**: 在起草新計畫前，**必須**掃描該目錄以參考既有的計畫模式。

### 2.2 Validation Audits (審計/報告)
- **路徑**: `aaa-tpl-docs/internal/development/audits/`
- **命名**: `YYYY-MM-DD-<milestone-or-audit-name>.md`
- **行為**: 完成核心變更後，**必須**將驗證證據記錄於此。

### 2.3 Triple-Summary Protocol (通訊)
在計畫起草或變更時，必須提供三份獨立摘要用於對齊資訊，每份摘要字數約 **200-300 字**：
1. **Plan Summary**: 核心邏輯、實作路徑與預期產出。
2. **Schema Summary**: 資料結構定義、SSOT 影響與邊界合約。
3. **Component Summary**: 模組化設計、狀態管理與視覺/UX 邏輯。
- **發布**: 計畫提交時，需將此三份摘要提供給使用者進行審查。

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
*Last updated: 2026-01-28*
