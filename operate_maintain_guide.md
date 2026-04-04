# Operate & Maintain Guide v2.1.0
> AAA 版本開發與維運工作流（AI / AI Agent 專用，無歧義可執行模板）

## 文件中繼資料
- document_version: `v2.1.0`
- effective_date: `2026-03-01`
- authority_level: `workflow-law`
- capability_name: `operate_maintain_workflow_v2`
- applies_to:
  - `AAA core`
  - `AAA inherited projects`（選擇匯入後生效）

## 0. 權威與優先序（MUST）
1. 本文件是版本開發流程唯一權威來源（Single Source of Workflow Truth）。
2. 任何 `task.md` / memo / 自建 checklist 不得覆蓋或改寫本文件規則。
3. 固定優先序：`operate_maintain_guide.md > task.md > memo`。
4. 違反 blocking 規則時，狀態必須標記為 `NOT READY` 或 `FAIL`，不得宣稱完成。

## 1. 核心目標
1. AAA 本體與繼承專案使用同一套 4-Step 版本治理語言。
2. 流程與證據可機器檢查（machine-checkable），避免敘述式完成宣告。
3. 版本/工作流程可在 registry 與 version 頁面完整追溯。

## 2. Canonical Sources（MUST）
以下兩份檔案是 `ops-registry` / `ops-version` 類頁面的 raw data SSOT：
- `aaa-tpl-docs/ops/index/version_index.md`
- `aaa-tpl-docs/ops/index/workflow_index.md`

硬規則：
1. 每次版本開發 Step1，必須新增或更新 `version_index.md` 對應列。
2. 若版本涉及 workflow，Step1 必須同步新增或更新 `workflow_index.md` 對應列。
3. Step2~Step4 的 run_ref / evidence / final status 必須回寫 index 對應列。
4. 不得繞過上述 index 建立平行資料來源。

## 3. Release Type
- `NORMAL_RELEASE`：Step1 + Step2 + Step3 + Step4 全完成。
- `BRIDGE_RELEASE`：治理補洞型版本；可停在 Step1，Step4 僅可標記 `COMPLETED_STEP1` 或 `BRIDGE_ONLY`。

## 3.1 Step2 Scarcity Governance（MUST）
1. Step2 是稀缺治理配額，不是每個新版本的預設權利。
2. 擬進 Step2 的版本，plan / audit 必須先回答：
   - 為何不能 bridge-only
   - 為何不能被既有 execution package 吸收
   - 為何不能重用既有 execution carrier
3. 下列類型預設不應建立獨立 Step2，除非 audit 明示不能 bridge-only 且不能被 bundled execution 吸收：
   - wording / vocabulary baseline
   - positioning / framing baseline
   - appendix / guide / narrative clarification baseline
   - historical / metadata / registry interpretation baseline
4. Step2 run_ref 合法，不等於可自動新增 version-specific workflow；預設必須優先重用既有 carrier 或 bundled execution。

## 3.2 Bridge Visibility Package（Reduced-Form MUST）
1. `BRIDGE_RELEASE` 若要求 consumer-visible surface，plan / audit 必須顯式定義 `bridge visibility package`。
2. `bridge visibility package` 只能處理 version-side visible surface，不得自動擴張到 workflow-side active registry。
3. bridge visibility proof 只可作為 local / page-visible evidence，不得冒充 Step2 remote executable evidence。

