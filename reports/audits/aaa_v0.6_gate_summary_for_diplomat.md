# AAA v0.6 Gate A/B Summary (Diplomat Reference)

## Overview
AAA v0.6 brings **verifiable governance**: onboarding and security are no longer manual assurances, but automated, repeatable checks with evidence.

---

## Gate A — Reproducible Birth (Init Pipeline)

**Meaning**
- A new repo is born compliant: PR + checks appear automatically.
- Eliminates manual setup and missing protections.

**Key Breakthrough**
- Resolved the "empty repo has no PR" deadlock by ensuring a valid evidence chain from the first commit.

---

## Gate B1 — Intelligent Compliance (Context-Aware Governance)

**Meaning**
- Rules are no longer one-size-fits-all.
- Non-agent repos (docs/service/frontend) are not forced to carry agent-only assets.

**Impact**
- CI signals regain trust.
- No more false alarms from governance checks.

---

## Gate B2 — Active Defense (Security as Code)

**Meaning**
- The system blocks unsafe agent behavior at runtime (Path Traversal, Scope Violation).
- Security is enforced by code, not policy reminders.

**Impact**
- AAA can safely host higher-risk agent workflows.
- Security verification runs in CI and is reproducible.

---

## One-Sentence Summary
AAA v0.6 upgrades the organization from **tooling** to **assurance**: governance becomes executable and provable.
