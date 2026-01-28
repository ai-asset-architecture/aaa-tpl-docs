# Architecture Update: v1.0 to v2.0 Alignment Plan

## Goal Description
系統化升級 `aaa-architecture.md`，將其從原有的 v0.1 基礎治理架構，演進為對齊 v1.0→v2.0 路線圖的 **「Agent OS 治理架構」**。

## Proposed Changes

### [aaa-tpl-docs]
#### [MODIFY] [aaa-architecture.md](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs/internal/development/architecture/aaa-architecture.md)
- **版本升級**：從 v0.1 升級至 v1.1 (Draft for v2.0)。
- **願景重塑**：將「資產庫治理」演進為「Agent OS 語義治理」。
- **新增架構層級**：
    - **Semantic Layer (v1.1-1.3)**：包含 AI-Native 協定與語義註冊表。
    - **Guardian Layer (v1.4-1.6)**：包含即時守護 (Daemon) 與自動修復。
    - **Constitution Layer (v1.7-2.0)**：包含聯邦治理與最高法院裁決。
- **組件邊界更新**：更新 RACI 表，加入 `aaa-guardian`、`Supreme Court UI` 等新組件的職責。

## Triple-Summary Protocol

### 1. Plan Summary
本計畫旨在將 AAA 的核心架構文件與最新的「邁向 v2.0 Agent OS」路線圖對齊。實作路徑分為三個階段：首先，重新定義核心願景與設計原則；其次，插入「語義時代」、「主動守護」與「數位憲法」三大架構層級及其關鍵組件；最後，更新各個 Repository 的責任邊界 (RACI)，確保 v1.x 新增的功能（如 MCP 支援、自動修復、即時監控）有明確的歸屬與定義。

### 2. Schema Summary
此變更不涉及資料庫 Schema 修改，但涉及 **「治理語義 (Governance Semantics)」** 的邏輯結構定義。我們將在架構中引入 `Object-type` 驅動的治理規則、`Capability-based` 的資產索引方式、以及 `Audit Ledger` 的不可篡改紀錄結構。這些更新將作為後續執行 `aaa register` 與 `aaa gate` 升級的邏輯底座。

### 3. Component Summary
架構更新將明確化以下新組件的定位：
- **AAA Guardian (v1.4)**：定位為本地 Background Daemon，負責即時監控變更。
- **Governance Compiler (v1.3)**：定位為政策轉代碼的編譯器，串接 LLM 與檢查器。
- **Supreme Court Interface (v1.9)**：定位為人類決策與仲裁的 Web 控制台。
- **Marketplace Hub (v2.0)**：定位為經認證的 Agent 與 Packs 交易/分發中心。

## Verification Plan
### Manual Verification
- 檢查 `aaa-architecture.md` 的章節是否與 `AAA_roadmap.md` 的版本目標 1:1 對應。
- 驗證 RACI 表是否涵蓋了 v1.x 規劃中的所有關鍵技術產出。
- 確認「Triple-Summary」是否具備足夠的資訊密度供決策者對齊。
