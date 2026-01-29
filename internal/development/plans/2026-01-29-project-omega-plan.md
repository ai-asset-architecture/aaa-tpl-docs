# Implementation Plan: Project OMEGA Ultimate Validation

## Goal Description
Perform a comprehensive "Shakedown Cruise" of the AAA system (v0.1 - v2.0). 
This goes beyond unit testing to verify **Logic Coverage** and **System Wiring** through an E2E "Project OMEGA" script that simulates a full Agent lifecycle.

## User Review Required
> [!IMPORTANT]
> - **Debt Purge**: We are focusing on core logic coverage (>90%). CLI wrapper debt is deferred to E2E verification.
> - **E2E Simulation**: Will run in a temporary sandbox to ensure no side effects on the main workspace.

## Proposed Changes

### [aaa-tools](file:///Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools)
- **[MODIFY] tests/**: Standardize all unit tests and fix signature mismatches.
- **[NEW] tests/integration/test_os_lifecycle.py**: Verify Kernel + Observability + Locking wiring.
- **[NEW] tests/e2e/omega_run.sh**: Multi-step Agent lifecycle simulation script.

## Triple-Summary Protocol (Project OMEGA)
### 1. Strategic Plan (戰略計畫摘要)
Execute a three-tier validation: Foundation (Unit), OS (Integration), and Agent (E2E). Focus on "Logic Coverage" rather than just line coverage.

### 2. Schema Evolution (結構演進摘要)
No schema changes in this milestone. This is a pure validation and stabilization phase.

### 3. Component Architecture (組件架構摘要)
Verifying the interaction between the **AgentKernel** (v2.0), **CourtClerk** (v1.9), **Observability** (v1.8), and **LockManager** (v1.6).

## Verification Plan
### Automated Tests
- `pytest --cov=aaa`
- `tests/integration/test_os_lifecycle.py`
### Manual Verification
- Execution of `omega_run.sh` with manual review of the generated Audit Log.
