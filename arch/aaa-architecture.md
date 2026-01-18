# ai-asset-architecture（aaa）最小 Repo 組合草案 v0.1
> Org：`ai-asset-architecture`  
> Alias / Prefix：`aaa`  
> 目標：建立「可重用、可演進」的資產庫（Evals / Templates / Tools / Governance）+ 可複製的模板 Repo，並提供清晰的 Consume / Feedback（回流）機制，支援多 AI + 多人協作的未來專案。

---

## 0) 設計原則（你要的 6 點對應）
### 0.1 資產分兩類：Copy vs Reference
- **Copy（一次性複製）**：用於新專案快速起步的骨架（結構、README、初始模板、少量專案級設定）
- **Reference（可升級引用）**：要「越來越好」的資產（Evals / Tools / CI Workflows / Governance），避免各專案 copy 後分叉

### 0.2 三條管線（必備）
1. **Bootstrap 管線**：用模板 Repo 生成新專案
2. **Consume 管線**：新專案引用/同步 AAA 的資產（不靠 copy）
3. **Feedback 管線**：新專案產出新資產 → 提煉硬化 → 回流 AAA 資產庫 → 版本化

---

## 1) 最小 Repo 組合（MVP Set）
> 原則：先少而硬，確保「能用、能回流、能升級」，再擴張。

### 1.1 現況必備（v0.1 已落地）
1) **`.github`**（組織級預設治理 + PR/Issue 模板）
- 定位：治理與模板入口（不是資產大倉庫）
- 內容：PR 模板、Issue templates、CONTRIBUTING、SECURITY、CODEOWNERS、GOVERNANCE、BOOTSTRAP_PROTOCOL

2) **`aaa-actions`**（可重用 GitHub Actions workflows）
- 定位：把 QA / Evals / Lint / Release gate 做成可被其他 repo `workflow_call` 引用的「中央升級」資產

3) **`aaa-evals`**（Evals 資產庫：規格、資料集、基準、回歸）
- 定位：評估集（可版本化）、資料、指標定義、基準結果
- 重點：提供「可回歸」的品質閘門，讓資產可進化

4) **`aaa-tools`**（工具庫：CLI / 檢查器 / scaffold / eval runner）
- 定位：把「規則」變成「可執行」，減少人肉審查成本
- 推薦：以 CLI 形式提供（本地與 CI 可用）
- 重要產物：
  - `runbooks/init/`（初始化 Runbook 與 Schema）
  - `specs/`（CLI 合約與 Plan Schema）

5) **`aaa-prompts`**（Prompt 資產庫：可版本化配方）
- 定位：收斂「已驗證的高品質 Prompt」，提供穩定可重用的配方資產
- 介面：由 `aaa-tools` 提供 `aaa pull prompt:<name>@<version>` 取用

6) **`aaa-tpl-docs`**（Docs 模板）
- 定位：AI 協作核心文件 SSOT（ACC/PP/.ai-context/PRD/ADR）

7) **`aaa-tpl-service`**（Service 模板）
- 定位：最小後端骨架 + CI 接線（aaa-actions）

8) **`aaa-tpl-frontend`**（Frontend 模板）
- 定位：最小前端骨架 + CI 接線（aaa-actions）

9) **`aaa-observability`**（觀測規範）
- 定位：事件/告警/Runbook 規範與範例

### 1.2 規劃中（未落地）
1) **`aaa-tpl-repo`**（最小通用 Repo 模板）
- 定位：新專案 Repo 的骨架（README/目錄/基本 CI 入口）
- 用法：新專案建立時「Use this template」→ 生成 `<orgAlias>-<repoName>` 類型 repo

> ✅ 現況必備：以 1.1 清單為準  
> ⭕ 規劃中：`aaa-tpl-repo`

---

## 2) 每個 Repo 的責任邊界（RACI/Scope）
### 2.1 `.github`
**負責**
- 組織級 PR/Issue 模板（包含 Asset Promotion Pipeline 的 PR 模板）
- 組織級貢獻規範與治理檔案（CONTRIBUTING/SECURITY）
- （可選）CODEOWNERS 與 review 規則引導
- `.github` 作為治理與流程入口，不作為資產倉庫

**不負責**
- 不放大型 eval 資料、工具 binaries、專案實作碼

### 2.2 `aaa-tpl-repo`
**負責**
- 新 repo 初始化骨架（目錄、README、基本腳本入口）
- 提供最小的「Consume 指引」（如何引用 `aaa-actions` / 安裝 `aaa-tools` / 接上 `aaa-evals`）

