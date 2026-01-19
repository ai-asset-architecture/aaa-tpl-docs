# 新專案初始化 SOP（v0.1）

以下流程以 **終端機為主**，不需要先開瀏覽器。若有需要 GitHub 授權，會由 `gh auth login` 觸發瀏覽器登入。

## 1) 本機工具檢查
確認必要工具可用：

```bash
gh auth status
git --version
aaa --version
```

若 `gh auth status` 失敗，先執行：

```bash
gh auth login
```

## 2) 設定工作區路徑
選擇本機放置新專案的根目錄：

```bash
export WORKSPACE_DIR=/path/to/projects/<PREFIX>_WORKSPACE
mkdir -p "$WORKSPACE_DIR"
```

## 3) 準備 plan（替換變數）
從 `aaa-tools/runbooks/init/plan.v0.1.json` 產生可執行版本：

```bash
cp /path/to/aaa-tools/runbooks/init/plan.v0.1.json /tmp/aaa_plan_resolved.json
# 手動替換 {{TARGET_ORG}}, {{PROJECT_SLUG}}, {{AAA_VERSION}}
```

## 4) 驗證 plan（fail-fast）

```bash
aaa init validate-plan --plan /tmp/aaa_plan_resolved.json --schema /path/to/aaa-tools/specs/plan.schema.json
```

## 5) Dry-run 預演（不改 repo）

```bash
WORKSPACE_DIR="$WORKSPACE_DIR" \
  aaa init --plan /tmp/aaa_plan_resolved.json --dry-run --jsonl
```

## 6) 正式執行（建立 repo/分支/PR）

```bash
WORKSPACE_DIR="$WORKSPACE_DIR" \
  aaa init --plan /tmp/aaa_plan_resolved.json --mode pr --jsonl
```

## 7) 產出報告與稽核
執行後會產生報告：

```
$WORKSPACE_DIR/aaa-init-report.json
```

確認報告符合 `output.schema.json`，並檢查 summary/steps。

## 8) 人工審查與合併
- 到 GitHub 上檢查新開的 PR
- 確認 CI（lint/test/eval）結果
- 由授權人員完成 merge

---

## 參考文件
- `aaa-tools/runbooks/init/INIT_PROJECT_CODEX.md`
- `aaa-tools/runbooks/init/INIT_PROJECT_HUMAN.md`
- `aaa-tools/specs/CLI_CONTRACT.md`
- `aaa-tools/runbooks/init/output.schema.json`
