# AAA Multi-Repo Workspace Architecture

> **目的**：為 AI Agents 和人類開發者提供清晰的 workspace 架構說明，避免因誤解 multi-repo 結構導致的操作錯誤。  
> **適用對象**：所有 AAA 成員（人類/AI）、新加入的開發者、系統整合者  
> **相關文檔**：[PROJECT_PLAYBOOK.md](../PROJECT_PLAYBOOK.md)、[AI_COMMAND_CENTER.md](../AI_COMMAND_CENTER.md)

---

## 🎯 核心概念

### AAA_WORKSPACE 不是單一 Repository

**關鍵理解**：
- ❌ **錯誤**：AAA_WORKSPACE 是一個大型 mono-repo
- ✅ **正確**：AAA_WORKSPACE 是多個獨立 git repositories 的**工作空間**（collection of repos）

### 每個子目錄 = 一個完整的 Git Repository

```
AAA_WORKSPACE/                          ← 工作空間根目錄（非 git repo）
├── .github/                            ← 獨立 repo #1
│   └── .git/                          → 指向 github.com/ai-asset-architecture/.github
├── aaa-tpl-docs/                       ← 獨立 repo #2
│   └── .git/                          → 指向 github.com/ai-asset-architecture/aaa-tpl-docs
├── aaa-tools/                          ← 獨立 repo #3
│   └── .git/                          → 指向 github.com/ai-asset-architecture/aaa-tools
└── ... (其他 repos)
```

**重點**：
1. 每個目錄都有自己的 `.git/` 目錄
2. 每個 repo 都有獨立的 remote URL
3. 所有 repos **地位平等**（包括 `.github`）
4. **不存在**「主 repo」或「子模組」(submodule) 關係

---

## 📁 Workspace 完整結構

```
AAA_WORKSPACE/                          ← 工作空間根目錄（非 git repo）
│
├── .github/                            ← 組織 Profile Repo
│   ├── .git/                          → github.com/ai-asset-architecture/.github
│   ├── profile/
│   │   └── README.md                  ← GitHub 組織首頁
│   ├── ISSUE_TEMPLATE/                ← Issue 模板
│   ├── PULL_REQUEST_TEMPLATE.md
│   ├── CODEOWNERS
│   └── GOVERNANCE.md
│
├── aaa-tpl-docs/                       ← 文檔 Repo (Template & Internal Docs)
│   ├── .git/                          → github.com/ai-asset-architecture/aaa-tpl-docs
│   ├── README.md
│   ├── AI_COMMAND_CENTER.md           ← AI 協作指南
│   ├── PROJECT_PLAYBOOK.md            ← 專案治理手冊
│   ├── public/                        → 未來抽出成 aaa-docs (PUBLIC)
│   ├── internal/                      → 核心團隊文檔 (PRIVATE)
│   ├── milestones/
│   └── templates/
│
├── aaa-tools/                          ← CLI 工具 Repo
│   ├── .git/                          → github.com/ai-asset-architecture/aaa-tools
│   ├── src/aaa/                       ← Python package
│   ├── runbooks/                      ← Automation scripts
│   ├── specs/                         ← Technical specs
│   └── pyproject.toml
│
├── aaa-actions/                        ← GitHub Actions Repo
│   ├── .git/                          → github.com/ai-asset-architecture/aaa-actions
│   ├── .github/workflows/             ← Nightly governance workflows
│   └── scripts/
│
├── aaa-evals/                          ← Evaluations Repo
│   ├── .git/                          → github.com/ai-asset-architecture/aaa-evals
│   └── evals/                         ← Eval definitions
│
├── aaa-prompts/                        ← Prompts Library Repo
│   ├── .git/                          → github.com/ai-asset-architecture/aaa-prompts
│   └── prompts/
│
├── aaa-observability/                  ← Observability Repo
│   └── .git/
│
├── ai-asset-architecture-registry/     ← Asset Registry Repo
│   └── .git/
│
├── aaa-tpl-frontend/                   ← Frontend Template Repo
│   └── .git/
│
└── aaa-tpl-service/                    ← Service Template Repo
    └── .git/
```

---

## 🔄 Git 操作規則

### ✅ 正確做法

#### 單一 Repo 變更

```bash
# Step 1: 進入特定 repo 目錄
cd /path/to/AAA_WORKSPACE/aaa-tpl-docs

# Step 2: 確認當前 repo
git remote -v
# 輸出應該是：
# origin  https://github.com/ai-asset-architecture/aaa-tpl-docs.git (fetch)
# origin  https://github.com/ai-asset-architecture/aaa-tpl-docs.git (push)

# Step 3: 執行 git 操作
git status
git add .
git commit -m "chore(docs): update workspace architecture"
git push origin main
```

#### 多 Repo 變更

當一次任務涉及多個 repos（例如：路徑重整）：