**不負責**
- 不承擔「升級」責任（模板被複製後會發散是正常的）

### 2.3 `aaa-actions`
**負責**
- 可重用 workflows：lint、tests、eval gates、release gates
- 統一的 CI 標準（升級一次，全組織逐步採用）

**不負責**
- 不放 eval dataset（放 `aaa-evals`）
- 不放工具源碼（放 `aaa-tools`）

### 2.4 `aaa-evals`
**負責**
- Eval spec（格式、欄位、指標、通過門檻）
- Eval datasets / fixtures（能版本化）
- baseline results（每版的基準）

**不負責**
- 不實作多種語言 runner（盡量集中到 `aaa-tools`）

### 2.5 `aaa-tools`
**負責**
- CLI：`aaa`（或 `aaa-tools`）提供
  - `aaa scaffold ...`（生成模板骨架、文件）
  - `aaa lint ...`（檢查 PRD/Docs 必備章節）
  - `aaa eval run ...`（跑 eval，輸出 JSON/Markdown 報告）
  - `aaa promote ...`（把 candidates 整理成可回流格式）

**不負責**
- 不放 project-specific hack（先留在 project 的 candidates）

### 2.6 `.agent` / `.codex`（Template Repo 內的 Consumer 資料夾）
**負責**
- 作為新專案的本地路徑（工具要求的資料夾存在即可）
- 放「引用設定」或「同步腳本」，指向 `aaa-tools` 的 skills 資產

**不負責**
- 不作為 Source of Truth（skills 原始碼與定義統一放 `aaa-tools`）

### 2.7 `aaa-tools/skills`（Skills SSOT）
**負責**
- Skills 單一真源（SSOT），統一命名為 `aaa-` 前綴
- 按用途分區：`common/`（共用）、`codex/`（Codex CLI 專用）、`agent/`（Antigravity 專用）
- 由 `aaa sync skills --target=codex|agent` 同步至專案根目錄的 `.codex/skills` / `.agent/skills`
- 常用治理技能：`aaa-governance-audit`（一鍵跑治理檢查並輸出報告）

**不負責**
- 不在各專案 repo 中手動維護 skills（避免分叉）

### 2.8 `aaa-prompts`
**負責**
- Prompt 資產（可版本化、可回歸的「配方卡」）
- 統一格式（如 `.md` / `.yaml` / `.json`），可被 `aaa-tools` 讀取或拉取

**不負責**
- 不放執行程式碼（程式邏輯應回流至 `aaa-tools`）

---

## 3) 建議目錄結構（每個 Repo）
> 目錄是資產化的第一步：讓人與 agent 都能預期「東西在哪裡」。

### 3.1 `.github` 目錄（組織級治理入口：不作為資產倉庫）
```
.github/
  CONTRIBUTING.md
  SECURITY.md
  CODEOWNERS
  GOVERNANCE.md
  BOOTSTRAP_PROTOCOL.md
  README.md
  PULL_REQUEST_TEMPLATE.md
  ISSUE_TEMPLATE/
    bug_report.yml
    feature_request.yml
    doc_request.yml
  profile/
    README.md
```

### 3.2 `aaa-tpl-repo` 目錄
```
aaa-tpl-repo/
  README.md
  AGENTS.md                   # optional: 新 repo 的 agent guardrails 入口
  .ai-context.md              # AI 必讀規則入口（或改用 .cursorrules）
  .agent/                      # Consumer stub（由 aaa-tools 同步）
  .codex/                      # Consumer stub（由 aaa-tools 同步）
  docs/
    AI_COMMAND_CENTER.md      # 憲法：AI 協作規則（模板化）
    PROJECT_PLAYBOOK.md       # 法律與 SOP（模板化）
    prd/
      PRD_TEMPLATE.md
    adr/
      0001-adr-template.md
  assets/
    candidates/
      eval/
      tool/
      template/
      playbook/
      workflow/
  scripts/
    bootstrap.sh              # optional
  .github/
    workflows/
      ci.yml                  # 只是入口，實際呼叫 aaa-actions
```

### 3.3 `aaa-actions` 目錄（Reusable Workflows：以 tag 引用）
```
aaa-actions/
  README.md
  .github/
    workflows/
      lint.yml
      test.yml
      eval.yml
      release.yml
  actions/                    # composite actions（可選）
    setup-aaa-tools/
    run-aaa-evals/
```

