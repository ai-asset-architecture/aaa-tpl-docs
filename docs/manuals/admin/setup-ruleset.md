# Repository Ruleset Setup (Governance Gate)

## Purpose
Define organization-level enforcement so every repo must pass the `governance-gate` status check before merge.

## Scope
- Target repositories: `*`
- Target branches: `main`, `release/*`

## Required Rules
1. Require status checks to pass:
   - `governance-gate`
2. Require pull request review:
   - Minimum approvals: 1
3. Block force pushes

## Notes
- Status check name must remain **exactly** `governance-gate`.
- If the workflow name or job name changes, update the ruleset immediately.

## UI Steps (GitHub)
1. Organization Settings → Rules → Rulesets
2. Create new ruleset: `governance-enforcement`
3. Apply to repositories: `*`
4. Branch targeting: `main`, `release/*`
5. Add required checks: `governance-gate`
6. Enable review requirement and force-push block
7. Save
