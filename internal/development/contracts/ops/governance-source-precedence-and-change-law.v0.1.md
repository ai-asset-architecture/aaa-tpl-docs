# AAA Governance Source Precedence and Change Law v0.1

- status: `active`
- canonical_role: `governing law`
- canonical_source_of_truth: `aaa-tpl-docs/internal/development/contracts/ops/governance-source-precedence-and-change-law.v0.1.md`

## Normative Scope

This document is the governing law for source precedence, mirror precedence, change ordering, stale-mirror handling, and spec conflict resolution across AAA governance contracts and implementation mirrors.

This law is authoritative for:
- precedence between canonical contracts and mirrors
- order of change across canonical spec, adapter, validators, and downstream adopters
- stale-state handling
- classification of breaking versus non-breaking spec changes

## Non-goals

This law does not define:
- individual tool fields
- command business logic
- CLI UX
- prompt text
- runtime code structure

## Override Prohibition

- no adapter, validator, runtime binder, or downstream adopter may override canonical governance law.
- no mirror may claim canonical status through freshness, implementation detail, or operational convenience.
- no downstream document may invert the prescribed change sequence.

## Conflict Resolution

Precedence order:
1. this governing law
2. canonical contracts in `aaa-tpl-docs`
3. implementation mirrors/adapters in `aaa-tools`
4. validators and executable bindings
5. downstream adopters and runtime helpers

If two layers conflict, the higher layer prevails. Lower-layer convenience never supersedes higher-layer law.

## Version Compatibility Rule

- `patch`: wording clarifications, examples, metadata refinements
- `minor`: additive fields or classifications that do not invalidate existing bindings
- `major`: precedence changes, change-sequence changes, override-law changes, or stale-handling changes

## Canonical Source Precedence Law

- canonical contracts in `aaa-tpl-docs` are the sole source of governance meaning.
- implementation mirrors in `aaa-tools` are bindings, not lawmakers.
- mirror freshness does not outrank canonical authority.
- runtime summaries, validator outputs, or operator logs never become canonical by implementation convenience alone.

## Change Sequence Law

Required change order:
1. canonical contract / governing law
2. implementation mirror / adapter
3. validators / bindings
4. downstream adopters

This order is mandatory for both additions and behavior changes.

## Mirror Stale-State Handling

- if canonical changes and mirror is stale, canonical remains authoritative and mirror is temporarily incomplete.
- stale mirror state must not be interpreted as an alternate canonical branch.
- validators should fail closed when they depend on stale mirror semantics that no longer match canonical law.

## Breaking vs Non-Breaking Classification

Breaking changes include:
- source precedence reordering
- promotion-law changes
- removal of required canonical fields
- authority-class meaning changes
- command dependency binding model changes

Non-breaking changes include:
- additive enum members
- additive optional fields
- clarification examples
- machine-parseable metadata additions that preserve prior meaning

## Cross-Contract Binding Law

- `tool contract`, `command registry contract`, and `context assembly contract` must reference this governing law where precedence or promotion behavior matters.
- mirror adapters must declare which canonical version and governing-law version they implement.
- downstream adopters must not define local exceptions to canonical source precedence.
