# GitHub CLI 安裝與登入（gh）

這份文件提供團隊成員在本機完成 GitHub CLI（`gh`）設定的最小流程。

## 步驟 1：安裝 GitHub CLI（gh）
macOS（Homebrew）：

```bash
brew install gh
```

## 步驟 2：登入 GitHub（瀏覽器授權）

```bash
gh auth login
```

依序選：
1. GitHub.com
2. HTTPS
3. Login with a web browser
4. 依畫面指示開啟網址 → 貼上一次性碼 → 完成授權

## 步驟 3：確認登入成功

```bash
gh auth status
```

看到 `Logged in to github.com as <你的帳號>` 就代表成功。

## 步驟 4：設定 Git 使用者資訊

```bash
git config --global user.name "你的名字"
git config --global user.email "你的信箱"
```

## 步驟 5：驗證 repo 操作權限

```bash
gh repo list ai-asset-architecture
```

## 步驟 6：常用檢查命令

```bash
gh repo view ai-asset-architecture/aaa-tools
gh pr list --repo ai-asset-architecture/aaa-tools
gh issue list --repo ai-asset-architecture/aaa-tools
```