### 3.4 `aaa-evals` 目錄
```
aaa-evals/
  README.md
  evals/
    suites/
      *.yml
    cases/
      *.jsonl
    baselines/
      *.json
  runner/
    run_repo_checks.py
    run_smoke.py
    requirements.txt
  ASSET_PROMOTION.md
```

### 3.5 `aaa-tools` 目錄（以 Python 或 Node 皆可）
```
aaa-tools/
  README.md
  aaa/                        # CLI package
  runbooks/
    init/
      INIT_PROJECT.md
      plan.v0.1.json
      output.schema.json
      LOCAL_CODEX_PROCEDURE.md
  specs/
    CLI_CONTRACT.md
    plan.schema.json
  skills/
    common/
    codex/
    agent/
  workflows/
    agent/
```

### 3.6 `aaa-prompts` 目錄（Prompt 資產庫）
```
aaa-prompts/
  README.md
  prompt.schema.json
  prompts/
    example/
      *.json
```

### 3.7 `.agent` 目錄（Consumer Stub）
```
.agent/
  README.md
  sync.sh                 # 或由 aaa-tools 提供的 sync 指令
```

### 3.8 `.codex` 目錄（Consumer Stub）
```
.codex/
  README.md
  custom_commands.py      # 只做 import 或 wrapper
```

---

## 4) Consume（資產帶入新專案）流程
> 你第 6 點的第一個未知：新專案怎麼用 AAA 資產？  
> 這裡給你「三層接法」：CI → Tools → Evals。

### 4.1 Consume Step 1：用模板生成新 repo（Copy）
1. 在新專案 org（例如 `lotto-ai-agent`）建立 repo：
   - `laa-docs` / `laa-frontend` / ...
2. 使用 `aaa-tpl-repo` 作為 template：
   - GitHub：Use this template → 建立新 repo
3. 生成後，立即做第一次 commit（把專案名、描述、owner 改掉）
4. 依照模板填入變數：
   - `docs/AI_COMMAND_CENTER.md`
   - `docs/PROJECT_PLAYBOOK.md`
   - `.ai-context.md`（或 `.cursorrules`）內必須指向上述兩份文件

### 4.1.1 AI Context Activation（必做）
在 `aaa-tpl-repo` 根目錄放置 `.ai-context.md`（或 `.cursorrules`），強制 AI 在工作前先閱讀：
- `docs/AI_COMMAND_CENTER.md`
- `docs/PROJECT_PLAYBOOK.md`

**`.ai-context.md` 範例：**
```markdown
# AI Context Configuration
> This file instructs AI agents on how to behave within this project.
> Currently primary tools: Codex CLI / Antigravity.

## 1. Mandatory Knowledge Loading
Before any plan/code, read:
- `docs/AI_COMMAND_CENTER.md`
- `docs/PROJECT_PLAYBOOK.md`

## 2. Agent Behavior Profile
### Mode: ARCHITECT (Planning Phase)
- Focus: High-level design, schema definitions, cross-repo consistency.
- Output: `plan.md`, ADRs.
- Constraint: Do NOT write implementation code until the plan is approved.

### Mode: BUILDER (Implementation Phase)
- Focus: Implementation and tests.
- Constraint: Follow Contract-first + Mock-first.
- Security: Do not touch `assets/` unless instructed.

## 3. Asset Lifecycle (Feedback Loop)
If you generate a reusable prompt/tool, save it to `assets/candidates/` and notify the user for upstreaming.
```

### 4.1.2 Skills Consume（必做）
`aaa-tools` 是 Skills 的 Source of Truth。新專案只保留 `.agent` / `.codex` 的 Consumer stub：
- **安裝法（推薦）**：安裝 `aaa-tools`，用 `aaa sync skills --target=codex` / `--target=agent` 同步。
- **引用法（可選）**：在 `.codex/custom_commands.py` 內只做 import/wrapper，核心邏輯仍由 `aaa-tools` 提供。

### 4.2 Consume Step 2：引用 `aaa-actions`（Reference, 可升級）
在新 repo 放一個 `.github/workflows/ci.yml`，內容改為呼叫 `aaa-actions` 的 workflow，例如：

- `uses: ai-asset-architecture/aaa-actions/.github/workflows/lint.yml@v0.1.0`
- `uses: ai-asset-architecture/aaa-actions/.github/workflows/eval.yml@v0.1.0`

> 版本固定使用 tag（如 `v0.1.0`），避免 main 變動導致 CI 不可控。

