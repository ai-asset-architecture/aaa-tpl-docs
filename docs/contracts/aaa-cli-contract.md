# AAA CLI 使用者合約 (User Contract v0.8)

這份文件是給「人」看的 CLI 合約，定義使用者在 AAA 專案初始化時必須遵守的指令與順序。
技術規格的唯一真相請見：`aaa-tools/specs/CLI_CONTRACT.md`。

---

## 目的與範圍
- 目的：避免 SOP 與 CLI 行為漂移，確保 onboarding 可重複且可稽核。
- 範圍：涵蓋安裝、計畫檔/Schema 下載、plan 驗證、初始化、post-init 稽核。

---

## 必要步驟 (不可省略)

### 1) 安裝 CLI（固定版本）
必須使用 tag 版本安裝：

```bash
python3 -m pip install "git+https://github.com/ai-asset-architecture/aaa-tools.git@v0.8.0"
```

### 2) 下載 Plan 與 Schema（私有 repo 必須用 gh api）

```bash
gh api -H "Accept: application/vnd.github.v3.raw" \
  /repos/ai-asset-architecture/aaa-tools/contents/runbooks/init/plan.v0.7.json?ref=v0.8.0 \
  > /tmp/aaa_plan_resolved.json

gh api -H "Accept: application/vnd.github.v3.raw" \
  /repos/ai-asset-architecture/aaa-tools/contents/specs/plan.schema.json?ref=v0.8.0 \
  > /tmp/aaa_plan_schema.json
```

### 3) 驗證 Plan（Fail-fast）

```bash
aaa init validate-plan \
  --plan /tmp/aaa_plan_resolved.json \
  --schema /tmp/aaa_plan_schema.json
```

### 4) 初始化（執行或 PR 模式）

```bash
aaa init --plan /tmp/aaa_plan_resolved.json --mode pr --jsonl
```

### 5) Post-init 稽核（必做）
初始化完成後必須跑 repo 檢查，確認治理對齊：

```bash
aaa init repo-checks \
  --org <TARGET_ORG> \
  --from-plan /tmp/aaa_plan_resolved.json \
  --suite governance \
  --jsonl
```

詳見 runbook：`aaa-tools/runbooks/init/POST_INIT_AUDIT.md`

---

## Gate C：Required Checks 名稱（SSOT）
為避免 required checks 名稱漂移導致 PR 死鎖，SSOT 檔案如下：

- `aaa-actions/checks.manifest.json`

Canonical 名稱如下：

| Check ID | Canonical Name |
| --- | --- |
| lint | `ci/lint / lint` |
| test | `ci/test / test` |
| eval | `ci/eval / eval` |

驗證方式（必跑）：

```bash
aaa init verify-ci \
  --org <TARGET_ORG> \
  --from-plan /tmp/aaa_plan_resolved.json
```

---

## Repo Type Governance（v0.7+）
- `repo_type` 需寫入 repo 根目錄 `.aaa/metadata.json`（由 `aaa init apply-templates` 自動落地）。
- `repo-checks` 以 `repo_type` 判斷是否需要 `skills/` 與 `prompt.schema.json`。

## Pack Marketplace（v0.8）
- 透過 `aaa pack list/install/show` 從 Registry 安裝資產包。
- Registry 入口：`AAA_REGISTRY_URL`
- 安裝路徑：`.aaa/packs/<pack-id>/<version>/`
- 安裝紀錄：`.aaa/packs/installed.json`

---

## 關鍵約束 (Contract Rules)
- SOP、Profile README 與 CLI 合約必須一致。
- Plan 與 Schema 的 tag 必須相同。
- 必須依照 `aaa-tools/runbooks/init/AGENT_BOOTSTRAP.md` 的流程執行。

---

## 版本
- User Contract: v0.8
- Tech Contract: `aaa-tools/specs/CLI_CONTRACT.md`
