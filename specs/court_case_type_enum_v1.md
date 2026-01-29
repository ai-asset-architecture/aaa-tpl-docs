# Court CaseType Enums (v1.0)

> **Purpose**: Categorize AAA Court (v1.9) Case Files for automated precedent matching and prioritized adjudication.

## 1. Security Violations
| CaseType Enum | Priority | Description |
| :--- | :--- | :--- |
| `CRITICAL_INTRUSION` | P0 | Replay attacks, Sandbox escapes, raw shell attempts. |
| `AUTH_VIOLATION` | P1 | Unauthorized capability usage via JWT or unassigned actors. |
| `DATA_EXFILTRATION` | P0 | Secret leaks or PII exfiltration detected by Scrubber. |

## 2. Operational Compliance
| CaseType Enum | Priority | Description |
| :--- | :--- | :--- |
| `DRIFT_INCIDENT` | P2 | Persistent policy or version mismatch across nodes. |
| `AUDIT_CORRUPTION` | P0 | Ledger integrity failure or missing evidence bundles. |
| `SYSTEM_SAFETY_EVENT` | P1 | System entered fail-closed state due to internal safety check or limit. |
| `FAIL_OPEN_EVENT` | P1 | System entered fail-open state without manual override. |

## 3. Economic Disputes
| CaseType Enum | Priority | Description |
| :--- | :--- | :--- |
| `SETTLEMENT_DISPUTE` | P2 | Manual challenge to an Algorithmic SLA outcome. |
| `RECON_OVERFLOW` | P1 | Cost variance > 10% requiring budget audit. |
| `SLA_CHEATING` | P0 | Evidence tampering or result forgery detected. |

---
*Derived from AAA Governance Framework v1.9*
