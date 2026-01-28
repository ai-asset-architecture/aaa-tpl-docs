# AAA Test Coverage Policy

**Version**: v1.0  
**Status**: Formalized  
**Category**: Internal Governance  
**Date**: 2026-01-28

---

## 1. 政策目標 (Policy Objective)

本政策旨在規範 AAA 專案所有組件的驗證標準，確保「法治」治理體系的嚴謹性。我們區分兩種驗證模式，以平衡「核心邏輯的絕對安全性」與「觀察性功能的開發效率」。

---

## 2. 核心規範：1+2+1 規則 (Strict Baseline)

所有涉及 **核心治理邏輯 (Core Governance Logic)** 的變更必須嚴格遵守 **1+2+1 規則**：
- **1 個技術實施計畫 (Implementation Plan)**：包含明確的 TDD 步驟。
- **2 個驗證證據 (Artifacts)**：
  - **單元測試 (Unit Tests)**：必須包含 TDD 失敗與成功的運行紀錄。
  - **集成/CLI 驗證 (Integration/CLI Validation)**：真實命令行的輸入輸出紀錄。
- **1 個標準工作流 (Workflow/Walkthrough)**：記錄從開發到驗證的完整鏈條。

**適用範圍**：
- `aaa-tools` 核心 CLI 命令（init, check, run, sync）。
- `aaa-evals` 核心評估腳本。
- 涉及路徑安全、權限校驗或資產索引更新的邏輯。

---

## 3. 彈性規範：證據驗證策略 (Evidence-Based Validation)

對於 **非阻塞性功能 (Non-blocking Features)** 或 **視覺化指標 (Visual Metrics)**，可採用證據驗證策略：
- **要求**：不強制要求結構化單元測試，但必須提供 **確鑿的截圖、錄影或 JSON 輸出證據**。
- **原則**：雖然減少了測試代碼，但證據的質量必須足以證明功能在邊界條件下的穩健性。

**適用範圍**：
- 治理儀表板 (Dashboard) 的視覺化呈現。
- 自動化報告的排版優化。
- 非核心資產的輔助性 Catalog 建立。

---

## 4. 決策矩陣 (Decision Matrix)

| 特徵類型 | 驗證模式 | 強制指標 |
|----------|----------|----------|
| **Core CLI/Logic** | 1+2+1 Strict | Unit Test Pass Rate = 100% |
| **Security/Path** | 1+2+1 Strict | Edge Case Tests Required |
| **Dashboard/UI** | Evidence-Based | Screenshot + Metadata Check |
| **Docs/Catalogs** | Evidence-Based | Link Integrity Check |

---

## 5. 執行要求 (Enforcement)

1. **里程碑結項 (Milestone Completion)**：任何里程碑的 `completion_report` 必須包含 `Test Coverage Appendix`，並對應本政策進行自評。
2. **CI 檢查 (aaa check)**：未來版本將引入針對測試覆蓋率標籤的自動化掃描，不符合政策的 PR 將被攔截。

---

**核准人**: AAA Governance Lead  
**生效日期**: 2026-01-28