### 4.3 Consume Step 3：安裝 `aaa-tools`（Reference, 可升級）
在新 repo 的 CI / 本地開發環境：
- `pip install aaa-tools==0.1.0` 或 `npm i @aaa/tools@0.1.0`
- 用它來跑：
  - `aaa lint docs`
  - `aaa eval run core/docs-quality`

### 4.4 Consume Step 4：接上 `aaa-prompts`（Reference, 可升級）
- 透過 `aaa-tools` 拉取已驗證 Prompt：`aaa pull prompt:<name>@<version>`
- 建議在專案內固定使用的 Prompt 以 tag 版本鎖定，避免不預期變動

### 4.5 Consume Step 5：接上 `aaa-evals`（Reference）
兩種模式：
- **模式 A（推薦）**：CI 直接從 `aaa-evals` 拉對應版本（tag）跑
- **模式 B**：用 submodule 指向 `aaa-evals` 的特定 commit（專案 repo 可檢視/固定版本）
  - 預設使用模式 A；只有需要離線/可審計固定版本時才用模式 B，並由 repo maintainer 負責更新 submodule 指標

### 4.5 `aaa-evals` 引用策略（落地建議）
- **方案 A（推薦，資料量小）**：以套件發佈（例如 `pip install aaa-evals==0.1.0` 或 `npm i @aaa/evals@0.1.0`），版本控管直覺、對開發者友善
- **方案 B（資料量大）**：保留 submodule，但由 `aaa-tools` 提供 `aaa sync evals` 指令，避免人手操作的錯誤

### 4.6 Prompt 資產歸宿與格式（獨立 repo + tools 介面）
- **概念比喻**：Prompt 是「手搖飲料店的配方卡」。AI 可幫你試配方，但定案後要存成「可重複使用的卡」。
- **歸宿**：已驗證的 Prompt 收錄到 `aaa-prompts`；臨時或專案專用 Prompt 先留在專案內。
- **格式**：建議 `prompt.md`（含用途/輸入/輸出/範例/限制）或 `prompt.yaml`（含參數與模板）。
- **介面**：由 `aaa-tools` 提供 `aaa pull prompt:<name>@<version>`，確保跨專案一致。

---

## 5) Feedback（回流資產）流程：Asset Promotion Pipeline
> 你第 6 點的第二個未知：新資產怎麼回饋到 AAA？  
> 下面是可執行的「四階段晉升」，搭配 PR 模板與 checklist 落地。

### 5.1 Pipeline 四階段
#### Phase 1 — Candidate（候選）
在「新專案 repo」先落地跑起來：
- 放置路徑：`./assets/candidates/<type>/<name>/...`
- 必備：一頁說明（用途、輸入輸出、範例、限制）

候選類型（type）建議：
- `eval/`：新測試集、資料集、指標
- `template/`：PRD 模板、ADR 模板、設計文件模板
- `tool/`：腳本、CLI 子命令、檢查器
- `playbook/`：SOP 劇本、流程卡
- `workflow/`：CI、可重用 workflow、composite action
- `skill/`：toolchain-bound skills（回流到 `aaa-tools`）

#### Phase 2 — Hardening（硬化）
把候選資產「去專案化」：
- 移除硬編碼（路徑、專案名、私有 token）
- 加上最小測試或驗證方式
- 加上版本與相容性聲明

#### Phase 3 — Upstream PR（回流）
向 AAA org 的對應資產 repo 提 PR：
- eval → `aaa-evals`
- tool → `aaa-tools`
- CI/workflow → `aaa-actions`
- docs template / governance → `.github` 或 `aaa-tpl-repo`
- toolchain-bound skills → `aaa-tools`

#### Phase 4 — Adoption（採用/升級）
- 合併後打 tag（`vX.Y.Z`）
- 新專案更新引用版本（逐步升級）
- 形成「越用越好」的複利循環

### 5.2 回流目的地對照表
| 資產類型 | 回流 Repo |
|---|---|
| eval / dataset / baseline | `aaa-evals` |
| workflow / CI | `aaa-actions` |
| lint / scaffold / eval runner | `aaa-tools` |
| prompt assets | `aaa-prompts` |
| org governance templates | `.github` |
| repo bootstrap skeleton | `aaa-tpl-repo` |
| docs/prd/adr templates（repo skeleton 一部分） | `aaa-tpl-repo` |
| docs/prd/adr templates（org-level governance） | `.github` |
| toolchain-bound skills | `aaa-tools` |

