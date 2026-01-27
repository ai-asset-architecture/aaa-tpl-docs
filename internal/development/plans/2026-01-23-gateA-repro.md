# Gate A Repro Script (2026-01-23)

## Goal
Provide a minimal, repeatable Gate A execution that yields PR evidence and checks.

## Environment
- AAA_ORG: ai-asset-architecture
- DUMMY_REPO: aaa-sandbox-20260122
- PLAN_PATH: /tmp/aaa_plan_v0.1_ref_v0.2.0.filled.json
- AAA_TAG: v0.1.0 (from plan aaa.version_tag)

## Steps
1) Validate plan
```
aaa init validate-plan --plan /tmp/plan.json
```

2) Ensure repos
```
aaa init ensure-repos --from-plan /tmp/plan.json --org ai-asset-architecture
```

3) Apply templates (requires --aaa-tag)
```
aaa init apply-templates --from-plan /tmp/plan.json --org ai-asset-architecture --aaa-tag v0.1.0
```

4) Protect + Open PRs
```
aaa init protect --from-plan /tmp/plan.json --org ai-asset-architecture

aaa init open-prs --from-plan /tmp/plan.json --org ai-asset-architecture
```

5) Verify CI + Repo Checks
```
aaa init verify-ci --from-plan /tmp/plan.json --org ai-asset-architecture

aaa init repo-checks --from-plan /tmp/plan.json --org ai-asset-architecture --suite repo_evals
```

## Evidence Collection
- PR list:
```
gh pr list -R ai-asset-architecture/ai-asset-architecture-docs --state all --limit 50
```
- PR checks:
```
gh pr checks 1 -R ai-asset-architecture/ai-asset-architecture-docs
```
- Workflow runs:
```
gh run list -R ai-asset-architecture/ai-asset-architecture-docs --limit 30
```

## Expected Output
- PR created on bootstrap branch
- Checks present: ci/lint, ci/test, ci/eval
- verify-ci and repo-checks exit code 0
