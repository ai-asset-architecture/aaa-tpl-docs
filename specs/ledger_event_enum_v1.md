# Ledger Event Enums (v1.0)

> **Purpose**: Standarized event types for RiskLedger (v1.8) to ensure auditable trend analysis and incident correlation.

## 1. Authentication Events
| Event Enum | Severity | Description |
| :--- | :--- | :--- |
| `AUTH_HANDSHAKE_START` | LOW | Connection attempt initiated. |
| `AUTH_HANDSHAKE_OK` | INFO | Handshake completed successfully. |
| `AUTH_DENY` | HIGH | Connection rejected (Invalid ID/Token). |
| `AUTH_REVOKED` | CRITICAL | Revoked identity attempted access. |

## 2. Authorization (Capability) Events
| Event Enum | Severity | Description |
| :--- | :--- | :--- |
| `AUTH_SCOPE_ALLOW` | INFO | Capability authorized and executed. |
| `AUTH_SCOPE_DENY` | HIGH | Capability rejected (Not in allowlist). |
| `AUTH_SCOPE_VIOLATION` | CRITICAL | Intent-Outcome mismatch detected. |

## 3. Security & Integrity Events
| Event Enum | Severity | Description |
| :--- | :--- | :--- |
| `SEC_REPLAY_ATTEMPT` | CRITICAL | Nonce reuse detected. |
| `SEC_POLICY_DRIFT` | HIGH | Node policy hash mismatch. |
| `SEC_BREACH_ATTEMPT` | CRITICAL | Sandbox escape or raw shell attempt. |
| `SEC_LEAK_DETECTED` | CRITICAL | PII or Secret pattern found in output. |

## 4. Economic Events
| Event Enum | Severity | Description |
| :--- | :--- | :--- |
| `ECON_SETTLE_START` | INFO | Settlement process initiated. |
| `ECON_SETTLE_OK` | INFO | SLA verified and CC settled. |
| `ECON_RECON_FAIL` | HIGH | Cost variance exceeded thresholds. |
| `ECON_FRAUD_BLOCK` | CRITICAL | Cheating pattern detected in SLA evidence. |