```bash
# 方案 1：逐個處理（推薦）
cd /path/to/AAA_WORKSPACE

# Repo 1: aaa-tpl-docs
cd aaa-tpl-docs
git add .
git commit -m "chore(arch): restructure for dual-repo preparation"
git push origin main
cd ..

# Repo 2: aaa-tools
cd aaa-tools
git add specs/v0.5-closing-protocol.md
git commit -m "chore(specs): update aaa-tpl-docs path references

Related: aaa-tpl-docs@9a56bb5"
git push origin main
cd ..

# Repo 3: .github
cd .github
git add profile/README.md
git commit -m "chore(profile): update aaa-tpl-docs path references

Related: aaa-tpl-docs@9a56bb5, aaa-tools@7a1cd67"
git push origin main
cd ..
```

### ❌ 錯誤做法

#### 錯誤 1：在 Workspace 根目錄執行 Git

```bash
# ❌ 這會失敗或顯示錯誤的 repo
cd /path/to/AAA_WORKSPACE
git status        # 錯誤！workspace 根目錄不是 git repo
git add .         # 錯誤！
git commit        # 錯誤！
```

#### 錯誤 2：忘記切換到正確的 Repo

```bash
# ❌ 在 aaa-tools/ 目錄下修改 aaa-tpl-docs 的文件
cd /path/to/AAA_WORKSPACE/aaa-tools
git add ../aaa-tpl-docs/README.md   # 錯誤！跨 repo 操作
```

#### 錯誤 3：把 .github 當作配置目錄

```bash
# ❌ 誤解：.github 只是 workspace 配置
# ✅ 真相：.github 是組織 profile repo，需要獨立 commit
```

---

## 📍 路徑引用規則

### 內部引用（同一 repo 內）

使用相對路徑：

```markdown
<!-- 在 aaa-tpl-docs/README.md -->
See [Architecture](../../internal/development/architecture/update_policy.md)
See [Playbook](./PROJECT_PLAYBOOK.md)
```

### 跨 Repo 引用

#### 選項 1：使用 Repo 名稱（本地開發）

```markdown
<!-- 在任何 repo 的文檔中 -->
See `aaa-tools/specs/v0.5-closing-protocol.md`
See `aaa-evals/evals/repo-checks.json`
```

#### 選項 2：使用完整 GitHub URL（推薦 - 發布文檔）

```markdown
<!-- 在 .github/profile/README.md -->
[v1.0 Completion](https://github.com/ai-asset-architecture/aaa-tpl-docs/blob/main/internal/development/milestones/completion-reports/aaa_v1.0_completion_report_20260124.md)
```

**何時使用哪種**：
- **本地/內部文檔**：使用 repo 名稱（簡潔）
- **公開/外部文檔**：使用完整 URL（可點擊）

---

## 🤖 AI Agent 特別注意事項

### 1. 路徑檢查 Protocol（必須執行）

**在執行任何 git 操作前**，必須執行：

```bash
# 檢查 1：確認當前目錄
pwd
# 期望輸出：/path/to/AAA_WORKSPACE/\u003crepo-name\u003e

# 檢查 2：確認當前 repo
git remote -v
# 期望輸出：正確的 repo URL

# 檢查 3：確認 branch
git branch --show-current
# 期望輸出：main (或正確的 branch)
```

### 2. 變更影響分析 Checklist

修改文件時，必須檢查：

- [ ] **內部影響**：同一 repo 內有無其他文件引用此路徑？
- [ ] **跨 repo 影響**：其他 repos 是否引用此路徑？
- [ ] **URL 影響**：GitHub URLs 是否需要更新？
- [ ] **里程碑結案**：若為 vx.y 100% 完成，是否已產出摘要與詳細報告？(見 AI Constitution 2.4)

**範例**：重整 aaa-tpl-docs 路徑時

```
受影響分析：
✓ aaa-tpl-docs/
  - AI_COMMAND_CENTER.md (2處)
  - README.md (1處)
✓ aaa-tools/
  - specs/v0.5-closing-protocol.md (3處)
✓ .github/
  - profile/README.md (10處 URLs)
```

### 3. Multi-Repo Commit 策略

#### Step 1: 確認所有變更的 Repos

```bash
# 列出所有修改
cd /path/to/AAA_WORKSPACE
for repo in aaa-*; do
  cd "$repo" 2>/dev/null || continue
  if [ -d .git ]; then
    echo "=== $repo ==="
    git status --short
  fi
  cd ..
done
```

#### Step 2: 為每個 Repo 創建獨立 Commit

```bash
# Commit message 格式
# Repo 1（被引用的）：不需要 cross-reference
git commit -m "chore(arch): restructure aaa-tpl-docs"

# Repo 2（引用者）：包含 cross-reference
git commit -m "chore(specs): update aaa-tpl-docs path references

Related: aaa-tpl-docs@9a56bb5"
```

#### Step 3: 按依賴順序 Push

```
推薦順序：
1. 被引用的 repo（aaa-tpl-docs）先 push
2. 引用者 repos（aaa-tools, .github）後 push
```

### 4. 常見陷阱 Checklist

#### ❌ 陷阱 1：誤認為 Workspace 是單一 Repo

