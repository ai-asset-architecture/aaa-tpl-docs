# Governance Evals Report (20260119_0018)

## Summary
All governance eval checks passed across the AAA org repos.

## Results
- `.github`: readme PASS, workflow PASS (no workflows to check)
- `aaa-actions`: readme PASS, workflow PASS (self-check skipped)
- `aaa-tools`: readme PASS, workflow PASS (no workflows to check), skills PASS
- `aaa-prompts`: prompt schema PASS
- `aaa-evals`: readme PASS, workflow PASS (no workflows to check)
- `aaa-tpl-docs`: readme PASS, workflow PASS
- `aaa-tpl-service`: readme PASS, workflow PASS
- `aaa-tpl-frontend`: readme PASS, workflow PASS
- `aaa-observability`: readme PASS, workflow PASS (no workflows to check)

## Notes
- Workflow checks pass when no workflows exist; only template repos require pinned workflows.
- Prompt schema validation uses fallback checks if jsonschema is unavailable.
