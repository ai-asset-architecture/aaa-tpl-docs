# AAA Runtime Plans

This directory contains **runtime plan specifications** (JSON format) used by AAA workflows and CLI commands.

---

## 📋 Purpose

Plans in this directory define **how to execute AAA operations** such as:
- Upgrading repository templates to latest AAA versions
- Applying standardized configurations across repos
- Automating maintenance tasks via GitHub Actions workflows

These are **machine-readable specifications** consumed by AAA runtime engines, distinct from human-readable implementation plans.

---

## 📁 Files

### `repo-upgrade.json`

**Purpose**: Defines how to upgrade `aaa-tpl-docs` with the latest AAA templates

| Property | Value |
|----------|-------|
| **Used by** | `repo-upgrade` workflow in `aaa-actions` repo |
| **Execution** | `aaa init apply-templates --from-plan plans/repo-upgrade.json` |
| **Modes** | Dry-run (testing) or live (actual upgrade) |
| **Target** | Self-upgrade (aaa-tpl-docs maintains itself) |

**Workflow Integration**:
```yaml
# .github/workflows/repo-upgrade.yaml (in aaa-actions)
- name: Run upgrade runbook
  run: |
    aaa run runbook --runbook-file ../aaa-tools/runbooks/repo/upgrade.yaml \
      --input plan_path=plans/repo-upgrade.json \
      --input aaa_tag=v1.0.0 \
      --input dry_run=true
```

**Structure**:
```json
{
  "plan_version": "1.0",
  "aaa": { ... },          // AAA system metadata
  "target": { ... },       // Target organization/repos
  "repos": [ ... ],        // Repository specifications
  "steps": [ ... ]         // Execution steps
}
```

---

## 🔍 Distinction from `internal/development/plans/`

AAA has **two types of plans** with different purposes:

| Aspect | **`plans/`** (Runtime Plans) | **`internal/development/plans/`** (Implementation Plans) |
|--------|------------------------------|----------------------------------------------------------|
| **Format** | JSON (machine-readable) | Markdown (human-readable) |
| **Purpose** | Runtime execution specs | AI Builder task descriptions |
| **Consumer** | AAA CLI / GitHub workflows | AI agents (Architect/Builder) |
| **Lifecycle** | Maintained for production use | Archived after task completion |
| **Examples** | `repo-upgrade.json` | `2026-01-24-p2-3-upgrade-audit-runbooks.md` |

### Visual Analogy

```
internal/development/plans/*.md  (Implementation Plans)
  ↓ [AI Builder reads and executes]
  ↓ [May reference...]
plans/*.json  (Runtime Plans)
  ↓ [AAA CLI executes]
Actual System Changes
```

---

## 📚 Related Documentation

- **Workflow Evidence**: [`internal/development/audits/2026-01-28-workflow-evidence.md`](../internal/development/audits/2026-01-28-workflow-evidence.md)
- **Runbook Spec**: `aaa-tools/runbooks/repo/upgrade.yaml`
- **Plan Schema**: `aaa-tools/specs/plan.schema.json`
- **Implementation Plans Directory**: [`internal/development/plans/`](../internal/development/plans/)

---

## 🚀 Usage Examples

### Manual Dry-Run (Testing)

```bash
# From aaa-tpl-docs root directory
PYTHONPATH=../aaa-tools python3 -m aaa.cli init apply-templates \
  --org ai-asset-architecture \
  --from-plan plans/repo-upgrade.json \
  --aaa-tag v1.0.0 \
  --dry-run
```

### Via GitHub Actions (Automated)

```bash
# Trigger repo-upgrade workflow
gh workflow run repo-upgrade.yaml \
  --repo ai-asset-architecture/aaa-actions \
  --field repository="ai-asset-architecture/aaa-tpl-docs" \
  --field plan_path="plans/repo-upgrade.json" \
  --field aaa_tag="v1.0.0" \
  --field dry_run="true"
```

---

## ⚠️ Important Notes

1. **Version Control**: All runtime plans should be version-controlled to ensure reproducibility
2. **Idempotency**: Plans should be designed to be idempotent (safe to run multiple times)
3. **Validation**: Run `aaa init validate-plan --plan plans/repo-upgrade.json` before committing
4. **Testing**: Always test with `--dry-run` first before live execution

---

**Last Updated**: 2026-01-28  
**Maintainer**: AAA Core Team