### 5.3 Asset Scout（可選自動化）
- 在 `aaa-actions` 新增「Asset Scout」workflow（週期性掃描 `assets/candidates/`）
- 若候選資產長期穩定未變動，自動建立 Issue 提醒 Architect 進行提煉或回流

---

## 6) .github PR 模板與 Checklist（直接可貼）
> 放置位置：`.github/.github/PULL_REQUEST_TEMPLATE/asset_promotion.md`  
> 用途：所有「資產回流」PR 必須使用此模板。

### 6.1 `asset_promotion.md`
```md
---
name: Asset Promotion
about: Promote a candidate asset into the AAA org asset repositories
---

## 1. Asset Summary
- **Asset Type**: (eval / tool / template / playbook / workflow / skill)
- **Target Repo**: (aaa-evals / aaa-tools / aaa-actions / .github / aaa-tpl-repo)
- **Asset Name**:
- **Origin Project Repo**:
- **Origin Path**: `assets/candidates/...`

## 2. Problem / Why
- What problem does this asset solve?
- Why should this be shared across projects (not project-specific)?

## 3. Scope & Interface
- **Inputs**:
- **Outputs**:
- **Usage Example**:
- **Non-goals**:
- **Dependencies** (runtime / env / permissions):

## 4. Hardening Checklist (Must)
- [ ] Removed project-specific hardcoding (paths, org, tokens)
- [ ] Added minimal documentation (README or usage section)
- [ ] Added validation method (tests, dry-run, or sample run)
- [ ] Added versioning notes / compatibility notes

## 5. Quality Gates (Pick applicable)
### For Evals
- [ ] Spec defined (`eval.spec.json` or equivalent)
- [ ] Dataset versioned and documented
- [ ] Baseline results provided (or rationale why not)
- [ ] Metrics/scoring documented

### For Tools
- [ ] CLI/API interface documented
- [ ] Error handling / exit codes defined
- [ ] Minimal tests included
- [ ] CI workflow updated to run tests

### For Templates / Playbooks
- [ ] Template has clear audience and usage context
- [ ] Placeholder sections are complete (no missing TODO critical parts)
- [ ] Example output included (optional but preferred)

### For Workflows
- [ ] Workflow is reusable (`workflow_call`) where applicable
- [ ] Inputs/outputs documented
- [ ] Version pinning strategy confirmed (tags)

## 6. Backward Compatibility / Breaking Changes
- [ ] No breaking change
- [ ] Breaking change (explain and provide migration notes)

## 7. Evidence (Required)
- Links to:
  - Successful run logs / screenshots
  - Example outputs
  - Benchmark comparison (if relevant)

## 8. Rollout Plan
- Which projects should adopt this asset first?
- Suggested adoption order:
  1)
  2)
  3)

---
```

## 7) 回流審查 Checklist（給 reviewer）
> 放置位置：`.github/.github/PULL_REQUEST_TEMPLATE/default.md` 或 `docs/GOVERNANCE.md`  
> 建議簡短但硬。

### 7.1 Reviewer Checklist（可貼到 default PR template 末尾）
- [ ] 這個資產「可跨專案重用」的理由清楚且合理
- [ ] 已完成去專案化（無硬編碼、無私密資訊）
- [ ] 有最小可驗證方法（跑得起來）
- [ ] 文件足夠讓下一個專案在 15 分鐘內用起來
- [ ] 有版本/相容性說明（或至少不破壞現有使用者）
- [ ] 若是 eval：有 spec + dataset + baseline/metrics
- [ ] 若是 tool：有介面 + 退出碼/錯誤處理 + 最小測試
- [ ] 若是 workflow：可重用 + 文件化 inputs + tag pin

---

## 8) 新專案 Repo 的「資產候選區」規範（建議寫進模板）
> 放在 `aaa-tpl-repo/README.md` 或 `docs/`，讓每個新專案一開始就具備回流能力。

### 8.1 建議路徑
```
assets/
  candidates/
    eval/
    tool/
    template/
    playbook/
    workflow/
```

### 8.2 Candidate 必備檔（最小）
每個 candidate folder 至少包含：
- `README.md`（用途、使用方式、限制、範例輸入輸出）
- 相關檔案（spec/dataset/script/template）

---

## 9) 版本化策略（確保「越來越好」而不是「越來越亂」）
### 9.1 Tag / Release（強制）
- `aaa-actions`：workflow 引用必須 pin tag，例如 `@v0.1.0`
- `aaa-tools`：套件版號（semver），CI 安裝固定版
- `aaa-evals`：eval spec/dataset 版號 + baseline 版號（可同 tag）

