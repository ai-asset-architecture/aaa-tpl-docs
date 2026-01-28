# Update Policy: v2.0 Alignment & Path Correction Plan

## Goal Description
系統化升級 `update_policy.md`，將其從 v1.0 的被動感知模型，演進為對齊 v2.0 **「Active Guardian (主動守護)」** 的主動更新模型。同時修正因目錄重構（Restructuring）導致的跨 Repo 連結失效問題。

## Proposed Changes

### [aaa-tpl-docs]
#### [MODIFY] [update_policy.md](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs/internal/development/architecture/update_policy.md)
- **版本升級**：更新 Metadata 狀態為 `v1.2 (Active)`。
- **願景更新**：加入 **「v2.0 Active Update」** 模型，包含：
    - **Self-Healing (v1.5)**：自動修正版本錯配。
    - **Guardian Daemon (v1.4)**：背景實時提醒。
    - **MCP Support (v1.1)**：讓 Agent 具備查詢與執行更新的能力。
- **流程更新**：更新 `Update Channels Matrix`，標記 MCP 與 Guardian 為已規劃/開發中。

#### [MODIFY] [PROJECT_PLAYBOOK.md](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs/PROJECT_PLAYBOOK.md)
- **修正連結**：將所有 `./internal/development/architecture/update_policy.md` 修正為對齊重構後的正確相對路徑。（註：目前 grep 顯示路徑看來是正確的，但需確認其連結點的出發點）。

#### [MODIFY] [WORKSPACE_ARCHITECTURE.md](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs/public/bootstrap/WORKSPACE_ARCHITECTURE.md)
- **修正連結**：同上。

## Triple-Summary Protocol

### 1. Plan Summary
本計畫包含兩個層次：第一是確保 AAA 更新政策文件的內容對齊最新 v2.0 路線圖，特別是強調從「手動 Polling」轉向「Agentic Auto-healing」的核心轉變；第二是執行全域連結一致性檢查，修復因之前的目錄調整導致的 Markdown 連結失效，確保「法律與憲法」文件的導航完整性。

### 2. Schema Summary
此變更不涉及代碼 Schema，但定義了 **「更新優先級與渠道矩陣 (Update Channel Matrix)」** 的語義定義。我們將新增 `L4. Autonomous` 層級，描述 Agent 如何透過 `aaa gate --auto-fix` 實現自主的版本生命週期管理。

### 3. Component Summary
更新重點在於明確化 `aaa-tools` 作為更新分發者（MCP）與 `aaa-guardian` 作為監控者（Daemon）的職責分工。`update_policy.md` 將作為這兩個組件未來開發時的政策依據。

## Verification Plan
### Manual Verification
- 使用 `grep` 檢查 `aaa-tpl-docs` 中是否還有指向舊路徑（若有）的 `update_policy.md`。
- 驗證 `update_policy.md` 中的 Matrix 是否正確反映了 v2.0 的進度。