```bash
# 症狀：在 workspace 根目錄執行 git 命令
cd /path/to/AAA_WORKSPACE
git status  # 這會失敗或顯示錯誤訊息

# 解決：Always cd 到具體的 repo
cd aaa-tpl-docs  # 正確
git status        # 現在可以
```

#### ❌ 陷阱 2：忘記 .github 也是獨立 Repo

```
誤解：.github 只是 workspace 配置目錄
真相：.github 是組織的 profile repository
     - 有自己的 .git/
     - 需要獨立 commit & push
     - 用於組織首頁、templates 等
```

#### ❌ 陷阱 3：跨 Repo 路徑引用過時

```markdown
# ❌ 錯誤：使用重整前的舊路徑
aaa-tpl-docs/reports/milestones/aaa_v1.0_completion_report.md

# ✅ 正確：使用重整後的新路徑
aaa-tpl-docs/internal/development/milestones/completion-reports/aaa_v1.0_completion_report.md
```

**防範措施**：
1. 路徑變更時，執行全 workspace grep 搜尋
2. 檢查 .github/profile/README.md（常有外部 URLs）
3. 檢查 aaa-tools/specs/（常有 cross-repo references）

#### ❌ 陷阱 4：Commit 後忘記 Push

```bash
# 症狀：本地 commit 成功，但 remote 沒更新
git commit -m "..."  # ✓ 成功
# ... 忘記 push，直接切換到下一個 repo

# 檢查方法
git status
# 輸出：Your branch is ahead of 'origin/main' by 1 commit.

# 解決
git push origin main
```

---

## 🎯 Quick Reference Card

| 動作 | 指令 | 注意事項 |
|------|------|---------|
| **檢查當前 repo** | `git remote -v` | 確認你在正確的 repo |
| **檢查當前目錄** | `pwd` | 應該在 `AAA_WORKSPACE/<repo-name>/` |
| **Commit 變更** | `cd <repo> && git commit` | 必須在 repo 目錄內 |
| **Push 變更** | `git push origin main` | Commit 後務必 push |
| **跨 repo 引用** | 使用 repo 名稱前綴 | `aaa-tools/specs/...` |
| **多 repo 變更** | 分別 cd 到各 repo commit | 按依賴順序 push |
| **檢查影響範圍** | `grep -r "old/path" AAA_WORKSPACE/` | 找出所有引用 |

---

## 📚 延伸閱讀

- **治理規則**：[PROJECT_PLAYBOOK.md](../PROJECT_PLAYBOOK.md) - Multi-Repo 治理詳細規則
- **AI 協作**：[AI_COMMAND_CENTER.md](../AI_COMMAND_CENTER.md) - AI Agent 協作指南
- **Bootstrap**：[public/bootstrap/](../public/bootstrap/) - 新專案初始化指南

---

## 💡 FAQ

### Q1: 為什麼不用 Git Submodules？

**A**: Git submodules 增加複雜度，不適合快速迭代：
- Submodule 需要額外的 `git submodule update` 步驟
- 容易出現 detached HEAD 狀態
- 對 AI Agents 和新人不友好

**AAA 方案**：獨立 repos + workspace 約定
- 簡單：每個 repo 是標準 git repo
- 靈活：可以只 clone 需要的 repos
- 清晰：無隱含依賴關係

### Q2: 如何確保跨 Repo 引用不會失效？

**A**: 三層防護：
1. **規範化路徑**：使用 `<repo-name>/<path>` 格式
2. **自動化檢查**：CI 檢查引用的文件是否存在
3. **變更通知**：路徑變更時，執行全 workspace grep 並通知相關 repos

### Q3: .github Repo 的特殊之處？

**A**: `.github` 是 GitHub 組織的特殊 repository：
- **用途**：組織首頁 profile、issue templates、org-level workflows
- **可見性**：通常是 public（因為展示給外部）
- **重要性**：代表組織形象，變更需謹慎

---

## 🏛️ Governance Inheritance (治理繼承)

當您從 AAA 組織繼承或 fork 一個新專案時，**必須**確保治理由此延續：

### 如何繼承里程碑工作流？
1.  **AI 憲法建立**：每個新 repo 在根目錄應具備 `.ai-context.md`。
    - 參考：`aaa-tpl-docs/templates/onboarding/AI-CONSTITUTION-TEMPLATE.md`
2.  **路徑規範對齊**：
    - 計畫放置於 `internal/development/plans/`
    - 審計報告放置於 `internal/development/audits/`
    - 結案詳報放置於 `internal/development/milestones/completion-reports/`
3.  **三步驟循環**：告知您的 AI Agent 必須執行「Initialization → Completion → Asset Preservation」的工作循環。

**意義**：透過治理繼承，即使是獨立的專案開發，其產出的 Evals 與 Prompts 也能夠輕鬆地回流並貢獻至 AAA 全域資產庫中。

---

**Last Updated**: 2026-01-28  
**Version**: 1.1  
**Maintainer**: @aaa/architect
