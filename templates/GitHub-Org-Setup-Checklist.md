# GitHub Org Setup Checklist

- [ ] 建立 Org（或確認已存在）
- [ ] 建立必要 repo（.github, aaa-actions, aaa-tools, aaa-evals, aaa-prompts, aaa-tpl-docs, aaa-tpl-service, aaa-tpl-frontend）
- [ ] 確認 `aaa-actions` 已有 tag（例如 v0.1.0）
- [ ] 確認所有 workflow 使用 tag 引用 `aaa-actions`
- [ ] 設定 branch protection（若方案允許）：lint / test / eval
- [ ] 設定 CODEOWNERS 與必要 Teams
- [ ] 跑 `aaa-governance-audit` 或 `aaa-gh-org-audit` 產出報告
