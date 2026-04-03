# Evidence Bundle: v2.1.1 Tool Command Adoption

- version: `v2.1.1`
- asset_group: `tool-command-adoption`
- computed_at_taipei: `2026-04-04T02:36:35+08:00`
- remote_run_ref: `gh-actions:ai-asset-architecture/aaa-tools@.github/workflows/v2-1-1-tool-command-adoption.yml#23957470365`

## Included Files
- `internal/development/evidence/v2.1.1/tool-command-adoption/result.json`
- `internal/development/evidence/v2.1.1/tool-command-adoption/index.json`
- `internal/development/evidence/v2.1.1/tool-command-adoption/run-evidence.md`
- `internal/development/evidence/v2.1.1/tool-command-adoption/asset-manifest.v0.1.json`

## Source References
- Step1 contract schema:
  - `internal/development/contracts/ops/tool-command-adoption-bundle.v0.1.schema.json`
- Step1 fixtures:
  - `internal/development/contracts/ops/examples/pass/2026-04-04-v2.1.1-tool-command-adoption-bundle.pass.json`
  - `internal/development/contracts/ops/examples/fail/2026-04-04-v2.1.1-tool-command-adoption-bundle.fail.json`
- Step2 implementation:
  - `aaa-tools/aaa/tool_command_adoption.py`
  - `aaa-tools/aaa/governance_commands.py`
  - `aaa-tools/aaa/cli.py`
  - `aaa-tools/tests/test_tool_command_adoption.py`
  - `aaa-tools/.github/workflows/v2-1-1-tool-command-adoption.yml`
- Step2 control evidence:
  - `internal/development/reviews/2026-04-04-v2.1.1-tool-command-adoption-run-evidence.md`
  - `internal/development/reviews/2026-04-04-v2.1.1-step2-exit-checklist.md`

## Reuse Intent
- `AAA core`
- `AAA inherited projects`