**硬規則**
- 消費端（新專案）禁止引用 `@main`；一律使用 tag（例如 `@v0.1.0`）。
- 任何會被外部 repo 引用的變更，merge 後必須在 24 小時內發布對應 tag（依 semver 決定 patch/minor/major）。

**Deprecation**
- 資產若要移除，需先標記為 `Deprecated`，並保留至少一個 Minor Version 的過渡期

### 9.2 Breaking Changes（最小規則）
- breaking 必須：
  - bump major
  - 提供 migration notes
  - 提供至少一個 adoption demo PR（對一個示範專案）

---

## 10) 你現在可以立刻開工的「第一階段任務清單」
> 目的：用最小成本把第 6 點落地（consume + feedback 能跑通）

1. 建 repo：`.github`，放入 PR 模板與 checklist（本文件的第 6-7 節）
2. 建 repo：`aaa-tools`（先空殼 + CLI stub）
3. 建 repo：`aaa-evals`（先空殼 + spec/schema）
4. 建 repo：`aaa-prompts`（先空殼 + prompt schema / README）
5. 建 repo：`aaa-tpl-repo`，內含：
   - `assets/candidates/...` 路徑
   - `.github/workflows/ci.yml` 入口呼叫 `aaa-actions`
   - `docs/AI_COMMAND_CENTER.md` + `docs/PROJECT_PLAYBOOK.md`
   - `.ai-context.md`（或 `.cursorrules`）指向上述兩份文件
6. 建 repo：`aaa-actions`，先提供 1 個 workflow：
   - `lint.yml`：檢查 README/Docs 結構（先簡單）

完成後你就會得到：
- 新專案可以「用模板生成」
- 新專案可以「引用中央 CI」
- 新專案可以「產生 candidates」
- candidates 可以「用 PR 模板回流」
- 回流資產可以「tag + 被其他專案引用」

---

## Appendix A：Repo Naming 規則（避免撞名）
- AAAO（本 org）內的「模板 repo」一律：`aaa-tpl-*`
- 其他 org（新專案 org）實際 repo：`<orgAlias>-docs`、`<orgAlias>-service-*`、`<orgAlias>-frontend`...

例：
- `ai-asset-architecture/aaa-tpl-repo`（模板）
- `lotto-ai-agent/laa-docs`（新專案實作）

---

## Appendix B：你要的 6 點如何被滿足（快速對照）
1) 可重用資產庫：`aaa-evals` / `aaa-tools` / `aaa-actions`
2) 資產可演進：Reference + Tag + 回流 pipeline
3) `.github` 作模板：`.github` 做治理模板與 PR/Issue 模板
4) `.agent` `.codex`：不做獨立 repo，整合到 `aaa-tools`
5) 新專案 repo 不撞名：模板用 `aaa-tpl-*`，新專案用 `<orgAlias>-*`
6) Consume/Feedback 落地：第 4 節 + 第 5~7 節（含 PR 模板與 checklist）

---

## Appendix C：Asset Scout Workflow（YAML 骨架）
> 建議路徑：`aaa-actions/.github/workflows/asset-scout.yml`
```yaml
name: Asset Scout
on:
  schedule:
    - cron: "0 3 * * 1" # weekly Monday 03:00 UTC
  workflow_dispatch:

jobs:
  scan-candidates:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Find candidate assets
        id: scan
        run: |
          # Find candidates not touched in 30+ days
          CANDIDATES=$(git ls-files 'assets/candidates/**' | xargs -I{} bash -lc \"git log -1 --format='%ct {}' {}\" | awk -v now=$(date +%s) '$1 < (now - 2592000) {print $2}')
          echo \"candidates=$CANDIDATES\" >> $GITHUB_OUTPUT

      - name: Create issue if candidates are stale
        if: steps.scan.outputs.candidates != ''
        uses: actions/github-script@v7
        with:
          script: |
            const candidates = `${{ steps.scan.outputs.candidates }}`.split(' ').filter(Boolean)
            const body = [
              '以下候選資產已超過 30 天未更新，可能可進入 Hardening / Upstream PR：',
              '',
              ...candidates.map(c => `- ${c}`),
              '',
              '請評估是否需要提煉並回流到 AAA 資產庫。'
            ].join('\\n')
            await github.rest.issues.create({
              owner: context.repo.owner,
              repo: context.repo.repo,
              title: 'Asset Scout: candidates ready for promotion',
              body
            })
```

---

