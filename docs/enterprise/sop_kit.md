---
title: "Enterprise SOP Kit: AI-Native Governance"
version: v1.0
type: Standard Operating Procedure
status: Active
owner: Governance Board
last_updated: 2026-01-24
---

# Enterprise SOP Kit: AI-Native Governance

## 1. 核心理念 (Core Philosophy)
AAA 的治理目標不是限制速度，而是將「合規 (Compliance)」內化為「可執行規則 (Executable Rules)」。
我們採用「人機協作，逐步自治」的模型。

### 1.1 治理宣言
1. **Code is Law**: 治理規則必須具備可執行的 Ruleset 與 Checks。
2. **Gate-First**: 不合規資產不得進入交付管道。
3. **Identity-Agnostic Ownership**: Owner 是責任實體，角色由能力與審計表現決定，不以生物身份限制。

---

## 2. 角色與職責 (Roles & Responsibilities)
本架構採用「動態授權 (Dynamic Entitlement)」。角色由能力與審計表現決定，可擴展至 AI 成為 Owner。

### 2.1 目前角色 (Current State)
- **Human Owner (HO)**
  - 定義業務目標與風險偏好。
  - 擁有例外豁免權 (Glass Break)。
  - 負責審核高風險與非標準變更。
- **AI Agent (Builder/Guardian)**
  - **Builder**: 生成代碼/文件/配置。
  - **Guardian**: 執行 `aaa-gate`，攔截違規並提供修復建議。
- **Governance Auditor**
  - 定義 Org-level Ruleset 與年度稽核標準。

### 2.2 協作模式 (Interaction)
- **Delegation (正向授權)**: Human Owner 將特定任務（如 dependency update）授權給 Agent。
- **Escalation (升級處理)**: Agent 不確定性高於閾值 (Confidence < 0.8) 時，必須暫停並要求人類介入。

### 2.3 未來預留：AI 自主權 (Future Reservation)
為適應 AI 能力演進，保留以下機制：
- **Agent Promotion**: 當 Agent 在特定領域連續 N 週達成：
  - Gate 全綠、0 次 P0/P1 事故
  - 審計結果通過 (audit pass)
  - 變更類型受限 (例如 dependency update / documentation)
  可晉升為 **Autonomous Owner**。
- **Reverse Delegation**: 允許 AI Agent 依架構需求建立任務並指派給人類（如需實體操作/外部資源）。

---

## 3. 導入流程 (Adoption Lifecycle)

### Phase 1: Injection (注入)
- **Action**: `aaa init enterprise`
- **Goal**: 建立 `aaa-gate` 與 org ruleset 基線
- **Result**: Repo 納入治理規則範圍

### Phase 2: Calibration (校準)
- **Action**: `aaa check --mode blocking`
- **Goal**: 清除歷史債務，使 Gate 全綠
- **Human Role**: 依 Agent 建議做決策

### Phase 3: Automation (自治)
- **Action**: 開啟 Auto-Fix / Auto-Merge 權限
- **Goal**: 90% 日常維運由 Agent 閉環完成
- **AI Role**: 接管日常維運，人類處理高風險事項

---

## 4. 異常管理 (Exception Management)

### 4.1 例外豁免 (Bypass)
當業務緊急需求必須繞過 Gate：
1. **Request**: Human Owner 提交 Bypass Request（附理由）。
2. **Evidence**: 系統記錄至 `audit_log`（不可篡改）。
3. **Approval**: Org Admin 或授權的高階 Agent 核准。

### 4.2 逆向授權協議 (Reverse Authority)
若系統偵測到違反核心安全原則：
1. **Block**: Agent 有權阻擋該操作。
2. **Override**: 需多簽 (Multi-sig) 才能覆寫。

限制條件：
- 僅限 policy scope 內的高風險事件。
- 必須記錄審計證據與批准人。

---

## 5. 稽核與證據 (Audit & Evidence)
所有決策需留痕（不包含完整推理鏈）：
- `nightly_governance.json`: 每日快照
- `compliance_report.json`: PR 准入憑證
- `decision_trace.log`: 決策理由摘要、規則命中與批准記錄

