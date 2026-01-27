# P2-3 Upgrade/Audit Runbooks + Pipeline Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add repo upgrade/audit runbooks in `aaa-tools` and wire new `aaa-actions` workflows to run them.

**Architecture:** Define two runbook specs that wrap existing AAA CLI commands, then add two GitHub workflows that check out the target repo + supporting repos and execute the runbooks via `aaa run runbook --runbook-file` with explicit inputs.

**Tech Stack:** Python (`aaa-tools`), JSON runbook specs, GitHub Actions YAML (`aaa-actions`).

### Task 0: Patch runbook runtime to support CLI actions

**Files:**
- Modify: `aaa-tools/aaa/action_registry.py`
- Modify: `aaa-tools/aaa/runbook_runtime.py`

**Step 1: Allow action scopes to match any allowed scope**

Update `ActionRegistry.execute()` so that if an action declares multiple scopes, it passes when **any** of those scopes appear in the runbook `required_scopes`.

**Step 2: Add `aaa_cli` and `gh_cli` actions**

Implement handlers in `runbook_runtime.py` to execute:
- `aaa_cli`: `python3 -m aaa.cli <args...>`
- `gh_cli`: `gh <args...>`

Return a payload with `returncode`, `stdout`, `stderr`, and the invoked command string.

**Step 3: Smoke validate**

Run:
```bash
PYTHONPATH=aaa-tools python3 - <<'PY'
from aaa.action_registry import ActionRegistry
from aaa.runbook_runtime import _default_registry

registry = _default_registry()
specs = list(registry._actions.keys())
print("aaa_cli" in specs, "gh_cli" in specs)
PY
```

Expected: `True True`

### Task 1: Create upgrade runbook (`repo/upgrade`)

**Files:**
- Create: `aaa-tools/runbooks/repo/upgrade.yaml`

**Step 1: Write runbook spec (initial, checksum placeholder)**

```json
{
  "metadata": {
    "id": "repo/upgrade",
    "version": "1.0.0",
    "source": "local",
    "checksum": "sha256:REPLACE_ME",
    "requires_engine": ">=0.5.0"
  },
  "contract": {
    "inputs": [
      {"name": "org", "type": "string"},
      {"name": "plan_path", "type": "string"},
      {"name": "aaa_tag", "type": "string"},
      {"name": "jsonl", "type": "string"},
      {"name": "log_dir", "type": "string"},
      {"name": "dry_run", "type": "string"}
    ],
    "preconditions": [],
    "outputs": [],
    "required_scopes": ["repo:write"],
    "timeout_seconds": 600,
    "idempotency_check": {
      "command": "aaa init apply-templates --org {{inputs.org}} --from-plan {{inputs.plan_path}} --aaa-tag {{inputs.aaa_tag}} --dry-run",
      "expect_exit_code": 0
    },
    "error_codes": []
  },
  "observability": {
    "emit_events": true,
    "audit_artifacts": [],
    "failure_modes": [],
    "declared_side_effects": ["apply_templates"]
  },
  "steps": [
    {
      "name": "apply_templates",
      "action": "aaa_cli",
      "args": [
        "init",
        "apply-templates",
        "--org",
        "{{inputs.org}}",
        "--from-plan",
        "{{inputs.plan_path}}",
        "--aaa-tag",
        "{{inputs.aaa_tag}}",
        "--jsonl",
        "{{inputs.jsonl}}",
        "--log-dir",
        "{{inputs.log_dir}}",
        "--dry-run",
        "{{inputs.dry_run}}"
      ]
    }
  ]
}
```

**Idempotency note:** The `idempotency_check` runs a dry-run apply to ensure repeated upgrades are safe. The actual upgrade step must be no-op or produce identical output on a second run.

**Step 2: Compute checksum and replace**

Run:
```bash
python3 - <<'PY'
import json
from pathlib import Path
from aaa.runbook_registry import _compute_checksum

path = Path("aaa-tools/runbooks/repo/upgrade.yaml")
payload = json.loads(path.read_text(encoding="utf-8"))
checksum = _compute_checksum(payload)
print(checksum)
PY
```

Update `metadata.checksum` with the printed value.

**Step 3: Validate checksum load**

