# AAA Context Assembly Contract v0.1

- status: `active`
- canonical_role: `governance contract`
- canonical_source_of_truth: `aaa-tpl-docs/internal/development/contracts/ops/context-assembly-contract.v0.1.md`
- mirror_adapter: `aaa-tools/specs/ops/context-assembly-adapter.v0.1.md`

## Normative Scope

This specification defines the canonical current-truth source model, context bundle composition rules, and contamination isolation law for AAA. It governs what sources may be used as current truth, what may only be used as supporting evidence, how context bundles are assembled, and what sources are prohibited from promotion into governance truth.

This specification is authoritative for:
- canonical current truth source eligibility
- context assembly precedence
- promotion law between source classes
- anti-contamination boundaries between canonical truth and local/operator traces

## Non-goals

This specification does not define:
- command UX or CLI flags
- tool internal caching strategy
- runtime memoization or session storage internals
- transcript rendering or assistant response phrasing

## Override Prohibition

- commands and tools may not override anti-contamination law.
- runtime convenience, summarization shortcuts, or local operator habits may not override source precedence.
- adapters may not promote a source class beyond what this canonical contract permits.

## Conflict Resolution

- if runtime convenience conflicts with canonical context law, canonical context law prevails.
- if a command or tool attempts to treat a prohibited source as current truth, the assembly result is invalid.
- if a mirror adapter describes looser promotion rules than this contract, the mirror is non-authoritative.

## Version Compatibility Rule

- `patch` revisions may clarify source-class examples or explanatory notes.
- `minor` revisions may add new source classes or bundle fields without changing precedence of existing classes.
- `major` revisions are required for precedence-rank changes, promotion-law changes, or current-truth eligibility changes for existing source classes.

## Core Rules

- Canonical current truth must come from eligible canonical source classes only.
- Supporting evidence may supplement current truth, but may not silently replace it.
- Local operation logs must never be treated as repo state, command readiness, session truth, or governance source.
- Promotion from supporting evidence to current truth is only legal if explicitly allowed by this contract or a higher-ranking governing law.

## Context Bundle Model

Each canonical context bundle must declare:

| Field | Type | Requirement | Notes |
| --- | --- | --- | --- |
| `bundle_id` | string | required | Stable machine-parseable id |
| `bundle_purpose` | string | required | Intent or runtime use |
| `required_source_classes[]` | string[] | required | Required inputs |
| `optional_source_classes[]` | string[] | optional | Permitted supplements |
| `promotion_rules_ref` | string | required | Governing promotion law |
| `contamination_rules_ref` | string | required | Governing anti-contamination rule |

## Source Precedence Table

| source_class | allowed_as_current_truth | allowed_as_supporting_evidence | promotion_allowed | precedence_rank | notes |
| --- | --- | --- | --- | --- | --- |
| `canonical_contract_docs` | yes | yes | n/a | 1 | Highest legal source for governance rules and contracts |
| `canonical_registries_indexes` | yes | yes | yes | 2 | Registry/index truth when generated and preserved under canonical law |
| `preserved_completion_audit_artifacts` | yes | yes | yes | 3 | Completion/audit artifacts may carry current truth for preserved execution outcomes |
| `repo_tracked_files` | yes | yes | yes | 4 | Repo-tracked canonical content below contract and registry layers |
| `worktree_state` | no | yes | no | 5 | Operational state only; never canonical truth by itself |
| `local_operation_logs` | no | yes | no | 6 | Only `ephemeral_operator_trace`, `troubleshooting_input`, `optional_evidence_supplement` |
| `ad_hoc_scratch_notes` | no | yes | no | 7 | Planning or scratch material only |
| `generated_runtime_summaries` | no | yes | no | 8 | Derived convenience summaries, never canonical by default |
| `external_execution_outputs` | no | yes | conditional | 9 | May support or preserve evidence only when separately bound by canonical artifact law |

## Anti-Contamination Law

### Allowed local-log roles

Local operation logs may only be used as:
- `ephemeral_operator_trace`
- `troubleshooting_input`
- `optional_evidence_supplement`

### Prohibited local-log promotions

Local operation logs must not directly become:
- `repo_state`
- `command_readiness`
- `session_truth`
- `governance_source`

### Runtime-summary restriction

Generated runtime summaries may accelerate operator understanding, but may not replace:
- canonical contracts
- canonical registries/indexes
- preserved completion/audit artifacts
- repo-tracked current truth

## Example Context Bundle Shape

```json
{
  "bundle_id": "context.bundle.ops.step4.closeout.v0.1",
  "bundle_purpose": "step4 closeout validation",
  "required_source_classes": [
    "canonical_contract_docs",
    "canonical_registries_indexes",
    "preserved_completion_audit_artifacts",
    "repo_tracked_files"
  ],
  "optional_source_classes": [
    "local_operation_logs",
    "external_execution_outputs"
  ],
  "promotion_rules_ref": "law.governance.source-precedence-and-change.v0.1",
  "contamination_rules_ref": "contract.context-assembly.v0.1#anti-contamination-law"
}
```