## 4. Strict Discipline（全部 MUST）
1. **Step1/Step2 邊界隔離**：Step1 只允許治理資產，禁止修改 runtime domain code。
2. **No-Glob**：所有 deliverables/evidence 路徑禁止 `*`、`**`，必須具體檔名。
3. **Remote-Only Evidence（Step2+）**：run_ref 僅允許 `gh-actions:<repo>@<workflow_file>#<run_id>`。
4. **Completion Claim Guard**：缺 remote evidence 禁止使用 `COMPLETED/PASS/已落地` 語意。
5. **Full-File Consistency**：涉及 index 或 dashboard raw data 的更新，必須維持全檔排序與語意一致。
6. **Guide Parity Gate（v2.1.0+）**：`aaa-docs/bootstrap/operate_maintain_guide.md` 與 `aaa-tpl-docs/operate_maintain_guide.md` 的 canonical sections 必須通過 CI parity gate；不一致一律 FAIL。
7. **Machine-Parseable Truth Priority**：若 guide MUST、schema/gate parser、與人類可讀敘述不一致，以 guide MUST + machine-checkable parser 為最高真相。
8. **Generated Artifact Shape Verification**：讀取 generated artifact 前，必須先確認 top-level keys 與對應 schema/type；不得直接假設欄位結構或猜測欄位名。
9. **Guide Patch Threshold**：只有 truth precedence、closeout sequence、shared validator/contract law、或 guide-level promotion law 類問題，才可直接升格為 top guide patch；其餘 recurring issue 預設優先進 register / checklist / validator / schema。

## 5. 4-Step Lifecycle

### Step 1: Contract Baseline（契約基線）
**目標**：先鎖規格與驗收，再進入實作。

允許（Step1）：
- `internal/development/plans/**`
- `internal/development/audits/**`
- `internal/development/reviews/**`
- `internal/development/contracts/**`
- `internal/development/templates/**`
- `scripts/gates/**`
- `.github/workflows/**`（僅草案狀態）

禁止（Step1）：
- `src/**`
- `PRD/**`
- runtime/build config（`package.json`, `tsconfig*`, `next.config*`, `eslint*`）

必備交付（No-Glob）：
1. `internal/development/plans/YYYY-MM-DD-<version>-<name>-plan.md`
2. `internal/development/audits/YYYY-MM-DD-<version>-<name>-audit.md`
3. `internal/development/reviews/YYYY-MM-DD-<version>-<name>-diff-paths.md`
4. 至少 1 份 `*.schema.json`
5. 至少 1 組 pass example + 1 組 fail example

Step1 Index Blocking（MUST）：
1. `aaa-tpl-docs/ops/index/version_index.md` 必須有新版本列（或更新既有列）。
2. 涉及 workflow 時，`aaa-tpl-docs/ops/index/workflow_index.md` 必須有新列（或更新既有列）。
3. 排序規則：日期 DESC；同日期下版本/ID DESC。
4. Step1 可使用 `run_ref=N/A (step2-pending)`，但不得宣稱 Step2 PASS。

#### Step 1 Exit Checklist
```yaml
ExitChecklistStep: 1
ExitChecklistVersion: v2.1.0
ExitChecklistOwner: <ai-or-human-role>
ExitChecklistVerdict: PASS|FAIL|N/A
```
- [ ] Plan 已建立（No-Glob）
- [ ] Audit 已建立（含驗收標準）
- [ ] Diff-Paths 已建立（含 allowlist/denylist/verdict）
- [ ] Schema + pass/fail examples 已建立
- [ ] 無 runtime domain code 變更（Step1 邊界合規）
- [ ] `version_index.md` 已更新
- [ ] `workflow_index.md` 已更新（若適用）
- [ ] 排序與欄位語意一致

### Step 2: Implementation & Executable Evidence
**目標**：依契約完成實作並產生可重放證據。

必備欄位（MUST）：
- `run_ref`（remote-only）
- `computed_at_taipei`
- `inputs_digest`
- `source_paths`（No-Glob）
- `evidence_path`（No-Glob）

硬規則：
1. 僅允許 `gh-actions:<repo>@<workflow_file>#<run_id>`。
2. 禁止 `local:*`, `file:*`, `shell:*`, `gh://` 作為 Step2 新證據。
3. 新增/重大修改 workflow 時，至少 1 次 remote smoke run。
4. Step2 完成後需更新 index 對應列（status/run_ref/evidence）。

