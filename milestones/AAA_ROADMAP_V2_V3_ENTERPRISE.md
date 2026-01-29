# AAA v2.0-v3.0 Roadmap (Enterprise Edition)

> **Document Status**: DRAFT v1.9 (Audit-Immune Control Plane - Gold)  
> **Target Audience**: CTO / Enterprise Architect / Governance Committee  
> **Purpose**: Defines the engineering path to extend AAA governance from artifacts (v1.x) to runtime connectivity and autonomous settlement (v2.x-v3.0), prioritizing security boundaries and auditability over feature expansion.

---

## Changelog
| Version | Date | Summary of Changes |
| :--- | :--- | :--- |
| **v1.1** | 2026-01-29 | Initial Strategic Blueprint with Hard DoDs. |
| **v1.2** | 2026-01-29 | Portable paths, terminology normalization (Exec Sidecar), and Secret Exfiltration risk. |
| **v1.3** | 2026-01-29 | **[HARDENED]** Host Integrity disclaimer, mTLS-first auth policy, Reason Codes, CC Threshold rationale, and Risk Table completion. |
| **v1.4** | 2026-01-29 | **[FINAL AUDIT]** JWT escalation rules, Reason Code mapping table, CC Pricing variables, and v3.0 KPI definitions. |
| **v1.5** | 2026-01-29 | **[AUDIT-RESILIENT]** Reason Code normalization, JWT/Court triage分流, Quarantine TTL, and KPI precision. |
| **v1.6** | 2026-01-29 | **[AUDIT-IMMUNE]** Triage SLAs, Quarantine Scope defined, Leak Classes, and Enum Spec anchoring. |
| **v1.7** | 2026-01-29 | **[CONTROL PLANE]** N=3 Escalation, Incident Schema, SLA Clock, CLI Command Contracts, and Enum Gate. |
| **v1.8** | 2026-01-29 | **[FINAL HARDENED]** N=3 Rationale, Bundle Contract, Replay Determinism, and Enum Fail-Closed Gate. |
| **v1.9** | 2026-01-29 | **[GOLD]** N/A usage rules, Triage priority hardening, Bot identity spec, and Audit model split. |

---

## 0. Executive Summary
The goal of AAA v2.x–v3.x is not "more features," but to extend the governance authority established in v1.x into the **Agent Runtime**. Every execution must be **Scoped, Audited, Replayable, Adjudicated, and Settled**. We are building a "Governance Sidecar" that wraps agent connectivity, not a new agent platform.

## 1. Scope & Non-Goals

### In Scope (Commitments)
*   **Trust Boundary (v2.0.1)**: Identity, Capability, Authorization, Revocation, and Audit Evidence Chain.
*   **Runtime Governance Sidecar (v2.1–v2.3)**: Secure Bridging, Endpoint Capability Allowlisting, **Exec Sidecar (No Raw Shell)**, Capability Mesh.
*   **Governance-Backed Settlement (v2.4–v3.0)**: Compute/Task Settlement based on **Algorithmic SLAs** (Deterministic Verification).

### Non-Goals (Exclusions)
*   ❌ **General Purpose Agent Runtime**: We will not compete with Microsoft/OpenAI/Anthropic on agent orchestration platforms.
*   ❌ **Arbitrary Desktop Automation**: No "unrestricted shell access." Desktop capabilities are strictly allowlisted.
*   ❌ **Direct Shell Exposure**: **Zero Raw Shell**. Execution is only via the Exec Sidecar with validated command specs.
*   ❌ **Host Integrity Guarantee**: AAA Sidecar does not guarantee protection if the host OS is already compromised; responsibility is limited to "Capability Enforcement + Fail-Closed + Evidence Output."
*   ❌ **Blockchain/Web3**: No crypto tokens or on-chain requirements. The "Economy" layer is an internal, audit-backed settlement ledger.

---

## 2. Definitions (De-hyped Terminology)

