# Runbook Runtime Contract (v0.6)

## Purpose
Define the minimum contract between runbook definitions and the runtime engine.

## Contract
1) Runbook spec format
- Runbook spec must be `<id>@<version>`.
- Runtime resolves to `runbooks/<id>.yaml` under repo root.

2) Checksum integrity
- `metadata.checksum` must match the computed checksum.
- Any runbook edit must update the checksum.

3) Required scopes
- `contract.required_scopes` must include scopes required by actions.
- Missing scopes must be treated as a runtime error.

4) Execution output
- Runtime returns JSON with at least: `status` and `result` or `message`.
- Security blocks must return `error_code` (e.g., PATH_TRAVERSAL, SCOPE_VIOLATION).

5) Action registry
- Actions are resolved via registry; unknown actions are runtime errors.
- Scope enforcement occurs before action execution.

## Minimum Action Scopes (v0.6)
- governance.update_index -> gov:index
- fs_write, fs_update_frontmatter -> fs:write
- notify -> notify:send
- aaa_evals.run -> eval:run

## Known Failure Modes
- checksum mismatch
- missing required scope
- runbook not found

## Operational Guidance
- Always update checksum when editing runbooks.
- Keep runbook contract aligned with CLI behavior.
- Use Gate B2 tests to validate scope/path traversal enforcement.