#### Step 2 Exit Checklist
```yaml
ExitChecklistStep: 2
ExitChecklistVersion: v2.1.0
ExitChecklistOwner: <ai-or-human-role>
ExitChecklistVerdict: PASS|FAIL|N/A
```
- [ ] Step1 全項 PASS
- [ ] 實作與 Step1 契約一致
- [ ] run-evidence 具備必要欄位
- [ ] run_ref remote-only 合規
- [ ] workflow smoke run 已完成（若適用）
- [ ] index 對應列完成 Step2 回寫

### Step 3: Asset Preservation
**目標**：把 Step1/Step2 產生的可重用成果轉成 AAA 資產，形成可回放、可匯入、可審計的資產鏈。

AAA Valuable Assets（MUST）：
1. Templates：
   - 例：`internal/development/templates/**`、可被繼承專案直接套用的 SOP/規格模板。
2. Prompts：
   - 例：`prompts/**`、agent/system prompt bundles、審核提示詞。
3. Contracts：
   - 例：`internal/development/contracts/**/*.schema.json`、reason-codes、pass/fail fixtures。
4. Workflows/Gates：
   - 例：`.github/workflows/*.yml`、`scripts/gates/**`。
5. Evals/Test Assets：
   - 例：`evals/**`、測試資料、驗證案例與 replay inputs。
6. Runbooks/Operational Guides：
   - 例：`internal/development/runbooks/**`、`internal/development/reviews/*-checklist.md`。
7. UI/Observability Assets（若有）：
   - 例：dashboard spec、MCP screenshots、ops/version page mapping docs。

來源規則（MUST）：
1. Step1 產物：以「治理可重用」為主（templates/contracts/gates/workflow specs）。
2. Step2 產物：以「可執行證據可重用」為主（run evidence/evals/replay assets）。
3. Step3 必須明確標示每項資產來自 Step1 或 Step2，不得混寫為不明來源。

最小保存交付（MUST）：
1. `internal/development/evidence/<version>/<asset>/result.json`
2. `internal/development/evidence/<version>/<asset>/index.json`
3. `internal/development/evidence/<version>/<asset>/run-evidence.md`
4. `internal/development/evidence/<version>/<asset>/asset-manifest.v0.1.json`
   - 至少欄位：`asset_id`, `asset_type`, `source_step`, `source_paths`, `reuse_target`, `owner`, `digest`

Value Gate（MUST）：
1. 若本版本沒有任何可沉澱 AAA 資產，必須在 Step3 checklist 填寫 `No-Asset Justification`（不可留空）。
2. 若有資產，`asset-manifest.v0.1.json` 至少 1 筆 `reuse_target` 必須是 `AAA core` 或 `AAA inherited projects`。
3. 每筆資產都要有對應 digest（如 `inputs_digest`, `policy_digest`, `dataset_digest`, `asset_digest`）。

#### Step 3 Exit Checklist
```yaml
ExitChecklistStep: 3
ExitChecklistVersion: v2.1.0
ExitChecklistOwner: <ai-or-human-role>
ExitChecklistVerdict: PASS|FAIL|N/A
```
- [ ] Value Check 完成
- [ ] Valuable Assets 已分類（Templates/Prompts/Contracts/Workflows/Evals/Runbooks/UI）
- [ ] 每項資產已標註 `source_step`（Step1 或 Step2）
- [ ] `asset-manifest.v0.1.json` 已建立（或有 No-Asset Justification）
- [ ] 證據檔已保存（`result.json`, `index.json`, `run-evidence.md`）
- [ ] digest 欄位齊全（含 asset_digest 類欄位）
- [ ] milestone 摘要已建立

### Step 4: Completion & Delivery
**目標**：完成版本閉環交付並可跨頁追溯。

必備文件：
1. `internal/development/milestones/YYYYMMDD_vX.Y_<name>.md`
2. `internal/development/milestones/completion-reports/vX.Y_completion_report_YYYYMMDD.md`

