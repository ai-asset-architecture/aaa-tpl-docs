---
title: "Update Policy: Staying Current with AAA"
type: Architecture Decision Record
status: Active
owner: AAA Governance
last_updated: 2026-01-24
---

# Update Policy: 如何取得最新 AAA

## 1. 核心策略 (Core Strategy)

AAA 生態系（Tools, Actions, Evals, Templates）持續演進。為了確保專案能即時獲得最新的治理能力與安全性修正，我們採用 **「多層次更新感知 (Multi-Layer Awareness)」** 策略。

我們將更新機制分為兩類：
1.  **Polling (主動輪詢)**：使用者或系統主動檢查是否有新版本。
2.  **Push (被動推送)**：AAA 透過 CI/CD 或通知管道主動告知使用者。

## 2. 更新通道矩陣 (Update Channels Matrix)

下表列出目前支援與規劃中的更新通道：

| 層次 (Layer) | 機制 (Mechanism) | 類型 | 狀態 | 適用場景 |
| :--- | :--- | :--- | :--- | :--- |
| **L1. Contextual** | **CLI Runtime Hint** | Polling (Auto) | **待補 (Planned)** | 當開發者在本地執行 `aaa` 指令時，背景檢查並提示更新。 |
| **L2. Push** | **Gate Enforcement** | Push (Blocking) | **已具備 (Available)** | `aaa-gate` 透過 Repo Checks 阻擋過舊或不合規的版本。 |
| **L2. Push** | **Dependabot** | Push (Auto) | **已具備 (Available)** | GitHub 原生機制，自動發送 PR 更新 Actions 版本。 |
| **L3. Pull** | **Registry Index** | Polling (Manual) | **已具備 (Available)** | 使用者查詢 `registry_index.json` 確認最新資產版本。 |
| **L3. Pull** | **aaa outdated** | Polling (Manual) | **已具備 (Available)** | 一鍵輸出本地版本與遠端版本差異報告。 |
| **L3. Pull** | **Release Notes** | Polling (Manual) | **已具備 (Available)** | 透過 `reports/milestones` 或 GitHub Releases 查看變更。 |
| **L3. Pull** | **Upgrade Command** | Action (Manual) | **待補 (Planned)** | `aaa upgrade` 指令，一鍵升級本地環境。 |

---

## 3. 本地通知方案規格 (Local Runtime Hint Spec)

> **注意**：本節為 `aaa-tools` v1.2+ 的功能規格描述，目前尚未實作。

為了讓開發者在「操作當下」即時感知更新，CLI 將實作 **Non-blocking Version Check**。

### 3.1 行為邏輯
1.  **觸發點**: 執行 `aaa init`, `aaa check`, `aaa run` 等指令時。
2.  **快取機制**: 檢查結果快取 24 小時（`~/.aaa/cache/version_check`），避免拖慢指令。
3.  **靜默檢查**: 網路請求若超時（>2s）直接略過，不影響主程序。
4.  **視覺回饋**: 僅在 **Local < Remote** 時，於指令結束處顯示：

```text
╭──────────────────────────────────────────────────────────────╮
│                                                              │
│   Update available 1.0.0 → 1.1.0                             │
│   Run "pip install --upgrade aaa-tools" to update.           │
│   See changes: [https://github.com/.../releases/tag/v1.1.0](https://github.com/.../releases/tag/v1.1.0)    │
│                                                              │
╰──────────────────────────────────────────────────────────────╯

```

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

## 5. Pending Logs (Non-Blocking)

1. **Nightly Verification**: 確認 P2-1 (Metrics/Thresholds) 部署後，Dashboard 是否正確呈現 Drift Rate 趨勢。
2. **P0-3 Evidence**: 確認 Org-level onboarding evals 是否能產出強制證據 (Enforced Report)。
3. **P2-3 Workflow Evidence**: 確認 `repo-upgrade` 與 `repo-audit` workflow 在真實環境下的執行結果。

---

## 6. 附錄：`aaa outdated` JSON Schema

以下為 `aaa outdated --json` 的輸出結構（簡化版 Schema），用於自動化解析與報表整合。

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
          "source": { "type": "string" },
          "details": {
            "type": "object",
            "properties": {
              "versions": { "type": "array", "items": { "type": "string" } }
            },
            "additionalProperties": true
          }
        }
      }
    }
  }
}
```

**欄位說明**
- `name`: component id（tools/actions/evals/templates/prompts）
- `local_version`: 本地版本或 `untracked`
- `remote_version`: 遠端版本或 `unknown`
- `status`: `up-to-date` / `outdated` / `unknown` / `multi`