Run:
```bash
python3 - <<'PY'
from pathlib import Path
from aaa import runbook_registry

path = Path("aaa-tools/runbooks/repo/upgrade.yaml")
runbook_registry.load_runbook_file(path)
print("ok")
PY
```

Expected: `ok`

### Task 2: Create audit runbook (`repo/audit`)

**Files:**
- Create: `aaa-tools/runbooks/repo/audit.yaml`

**Step 1: Write runbook spec (initial, checksum placeholder)**

```json
{
  "metadata": {
    "id": "repo/audit",
    "version": "1.0.0",
    "source": "local",
    "checksum": "sha256:REPLACE_ME",
    "requires_engine": ">=0.5.0"
  },
  "contract": {
    "inputs": [
      {"name": "output_path", "type": "string"}
    ],
    "preconditions": [],
    "outputs": [],
    "required_scopes": ["repo:read"],
    "timeout_seconds": 300,
    "idempotency_check": {
      "command": "test -f {{inputs.output_path}}",
      "expect_exit_code": 0
    },
    "error_codes": []
  },
  "observability": {
    "emit_events": true,
    "audit_artifacts": ["{{inputs.output_path}}"],
    "failure_modes": [],
    "declared_side_effects": ["write_audit_report"]
  },
  "steps": [
    {
      "name": "run_local_audit",
      "action": "aaa_cli",
      "args": [
        "audit",
        "--local",
        "--output",
        "{{inputs.output_path}}"
      ]
    }
  ]
}
```

**Step 2: Compute checksum and replace**

Run:
```bash
python3 - <<'PY'
import json
from pathlib import Path
from aaa.runbook_registry import _compute_checksum

path = Path("aaa-tools/runbooks/repo/audit.yaml")
payload = json.loads(path.read_text(encoding="utf-8"))
checksum = _compute_checksum(payload)
print(checksum)
PY
```

Update `metadata.checksum` with the printed value.

**Step 3: Validate checksum load**

Run:
```bash
python3 - <<'PY'
from pathlib import Path
from aaa import runbook_registry

path = Path("aaa-tools/runbooks/repo/audit.yaml")
runbook_registry.load_runbook_file(path)
print("ok")
PY
```

Expected: `ok`

### Task 3: Add repo-upgrade workflow in `aaa-actions`

**Files:**
- Create: `aaa-actions/.github/workflows/repo-upgrade.yaml`

**Step 1: Add workflow YAML**

```yaml
name: repo-upgrade
on:
  workflow_dispatch:
    inputs:
      repository:
        description: "Repo with the upgrade plan file"
        required: true
        default: "ai-asset-architecture/aaa-tpl-docs"
      ref:
        description: "Git ref for target repo"
        required: false
        default: "main"
      org:
        description: "GitHub org for template application"
        required: true
        default: "ai-asset-architecture"
      plan_path:
        description: "Path to upgrade plan (relative to repo root)"
        required: true
        default: "plans/repo-upgrade.json"
      aaa_tag:
        description: "Template tag"
        required: true
        default: "v1.0.0"
      dry_run:
        description: "Dry run"
        required: false
        default: "true"
  workflow_call:
    inputs:
      repository:
        type: string
        required: true
      ref:
        type: string
        required: false
        default: "main"
      org:
        type: string
        required: true
      plan_path:
        type: string
        required: true
      aaa_tag:
        type: string
        required: true
      dry_run:
        type: string
        required: false
        default: "true"

jobs:
  upgrade:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout target repo
        uses: actions/checkout@v4
        with:
          repository: ${{ inputs.repository }}
          ref: ${{ inputs.ref }}
          path: target
      - name: Checkout aaa-tools
        uses: actions/checkout@v4
        with:
          repository: ai-asset-architecture/aaa-tools
          path: aaa-tools
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.x"
      - name: Install aaa-tools (local)
        run: |
          python3 -m pip install -U pip
          python3 -m pip install -e ./aaa-tools
      - name: Run upgrade runbook
        working-directory: target
        run: |
          aaa run runbook --runbook-file ../aaa-tools/runbooks/repo/upgrade.yaml \
            --input org=${{ inputs.org }} \
            --input plan_path=${{ inputs.plan_path }} \
            --input aaa_tag=${{ inputs.aaa_tag }} \
            --input jsonl=true \
            --input log_dir=./aaa-logs \
            --input dry_run=${{ inputs.dry_run }}
      - name: Detect changes
        id: changes
        working-directory: target
        run: |
          if [ -n \"$(git status --porcelain)\" ]; then
            echo \"changed=true\" >> \"$GITHUB_OUTPUT\"
          else
            echo \"changed=false\" >> \"$GITHUB_OUTPUT\"
          fi
      - name: Commit changes
        if: ${{ steps.changes.outputs.changed == 'true' && inputs.dry_run != 'true' }}
        working-directory: target
        run: |
          git config user.name \"aaa-bot\"
          git config user.email \"aaa-bot@users.noreply.github.com\"
          git add -A
          git commit -m \"chore: apply upgrade plan\"
          git push origin HEAD
      - name: No-op (no changes)
        if: ${{ steps.changes.outputs.changed != 'true' }}
        run: echo \"No changes detected; skipping commit.\"
      - name: Upload logs
        uses: actions/upload-artifact@v4
        with:
          name: repo-upgrade-logs
          path: |
            target/aaa-logs
```

