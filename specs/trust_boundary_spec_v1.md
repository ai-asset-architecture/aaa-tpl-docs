# Trust Boundary Specification (v1.0)

## Overview
This specification defines the mandatory security controls for the AAA Trust Boundary (v2.0.1). All Agent connectivity (Bridge/Endpoint) must implement these controls to pass the Governance Gate.

## 1. Handshake Protocol
### 1.1 Priority
1. **mTLS (Mutual TLS)**: Mandatory for server-to-server or persistent backend connections.
2. **JWT (RS256/ES256)**: Allowed for ephemeral sessions or frontend-originated bridge connections.

### 1.2 Rotation & Expiry
- **Session Keys**: Must rotate every 24 hours (max).
- **JWT TTL**: Maximum 1 hour.
- **Revocation**: The `aaa/trust/revocator` must sync the CRL (Certificate Revocation List) every 60 seconds.

### 1.3 Replay Protection
- Every request must include a `nonce` and a `timestamp`.
- Nonce must be unique within the `timestamp` +/- 5-minute window.
- Duplicated nonces trigger an immediate `SEC_REPLAY_ATTEMPT` event.

## 2. Scope Enforcement
### 2.1 Deny-by-Default
- All capabilities start with `deny`.
- Access is only granted via explicit `aaa court auth` or signed `capability_pack`.

### 2.2 Reason Codes (Audit Standard)
| Code | Meaning | Outcome |
| :--- | :--- | :--- |
| `ERR_ID_EXPIRED` | Credential expired | Connection Dropped |
| `ERR_REVOKED` | Identity in CRL | Connection Dropped |
| `ERR_SCOPE_LACK` | Capability not in whitelist | Operation Blocked |
| `ERR_REPLAY` | Nonce already used | Alert + Drop |
| `ERR_SEC_LEAK` | Sensitive data pattern detected | Alert + Scrub |

## 3. Evidence Collection
- All `decision` events must be written to `RiskLedger` within 10ms.
- Evidence must include the `request_hash` and `signer_id`.
