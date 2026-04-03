# AAA Tool Contract v0.1

- status: `active`
- canonical_role: `governance contract`
- canonical_source_of_truth: `aaa-tpl-docs/internal/development/contracts/ops/tool-contract.v0.1.md`
- mirror_adapter: `aaa-tools/specs/ops/tool-contract-adapter.v0.1.md`

## Normative Scope

This specification defines the canonical governance contract for AAA tools. It governs tool classification, allowed authority, execution posture, evidence obligations, target applicability, and the minimum machine-parseable fields required before a tool may be referenced by canonical commands, validators, or runtime bindings.

This specification is authoritative for:
- tool legality classification
- tool scope and target applicability
- evidence obligations attached to tool execution
- compatibility boundaries between canonical tool definitions and implementation adapters

## Non-goals

This specification does not define:
- CLI UX or slash-command wording
- command sequencing policy
- prompt phrasing or assistant response style
- internal caching strategy, retries, or transport implementation
- low-level runtime code structure in `aaa-tools`

## Override Prohibition

- `aaa-tools` adapters may bind, mirror, or operationalize tool definitions, but may not redefine canonical tool authority, scope, applicability, or evidence law.
- commands, validators, and runtime helpers may not override `tool_scope`, `applicability_target`, or `evidence_class` for convenience.
- free-text prose in downstream documents may not supersede this contract.

## Conflict Resolution

- If an implementation adapter conflicts with this canonical contract, this contract prevails.
- If a command definition requests authority beyond the referenced tool's `authority_class`, the command definition is invalid.
- If a runtime implementation can technically perform an action but the tool contract does not authorize the target scope or applicability, the runtime behavior is non-compliant.

## Version Compatibility Rule

- `patch` revisions may clarify wording, examples, and notes without changing field meaning.
- `minor` revisions may add new optional fields, enum members, or examples, if they do not alter existing semantics.
- `major` revisions are required for field removals, enum meaning changes, authority reclassification, or changed legality/evidence behavior.
- adapters must declare the canonical tool contract version they implement.

## Canonical Fields

Each canonical tool definition must include at minimum:

| Field | Type | Requirement | Notes |
| --- | --- | --- | --- |
| `tool_id` | string | required | Stable machine-parseable identifier |
| `tool_name` | string | required | Human-facing tool label |
| `tool_scope` | enum | required | Governs legal operating boundary |
| `applicability_target[]` | enum[] | required | Lists target classes the tool may legally act on |
| `input_schema_ref` | string | required | Schema or contract reference for input |
| `output_schema_ref` | string | required | Schema or contract reference for output |
| `permission_requirements` | object/ref | required | Permission or approval prerequisites |
| `progress_message_policy` | object/ref | required | Progress message obligations |
| `failure_types[]` | enum[] | required | Canonical failure taxonomy |
| `authority_class` | enum | required | Legal action authority level |
| `execution_class` | enum[] | required | Execution posture and interaction profile |
| `evidence_class` | enum[] | required | Required evidence shape after execution |

## Enumerations

### `tool_scope`

- `workspace_level`
- `repo_level`
- `worktree_level`
- `artifact_level`
- `external_system_level`

### `applicability_target`

Allowed initial target classes:
- `canonical_repo_root`
- `worktree_instance`
- `docs_artifact`
- `registry_snapshot`
- `completion_report`
- `audit_bundle`
- `runtime_summary`
- `external_service_endpoint`

### `authority_class`

- `read_only`
- `analysis_only`
- `plan_only`
- `advisory_write_draft`
- `mutation_local`
- `mutation_repo`
- `governance_gate`
- `external_side_effect`

### `execution_class`

- `sync_short`
- `sync_long`
- `multi_step`
- `interactive`
- `remote_dependent`
- `evidence_required`

### `evidence_class`

- `none`
- `stdout_only`
- `artifact_report`
- `registry_update`
- `completion_evidence`
- `audit_evidence`

### `failure_types`

Allowed initial canonical failure types:
- `invalid_input`
- `missing_context`
- `authority_violation`
- `scope_violation`
- `target_applicability_mismatch`
- `permission_denied`
- `remote_dependency_unavailable`
- `evidence_missing`
- `execution_failed`
- `policy_blocked`

## Tool Legality Rules

- A tool may only operate within its declared `tool_scope`.
- A tool may only act on targets explicitly listed in `applicability_target[]`.
- A tool with `analysis_only` or `plan_only` authority must not mutate repo-tracked state, registries, or external systems.
- A tool with `mutation_local` authority may modify ephemeral local state, but may not mutate canonical repo-tracked artifacts unless separately classified as `mutation_repo`.
- A tool with `governance_gate` authority may evaluate, validate, or block transitions, but must still obey scope and evidence rules.
- A tool with `external_side_effect` authority must declare `external_system_level` scope or an explicitly compatible target class.

## Evidence Rules

- `evidence_class = none` is only valid for tools whose outcome does not contribute to governance state, completion state, or audit trace.
- Any tool classified with `evidence_required` in `execution_class` must declare at least one non-`none` `evidence_class`.
- Tools affecting registry, closeout, audit, or gate decisions must not use `stdout_only` as their sole evidence class.
- If a tool produces data later consumed as governance evidence, the tool definition must declare the strongest applicable evidence class at tool-contract level rather than relying on command prose.

## Example Canonical Tool Definition Shape

```json
{
  "tool_id": "ops.registry.rebuild",
  "tool_name": "Ops Registry Rebuild",
  "tool_scope": "repo_level",
  "applicability_target": ["registry_snapshot", "docs_artifact"],
  "input_schema_ref": "aaa-tpl-docs/.../registry-rebuild-input.v0.1.schema.json",
  "output_schema_ref": "aaa-tpl-docs/.../registry-rebuild-output.v0.1.schema.json",
  "permission_requirements": {
    "approval_mode": "repo_mutation_required"
  },
  "progress_message_policy": {
    "must_emit": ["start", "progress", "result"]
  },
  "failure_types": [
    "missing_context",
    "permission_denied",
    "execution_failed",
    "evidence_missing"
  ],
  "authority_class": "mutation_repo",
  "execution_class": ["multi_step", "evidence_required"],
  "evidence_class": ["registry_update", "artifact_report"]
}
```
