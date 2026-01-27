# Governance Suite Evidence Report (P0-3)

**Generated At**: 2026-01-27T22:37:41Z  
**Task**: P0-3 證據補齊 — 實跑 governance suite 並產生完整稽核報告  
**Execution Command**:
```bash
PYTHONPATH=../aaa-tools python3 -m aaa.cli audit --local \
  --output internal/development/audits/2026-01-28-governance-suite-evidence.json
```

---

## Audit Summary

| Metric | Value |
|--------|-------|
| **Repo Name** | `aaa-tpl-docs` |
| **Repo Type** | `docs` |
| **Archived** | No |
| **Total Checks** | 5 |
| **Passed** | 4 ✅ |
| **Failed** | 1 ❌ |
| **Compliance Rate** | 80% |

---

## Check Results

### ✅ Passed Checks (4/5)

| Check ID | Status | Description |
|----------|--------|-------------|
| `readme` | ✅ PASS | README.md exists and follows standards |
| `workflow` | ✅ PASS | GitHub workflows configured correctly |
| `repo_type_consistency` | ✅ PASS | `.aaa/metadata.json` repo_type 與實際類型一致 |
| `checks_manifest_alignment` | ✅ PASS | Required checks 與 manifest 對齊 |

### ❌ Failed Checks (1/5)

| Check ID | Status | Reason |
|----------|--------|--------|
| `orphaned_assets` | ❌ FAIL | 偵測到 orphaned assets（可能是舊版本檔案未清理） |

---

## Remediation Plan (Optional)

針對 `orphaned_assets` 失敗項目，可採取以下行動：

1. **定位 orphaned assets**:
   ```bash
   PYTHONPATH=../aaa-tools python3 ../aaa-evals/runner/run_repo_checks.py \
     --check orphaned_assets --repo . --verbose
   ```

2. **清理策略**:
   - 若為歷史檔案，移至 `archive/` 資料夾
   - 若為無效連結，更新或移除引用
   - 若為預期存在，更新 `orphaned_assets` 檢查規則

---

## P0-3 Task Status

✅ **Task Completed**: Governance suite 已成功執行並產生完整證據鏈

**Deliverables**:
1. JSON 稽核報告: `2026-01-28-governance-suite-evidence.json`
2. Markdown 可讀報告: `2026-01-28-governance-suite-evidence.md` (本檔案)

**Next Steps**:
- Commit 並 push 證據檔案至 `aaa-tpl-docs` repo
- 更新 `.github/profile/README.md` 待辦紀錄，標記 P0-3 為已完成
- 繼續執行 Task 3 (P2-3 Workflow Evidence)
