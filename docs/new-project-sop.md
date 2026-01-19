# 新專案初始化 SOP（v0.1）

這份 SOP 用「國中生也看得懂」的方式，一步一步教你做完新專案初始化。

## 先搞懂：兩種模式
這份 SOP 前半段（第 1–5 步）是「所有人都要做的準備」。  
第 6 步開始分成兩條路：**給 Codex 做** 或 **自己做**。

- **Codex 需要讀的文件**：`aaa-tools/runbooks/init/AGENT_BOOTSTRAP.md`
- **人類只需要看這一份 SOP**：就是 `new-project-sop.md`

---

## 1) 先確認你的電腦有沒有工具
打開終端機，確認三件事：

```bash
gh auth status
gh auth setup-git
git --version
python3 --version
```

你要看到：
- `gh auth status` 顯示已登入
- `git` 有版本
- `python3` 有版本

`gh auth setup-git` 會讓 `pip install` 背後的 git clone 能通過 private repo 權限。

如果 `gh auth status` 失敗，先登入：

```bash
gh auth login
```

若遇到 `403/404`，請檢查：
- 是否需要對該 org 完成 SSO 授權
- token scopes 是否不足（必要時重新 `gh auth login`）
- 是否有在 org 建 repo 的權限（member 可能預設被關閉）

---

## 2) 安裝 AAA 工具（不需要 clone AAA）
新手不要 clone 整個 AAA repo，直接安裝工具就好：

```bash
python3 -m pip install --upgrade pip
python3 -m pip install "git+https://github.com/ai-asset-architecture/aaa-tools.git@v0.1.0"
```

安裝完成後，確認指令可用：

```bash
aaa --version
```

---

## 3) 下載計畫檔與 schema（只下載必要檔案）

```bash
gh api -H "Accept: application/vnd.github.v3.raw" \
  /repos/ai-asset-architecture/aaa-tools/contents/runbooks/init/plan.v0.1.json?ref=v0.1.0 \
  > /tmp/aaa_plan_resolved.json

gh api -H "Accept: application/vnd.github.v3.raw" \
  /repos/ai-asset-architecture/aaa-tools/contents/specs/plan.schema.json?ref=v0.1.0 \
  > /tmp/aaa_plan_schema.json
```

（注意：若 `v0.1.0` 尚未發布，請暫時把 URL 中的 tag 改成 `main` 以便測試。）  

下載後請先做一次 JSON 檢查，避免抓到 404 假檔：

```bash
python3 - <<'PY'
import json
json.load(open("/tmp/aaa_plan_resolved.json"))
print("OK: plan")
PY
```

---

## 4) 修改 plan（替換三個變數）
打開 `/tmp/aaa_plan_resolved.json`，手動替換三個變數：
- `{{TARGET_ORG}}` → 你的 GitHub org 名稱
- `{{PROJECT_SLUG}}` → 專案代號（kebab-case）
- `{{AAA_VERSION}}` → 例如 `v0.1.0`

小撇步：請用 VS Code 或純文字編輯器，不要用 Word，以免破壞 JSON 格式。  

---

## 5) 驗證 plan（先檢查再執行）

```bash
aaa init validate-plan \
  --plan /tmp/aaa_plan_resolved.json \
  --schema /tmp/aaa_plan_schema.json
```

如果有錯誤，先修正 plan 再繼續。

---

## 6) 選擇你要的模式

### 模式 A：讓 Codex 幫你做（推薦給新手）
你只要把這段話丟給 Codex CLI：  

```
我已經準備好 /tmp/aaa_plan_resolved.json。
請讀取 aaa-tools/runbooks/init/AGENT_BOOTSTRAP.md，
並依照內容完成專案初始化，最後輸出 JSON 報告。
```

如果 Codex 有問你路徑，就回答你的 `WORKSPACE_DIR`。

---

### 模式 B：自己動手做（工程師模式）
下面開始是純人工流程。

## 6.1) 設定新專案的本機資料夾
這是新專案 repo 會放的地方（先建立資料夾，再切換進去）： 

```bash
export WORKSPACE_DIR="$HOME/Projects/<PREFIX>_WORKSPACE"
mkdir -p "$WORKSPACE_DIR"
cd "$WORKSPACE_DIR"
```

說明：
- `<PREFIX>` 是你的專案代號，例如 `lotto`。
- `WORKSPACE_DIR` 就是「新專案的家」。

不知道路徑怎麼寫？可以這樣做：
1) 在 Finder 建一個資料夾
2) 打開終端機，輸入 `export WORKSPACE_DIR=`
3) 把資料夾拖進終端機，就會自動出現完整路徑

---

## 6.2) Dry-run 預演（不會改 repo）
這一步只跑流程，不會真的動 GitHub。

```bash
aaa init --plan /tmp/aaa_plan_resolved.json --dry-run --jsonl
```

看到 `status: completed` 就代表預演成功。

---

## 6.3) 正式執行（建立 repo/分支/PR）
預演成功後再跑正式版：

```bash
aaa init --plan /tmp/aaa_plan_resolved.json --mode pr --jsonl
```

執行後會產生報告：

```
$WORKSPACE_DIR/aaa-init-report.json
```

最後請到 GitHub：
- 檢查新開的 PR
- 確認 CI（lint/test/eval）結果
- 由授權人員完成 merge

---

## 參考文件
- `aaa-tools/runbooks/init/AGENT_BOOTSTRAP.md`
- `aaa-tools/specs/CLI_CONTRACT.md`
- `aaa-tools/runbooks/init/output.schema.json`
