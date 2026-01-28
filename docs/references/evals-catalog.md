---
title: AAA Evals Catalog  
summary_zh: 'AAA Evals 完整索引與使用指南'
summary_en: 'Complete AAA Evals catalog with usage guide'
version: '1.0'
created: '2026-01-28'
---

# AAA Evals Catalog

> **Purpose**: Complete index of all AAA evaluation cases and suites  
> **Total**: 20 eval cases, 21 eval suites  
> **Execution**: Via `aaa-evals` runner or CI workflows

---

## What are Evals?

**Evals** (Evaluations) are governance checks that validate repository compliance with AAA standards:
- ✅ **Deterministic**: Pass/fail criteria clearly defined
- ✅ **Automated**: Run via CLI or CI
- ✅ **Blocking**: Can prevent PRmerge when used in gates
- ✅ **Traceable**: JSON output for audit trails

---

## Eval Categories

### 📋 Governance Core (v0.4)

| Eval | Suite | Purpose | Added |
|---|-----------|---------|-------|
| `cli_contract_sync` | cli_contract_sync.yml | Verify CLI contract matches SOP docs | v0.4 |
| `post_init_audit_required` | post_init_audit_required.yml | Ensure post-init audit documented | v0.4 |

### 📦 Onboarding (v0.3+)

| Eval | Suite | Purpose | Added |
|------|-------|---------|-------|
| `start_here_sync` | start_here_sync.yml | START_HERE.md exists and valid | v0.3 |
| `onboarding_command_integrity` | onboarding_command_integrity.yml | Onboarding commands documented | v0.3 |
| `prompt_schema` | prompt_schema.yml | Onboarding prompts valid schema | v0.3 |

### 🔒 Agent Safety (v0.6)

| Eval | Suite | Purpose | Added |
|------|-------|---------|-------|
| `agent_safety` | agent_safety.yml | Path traversal & security checks | v0.6 |
| `orphaned_assets` | orphaned_assets.yml | No orphaned files in assets | v0.6 |

### 🔧 Multi-Repo Runtime (v0.5)

| Eval | Suite | Purpose | Added |
|------|-------|---------|-------|
| `runbook_schema_validate` | runbook_schema_validate.yml | Runbooks validate against schema | v0.5 |
| `runbook_checksums` | runbook_checksums.yml | Runbook integrity checksums | v0.5 |
| `plan_schema_ref_sync` | plan_schema_ref_sync.yml | Plan refs match schema | v0.5 |

### 🏗️ Org-Scale Reliability (v0.7)

| Eval | Suite | Purpose | Added |
|------|-------|---------|-------|
| `repo_type_consistency` | (none - check) | repo_type matches manifest | v0.7 |
| `checks_manifest_alignment` | (none - check) | Checks align with manifest | v0.7 |

### 🎭 Skills & Templates

| Eval | Suite | Purpose | Added |
|------|-------|---------|-------|
| `skills_structure` | skills_structure.yml | Skills follow v1 structure | v0.1 |
| `skill_structure_v2` | skill_structure_v2.yml | Skills follow v2 structure | v0.6 |
| `workflow_tag_refs` | workflow_tag_refs.yml | Workflows pin to AAA tags | v0.1 |

### 📝 Documentation

| Eval | Suite | Purpose | Added |
|------|-------|---------|-------|
| `readme_required` | readme_required.yml | README.md exists | v0.1 |

### 🔐 Security & Bootstrap

| Eval | Suite | Purpose | Added |
|------|-------|---------|-------|
| `private_download_sanity` | private_download_sanity.yml | No unauthorized downloads | v0.6 |
| `member_bootstrap_prereq` | member_bootstrap_prereq.yml | Member onboarding prereqs | v0.3 |

### 🧪 Smoke Tests

| Eval | Suite | Purpose | Added |
|------|-------|---------|-------|
| `smoke_cases` | smoke.yml | Basic smoke tests | v0.1 |
| `gate_a_smoke` | gate_a_smoke.yml | Gate A smoke test | v0.4 |

### 🔧 Setup Checks

| Eval | Suite | Purpose | Added |
|------|-------|---------|-------|
| `gh_cli_setup` | gh_cli_setup.yml | GitHub CLI configured | v0.3 |
| `gh_org_audit` | gh_org_audit.yml | Org audit permissions | v0.9 |

### 🆕 New (v1.0+)

| Eval | Suite | Purpose | Added |
|------|-------|---------|-------|
| `nightly_dashboard_resilience` | nightly_dashboard_resilience.yml | Dashboard graceful degradation | v1.0 |
| `test_policy_compliance` | test_policy_compliance.yml | Validate 1+2+1 test coverage policy | v1.1 |

---

## Core Checks (Blocking Mode)

**Location**: `aaa-tools/aaa/check_commands.py`  
**Execution**: `aaa check --mode blocking`

The following 5 checks are run in blocking mode:

1. **readme**: README.md must exist
2. **workflow**: Required workflows present
3. **repo_type_consistency**: repo_type matches manifest
4. **checks_manifest_alignment**: Checks align with manifest
5. **orphaned_assets**: No orphaned files

**Exit Behavior**:
- Exit 0: All checks pass
- Exit 1: One ore fails

---

## Usage Examples

### Run Single Eval
```bash
cd aaa-evals
python runner/run_repo_checks.py \
  --check readme \
  --repo /path/to/repo
```

### Run All Checks (Blocking)
```bash
aaa check --mode blocking
```

### Run in CI
```yaml
- name: Governance Checks
  run: aaa check --mode blocking
```

---

## Eval File Structure

### Case File (.jsonl)
```jsonl
{"input": {...}, "expected_output": {...}}
```

### Suite File (.yml)
```yaml
---
name: eval_name
description: What this eval validates
version: 1.0
created: YYYY-MM-DD
priority: P0|P1|P2
tags:
  - category
check:
  id: eval_id
  runner: runner/checks/check_xxx.py
```

---

## Creating Custom Evals

1. **Create check runner**: `runner/checks/check_my_eval.py`
2. **Create test cases**: `evals/cases/my_eval.jsonl`
3. **Create suite**: `evals/suites/my_eval.yml`
4. **Add to manifest** (if blocking): `aaa-actions/checks.manifest.json`

---

## Total Count

- **Eval Cases**: 21
- **Eval Suites**: 22  
- **Core Checks**: 5 (blocking mode)
- **Categories**: 10+

---

| 1.0 | 2026-01-28 | Initial catalog creation |
| 1.1 | 2026-01-28 | Added v1.1 Evals (test_policy_compliance) |

---

**Total Count**: 21 cases, 22 suites

**Last Updated**: 2026-01-28  
**Version**: 1.1
