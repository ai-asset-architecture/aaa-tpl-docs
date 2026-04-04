# Evidence Bundle: v2.1.8 Result Evidence Promotion Gate

- version: `v2.1.8`
- asset: `result-evidence-promotion-gate`
- source_step:
  - Step1 contracts: schema + pass/fail fixtures
  - Step2 runtime: promotion gate validator + CLI + workflow + remote run evidence
- remote_run_ref: `gh-actions:ai-asset-architecture/aaa-tools@.github/workflows/v2-1-8-result-evidence-promotion-gate.yml#23971353018`

## Preserved Sources
- `internal/development/contracts/ops/result-artifact-eligibility-and-evidence-promotion-gate.v0.1.schema.json`
- `internal/development/contracts/ops/examples/pass/2026-04-04-v2.1.8-result-artifact-eligibility-and-evidence-promotion-gate.pass.json`
- `internal/development/contracts/ops/examples/fail/2026-04-04-v2.1.8-result-artifact-eligibility-and-evidence-promotion-gate.fail.json`
- `aaa-tools/aaa/result_artifact_eligibility_and_evidence_promotion_gate.py`
- `aaa-tools/aaa/governance_commands.py`
- `aaa-tools/aaa/cli.py`
- `aaa-tools/aaa/__init__.py`
- `aaa-tools/tests/test_result_artifact_eligibility_and_evidence_promotion_gate.py`
- `aaa-tools/.github/workflows/v2-1-8-result-evidence-promotion-gate.yml`
- `internal/development/reviews/2026-04-04-v2.1.8-result-evidence-promotion-gate-run-evidence.md`
- `internal/development/reviews/2026-04-04-v2.1.8-step2-exit-checklist.md`

## Reuse Target
- `AAA core`
- `AAA inherited projects`
