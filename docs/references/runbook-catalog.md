---
title: AAA Runbook Catalog
summary_zh: 'AAA Runbook 完整索引與使用指南'
summary_en: 'Complete AAA Runbook catalog with usage guide'
version: '1.0'
created: '2026-01-28'
---

# AAA Runbook Catalog

> **Purpose**: Complete index of all AAA runbooks with usage descriptions  
> **Audience**: Operators, DevOps engineers, and automation developers  
> **Execution**: All runbooks executed via `aaa run runbook <id>@<version>`

---

## What are Runbooks?

**Runbooks** are production-grade automation scripts that execute multi-step operations with:
- ✅ **Contract System**: Typed inputs, preconditions, outputs
- ✅ **Idempotency Checks**: Prevent duplicate execution
- ✅ **Error Codes**: Structured error handling
- ✅ **Observability**: Audit artifacts, failure modes
- ✅ **Security**: Required scopes and permission management

**Key Difference** vs GitHub Workflows:
- **Runbooks**: Local/manual execution via CLI (`aaa run runbook`)
- **Workflows**: CI/CD automation on GitHub Actions

---

## Execution Syntax

### By Spec (Registry Lookup)
```bash
aaa run runbook <id>@<version> --input key=value
```

### By File (Direct Execution)
```bash
aaa run runbook --runbook-file ./path/to/runbook.yaml --input key=value
```

### JSON Output
```bash
aaa run runbook <id>@<version> --json
```

---

## Runbook Categories

### 📦 Init Runbooks
**Purpose**: Project initialization and bootstrap operations

| ID | Version | File | Purpose | Inputs |
|----|---------|------|---------|--------|
| *Manual* | v0.1 | `init/AGENT_BOOTSTRAP.md` | Bootstrap new AAA projects via Codex/Agent | See doc |
| *Manual* | v0.1 | `init/POST_INIT_AUDIT.md` | Post-init governance verification | See doc |

**Plans**:
- `init/plan.v0.1.json`: Original init plan
- `init/plan.v0.7.json`: Updated plan with repo_type

**Schema**:
- `init/output.schema.json`: Output validation schema (180 lines)

---

### ⚙️ Ops Runbooks
**Purpose**: Operational maintenance and org-level tasks

| ID | Version | File | Purpose | Inputs | Outputs |
|----|---------|------|---------|--------|---------|
| `ops/reindex-all-assets` | 1.0.0 | `ops/reindex-all-assets.yaml` | Rebuild all asset indexes across repos | None | Updated `index.json` files |
| `ops/init-milestone` | 1.0.0 | `ops/init-milestone.yaml` | Initialize new milestone (runbooks, plans, docs) | milestone_id, target_date | Milestone structure |
| `ops/complete-milestone` | 1.0.0 | `ops/complete-milestone.yaml` | Finalize milestone (reports, archival) | milestone_id | Completion report |

**ops/reindex-all-assets Details**:
- **Steps**: 7 index update operations
- **Targets**: 
  - `aaa-tpl-docs/milestones`
  - `aaa-tpl-docs/reports`
  - `aaa-tpl-docs/docs`
  - `aaa-tools/specs`
  - `aaa-tpl-frontend/docs`
  - `aaa-tpl-service/docs`
- **Template-driven**: Generates MD + JSON indexes
- **Required Scope**: `gov:index`
- **Timeout**: 300s

---

### 🔧 Repo Runbooks
**Purpose**: Per-repository operations

| ID | Version | File | Purpose | Inputs | Outputs |
|----|---------|------|---------|--------|---------|
| `repo/audit` | 1.0.0 | `repo/audit.yaml` | Run governance audit on repo | `output_path` | Audit JSON report |
| `repo/upgrade` | 1.0.0 | `repo/upgrade.yaml` | Upgrade repo templates to new AAA version | `org`, `plan_path`, `aaa_tag`, `jsonl`, `log_dir`, `dry_run` | Applied templates |
| `repo/init-repo` | 1.0.0 | `repo/init-repo.yaml` | Initialize new repository | `org`, `repo_name`, `template` | Initialized repo |
| `repo/protect` | 1.0.0 | `repo/protect.yaml` | Apply branch protection rules | `org`, `repo_name`, `branch` | Protection config |
| `repo/repo-checks` | 1.0.0 | `repo/repo-checks.yaml` | Run all governance checks | `org`, `repo_name` | Check results |
| `repo/verify-ci` | 1.0.0 | `repo/verify-ci.yaml` | Verify CI workflow integrity | `org`, `repo_name` | CI status |

**repo/audit Details**:
- **Action**: `aaa audit --local --output <path>`
- **Required Scope**: `repo:read`
- **Idempotency**: Checks if output file exists
- **Audit Artifacts**: `{{inputs.output_path}}`
- **Side Effects**: `write_audit_report`

**repo/upgrade Details**:
- **Action**: `aaa init apply-templates`
- **Supports**: Dry-run mode, JSONL output
- **Required Scope**: `repo:write`
- **Timeout**: 600s (longest of all runbooks)
- **Idempotency**: Dry-run check before execution

