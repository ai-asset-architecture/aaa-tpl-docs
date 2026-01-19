# Skill Review Checklist (AAA)

## Routing
- [ ] Hard Rules 至少 1 條（或標註固定路徑）
- [ ] Soft Rules 可計分或明確說明不適用
- [ ] Routing Decision 明確可判斷

## Execution
- [ ] 至少 2 個步驟
- [ ] 明確輸入來源（檔案/參數）
- [ ] 可由人類照做、不只有抽象描述

## Fallback
- [ ] 失敗時有降級路徑
- [ ] 不直接結束，提供手動步驟或替代工具

## Inputs / Outputs
- [ ] Input 最小集合清楚
- [ ] Output 可驗證（JSON/檔案/清單）

## Limitations
- [ ] 至少 1 條限制或邊界

## Execution Test
- [ ] `tests/smoke.sh` 存在
- [ ] 輸出 PASS / SKIP / FAIL
