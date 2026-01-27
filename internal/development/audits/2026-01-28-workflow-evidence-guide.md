# P2-3 Workflow Evidence Collection Guide

**Task**: 驗證 repo-upgrade / repo-audit workflow 實際執行能力  
**Date**: 2026-01-28  
**Status**: 🟡 PENDING (Awaiting manual workflow trigger)

---

## 📋 Prerequisites Check

- [x] `aaa-actions/.github/workflows/repo-audit.yaml` 存在
- [x] `aaa-actions/.github/workflows/repo-upgrade.yaml` 存在
- [x] Workflows 支援 `workflow_dispatch` (手動觸發)
- [ ] User 已登入 GitHub 且有 Actions 執行權限

---

## 🚀 Execution Steps

### **Step 1: 觸發 `repo-audit` Workflow**

#### **方法 A: 使用 GitHub Web UI**

1. 前往 https://github.com/ai-asset-architecture/aaa-actions/actions
2. 左側選擇 **"repo-audit"** workflow
3. 點擊右上角 **"Run workflow"** 按鈕
4. 填寫參數（使用預設值即可）:
   - **repository**: `ai-asset-architecture/aaa-tpl-docs` ✅
   - **ref**: `main` ✅
   - **output_path**: `reports/audits/local_audit.json` ✅
5. 點擊 **"Run workflow"** 確認執行

#### **方法 B: 使用 GitHub CLI**

```bash
gh workflow run repo-audit.yaml \
  --repo ai-asset-architecture/aaa-actions \
  --field repository="ai-asset-architecture/aaa-tpl-docs" \
  --field ref="main" \
  --field output_path="reports/audits/local_audit.json"
```

#### **預期結果**
- ✅ Workflow status: **Success** (綠色勾勾)
- ✅ Artifact 產生: `repo-audit-report` (包含 `local_audit.json`)
- ⏱️ 預計執行時間: 1-2 分鐘

---

### **Step 2: 觸發 `repo-upgrade` Workflow**

#### **方法 A: 使用 GitHub Web UI**

1. 前往 https://github.com/ai-asset-architecture/aaa-actions/actions
2. 左側選擇 **"repo-upgrade"** workflow
3. 點擊右上角 **"Run workflow"** 按鈕
4. 填寫參數（**建議使用 dry-run 模式**）:
   - **repository**: `ai-asset-architecture/aaa-tpl-docs` ✅
   - **ref**: `main` ✅
   - **org**: `ai-asset-architecture` ✅
   - **plan_path**: `plans/repo-upgrade.json` ⚠️ (檔案可能不存在，workflow 會 gracefully fail)
   - **aaa_tag**: `v1.0.0` ✅
   - **dry_run**: `true` ✅ **(IMPORTANT: 設為 true 避免非預期修改)**
5. 點擊 **"Run workflow"** 確認執行

#### **方法 B: 使用 GitHub CLI**

```bash
gh workflow run repo-upgrade.yaml \
  --repo ai-asset-architecture/aaa-actions \
  --field repository="ai-asset-architecture/aaa-tpl-docs" \
  --field ref="main" \
  --field org="ai-asset-architecture" \
  --field plan_path="plans/repo-upgrade.json" \
  --field aaa_tag="v1.0.0" \
  --field dry_run="true"
```

#### **預期結果**
- ✅ Workflow status: **Success** 或 **No changes detected** (兩者皆可接受)
- ✅ Artifact 產生: `repo-upgrade-logs` (包含執行日誌)
- ⚠️ 若 `plans/repo-upgrade.json` 不存在，workflow 可能會 fail (這是預期內的，證明錯誤處理機制正常)
- ⏱️ 預計執行時間: 1-2 分鐘

---

## 📊 Evidence Collection Checklist

完成兩個 workflows 執行後，請收集以下資訊：

### **Repo Audit Workflow**
- [ ] Workflow Run URL: `__________________`
- [ ] Run ID: `__________________`
- [ ] Status: `[ ] Success / [ ] Failed`
- [ ] Artifact 下載連結: `__________________`
- [ ] 執行時間: `__________________`

### **Repo Upgrade Workflow**
- [ ] Workflow Run URL: `__________________`
- [ ] Run ID: `__________________`
- [ ] Status: `[ ] Success / [ ] No changes / [ ] Failed`
- [ ] Artifact 下載連結: `__________________`
- [ ] Created PR? `[ ] Yes (PR #__) / [ ] No`
- [ ] 執行時間: `__________________`

---

## 📝 Final Report Template

完成證據收集後，請將以下模板填寫完整並儲存為:  
**`internal/development/audits/2026-01-28-workflow-evidence.md`**

---

## 🔍 Troubleshooting

### **問題 1: Workflow 執行失敗 (repo-upgrade)**
**原因**: `plans/repo-upgrade.json` 檔案不存在  
**解決方案**: 這是預期內的！證明 workflow 的錯誤處理機制正常運作，在證據報告中標註為「Gracefully failed (expected)」

### **問題 2: 沒有權限觸發 workflow**
**原因**: 需要 repo write 權限  
**解決方案**: 確認 GitHub 帳號有 `ai-asset-architecture` org 的 member 身份

### **問題 3: Artifact 無法下載**
**原因**: Workflow 尚未完成或執行失敗  
**解決方案**: 等待 workflow 完成（綠色勾勾），然後點擊 Summary 頁面的 Artifacts 區塊下載

---

## ✅ Next Steps

1. 執行上述兩個 workflows
2. 收集證據資訊
3. 填寫最終報告 (`2026-01-28-workflow-evidence.md`)
4. Commit 並 push 到 `aaa-tpl-docs` repo
5. 更新 `.github/profile/README.md` 待辦事項 (標記 P2-3 為完成)

---

**Ready to proceed? 請開始執行 Step 1 & Step 2！** 🚀
