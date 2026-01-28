---
title: "Update Policy: Staying Current with AAA"
type: Architecture Decision Record
status: Active
owner: AAA Governance
version: v1.2 (Target v2.0)
last_updated: 2026-01-28
---

# Update Policy: 從被動輪詢到自主守護 (v2.0)

## 1. 核心策略 (Core Strategy)

AAA 生態系（Tools, Actions, Evals, Templates）持續演進。我們正從 v1.0 的 **「多層次更新感知 (Multi-Layer Awareness)」** 轉型為 v2.0 的 **「自主守護更新 (Autonomous Life-cycle)」**。

核心演進點：
1.  **Agentic Awareness (v1.1)**：透過 MCP 協定，Agent 能主動感知 AAA 版本狀態。
2.  **Active Guarding (v1.4)**：由 `aaa-guardian` daemon 提供實時的版本落後提醒。
3.  **Self-Healing (v1.5)**：`aaa gate --auto-fix` 可自主修正過舊的 CI Workflow 配置。

## 2. 更新通道矩陣 (Update Channels Matrix)

| 層次 (Layer) | 機制 (Mechanism) | 類型 | 狀態 | 適用場景 |
| :--- | :--- | :--- | :--- | :--- |
| **L1. Autonomous** | **Self-Healing PR** | Auto (Agent) | **開發中 (v1.5)** | Agent 自主發起 PR 修復過舊的 Workflow 引用。 |
| **L1. Autonomous** | **MCP Capability** | Polling (Agent) | **已規劃 (v1.1)** | AI Agent 透過 MCP 直接查詢最新版號與更新腳本。 |
| **L2. Guardian** | **Daemon Watch** | Live (Local) | **已規劃 (v1.4)** | `aaa watch` 在背景偵測到版本過舊時發出系統通知。 |
| **L3. Push** | **Gate Enforcement** | Push (Blocking) | **已具備 (v1.0)** | `aaa-gate` 阻擋版本不符之提交。 |
| **L4. Pull** | **aaa outdated** | Polling (Manual) | **已具備 (v1.0)** | 人類開發者檢核版本差異。 |

---

## 3. 本地通知方案規格 (Local Runtime Hint Spec)

> **注意**：本節為 `aaa-tools` v1.2+ 的功能規格描述，目前尚未實作。

為了讓開發者在「操作當下」即時感知更新，CLI 將實作 **Non-blocking Version Check**。

### 3.1 行為邏輯
1.  **觸發點**: 執行 `aaa init`, `aaa check`, `aaa run` 等指令時。
2.  **快取機制**: 檢查結果快取 24 小時（`~/.aaa/cache/version_check`），避免拖慢指令。
3.  **靜默檢查**: 網路請求若超時（>2s）直接略過，不影響主程序。
4.  **視覺回饋**: 僅在 **Local < Remote** 時，於指令結束處顯示提醒資訊。

---

## 4. 升級路徑建議 (Upgrade Paths)

### 4.1 對於現有專案 (Existing Projects)

* **Actions**: 建議啟用 GitHub Dependabot，自動接收 `aaa-actions` 的版本更新 PR。
* **Tools**: 開發者應定期執行 `pip install --upgrade aaa-tools`。
* **Templates**: 執行 `aaa init repo-checks` 可檢測本地設定是否落後於最新治理標準。

### 4.2 對於新專案 (New Projects)

* 執行 `aaa init enterprise` 時，系統會自動抓取當下最新的 Workflow 定義與 Template。
* **Best Practice**: 始終使用最新的 Tag (`@v1`) 而非 SHA，以確保接收 Patch 更新。

---

## 5. 附錄：`aaa outdated` JSON Schema

以下為 `aaa outdated --json` 的輸出結構，用於自動化解析與報表整合。

```json
{
  "type": "object",
  "required": ["source", "components"],
  "properties": {
    "source": { "type": "string" },
    "components": {
      "type": "array",
      "items": {
        "type": "object",
        "required": ["name", "local_version", "remote_version", "status", "source"],
        "properties": {
          "name": { "type": "string" },
          "local_version": { "type": "string" },
          "remote_version": { "type": "string" },
          "status": {
            "type": "string",
            "enum": ["up-to-date", "outdated", "unknown", "multi"]
          },
          "source": { "type": "string" }
        }
      }
    }
  }
}
```