**Step 2: Validate workflow syntax**

Run:
```bash
yamllint aaa-actions/.github/workflows/repo-upgrade.yaml
```

Expected: no errors (if `yamllint` not available, skip and note).

### Task 4: Add repo-audit workflow in `aaa-actions`

**Files:**
- Create: `aaa-actions/.github/workflows/repo-audit.yaml`

**Step 1: Add workflow YAML**

```yaml
name: repo-audit
on:
  workflow_dispatch:
    inputs:
      repository:
        description: "Repo to audit"
        required: true
        default: "ai-asset-architecture/aaa-tpl-docs"
      ref:
        description: "Git ref for target repo"
        required: false
        default: "main"
      output_path:
        description: "Audit JSON path (relative to repo root)"
        required: true
        default: "reports/audits/local_audit.json"
  workflow_call:
    inputs:
      repository:
        type: string
        required: true
      ref:
        type: string
        required: false
        default: "main"
      output_path:
        type: string
        required: true

jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout target repo
        uses: actions/checkout@v4
        with:
          repository: ${{ inputs.repository }}
          ref: ${{ inputs.ref }}
          path: target
      - name: Checkout aaa-tools
        uses: actions/checkout@v4
        with:
          repository: ai-asset-architecture/aaa-tools
          path: aaa-tools
      - name: Checkout aaa-evals
        uses: actions/checkout@v4
        with:
          repository: ai-asset-architecture/aaa-evals
          path: aaa-evals
      - name: Checkout aaa-actions
        uses: actions/checkout@v4
        with:
          repository: ai-asset-architecture/aaa-actions
          path: aaa-actions
      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.x"
      - name: Install aaa-tools (local)
        run: |
          python3 -m pip install -U pip
          python3 -m pip install -e ./aaa-tools
      - name: Run audit runbook
        working-directory: target
        env:
          AAA_EVALS_ROOT: ${{ github.workspace }}/aaa-evals
          AAA_CHECKS_MANIFEST: ${{ github.workspace }}/aaa-actions/checks.manifest.json
        run: |
          aaa run runbook --runbook-file ../aaa-tools/runbooks/repo/audit.yaml \
            --input output_path=${{ inputs.output_path }}
      - name: Upload audit report
        uses: actions/upload-artifact@v4
        with:
          name: repo-audit-report
          path: |
            target/${{ inputs.output_path }}
```

**Step 2: Validate workflow syntax**

Run:
```bash
yamllint aaa-actions/.github/workflows/repo-audit.yaml
```

Expected: no errors (if `yamllint` not available, skip and note).

### Task 5: Sanity checks

**Step 1: Run runbook checksum checks (optional)**

From repo root:
```bash
python3 aaa-evals/runner/run_repo_checks.py --check runbook_checksums --repo aaa-tools
```

Expected: pass.

**Step 2: Document changes**

Update `aaa-tpl-docs/docs/plans/2026-01-24-v1.0-remediation-plan.md` if needed to mark P2-3 as complete once merged.

---

## Notes
- The runbooks use `aaa_cli` action (consistent with existing runbooks). If the action registry does not support `aaa_cli`, add a follow-up task to implement the action or switch to a supported action.
- The workflows are reusable (`workflow_call`) and also manually triggerable (`workflow_dispatch`).
