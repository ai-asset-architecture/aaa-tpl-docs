# Start Here Block Template (Org Profile)

Use this block in `.github/profile/README.md` to keep onboarding aligned with SOP and eval checks.

```markdown
### 對成員（Members）— 5 分鐘開案
我們採用「零相依啟動」：**不需要 clone 整個 AAA**，只要安裝 CLI。

**1) 準備環境**
```bash
gh --version
gh auth status
gh auth setup-git
git --version
python3 --version
```

**2) 安裝 AAA 工具**
```bash
python3 -m pip install --upgrade pip
python3 -m pip install "git+https://github.com/ai-asset-architecture/aaa-tools.git@{{AAA_VERSION}}"
aaa --version
```

**3) 下載計畫檔並啟動**
```bash
gh api -H "Accept: application/vnd.github.v3.raw" \
  /repos/ai-asset-architecture/aaa-tools/contents/runbooks/init/plan.v0.1.json?ref={{AAA_VERSION}} \
  > /tmp/aaa_plan_resolved.json
aaa init --plan /tmp/aaa_plan_resolved.json
```

詳細步驟請看：  
https://github.com/ai-asset-architecture/aaa-tpl-docs/blob/main/docs/new-project-sop.md
```
