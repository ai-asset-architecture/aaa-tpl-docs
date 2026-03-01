# AAA Tpl Docs Folder Re-org Plan (2026-03-02)

## 1. Goal
- 清理 `aaa-tpl-docs/` 的重複與殘留結構。
- 把「版本開發產物」正式收斂到 `aaa-tpl-docs/internal/development/`。
- 在不破壞既有跨 repo 相依的前提下，分階段完成重組。

## 2. Scan Summary (as-is)
- total files (excluding `.git`): `893`
- high-noise area: `.worktrees/**` (`414` files, local worktree artifacts)
- active data areas:
  - `internal/**`: `185` files
  - `reports/**`: `223` files
  - `milestones/**`: `30` files
  - `docs/**`: `10` files (tracked core files only 5)
- `docs/` vs `internal/development/` same-relative-path overlap: only `3` (mainly `.DS_Store`/README), not true mirror.

## 3. Core Findings
1. Guide 已改為 `internal/development/...`，但 `docs/contracts/ops/*.schema.json` 仍在 `docs/`，與新規不一致。
2. `docs/` 下多個子目錄是空的（`plans/audits/reviews/milestones/evidence/...`），屬可清理噪音。
3. 全 workspace 還有大量 `aaa-tpl-docs/docs/...` / `aaa-tpl-docs/reports/...` 硬編碼引用，不能一次硬刪。
4. `.worktrees/` 為 active git worktree（非單純垃圾目錄），必須用 `git worktree remove/prune` 方式處理。
5. `.DS_Store` 存在多處，可直接清理（已在 `.gitignore`）。

## 4. Target Structure (to-be)
- `aaa-tpl-docs/internal/development/`：版本開發全部產物（plan/audit/review/contracts/evidence/milestones/runbooks）。
- `aaa-tpl-docs/reports/`：保留為「執行輸出」區（nightly/org audit/generated reports），短期不搬移。
- `aaa-tpl-docs/docs/`：過渡期兼容層，只保留必要入口與轉址說明；移除空子目錄與重複資產。
- `aaa-tpl-docs/.worktrees/`：不納入 repo 資產治理，僅作本機工作區（清理 stale worktree）。

## 5. Execution Plan

### Phase 0: Safety Gate (required)
1. freeze window：先不刪任何跨 repo 仍引用的目錄。
2. 建立 before snapshot（目錄清單 + 引用清單）。
3. 所有刪除動作先 dry-run（只列清單，不直接 rm）。

### Phase 1: Safe Hygiene Cleanup (low risk)
1. 刪除所有 `.DS_Store`。
2. 刪除 `docs/` 下空目錄（`plans/`, `audits/`, `reviews/`, `milestones/`, `evidence/...`）。
3. 清理 prunable worktree（只處理 `git worktree list` 標記 `prunable` 的項目）。

Acceptance:
- `git status` 無意外檔案刪除。
- `find aaa-tpl-docs -name .DS_Store` 為 0。

### Phase 2: Canonical Path Alignment (medium risk)
1. 建立 `internal/development/contracts/ops/`，將：
   - `docs/contracts/ops/guide-parity-report.v0.1.schema.json`
   - `docs/contracts/ops/ops-version-step-block.v0.1.schema.json`
   移到 canonical 路徑。
2. 在 `docs/contracts/ops/` 放過渡說明（deprecation README），不要再放實體 schema。
3. 更新本 repo 內所有引用為 `internal/development/contracts/ops/...`。

Acceptance:
- `rg "docs/contracts/ops/" aaa-tpl-docs` 只剩 deprecation 說明。
- `operate_maintain_guide.md` 與實際路徑一致。

### Phase 3: Cross-Repo Consumer Migration (high risk, multi-repo)
需同步以下 repo 的硬編碼路徑：
1. `aaa-tpl-service`（`ops_registry.py` / tests）
2. `aaa-tools`（templates/specs/output formatter）
3. `aaa-evals`（repo checks runner）
4. `aaa-prompts`（prompt 內 reference）
5. `aaa-docs`（dashboard/spec references）

Acceptance:
- `rg "aaa-tpl-docs/docs/" AAA_WORKSPACE` 僅剩刻意保留的相容層文件。
- 相關單元測試與 build 通過。

### Phase 4: Optional Legacy Reduction (after Phase 3 stable)
1. 評估 `docs/` 是否可縮成單一 `README + index.json`。
2. 評估 `archive/`, `dashboard/index.html`, `plans/repo-upgrade.json` 是否轉入 `internal/development/legacy/`。
3. `reports/` 依日期分區封存（保留 API/skill 依賴路徑不變）。

## 6. Delete/Keep Matrix

### Can Delete Now
- all `.DS_Store`
- empty directories under `docs/` (`plans`, `audits`, `reviews`, `milestones`, `evidence/*` empty branches)
- prunable worktrees (`git worktree list` 標記 prunable)

### Keep for Now (dependency exists)
- `reports/**`（被 tools/skills/evals/docs 多處引用）
- `docs/runbooks/nightly_debug_runbook.md`（registry index 仍引用）
- `docs/index.json`, `docs/README.md`（過渡入口）

### Move with Migration
- `docs/contracts/ops/*.schema.json` -> `internal/development/contracts/ops/`

## 7. Suggested Commit Batches
1. `chore(tpl-docs): remove ds_store and empty docs directories`
2. `refactor(tpl-docs): move ops schemas to internal/development/contracts`
3. `docs(tpl-docs): add docs path deprecation notice and migration notes`
4. (multi-repo) `refactor: migrate aaa-tpl-docs/docs path references to internal/development`

## 8. Risks
- High risk: 一次刪掉 `docs/` 會讓 `aaa-evals` / `aaa-tpl-service` / `aaa-tools` 即刻失效。
- Medium risk: `.worktrees/` 若直接刪資料夾，可能破壞 active branch 工作區。
- Low risk: `.DS_Store` 與空目錄清理。

## 9. Recommended Immediate Action
- 先執行 Phase 1（安全清理）+ Phase 2（schema canonical move）；
- Phase 3 走跨 repo 分批 PR，再決定是否進入 Phase 4。