| Term | Definition |
| :--- | :--- |
| **Handshake** | Verifiable connection establishment including identity proof, capability exchange, rotation, and revocation checks. |
| **Scope Control** | Mandatory runtime enforcement of agent permissions (Deny-by-Default). |
| **Capability** | An explicitly declared, authorized, and audited unit of action (e.g., `read_file`, `call_api`). |
| **Exec Sidecar** | The only allowed execution path. Implements a wrapper around OS commands with strict allowlisting. |
| **Algorithmic SLA** | *Replaces "Smart Contract"*. Deterministic verification logic (tests/evals) that dictates settlement outcomes. |
| **Governance-Backed Settlement** | Settlement process driven by hard evidence (Ledger + Court Rulings + Test Results). |
| **Sidecar** | An architectural pattern where AAA intercepts, audits, and enforces policy without replacing the host system. |
| **Incident Queue (P2)** | Managed queue for misconfigurations. SLA: Triage within 24h. Schema: `id, category, created_at, triage_at, owner, resolution, evidence_link`. Escalates to Court after `N_default=3` repetitive failures. |
| **Governance Parameters** | `N_default=3` (Rationale: Noise suppression vs persistency). Update requires CaseFile + Evidence + 2-person approval. **Bot Approver** MUST be a certified AAA agent identity (Enterprise Cert). |

---

## 3. Asset Linking (Hard Evidence)

*   **v1.8 Observability 2.0 / RiskLedger**: The immutable store for all Audit Logs, Metrics, and Risk Events.
*   **v1.9 Supreme Court / CaseFile**: The final arbiter for violations, disputes, and precedent setting.
*   **Project OMEGA**: The comprehensive acceptance suite (135+ tests, E2E simulation) used to validate every DoD.
*   **v1.5/v1.6 Intent Verification**: [intent_verification_spec_v1.md](../specs/intent_verification_spec_v1.md) (Compliance Checks).

---

## 4. Roadmap Overview

| Version | Theme | Goal | Core Deliverable |
| :--- | :--- | :--- | :--- |
| **v2.0.1** | **Trust Boundary Release** | Runtime Security Foundation | Production-Ready Handshake + Scope Enforcement + Audit Evidence |
| **v2.1** | **Bridge MVP** | Controlled Channel | SSE Bridge (authz/limit/audit/deny) |
| **v2.2** | **Endpoint MVP** | Controlled Endpoint | macOS Desktop Bridge (allowlist + revocation + sandbox) |
| **v2.3** | **Mesh MVP** | Governed Mesh | Capability Mesh (schema/discovery/version/remote check) |
| **v2.4** | **Settlement MVP** | Minimal Economic Layer | Compute Credits (Accounting) + Algorithmic SLA |
| **v2.5+** | **Market Hardening** | Enterprise Task Market | Task Bounties (Verification/Dispute) + Reputation Hooks |
| **v3.0** | **Autonomous Governance** | Controlled Autonomy | Policy-enforced autonomy + Court Precedents |

---

## 5. Version Details & Non-Negotiable DoDs

### v2.0.1 — Trust Boundary Release
*Target: The boundary becomes a verifiable security baseline.*

#### Value Proposition
Upgrade AAA from a "Coroner" (post-mortem artifacts) to a "Bodyguard" (runtime enforcement). No runtime operation happens without ID, Authorization, Scope, and Evidence.

#### Non-Negotiable DoD
1.  **Deny-by-Default**: Unauthorized capabilities are rejected with traceable reason codes.
2.  **Auth Policy: mTLS Default**: mTLS is mandatory for backend connections. JWT is only permitted for `RiskTier=LOW` & `CapabilityClass=EDGE_TRIGGER` sessions (< 1h).
    *   **JWT Triage**: Unauthorized capability attempts via JWT trigger `ERR_SCOPE_DENY` + **Auto-Court**. 
    *   **Misconfig Triage**: Policy mismatches trigger `ERR_POLICY_HASH_MISMATCH` + **Incident Queue** (No Auto-Court).
