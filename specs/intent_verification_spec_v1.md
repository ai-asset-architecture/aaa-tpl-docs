# Intent Verification Specification (v1.0)

> **Purpose**: Define the pre-execution governance gate that validates Agent Intent against System Policies and Actor Capabilities.

## 1. Context Analysis
- **Goal**: Detect intent-outcome mismatch before any side-effect occurs.
- **Scope**: Covers LLM-generated plans, tool calls, and structured outputs.

## 2. Verification Gates
1. **Contract Check**: Does the intent match the `Zod` or `JSON Schema` defined for the capability?
2. **Policy Compliance**: Does the intent violate any `Deny-by-Default` or `Static Attribute` rules?
3. **Semantic Consistency**: Is the intent consistent with the current mission context? (v1.5/v1.6).

## 3. Governance Outcomes
- **PASS**: Intent proceeds to Execution Gate.
- **BLOCK**: Intent is rejected with `ERR_SCOPE_DENY`.
- **REDACT**: Sensitive intent components are scrubbed before proceeding.

---
*Referenced in AAA Roadmap v1.7*
