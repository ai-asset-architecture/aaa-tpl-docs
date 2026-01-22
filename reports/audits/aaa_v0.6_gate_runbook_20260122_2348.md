# AAA v0.6 Readiness Gate Runbook (Executable Mapping)

Date: 2026-01-22 23:48 (Asia/Taipei)
Owner: AAA Core

## Purpose
Convert v0.6 gates into machine-executable commands with expected outputs.

## Scope
- Gate A: Init pipeline can run end-to-end
- Gate B: Governance checks pass (orphaned_assets, agent_safety)
- Gate C: Workflow inheritance + required checks names remain stable
- Gate D: CLI JSON output is parseable and contains required fields

## Gate A - Init Pipeline End-to-End

### A1. Validate plan
Command:
```
aaa init validate-plan --plan /tmp/plan.json
```
Expected output:
- Exit code 0
- Output contains "plan valid" or a success summary

### A2. Ensure repos + apply templates
Command:
```
aaa init ensure-repos --plan /tmp/plan.json
aaa init apply-templates --plan /tmp/plan.json
```
Expected output:
- Exit code 0
- Created repos listed in output

### A3. Protect + open PRs
Command:
```
aaa init protect --plan /tmp/plan.json
aaa init open-prs --plan /tmp/plan.json
```
Expected output:
- Exit code 0
- PR URLs printed

### A4. Verify CI + repo checks
Command:
```
aaa init verify-ci --plan /tmp/plan.json
aaa init repo-checks --plan /tmp/plan.json
```
Expected output:
- Exit code 0
- Checks list includes expected required checks (see Gate C)

## Gate B - Governance Checks

### B1. Orphaned assets
Command:
```
python3 runner/run_repo_checks.py --check orphaned_assets --repo <AAA_WORKSPACE>
```
Expected output:
- JSON `pass: true`
- No `orphaned_asset` entries in `details`

### B2. Agent safety (expected block semantics)
Command:
```
AAA_TOOLS_ROOT=<path-to-aaa-tools> \
  python3 runner/run_repo_checks.py --check agent_safety --repo <AAA_WORKSPACE>
```
Expected output:
- JSON `pass: true`
- Each case reports `status: error` with `error_code` in:
  - `SCOPE_VIOLATION`
  - `PATH_TRAVERSAL`

## Gate C - Workflow Inheritance + Required Checks

### C1. Verify reusable workflow is used
Command:
```
rg "aaa-actions/.github/workflows/eval.yml" -n .github/workflows
```
Expected output:
- At least one workflow references `ai-asset-architecture/aaa-actions/.github/workflows/eval.yml@<tag-or-main>`

### C2. Required checks names are stable (SSOT)
Minimal canonical names (v0.6):
- `orphaned_assets`
- `agent_safety`

Expected output:
- `verify-ci` output includes these names
- Branch protection rules reference the same names

## Gate D - CLI JSON Output (Minimal Contract)

Command:
```
aaa run --runbook-file <runbook.json> --json
```
Expected output:
- Output is valid JSON
- Must include keys: `status`, `error_code` (when status is error), and `message` or `result`

## Notes
- This runbook intentionally stays within v0.6 scope.
- `expected block` means the system blocked the action and returned the security error code.
