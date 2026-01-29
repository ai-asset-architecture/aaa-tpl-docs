# AAA Strategic Roadmap (v2.0.1 → v3.0): Enterprise Edition

> **戰略定位**：AAA 不是一個 Agent 平台，而是 Agent 的 **「治理邊車 (Governance Sidecar)」**。
> **核心目標**：在不犧牲安全與主權的前提下，賦予 AI 代理「執行權」與「經濟激勵」。

---

## 🛡️ Phase 2: Trust & Connectivity (v2.0.1 - v2.3)

### v2.0.1 — The Shield (Trust Boundary Layer)
**核心價值**：建立不可逾越的「主權黑盒」，確保 Agent 只能在授權範圍內操作。

**不可妥協 DoD (Hard DoDs)**:
1. [ ] **Runtime Policy Enforcement**: 實作 `@mcp.tool(scope="public|admin")` 裝飾器，不符合 Scope 的請求在 Kernel 層直接阻斷。
2. [ ] **Verified Handshake (v1.0)**: 實施基於 JWT / ECDSA 的簽章驗證，取代 Stub 模式，支援 Session TTL 與 Nonce。
3. [ ] **Security Evidence Pack**: 連結 [RiskLedger (v1.8)](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs/milestones/20260129_v1.8_observability_2.0.md)，自動記錄所有跨邊界 (Cross-boundary) 請求。
4. [ ] **Deny-by-Default Logic**: 預設關閉所有高風險工具（如 `os boot`, `storage wipe`），需顯示調用 `aaa court auth`。
5. [ ] **Threat Model Report**: 提供至少 10 條針對 A2A 連線的威脅模型分析與對應測試。
6. [ ] **Registry Sanitization**: 遠端查詢自動過濾本地敏感路徑，防範路徑遍歷與配置洩漏。

---

### v2.1 — The Bridge (Secure Gateway)
**核心價值**：在防護盾下開放標準通訊鏈路，支援跨 Process 與跨機器通訊。

**不可妥協 DoD (Hard DoDs)**:
1. [ ] **SSE Bridge Server**: 支援 HTTP/SSE 協定，具備連線限流 (Rate Limiting) 與自動斷線機制。
2. [ ] **Gateway Audit Logs**: 所有經由 Bridge 的 IO 需附帶 Request ID，並可追溯至發起者的 Trust Token。
3. [ ] **macOS Reference Client**: 實作原生工具列 App，處理 [Supreme Court (v1.9)](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs/milestones/20260129_v1.9_supreme_court_interface.md) 的即時桌面彈窗提醒。
4. [ ] **Local-Only Encryption**: Bridge 的敏感流量採本地對稱加密，不通過第三方伺服器。

---

### v2.2 — The Endpoint (Execution Sidecar)
**核心價值**：控制 Agent 的「手 (Action)」，提供受控的執行環境。

**不可妥協 DoD (Hard DoDs)**:
1. [ ] **Capability Whitelist**: 定義 `aaa sh` 可執行的命令白名單。禁止 Agent 執行未經 AAA 驗證的系統命令。
2. [ ] **Sandbox Profiles**: 為不同的 Agent 分配獨立的隔離設定（如唯讀檔案系統、禁止外網連線）。
3. [ ] **Remote Revocation**: 指揮官可隨時透過 `aaa court kill` 終止所有端點的連線或權限。
4. [ ] **Deterministic Log Streaming**: 執行過程的所有 Stdout/Stderr 需同步傳回 Kernel 進行語義合規掃描。

---

### v2.3 — The Mesh (Capability Mesh)
**核心價值**：建立 Agent 之間的能力發現、授權與驗證體系。

**不可妥協 DoD (Hard DoDs)**:
1. [ ] **Capability Schema (v2.0)**: 繼承 [Semantic Registry (v1.2)](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs/milestones/20260128_v1.2_semantic_registry.md)，定義標準的能力描述格式。
2. [ ] **Version Handshake**: Agent 雙方在連線前需完成能力版本握手，不匹配則拒絕連線。
3. [ ] **Remote Attestation (MVP)**: 驗證對端 Agent 是否持有合規的 AAA 證書。
4. [ ] **Route Observability**: 視覺化展示 Agent 間的連線拓樸與調用流圖。

---

## 💰 Phase 3: Resource & Economy (v2.4 - v3.0)

### v2.4 — The Ledger (Resource Management)
**核心價值**：將「算力」與「成本」從不可控的黑盒轉變為可管理的資產。

**不可妥協 DoD (Hard DoDs)**:
1. [ ] **Compute Credits (CC) Ledger**: 擴展 [MetricStore (v1.8)](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs/milestones/20260129_v1.8_observability_2.0.md)，實現精確的 Token 記帳系統。
2. [ ] **Real-Cost Anchoring**: 1 CC 錨定真實的 API 成本（如 1k Input Tokens），防止資源過度耗損。
3. [ ] **Resource Shaping**: 自動攔截超過當前 Session 預算的任務。
4. [ ] **Anti-Fraud Detection**: 偵測異於常規的 Token 消耗行為（防止 Agent 陷入無意義死迴圈）。

---

### v2.5 — The Settlement (Algorithmic SLA)
**核心價值**：建立基於驗證的任務結算機制，實現 A2A 協作市場。

**不可妥協 DoD (Hard DoDs)**:
1. [ ] **Task Bounty Schema**: 定義任務的需求、預算與驗收標準。
2. [ ] **Algorithmic Verification**: 使用 [Project OMEGA style tests](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/tests/e2e/omega_run_final.sh) 自動判定任務完成度。
3. [ ] **SLA Dispute Arbitration**: 任務結果有爭議時，自動上傳至 [Supreme Court (v1.9)](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs/milestones/20260129_v1.9_supreme_court_interface.md) 進行人工裁決。
4. [ ] **Escrow Protocol**: 在驗證成功前，將 CC 資產鎖定在 Kernel 託管層。

---

### v3.0 — The Civilization (Governed Autonomy)
**核心價值**：從「工具」演進至「社會」，人類僅負責戰略方針，系統實現自我優化。

**不可妥協 DoD (Hard DoDs)**:
1. [ ] **Reputation Engine**: 根據歷史合規率與任務成功率，自動計算 Agent 的資信等級。
2. [ ] **Decentralized Policy Tuning**: 高資信 Agent 可提議微調 Check 參數，交由 Court 批准。
3. [ ] **Macro-Optimization**: 根據歷史數據自動調整資源分配權重。

---

## 🔭 Vision: Beyond Metrics
AAA v3.0 的成功不在於我們印發了多少 Compute Credits，而在於我們建立了一個 **「可信賴的數位治理基礎設施」**，讓企業敢於在大規模生產環境中，將關鍵權限交給自主 Agent。
