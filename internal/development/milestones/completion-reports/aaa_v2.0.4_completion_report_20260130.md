<template id="completion-report">
# Milestone Completion Report: v2.0.4 Init Plan Presets

## Metadata
*   **Milestone**: v2.0.4
*   **Release Name**: Init Plan Presets
*   **Status**: COMPLETED
*   **Date**: 2026-01-30
*   **Hash**: aaa-tools@1977d97; aaa-docs@ff5671f; aaa-tpl-docs@7108246; registry@afb8e8a

## 1. Executive Summary
ZH-TW: v2.0.4 以「單檔 presets + default_preset」完成 init 升級，預設 Governance-Native 並強制包含 `.github`，提供 `--preset` 覆寫與 legacy fallback（含 MODE/WARN token），並完成測試、審計證據與資產登錄。
EN: v2.0.4 upgrades init via a single plan with `presets + default_preset`, defaulting to Governance-Native with required `.github`, adds `--preset` override and legacy fallback (MODE/WARN tokens), and completes tests, audit evidence, and asset registration.

## 2. Deliverables Status
### A. Plan + Schema
| Component | Function | Status | Coverage |
| :--- | :--- | :--- | :--- |
| `aaa-tools/runbooks/init/plan.v2.0.json` | Presets + default plan definition | ✅ Done | 100% |
| `aaa-tools/specs/plan.schema.json` | Presets schema + legacy fallback | ✅ Done | 100% |

### B. Resolver + CLI
| Component | Function | Status | Coverage |
| :--- | :--- | :--- | :--- |
| `aaa-tools/aaa/init_commands.py` | Preset resolver + fail-fast tokens | ✅ Done | 100% |
| `aaa-tools/aaa/cli.py` | `--preset` override wiring | ✅ Done | 100% |

### C. Tests + Docs + Audit
| Component | Function | Status | Coverage |
| :--- | :--- | :--- | :--- |
| `aaa-tools/tests/test_init_plan_presets.py` | Preset resolution tests | ✅ Done | 100% |
| `aaa-docs/bootstrap/ai_bootstrap.md` | Preset usage guidance | ✅ Done | 100% |
| `aaa-docs/bootstrap/cli_connection_guide.md` | CLI preset examples | ✅ Done | 100% |
| `aaa-tpl-docs/internal/development/audits/2026-01-30-v2.0.4-audit-presets.md` | Audit evidence | ✅ Done | 100% |

## 3. Verification Evidence
*   **Unit Tests**: `python -m unittest tests/test_init_plan_presets.py` (PASS)
*   **Manual Verification**: T-001..T-008 outputs recorded in audit evidence (CMD/OUT/HASH)

## 4. Asset Preservation (Nightly Candidates)
1.  `aaa-tools/tests/test_init_plan_presets.py` (Critical init flow; resolver correctness)

> **Explicitly unchanged**: Evals / Templates / Policy Packs (v2.0.4)

## 5. Next Steps
*   **v2.0.5**: Optional registry enrichment for preset metadata (non-breaking).
*   **Backlog**: Interactive menu (v1.3.1) alignment with preset definitions.
</template>
