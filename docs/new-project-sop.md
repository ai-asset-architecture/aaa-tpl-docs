# 新專案初始化 SOP (v0.2) - Member Edition

這份文件引導組織成員從零開始，在本機完成 aaa 架構的專案初始化。
本流程專為 **Private Repo** 與 **Member 權限** 優化，確保你不會卡在驗證或下載錯誤上。

---

## 階段一：準備工作（必做）

### 1) 檢查環境與接管 Git 驗證
確保你的 GitHub CLI 已登入，並設定讓 git 操作自動使用 `gh` 的憑證（這能解決 `pip install` 私有庫時背後的 `git clone` 驗證問題）。

```bash
# 1. 確認已登入 GitHub
gh auth status

# 2. 【關鍵】讓 git 自動使用 gh 憑證
gh auth setup-git
```

---

### 2) 安裝 AAA 工具（CLI）

直接從 GitHub 安裝指定版本工具（注意：這行不可被 Markdown 變成連結語法）。

```bash
python3 -m pip install "git+https://github.com/ai-asset-architecture/aaa-tools.git@v0.1.0"

# 確認安裝成功
aaa --version
```

---

### 3) 下載計畫檔與 Schema（Private Repo 用 gh api，不用 curl）

因為是私有 Repo，`raw.githubusercontent.com` 可能會下載到「404 假檔」，必須用 `gh api`。

```bash
# 下載 Plan（你的執行計畫）
gh api -H "Accept: application/vnd.github.v3.raw" \
  /repos/ai-asset-architecture/aaa-tools/contents/runbooks/init/plan.v0.1.json?ref=v0.1.0 \
  > /tmp/aaa_plan_resolved.json

# 下載 Schema（驗證規則）
gh api -H "Accept: application/vnd.github.v3.raw" \
  /repos/ai-asset-architecture/aaa-tools/contents/specs/plan.schema.json?ref=v0.1.0 \
  > /tmp/aaa_plan_schema.json
```

---

### 4) 立刻做 JSON 檢查（Sanity Check）

避免下載到「404 Not Found」或 HTML 內容假裝成 JSON。請同時檢查 **plan + schema**：

```bash
python3 - <<'PY'
import json, sys
paths = ["/tmp/aaa_plan_resolved.json", "/tmp/aaa_plan_schema.json"]
for p in paths:
    try:
        json.load(open(p))
        print(f"✅ JSON OK: {p}")
    except Exception as e:
        print(f"❌ JSON ERROR: {p} -> {e}")
        print("請檢查：GitHub Token 權限 / SSO 授權 / URL ref 是否正確")
        sys.exit(1)
PY
```

---

## 階段二：編輯與執行

### 5) 修改計畫變數（替換三個變數）

使用編輯器打開 `/tmp/aaa_plan_resolved.json`，替換以下變數：

* `{{TARGET_ORG}}`：你的 GitHub Organization 名稱
* `{{PROJECT_SLUG}}`：專案代號（例如 `lotto`）
* `{{AAA_VERSION}}`：工具版本（例如 `v0.1.0`）

> 建議使用 VS Code 編輯，避免破壞 JSON 格式。

**改完後，立刻做「未替換變數」檢查（Fail-fast）：**

```bash
grep -n "{{" /tmp/aaa_plan_resolved.json && echo "❌ ERROR: 仍有未替換變數（{{...}}），請先完成替換" && exit 1 || true
```

---

### 6) 設定工作目錄（新專案 repo 的家）

請先決定你的專案代號（與 plan 的 `{{PROJECT_SLUG}}` 一致），再設定工作目錄：

```bash
export PROJECT_SLUG="<PROJECT_SLUG>"
export WORKSPACE_DIR="$HOME/Projects/${PROJECT_SLUG}_WORKSPACE"
mkdir -p "$WORKSPACE_DIR" && cd "$WORKSPACE_DIR"
```

---

### 7) 驗證與預演（Dry-run）

正式動手前，先驗證 plan 是否合規，並跑一次空轉測試（不會修改 GitHub）。

```bash
# 1) 驗證格式（Fail-fast）
aaa init validate-plan \
  --plan /tmp/aaa_plan_resolved.json \
  --schema /tmp/aaa_plan_schema.json

# 2) Dry-run（不改 GitHub）
aaa init --plan /tmp/aaa_plan_resolved.json --dry-run --jsonl
```

---

### 8) 選擇模式（必選一條路）

你可以選擇「交給 Codex」或「自己完成」：

#### 模式 A：人類準備 + Codex 執行
把下面這段話丟給 Codex CLI：

```
我已經準備好 /tmp/aaa_plan_resolved.json。
WORKSPACE_DIR 是：$WORKSPACE_DIR
請讀取 aaa-tools/runbooks/init/AGENT_BOOTSTRAP.md，
依照內容完成專案初始化，最後輸出 JSON 報告。
```

#### 模式 B：人類自己完成（工程師模式）
預演成功後再執行正式初始化。建議 `--mode pr`（建立 Pull Request）以便審核。

```bash
aaa init --plan /tmp/aaa_plan_resolved.json --mode pr --jsonl
```

---

## 常見問題排除（Troubleshooting）

### Q1：執行 `aaa init` 出現 `403 Forbidden`？

**原因**：你可能沒有在 Organization 內建立 Repository 的權限。
**解法**（二選一）：

1. 請 Org Owner 在 `Settings > Member privileges` 開啟「Repository creation」。
2. 或請 Owner 先手動建立好目標 repos（例如 `xxx-docs`, `xxx-service`），再由你執行 `aaa init`（工具應能偵測 repo 已存在並繼續後續設定）。

---

### Q2：`pip install` 失敗（Authentication failed / Username prompt）？

**解法**：請務必先做 **Step 1**：

```bash
gh auth setup-git
```

若仍失敗，請重新登入並確認權限/授權狀態：

```bash
gh auth status
```

---

*文件版本：v0.2*