3.  **Canonical Spec Compliance**: Implements [trust_boundary_spec_v1.md](../specs/trust_boundary_spec_v1.md) (mTLS priority, rotation SLA, reason codes).
4.  **Reason Code Minimum Set**: Standardized codes used for audit: `ERR_ID_EXPIRED` (Cert Rotation >24h), `ERR_TOKEN_EXPIRED` (JWT >1h), `ERR_SCOPE_DENY`, `ERR_REPLAY`, `ERR_REVOKED`, `ERR_RATE_LIMIT`, `ERR_POLICY_HASH_MISMATCH`, `ERR_AUDIT_SCHEMA_MISSING`, `ERR_FAIL_CLOSED`.
5.  **Replay Protection**: Nonce + TTL implementation; replay attempts are rejected and logged.
6.  **Revocation Enforcement**: Revoked keys/identities result in immediate denial of service.
7.  **Audit Log Schema**: Minimal viable schema (actor, capability, scope, decision, reason, request_id, hash).
8.  **RiskLedger Integration**: All allow/deny decisions persist to [v1.8 Ledger](./20260129_v1.8_observability_2.0.md).
9.  **Court Auto-Trigger**: Unauthorized access/replay attacks file a [v1.9 Court Case](./20260129_v1.9_supreme_court_interface.md). **Priority**: Auto-trigger respects triage; misconfig/policy mismatch MUST NOT file court directly.
10. **OMEGA Extension**: New test suite for Handshake, Replay, Revoke, Deny, and Court Trigger.

### v2.1 — Bridge MVP (SSE Bridge Server)
*Target: A controlled channel for Agent-to-Runtime communication.*

#### Value Proposition
Establish a "Managed Channel" where all Agent-Runtime traffic passes through the AAA Sidecar for authorization, throttling, and audit.

#### Non-Negotiable DoD
1.  **Handshake Required**: Connection rejected without valid v2.0.1 handshake.
2.  **Authz per Capability**: Every message must cite a capability ID; unauthorized messages rejected.
3.  **Connection Identity Binding**: Identity is bound to the connection; no mid-stream actor switching.
4.  **Full Audit Trail**: Request/Decision/Result flow into [v1.8 Ledger](./20260129_v1.8_observability_2.0.md).
5.  **Policy Hot Reload**: New requests obey updated policies immediately; existing connections cannot bypass.
6.  **Fail-Closed Mode**: Bridge failure defaults to "Deny All". Fail-Open requires Court documentation.
7.  **Remote Audit Pack**: Ability to export a time-bound evidence bundle for external audit.
8.  **OMEGA Bridge Suite**: E2E simulation of Bridge defense and policy enforcement using the [OMEGA framework](../../aaa-tools/tests/e2e/omega_run_final.sh).

### v2.2 — Endpoint MVP (macOS Desktop Bridge)
*Target: Bringing endpoint capabilities under governance without building a desktop platform.*

#### Value Proposition
Expose endpoint capabilities (macOS) via a strictly allowlisted, revocable, and auditable API.

#### Non-Negotiable DoD
1.  **Allowlist Only**: Only explicitly declared capabilities are exposed; NO raw shell access.
2.  **Exec Sidecar (v1)**: All command execution is wrapped and audited; no direct process spawning.
3.  **Sandbox Profile Enforced**: Path, process, and network restrictions are mandatory and unavoidable.
4.  **Secrets Hygiene**: Scrubber filters sensitive patterns; leaks trigger Court Case. 
    *   **Leak Classes & Triage**: 
        *   `CREDENTIAL/API_KEY` → **Auto-Court**.
        *   `PII/PROMPT_SENSITIVE/FILE_CONTENT_SENSITIVE` → **Incident Queue** (Escalate on N=3).