## v0.1 執行令（Execution Order）
這是一份給開局者的執行令（Execution Order）  
v0.1 初始化清單（收斂版）

### 0) 原則（先記住三句話）
- Docs SSOT：所有決策文件只在 `*-docs`
- Workflow SSOT：所有 reusable workflows 只在 `aaa-actions`
- Skills SSOT：所有技能/工具只在 `aaa-tools`

### 1) v0.1 Repo List（一次建齊）
必備（先做）  
- `.github`（org-level 治理入口）  
- `aaa-actions`（reusable workflows）  
- `aaa-tpl-docs`（Docs SSOT 模板）  
- `aaa-tpl-service`（通用後端/工具模板）  
- `aaa-tpl-frontend`（通用前端模板）  
- `aaa-tools`（CLI + skills source of truth）  
- `aaa-evals`（eval spec + baseline）  
- `aaa-prompts`（prompt 資產庫）

可後補（v0.2）  
- `aaa-observability`（若要統一觀測治理）  
- `aaa-examples`（示範專案）

### 2) 每個 Repo 的 README 必備章節（最小必備）
通用章節（所有 repo 都要）  
- Purpose / Scope  
- Ownership / CODEOWNERS  
- Versioning / Release  
- How to Consume / Use  
- Contribution / Promotion Rules

專用章節（針對 repo）  
- `.github`  
  - Governance Assets List  
  - What NOT to put here (no workflows)  
- `aaa-actions`  
  - Available Workflows  
  - Usage (with tag)  
  - Release Gate & Tag Policy  
- `aaa-tools`  
  - CLI Commands (version / sync / lint / eval)  
  - Skills Source of Truth  
  - Install & Update  
- `aaa-evals`  
  - Eval Suites  
  - Dataset & Baselines  
  - How to Run  
- `aaa-prompts`  
  - Prompt Schema  
  - Validation Requirements  
  - How to Pull via `aaa-tools`  
- `aaa-tpl-docs`  
  - Docs SSOT Rules  
  - Required Files (ACC / PP / PRD / ADR)  
  - `.ai-context.md` usage  
- `aaa-tpl-service` / `aaa-tpl-frontend`  
  - Repo Scope  
  - Docs Link to `<org>-docs`  
  - CI wiring to `aaa-actions`

### 3) Branch Protection / Teams 建議（v0.1 基線）
Branch Protection（全部 repo）  
- Require PR reviews: 1  
- Require status checks: lint/test/eval（由 `aaa-actions`）  
- Dismiss stale approvals: on  
- Prevent force push: on  
- Require linear history: optional（建議 on）

Teams / Ownership（最小組合）  
- `@aaa/architect`：治理決策與模板  
- `@aaa/platform`：actions/tools/infra  
- `@aaa/qa`：evals 與品質閘門  
- `@aaa/pm`：prompts / docs templates

Repo owner 建議  
- `.github` → architect + platform  
- `aaa-actions` → platform  
- `aaa-tools` → platform + architect  
- `aaa-evals` → qa + architect  
- `aaa-prompts` → pm + architect  
- `aaa-tpl-docs` → architect + pm  
- `aaa-tpl-service` → architect + platform  
- `aaa-tpl-frontend` → architect + platform

### 4) 初始化順序（最小可用）
1) `.github`：PR/Issue 模板 + GOVERNANCE + CODEOWNERS  
2) `aaa-actions`：lint/test/eval/release workflows + tag v0.1.0  
3) `aaa-tpl-docs`：ACC/PP + `.ai-context.md` + PRD/ADR 模板  
4) `aaa-tpl-service`：最小程式碼骨架 + CI 呼叫 `aaa-actions`  
5) `aaa-tpl-frontend`：最小前端骨架 + CI 呼叫 `aaa-actions`  
6) `aaa-tools`：CLI stub（version/sync/lint/eval）  
7) `aaa-evals`：最小 eval suite + baseline  
8) `aaa-prompts`：schema + 範例 prompt

### 5) 交付完成定義（DoD）
- 每個 repo README 含必備章節  
- 每個 repo 有 CODEOWNERS  
- 所有 workflow 使用 tag 引用  
- `aaa-tools` 可執行 `aaa --version` 與 `aaa sync skills --target=codex|agent`  
- `aaa-tpl-docs` 內含 ACC/PP + `.ai-context.md`  
- `aaa-tpl-service` / `aaa-tpl-frontend` 的 `docs/` 只保留指向 `<org>-docs` 的連結

---

## 現況實作（Current State, v0.1）
> 本章節為「現況對照」，用於對齊目前已落地的 repo 與目錄結構。