---

### 🔒 Security Runbooks
**Purpose**: Security analysis and validation

| ID | Version | File | Purpose | Inputs | Outputs |
|----|---------|------|---------|--------|---------|
| `security/attack-scope` | 1.0.0 | `security/attack-scope.yaml` | Analyze attack surface scope | TBD | Security report |

---

## Common Usage Patterns

### Pattern 1: Audit All Repos
```bash
# For each repo in org
for repo in $(gh repo list my-org --json name -q '.[].name'); do
  aaa run runbook repo/audit@1.0.0 \
    --input output_path=./reports/${repo}_audit.json
done
```

### Pattern 2: Batch Upgrade
```bash
# Create upgrade plan first
aaa init create-upgrade-plan --org my-org --aaa-tag v1.1.0 > upgrade.json

# Execute upgrade runbook
aaa run runbook repo/upgrade@1.0.0 \
  --input org=my-org \
  --input plan_path=./upgrade.json \
  --input aaa_tag=v1.1.0 \
  --input dry_run=false
```

### Pattern 3: Rebuild All Indexes
```bash
# Simple one-liner
aaa run runbook ops/reindex-all-assets@1.0.0
```

### Pattern 4: Initialize New Milestone
```bash
aaa run runbook ops/init-milestone@1.0.0 \
  --input milestone_id=v1.2 \
  --input target_date=2026-02-15
```

---

## Runbook Contract Structure

All YAML runbooks follow this schema:

```json
{
  "metadata": {
    "id": "category/name",
    "version": "1.0.0",
    "source": "local",
    "checksum": "sha256:...",
    "requires_engine": ">=0.5.0"
  },
  "contract": {
    "inputs": [{"name": "...", "type": "string"}],
    "preconditions": [],
    "outputs": [],
    "required_scopes": ["scope:permission"],
    "timeout_seconds": 300,
    "idempotency_check": {
      "command": "test ...",
      "expect_exit_code": 0
    },
    "error_codes": []
  },
  "observability": {
    "emit_events": true,
    "audit_artifacts": ["path/to/artifact"],
    "failure_modes": [],
    "declared_side_effects": ["action_name"]
  },
  "steps": [
    {
      "name": "step_name",
      "action": "action_type",
      "args": ["--flag", "value"]
    }
  ]
}
```

---

## Action Types

| Action | Description | Example |
|--------|-------------|---------|
| `aaa_cli` | Execute `aaa` CLI command | `["audit", "--local"]` |
| `governance.update_index` | Update asset index | `["--target-dir", "path"]` |
| `shell` | Execute shell command | `["bash", "-c", "..."]` |

---

## Creating Custom Runbooks

### 1. Create Runbook File
```yaml
{
  "metadata": {
    "id": "custom/my-operation",
    "version": "1.0.0",
    "source": "local",
    "requires_engine": ">=0.5.0"
  },
  "contract": {
    "inputs": [{"name": "target", "type": "string"}],
    "required_scopes": ["repo:read"],
    "timeout_seconds": 60
  },
  "steps": [
    {
      "name": "do_something",
      "action": "aaa_cli",
      "args": ["check", "--repo", "{{inputs.target}}"]
    }
  ]
}
```

### 2. Test Locally
```bash
aaa run runbook --runbook-file ./my-runbook.yaml \
  --input target=my-repo \
  --json
```

### 3. Add to Registry
Place in `aaa-tools/runbooks/<category>/` directory.

---

## Troubleshooting

### Runbook Not Found
```bash
# Check available runbooks
ls -la aaa-tools/runbooks/*/

# Verify runbook ID format
# Correct: repo/audit@1.0.0
# Wrong: repo-audit@1.0.0
```

### Idempotency Check Failed
```bash
# Run with explicit override (if supported)
aaa run runbook <id>@<version> --force
```

### Permission Denied
```bash
# Check required scopes in runbook metadata
# Ensure your GitHub token has sufficient permissions
gh auth status
```

### Timeout
```bash
# Increase timeout in runbook contract.timeout_seconds
# Or split operation into smaller runbooks
```

---

## Runbook vs Workflow Decision Matrix

| Use Case | Runbook | Workflow |
|----------|---------|----------|
| Local manual operation | ✅ | ❌ |
| CI/CD automation | 🔮 Future | ✅ |
| One-time migration | ✅ | ❌ |
| Scheduled nightly job | 🔮 Future | ✅ |
| Multi-repo batch operation | ✅ | ⚠️ Complex |
| Interactive debugging | ✅ | ❌ |

**Future Direction (v1.1+)**: Integrate runbooks into workflows for unified automation engine.

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-01-28 | Initial catalog creation |

---

## See Also

- [Runbook Schema](../../aaa-tools/runbook.schema.json)
- [CLI Contract](../../aaa-tools/specs/CLI_CONTRACT.md)
- [Action Registry](./action-registry.md) *(if exists)*

---

**Total Runbooks**: 16+  
**Categories**: Init (2 manual), Ops (3), Repo (6), Security (1)  
**Last Updated**: 2026-01-28
