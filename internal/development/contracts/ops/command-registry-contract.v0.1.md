# AAA Command Registry Contract v0.1

- status: `active`
- canonical_role: `governance contract`
- canonical_source_of_truth: `aaa-tpl-docs/internal/development/contracts/ops/command-registry-contract.v0.1.md`
- mirror_adapter: `aaa-tools/specs/ops/command-registry-adapter.v0.1.md`

## Normative Scope

This specification defines the canonical governance contract for AAA commands. A command is a governance-intent entrypoint, not a mere alias for a tool. This contract governs command identity, intent, target scope, required context bundles, allowed authority envelope, machine-parseable dependency references, expected artifacts, and escalation behavior.

This specification is authoritative for:
- command identity and intent classification
- machine-parseable dependency binding
- command-to-tool authority compatibility
- artifact and escalation obligations attached to command execution

## Non-goals

This specification does not define:
- terminal wording, help text, or CLI flags
- detailed tool internals
- runtime scheduling algorithms
- prompt decoration or assistant tone
- transport-specific execution details

## Override Prohibition

- commands may not override tool authority, tool scope, target applicability, or context contamination law.
- prose-only dependency descriptions are not sufficient to establish canonical command bindings.
- adapters may not redefine command intent or dependency semantics outside the canonical registry contract.

## Conflict Resolution

- if a command contract conflicts with the referenced tool contract, the tool contract prevails on authority, scope, and evidence legality.
- if a command requests a context source prohibited by the context assembly contract, the command is invalid.
- if an adapter omits a required dependency reference present in canonical contract, the adapter is incomplete and non-authoritative.

## Version Compatibility Rule

- `patch` revisions may clarify dependency semantics or examples without changing required fields.
- `minor` revisions may add optional fields or new enum members.
- `major` revisions are required for command field removals, dependency model changes, or new binding rules that invalidate older adapters.

## Canonical Fields

Each canonical command definition must include at minimum:

| Field | Type | Requirement | Notes |
| --- | --- | --- | --- |
| `command_id` | string | required | Stable command identity |
| `intent_class` | string/enum | required | Governance intent family |
| `target_scope` | enum[] | required | Legal target boundary |
| `required_context_bundle` | string/ref | required | Canonical required context bundle id |
| `allowed_authority` | enum[] | required | Max authority envelope allowed for this command |
| `default_tool_chain` | string[] | required | Ordered default operational sequence |
| `expected_output_artifact` | string[] | required | Artifacts command is expected to emit or update |
| `failure_escalation_path` | string/ref | required | Canonical escalation route |
| `tool_chain_refs[]` | string[] | required | Machine-parseable refs to canonical tools |
| `context_bundle_refs[]` | string[] | required | Machine-parseable refs to canonical context bundles |
| `artifact_contract_refs[]` | string[] | required | Machine-parseable refs to artifact/evidence contracts |
| `governance_dependency_refs[]` | string[] | required | Machine-parseable refs to governing law/contract dependencies |

## Required Binding Law

- canonical command dependencies must be machine-parseable.
- prose may explain a dependency, but may not be the only binding.
- `tool_chain_refs[]`, `context_bundle_refs[]`, `artifact_contract_refs[]`, and `governance_dependency_refs[]` are mandatory, not advisory.
- a command without explicit dependency refs is incomplete and may not be treated as canonical.

## Command Legality Rules

- `allowed_authority` must not exceed the authority classes of the referenced `tool_chain_refs[]`.
- command execution may only target scopes compatible with the referenced tools and context law.
- commands that can affect gate, registry, completion, or audit state must declare explicit artifact outputs and escalation path.
- if a command includes any repo mutation step, `expected_output_artifact` must include the canonical target artifact class, not only human-readable prose.

## Example Canonical Command Definition Shape

```json
{
  "command_id": "aaa.ops.registry.rebuild",
  "intent_class": "registry_maintenance",
  "target_scope": ["repo_level", "artifact_level"],
  "required_context_bundle": "context.bundle.ops.registry.rebuild.v0.1",
  "allowed_authority": ["analysis_only", "mutation_repo"],
  "default_tool_chain": [
    "ops.registry.inspect",
    "ops.registry.rebuild",
    "ops.registry.validate"
  ],
  "expected_output_artifact": [
    "registry_snapshot",
    "artifact_report"
  ],
  "failure_escalation_path": "escalation.ops.registry.rebuild.v0.1",
  "tool_chain_refs": [
    "ops.registry.inspect",
    "ops.registry.rebuild",
    "ops.registry.validate"
  ],
  "context_bundle_refs": [
    "context.bundle.ops.registry.rebuild.v0.1"
  ],
  "artifact_contract_refs": [
    "artifact.contract.registry_snapshot.v0.1"
  ],
  "governance_dependency_refs": [
    "law.governance.source-precedence-and-change.v0.1",
    "contract.tool.v0.1",
    "contract.context-assembly.v0.1"
  ]
}
```