### Repo 清單（已存在）
- `.github`
- `aaa-actions`
- `aaa-evals`
- `aaa-tools`
- `aaa-prompts`
- `aaa-tpl-docs`
- `aaa-tpl-service`
- `aaa-tpl-frontend`
- `aaa-observability`

### Repo 結構摘要（v0.1）
#### `.github`
- `GOVERNANCE.md`
- `BOOTSTRAP_PROTOCOL.md`
- `CODEOWNERS`
- `README.md`
- `ISSUE_TEMPLATE/`
- `PULL_REQUEST_TEMPLATE.md`
- `SECURITY.md`
- `CONTRIBUTING.md`
- `profile/README.md`

#### `aaa-actions`
- `.github/workflows/`（lint/test/eval/release/asset-promotion）
- `README.md`
- `CODEOWNERS`

#### `aaa-evals`
- `evals/suites/`、`evals/cases/`、`evals/baselines/`
- `runner/run_repo_checks.py`、`runner/run_smoke.py`、`runner/requirements.txt`
- `ASSET_PROMOTION.md`
- `README.md`、`CODEOWNERS`

#### `aaa-tools`
- `aaa/`（CLI）
- `runbooks/init/`（INIT_PROJECT、plan、output schema、LOCAL_CODEX_PROCEDURE）
- `specs/`（CLI_CONTRACT、plan.schema）
- `skills/`（common/codex/agent）
- `workflows/agent/`
- `README.md`、`CODEOWNERS`

#### `aaa-prompts`
- `prompt.schema.json`
- `prompts/`（example）
- `README.md`、`CODEOWNERS`

#### `aaa-tpl-docs`
- `AI_COMMAND_CENTER.md`、`PROJECT_PLAYBOOK.md`、`.ai-context.md`
- `templates/PRD-template.md`、`templates/ADR-template.md`
- `.github/workflows/ci.yml`
- `reports/`、`milestones/`
- `README.md`、`CODEOWNERS`

#### `aaa-tpl-service`
- `src/`、`tests/`、`requirements.txt`
- `docs/README.md`
- `.github/workflows/ci.yml`
- `README.md`、`CODEOWNERS`

#### `aaa-tpl-frontend`
- `public/index.html`
- `docs/README.md`
- `.github/workflows/ci.yml`
- `README.md`、`CODEOWNERS`

#### `aaa-observability`
- `README.md`、`CODEOWNERS`

### 重要實作連結（v0.1）
- Bootstrap protocol SSOT：`.github/BOOTSTRAP_PROTOCOL.md`
- Runbook SSOT：`aaa-tools/runbooks/init/INIT_PROJECT.md`
- Plan：`aaa-tools/runbooks/init/plan.v0.1.json`
- Output schema：`aaa-tools/runbooks/init/output.schema.json`
- CLI contract：`aaa-tools/specs/CLI_CONTRACT.md`
- Plan schema：`aaa-tools/specs/plan.schema.json`

---

## Appendix D：Agentic Bootstrap Protocol（開案自動化）
> 目標：透過 AI Agent（Codex CLI）讀取標準化協定，自動完成 GitHub Repo 建立、變數替換與 Context 注入，實現「一句話開案」。

### 1) 協定檔案位置（SSOT）
- Source：`https://raw.githubusercontent.com/ai-asset-architecture/.github/main/BOOTSTRAP_PROTOCOL.md`
- 內容：定義 `gh repo create` 順序、Template 引用規則與本地 Context 注入流程

### 2) 人類指揮官指令（Prompt）
在本地終端機（需具備 `gh` 與 `codex` 環境）執行：

```bash
codex run -m "請依照這個協定，幫我初始化一個新專案 [PROJECT_NAME] (prefix: [PREFIX]) 於組織 [ORG]：https://raw.githubusercontent.com/ai-asset-architecture/.github/main/BOOTSTRAP_PROTOCOL.md"
```

### 3) Agent 執行流程（SOP）
1. Check：驗證 `gh auth status`
2. Create：依序從 `aaa-tpl-docs` / `aaa-tpl-service` / `aaa-tpl-frontend` 生成新 Repos
3. Hydrate：自動替換模板內的 `{{PROJECT_NAME}}` / `{{PROJECT_PREFIX}}` / `{{GITHUB_ORG}}`
4. Inject：在本地工作區寫入 `.codex/context.md`，將新建立的 Docs Repo 設為 AI 的 Mandatory Knowledge