必做同步（MUST）：
1. `version_index.md` 更新最終狀態（NORMAL=`COMPLETED`；BRIDGE=`COMPLETED_STEP1`/`BRIDGE_ONLY`）。
2. `workflow_index.md` 同步 workflow 的 latest_run/evidence/mode/status。
3. 任何 completion claim 必須對應 Step2 remote evidence。

Global MCP Validation（Step4 MUST）：
1. `/ops-registry?tab=versions`
2. `/ops-registry?tab=workflows`
3. `/ops-version/<version>`

UI Validation Evidence Policy（Reduced-Form MUST）：
1. Step4 若產出 UI validation evidence，必須明示：
   - `primary_tool`
   - `fallback_tool`
   - `exception_reason`（若使用 fallback）
2. UI validation tool naming 只作 evidence metadata，不自動升格為 workflow-law 主權判斷。

Step4 Checklist Tiering（MUST）：
1. Step4 checklist item 必須分級為：
   - `ALWAYS_ON_MUST`
   - `CONDITIONAL_MUST`
   - `REVIEW_SAMPLED`
2. 新增 Step4 item 預設不得直接進 `ALWAYS_ON_MUST`，除非 audit 能證明其對 closeout 真實性具有不可替代價值。

Single Review Artifact Rule（MUST）：
1. 每次 4-step closeout 完成後，只允許一份 post-closeout review artifact。
2. 該 artifact 必須同時承載 lesson learned、follow-up decision、與必要 appendix。
3. 不得再拆出 decision note / wording draft / mutation patch draft / completion note 的中間文件鏈充當 current preferred process。

Recurring Issue Register Discipline（Reduced-Form MUST）：
1. recurring issue 不得只留在 review note；若屬重複性 failure / drift / checklist degradation，必須進入正式 register。
2. register mutation 至少必須包含：
   - `entry_id`
   - `pattern_summary`
   - `affected_area`
   - `recommended_promotion_target`
   - `status`
3. `ABSORBED` 不得只表示「已知悉」；至少必須已有 1 個正式 guard 落地於 guide / schema / validator / checklist 之一。

Post-Closeout Interpretation Boundary（Reduced-Form MUST）：
1. post-closeout interpretation artifact 只能限制外推邊界，不得自動授權新 runtime family、new version line、或新治理主權層。
2. interpretation artifact 可作為 review / planning 邊界參考，但不得單獨取代正式 plan / audit / schema / validator 規則。

#### Step 4 Exit Checklist
```yaml
ExitChecklistStep: 4
ExitChecklistVersion: v2.1.0
ExitChecklistOwner: <ai-or-human-role>
ExitChecklistVerdict: PASS|FAIL|N/A
```
- [ ] completion report 已建立
- [ ] milestone 摘要已建立
- [ ] version/workflow index 同步完成
- [ ] MCP 3 頁驗證證據存在
- [ ] completion claim 與 remote evidence 一致

## 6. Import Model（給繼承專案）
Capability: `operate_maintain_workflow_v2`

規則：
1. 繼承專案可選擇是否匯入本 workflow。
2. 未匯入時，可不提供 ops-registry / ops-version 相關能力。
3. 一旦匯入，必須遵守本文件 Step1~4 所有 MUST 規則。
4. 推薦透過 `aaa-tools` 匯入命令安裝本 capability（避免手動遺漏）。

## 7. Canonical Status Enums
- `PLANNED`
- `UNVERIFIED`
- `COMPLETED_STEP1`
- `BRIDGE_ONLY`
- `COMPLETED`

## 8. Violation Handling
1. Step1 未更新 index：`Step1 FAIL`。
2. Step2 使用非 remote run_ref：`Hard FAIL`。
3. completion claim 缺 evidence：`Hard FAIL`。
4. index 與頁面資料語意不一致：`Process Non-Compliance`，必須先修復再繼續。