5.  **Revocation Works**: Revoking a capability immediately stops its function on the endpoint.
6.  **Evidence Bundle**: Exportable proof of endpoint operations (with hash chain).
7.  **Drift Detection Hook**: Detects if endpoint capabilities drift from policy versions (v0.9/v1.8).
8.  **Court Precedent Mapping**: Endpoint violations map to specific [v1.9 Case Types](./20260129_v1.9_supreme_court_interface.md).
9.  **OMEGA Endpoint Suite**: E2E simulation of endpoint abuse and authorization checks.

### v2.3 — Mesh MVP (Capability Mesh)
*Target: Converging ad-hoc capabilities into a discoverable, governed mesh.*

#### Value Proposition
Prevent "governance drift" by standardizing how capabilities are discovered, authorized, and version-handshaked across the network.

#### Non-Negotiable DoD
1.  **Capability Schema v1**: Unified schema (ID, Version, Risk, I/O) used system-wide (v1.2).
2.  **Version Handshake**: Nodes must verify protocol/policy version compatibility before interaction.
3.  **Authz Separation**: Discovery (Seeing) != Permission (Using).
4.  **Policy Hash Agreement**: Connection requires mutual agreement on active Policy Hash.
5.  **Remote Check**: `aaa check --remote` verifies mesh node health and drift status.
6.  **Ledger-First Observability**: All mesh operations write to [v1.8 Ledger](./20260129_v1.8_observability_2.0.md).
7.  **Court Escalation**: Inconsistent/Poisoned mesh nodes trigger [v1.9 Court Case](./20260129_v1.9_supreme_court_interface.md).
8.  **Supply Chain Hooks**: Capability Packs must verify signatures/provenance (v1.7).
9.  **OMEGA Mesh Suite**: Simulation of mesh drift, poisoning, and revocation scenarios.

### v2.4 — Settlement MVP (Compute Credits + Algorithmic SLA)
*Target: Minimal economic layer for resource accounting and deterministic settlement.*

#### Value Proposition
Introduce "Compute Credits" not for crypto speculation, but for Enterprise Resource Governance. Settlement is driven by **Algorithmic SLAs** (Tests/Evals).

#### Non-Negotiable DoD
1.  **CC Ledger Model**: Schema for Compute Credits, sources, and exchange rates (v1.8).
2.  **CC Pricing Function**: Defined cost model. Inputs: `token_in`, `token_out`, `wall_time_ms`, `tier`, `risk_multiplier`. Units: `CC/1k Tokens` or `CC/Second`.
3.  **Threshold Rationale**: Initial thresholds (5% variance, 10% block) are conservative baselines. Each mission has a `Mission-Max CC` cap; exceeding this triggers an immediate Court Review.
4.  **Reconciliation Flow**: Automated audit of Estimated vs Actual CC cost; < 5% variance required.
5.  **Reconciliation Overflow**: Variance > 10% blocks settlement and triggers a Court Review.
6.  **Anti-Cheat**: Replay/Forged results rejected; attempts trigger Court Case.
7.  **Algorithmic SLA v1**: Verification logic (tests) must be deterministically replayable.
8.  **Settlement Traceability**: Trace every settlement to Inputs, Policy, Tests, and Decision.
9.  **Court Integration**: Settlement disputes automatically package evidence into a [v1.9 Case File](./20260129_v1.9_supreme_court_interface.md).
10. **Privacy Scrubber**: Settlement/Audit exports must be scrubbed of sensitive data (v1.8).
11. **OMEGA Settlement Suite**: E2E simulation of successful, failed, cheated, and disputed settlements.

### v3.0 — Autonomous Governance (Engineering Edition)
*Target: Controlled Autonomy where humans handle exceptions, and systems handle precedents.*

#### Value Proposition
Autonomy is not "removing humans," but "humans handling exceptions only." Routine decisions are driven by Policy + Evidence + Court Precedents.

