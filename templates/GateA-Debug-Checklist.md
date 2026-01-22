# Gate A Debug Checklist

## Goal
Provide a minimal, repeatable checklist to diagnose Gate A failures and capture evidence.

## Preflight
- Confirm plan file path and `aaa.version_tag`.
- Confirm template tags exist for all template repos.
- Confirm repo has an initial commit on main.

## Common Failures
1) No base commit
- Symptom: PR create failed with "Head sha can't be blank" or "No commits between main and bootstrap/..."
- Fix: create initial commit (README), push main.

2) Missing template tag
- Symptom: template clone failed: "Remote branch <tag> not found"
- Fix: create tag in template repos or align plan to existing tag.

3) No-op template sync
- Symptom: apply-templates noop, open-prs fails with "No commits between main and bootstrap/..."
- Fix: allow empty commit on bootstrap branch (tool fix).

4) Runbook checksum mismatch
- Symptom: runbook error "checksum mismatch"
- Fix: recompute checksum after edit.

5) Missing required scopes
- Symptom: runbook error "missing scopes: gov:index"
- Fix: declare required_scopes in runbook contract.

## Evidence Capture
- PR URL
- `gh pr checks <PR_NUM> -R <ORG/REPO>`
- `gh run list -R <ORG/REPO>`

## Repro Commands
- See `docs/plans/2026-01-23-gateA-repro.md` for full Gate A script.
