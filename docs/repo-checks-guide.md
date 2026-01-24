# Repo Checks 指南（集中入口）

這份文件集中回答「repo-checks / plan / suite」常見問題，避免資訊分散。

## 1) repo-checks 是什麼？什麼時候跑？
`aaa init repo-checks` 是 **post-init 治理檢查**，在專案初始化完成後執行，用來確認新建 repos 是否符合治理規範（例如 README、workflow pinning、orphaned assets 等）。

常見使用情境：
- 使用 AAA 建立新專案後，做一次「收尾驗證」。
- CI/Gate 或管理流程需要治理一致性的證據。

## 2) 為什麼需要 plan 檔？
`repo-checks` 需要知道 **要檢查哪些 repos** 與 **哪些治理規則**。因此必須指定 `--from-plan`。

官方 plan 位置（範例）：
- `aaa-tools/runbooks/init/plan.v0.7.json`

實務上：多數人/AI 直接使用官方 plan；若有客製需求才會拷貝修改。

## 3) suite 是什麼？
`suite` 是「檢查集合」的名稱。對 `aaa init repo-checks` 來說，常用是 `governance`（治理檢查集合）。

suite 定義來源：
- `aaa-evals/evals/suites/*.yml`
- 簡介彙總：`aaa-evals/README.md`

### 常用治理相關 suites（情境指引）
| Suite | Check ID | 命令範例 | 一句話說明 | 何時使用 |
| --- | --- | --- | --- | --- |
| `readme_required` | `readme` | `python3 runner/run_repo_checks.py --check readme --repo <REPO>` | 檢查 README 必要章節與 CODEOWNERS | 新 repo 建立後確認治理文件齊備 |
| `workflow_tag_refs` | `workflow` | `python3 runner/run_repo_checks.py --check workflow --repo <REPO>` | 檢查 workflow 是否以 tag 引用 aaa-actions | 要求 CI 固定版本、避免漂移 |
| `orphaned_assets` | `orphaned_assets` | `python3 runner/run_repo_checks.py --check orphaned_assets --repo <REPO>` | 檢查治理目錄是否有未入索引的檔案 | README/index.json 同步時使用 |
| `skills_structure` | `skills` | `python3 runner/run_repo_checks.py --check skills --repo <REPO> --skills-root skills` | 檢查 skills 目錄是否含 SKILL.md | agent repo 新增/調整 skills 時 |
| `skill_structure_v2` | `skill_structure_v2` | `python3 runner/run_repo_checks.py --check skill_structure_v2 --repo <REPO> --skills-root skills` | 檢查技能區塊完整性（Routing/Execution/Fallback/IO/Limitations） | 要求技能格式更嚴格時 |
| `prompt_schema` | `prompt` | `python3 runner/run_repo_checks.py --check prompt --repo <REPO> --schema-path prompt.schema.json --prompts-dir prompts` | 驗證 prompts 符合 prompt.schema.json | 更新 prompts 或 schema 時 |
| `cli_contract_sync` | `cli_contract_sync` | `python3 runner/run_repo_checks.py --check cli_contract_sync --repo <REPO>` | 檢查 SOP/使用者合約是否對齊 CLI contract | CLI/SOP 更新後 |
| `plan_schema_ref_sync` | `plan_schema_ref_sync` | `python3 runner/run_repo_checks.py --check plan_schema_ref_sync --repo <REPO>` | 檢查 SOP 中 plan/schema 版本一致 | 版本升級或 rebase 時 |
| `onboarding_command_integrity` | `onboarding_command_integrity` | `python3 runner/run_repo_checks.py --check onboarding_command_integrity --repo <REPO>` | 檢查 README/SOP 指令一致 | onboarding 指令更新後 |
| `start_here_sync` | `start_here_sync` | `python3 runner/run_repo_checks.py --check start_here_sync --repo <REPO> --profile-path profile/README.md` | 檢查組織首頁 Start Here 與 SOP 一致 | Start Here 或 SOP 內容變更後 |
| `post_init_audit_required` | `post_init_audit_required` | `python3 runner/run_repo_checks.py --check post_init_audit_required --repo <REPO>` | 檢查 post-init 稽核 runbook 已引用且存在 | 確保 repo-checks 必做規則 |
| `runbook_schema_validate` | `runbook_schema_validate` | `python3 runner/run_repo_checks.py --check runbook_schema_validate --repo <REPO>` | 驗證 runbook 符合 runbook.schema.json | runbook 編輯後 |
| `runbook_checksums` | `runbook_checksums` | `python3 runner/run_repo_checks.py --check runbook_checksums --repo <REPO>` | 驗證 runbook checksum 一致性 | 發布前確認 runbook 未被竄改 |

### repo-checks vs. 單一 check（什麼時候用哪個？）
- `aaa init repo-checks`：針對 **新專案初始化後** 的整體治理一致性驗證（會依 plan/suite 針對多個 repos 跑完整集合）。
- `runner/run_repo_checks.py --check ...`：針對 **單一 repo/單一問題** 的快速定位與驗證（例如只檢查 README 或 orphaned assets）。
- 建議流程：初始化後先跑 `aaa init repo-checks`；若失敗，再用單一 check 命令快速定位問題。

## 4) 常用指令範例
```bash
aaa init repo-checks \
  --org <TARGET_ORG> \
  --from-plan /tmp/aaa_plan_resolved.json \
  --suite governance \
  --jsonl
```

## 5) 參考文件
- CLI 合約：`aaa-tools/specs/CLI_CONTRACT.md`
- init plan 範例：`aaa-tools/runbooks/init/plan.v0.7.json`
- suite 清單與說明：`aaa-evals/README.md`
- suite 定義：`aaa-evals/evals/suites/`
- Post-init runbook：`aaa-tools/runbooks/init/POST_INIT_AUDIT.md`
