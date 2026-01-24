---
title: "Annual Governance Audit Report"
version: v1.0
status: Template
owner: Governance Auditor
last_updated: 2026-01-24
---

# Annual Governance Audit Report

## 1) Overview
- **Audit Period**: YYYY-01-01 → YYYY-12-31
- **Org**: <ORG>
- **Scope**: repos, policies, workflows, packs
- **Audit Owner**: <NAME/ROLE>

## 2) Governance Policy Snapshot
- **Ruleset**: <ruleset id / link>
- **Required Checks**: <checks.manifest.json>
- **Gate Workflow**: `governance-gate`

## 3) Evidence Index
- `nightly_governance.json` range: <paths>
- `reports/audits/` range: <paths>
- `decision_trace.log` range: <paths>

## 4) Findings Summary
| Category | Status | Notes |
| --- | --- | --- |
| README/CODEOWNERS | PASS/FAIL | <notes> |
| Workflow Pinning | PASS/FAIL | <notes> |
| Repo Type Consistency | PASS/FAIL | <notes> |
| Orphaned Assets | PASS/FAIL | <notes> |
| Agent Safety | PASS/FAIL | <notes> |
| Release Integrity | PASS/FAIL | <notes> |

## 5) Exceptions & Bypass
- **Total Bypass Events**: <count>
- **Top Reasons**: <summary>
- **Approvals**: <owners>

## 6) Risk Assessment
- **High Risk**: <list>
- **Medium Risk**: <list>
- **Low Risk**: <list>

## 7) Action Items
| Item | Owner (RACI) | Due Date | Status |
| --- | --- | --- | --- |
| <action> | <owner> | <date> | Open/Closed |

## 8) Sign-off
- Governance Auditor: <name>
- Org Admin: <name>
- Human Owner: <name>

