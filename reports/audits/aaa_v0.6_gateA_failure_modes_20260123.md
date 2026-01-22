# AAA v0.6 Gate A Failure Modes (2026-01-23)

## Purpose
Capture repeatable failure modes from the Gate A exercise and the corrective actions that actually worked.

## Failure Modes And Fixes
1) Empty repo (no base commit)
- Symptom: PR create failed: "Head sha can't be blank" / "No commits between main and bootstrap/..."
- Root cause: repo created without initial commit, no main branch history
- Fix: seed initial commit (README) before apply-templates/open-prs

2) Missing template tag
- Symptom: template clone failed: "Remote branch v0.1.0 not found"
- Root cause: plan references a tag that does not exist in template repos
- Fix: create required tag in template repos or align plan to existing tags

3) Apply-templates returns noop, no PR
- Symptom: apply-templates noop, open-prs fails with "No commits between main and bootstrap/..."
- Root cause: templates identical to target, no diff => no commit => no PR
- Fix: allow empty commit on bootstrap branch (tool fix)

4) Runbook checksum mismatch
- Symptom: runbook error "checksum mismatch"
- Root cause: runbook content changed but checksum not updated
- Fix: recompute checksum after edits, commit together

5) Missing required scopes
- Symptom: runbook error "missing scopes: gov:index"
- Root cause: runbook requires action with scope but contract.required_scopes empty
- Fix: declare required_scopes explicitly in runbook contract

6) CLI flags mismatch
- Symptom: "No such option: --plan" or missing required flags
- Root cause: Gate doc/commands not aligned to actual CLI flags
- Fix: update Gate runbook with --from-plan, --org, --aaa-tag, --suite

## Preventive Controls
- Keep template tags aligned with plan. Prefer a single source for tag refs.
- Ensure bootstrap path can produce a commit even on noop.
- Treat runbook checksum and required_scopes as mandatory when editing runbooks.
- Keep Gate runbook commands aligned to CLI help output.

## Evidence
- Gate A PR created in ai-asset-architecture-docs (#1)
- Checks: ci/lint, ci/test, ci/eval all PASS
