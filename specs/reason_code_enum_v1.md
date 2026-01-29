# Reason Code Enums (v1.0)

> **Purpose**: Standardized error codes for AAA Sidecar execution (v2.0).

| Reason Code Enum | Severity | Description |
| :--- | :--- | :--- |
| `ERR_ID_EXPIRED` | HIGH | Certificate rotation window exceeded. |
| `ERR_TOKEN_EXPIRED` | HIGH | JWT session TTL exceeded. |
| `ERR_SCOPE_DENY` | CRITICAL | Capability not in assigned allowlist. |
| `ERR_REPLAY` | CRITICAL | Nonce reuse detected. |
| `ERR_REVOKED` | HIGH | Identity found in global CRL. |
| `ERR_RATE_LIMIT` | LOW | Request burst exceeded budget. |
| `ERR_POLICY_HASH_MISMATCH` | HIGH | Node policy hash != consensus. |
| `ERR_AUDIT_SCHEMA_MISSING` | CRITICAL | Ledger write failure or schema violation. |
| `ERR_FAIL_CLOSED` | HIGH | Internal safety trip or circuit breaker. |
