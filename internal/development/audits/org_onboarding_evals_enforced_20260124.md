# Org Onboarding Evals Enforcement Evidence (2026-01-24)

## Summary (ZH-TW)
此報告用於記錄「org-level onboarding Evals 強制」的執行證據與結果。當前為待執行狀態，需補齊 org/plan/suite 參數後跑實際檢查。

## Summary (EN)
This report records evidence for org-level enforcement of onboarding evals. It is pending execution and requires org/plan/suite inputs.

---

## Required Inputs
- **Target Org**: `<ORG>`
- **Plan**: `<PATH_TO_PLAN_JSON>`
- **Suite**: `governance`

## Execution Command
```bash
aaa init repo-checks \
  --org <ORG> \
  --from-plan <PATH_TO_PLAN_JSON> \
  --suite governance \
  --jsonl
```

## Status
- **Execution**: Pending
- **Reason**: org/plan parameters not provided in this environment

## Evidence Checklist
- [ ] Command output JSONL attached
- [ ] Pass/fail summary per repo
- [ ] Orphaned assets check status
- [ ] README/workflow pinning status

## Notes
- 產生後請將 JSONL 結果附在本報告或另存於同目錄並連結。
