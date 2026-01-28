# Member Start Checklist (AAA)

## 1. Access & Auth
- [ ] `gh auth status` shows logged in
- [ ] `gh auth setup-git` completed (git uses gh token)
- [ ] Org access confirmed (member can view private repos)
- [ ] Repo creation permission confirmed (or owner will create repos)

## 2. Tooling
- [ ] `git --version`
- [ ] `python3 --version`
- [ ] `aaa --version`

## 3. Plan & Schema
- [ ] Download plan via `gh api` (not curl)
- [ ] Download schema via `gh api`
- [ ] JSON sanity check passed
- [ ] `{{TARGET_ORG}}`, `{{PROJECT_SLUG}}`, `{{AAA_VERSION}}` replaced

## 4. Execution
- [ ] `aaa init validate-plan` passed
- [ ] `aaa init --dry-run` passed
- [ ] `aaa init --mode pr` executed

## 5. Governance Inheritance (繼承治理)
- [ ] 將 `templates/onboarding/AI-CONSTITUTION-TEMPLATE.md` 複製並更名為根目錄的 `.ai-context.md`
- [ ] 檢查 `.ai-context.md` 中的路徑是否符合當前 Repo 結構
- [ ] 向 AI Agent 介紹新專案的行為準則

## 5. Review
- [ ] PRs created
- [ ] CI checks show `lint` / `test` / `eval`
- [ ] Report saved to `$WORKSPACE_DIR/aaa-init-report.json`