#### Non-Negotiable DoD
1.  **Autonomy Modes**: Manual / Supervised / Autonomous; switching requires logged evidence.
2.  **Exception-Only Human Load**: Human intervention is strictly for defined exceptions (measurable).
3.  **Precedent-Driven Decisions**: New events match against [v1.9 Court Precedents](./20260129_v1.9_supreme_court_interface.md) for auto-ruling.
4.  **Fail-Safe**: System fails to "Closed" or "Escalate" on uncertainty.
5.  **Governed Settlement**: Autonomous tasks still require SLA validation for settlement.
6.  **Federated Auditability**: Cross-org audit bundles are exportable and verifiable (v1.7).
7.  **Autonomy KPI Model**: v3.0 must provide measurable KPIs:
    *   **Auto-ruling Rate**: `Automated Decisions / Total Events`.
    *   **Escalation Rate**: `Human Escalations / Total Events`.
    *   **False Escalation Rate**: `Post-Audit Overturns / Total Escalations` (Overturn = Human reversal of a system-proposed auto-ruling).
8.  **OMEGA v3 Suite**: Full lifecycle autonomy simulation with replayable failure modes.

---

## 6. Risk Register

| Risk | Mitigation Strategy |
| :--- | :--- |
| **Attack Surface Expansion** | Strict v2.0.1 DoD; Deny-by-default; Evidence-First Architecture. |
| **Secret Exfiltration / Leaked PII** | Privacy Scrubber; Raw Shell Ban; Exec Sidecar Inspection; Court Triggers. |
| **Prompt Injection / Tool Misuse** | Intent Verification (v1.7) + Capability Allowlist + Court Adjudication. |
| **Insider / Misconfiguration** | Fail-Closed Default + Remote Check + Policy Hash Agreement + Drift Detection. |
| **Product Scope Drift** | Adhere to Sidecar Principle: Wrap/Filter/Enforce, do not Replace. |
| **Compliance Panic (Econ)** | Terminology shift: Algorithmic SLA / Governance Settlement; No blockchain. |
| **DoD Degradation** | Mandatory OMEGA suite extension for every release version. |

---

## 7. Acceptance Strategy
*   **OMEGA Lifecycle Architecture**: `aaa-tools/tests/e2e/` contains the lifecycle runner; `aaa-tools/tests/omega/vX.Y/` contains version-specific suites.
*   **OMEGA Expansion**: Every version MUST add a corresponding OMEGA test suite in `aaa-tools/tests/omega/vX.Y/`.
*   **Evidence Bundles**: Every claim must be backed by an exportable Ledger/Case/Test bundle per [v2.0.1 Spec](../specs/trust_boundary_spec_v1.md).
*   **Court Intervention**: Violations and disputes are resolved via v1.9 Case Files, creating a precedent database.

## 8. Minimal KPIs
*   **Drift Rate**: Frequency of policy/version mismatch.
*   **Gate Pass Rate**: Percentage of operations passing governance gates.
*   **MTTD/MTTR**: Mean Time To Detect/Repair governance violations.
*   **Audit Completeness**: Percentage of operations with full evidence chains.
*   **Dispute Resolution Time**: Speed of resolving settlement/policy disputes.

---

## Appendix A: Evidence Index (Release Gate Standard)

> **Release Gate Requirement**: All `Repo/Path` entries must be verifiable (`test -f`). All `OMEGA Test ID` entries must be searchable by the runner. All artifact paths must be reproducible during the OMEGA FSAT.  
> **N/A Policy**: Court Case Type is `N/A` IF AND ONLY IF the DoD states 'No Auto-Court' and the event is non-adjudicative.  
> **Control Plane Entrypoints**:
> - Evidence Bundle Generator: `aaa export --evidence --version <ver>` (Package: `ledger_export.jsonl, policy_snapshot.json, test_results.json, hash_chain.txt`)
> - Replay Entrypoint: `aaa omega replay --bundle <path>` (Identity check: Decisions/Hashes MUST match original bundle)
> - Enum Consistency Gate: `aaa check --enums` (Enforced via CI; Mismatch fails-closed & blocks Release)
> **Canonical Enums**:  
> - Ledger Event Spec: [ledger_event_enum_v1.md](../specs/ledger_event_enum_v1.md)  
> - Court CaseType Spec: [court_case_type_enum_v1.md](../specs/court_case_type_enum_v1.md)

| DoD Item | Related Asset (Repo/Path) | OMEGA Test ID | Ledger Event | Court Case Type | Evidence Bundle Artifact Path |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Handshake** | `aaa-tools/aaa/trust/handshake.py` | `test_handshake_flow` | `AUTH_HANDSHAKE_OK` | N/A | `artifacts/evidence_bundle/v2.0.1/hshake.zip` |
| **Replay Protect** | `aaa-tools/aaa/trust/nonce.py` | `test_replay_attack` | `SEC_REPLAY_ATTEMPT` | `CRITICAL_INTRUSION` | `artifacts/evidence_bundle/v2.0.1/replay.zip` |
| **Scope Enforce** | `aaa-tools/aaa/policy/scope.py` | `test_scope_deny` | `AUTH_SCOPE_DENY` | N/A | `artifacts/evidence_bundle/v2.0.1/scope.zip` |
| **Bridge Authz** | `aaa-tools/aaa/bridge/server.py` | `test_bridge_unauth` | `BRIDGE_ACCESS_DENY` | `AUTH_VIOLATION` | `artifacts/evidence_bundle/v2.1/bridge.zip` |
| **Endpoint Sandbox**| `aaa-tools/aaa/endpoint/sandbox.py`| `test_sandbox_escape` | `EP_SANDBOX_VIOLATION`| `SEC_BREACH_ATTEMPT` | `artifacts/evidence_bundle/v2.2/sandbox.zip` |
| **Settlement** | `aaa-tools/aaa/economy/sla.py` | `test_sla_settle` | `ECON_SETTLE_OK` | N/A | `artifacts/evidence_bundle/v2.4/settle.zip` |
| **Court Trigger** | `aaa-tools/aaa/court/trigger.py` | `test_auto_file_case` | `CASE_FILED_AUTO` | `AUTH_VIOLATION` | `artifacts/evidence_bundle/v2.0.1/court.zip` |
## Appendix B: Reason Code Index (Audit Mapping)

| Reason Code | Trigger Condition | Severity | Governance Outcome | Court Auto-Trigger? |
| :--- | :--- | :--- | :--- | :--- |
| `ERR_ID_EXPIRED` | Identity rotation window exceeds SLA (>24h). | HIGH | Connection Terminated | No (Audit Alert) |
| `ERR_TOKEN_EXPIRED`| JWT session TTL exceeded (>1h). | HIGH | Session Dropped | No (Incident Queue P2) |
| `ERR_SCOPE_DENY` | Capability not in signed allowlist for Actor. | CRITICAL | Payload Blocked | Yes (AUTH_VIOLATION) |
| `ERR_REPLAY` | Nonce reused within TTL window. | CRITICAL | **Quarantine (24h; Actor+Conn)** | Yes (CRITICAL_INTRUSION) |
| `ERR_REVOKED` | Actor ID found in global CRL. | HIGH | Connection Terminated | No (System Policy) |
| `ERR_RATE_LIMIT` | Request burst exceeds capability budget. | LOW | Throttled (429) | No (Metric Log) |
| `ERR_POLICY_HASH_MISMATCH`| Node policy hash != Global consensus hash. | HIGH | **Deny + Incident Queue (P2)**| No (DRIFT_INCIDENT) |
| `ERR_AUDIT_SCHEMA_MISSING` | RiskLedger write failure or schema violation. | CRITICAL | Fail-Closed (Deny) | Yes (AUDIT_CORRUPTION) |
| `ERR_FAIL_CLOSED` | System internal error or circuit breaker trip. | HIGH | Safe State (**SYSTEM_SAFETY_EVENT**) | Yes (**SYSTEM_SAFETY_EVENT**) |
