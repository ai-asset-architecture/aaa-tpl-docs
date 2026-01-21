# Member Start SOP Template (Onboarding v0.2.x)

> This template is the single source for Member onboarding steps. Keep aligned with `.github/profile/README.md` and eval checks.

## 1) Prerequisites

```bash
gh --version
gh auth status
gh auth setup-git
git --version
python3 --version
```

## 2) Install AAA Tools

```bash
python3 -m pip install --upgrade pip
python3 -m pip install "git+https://github.com/ai-asset-architecture/aaa-tools.git@{{AAA_VERSION}}"

# Verify

aaa --version
```

## 3) Download Plan + Schema (Private Repos)

```bash
# Plan
gh api -H "Accept: application/vnd.github.v3.raw" \
  /repos/ai-asset-architecture/aaa-tools/contents/runbooks/init/plan.v0.1.json?ref={{AAA_VERSION}} \
  > /tmp/aaa_plan_resolved.json

# Schema
gh api -H "Accept: application/vnd.github.v3.raw" \
  /repos/ai-asset-architecture/aaa-tools/contents/specs/plan.schema.json?ref={{AAA_VERSION}} \
  > /tmp/aaa_plan_schema.json
```

## 4) JSON Sanity Check

```bash
python3 - <<'PY'
import json, sys
paths = ["/tmp/aaa_plan_resolved.json", "/tmp/aaa_plan_schema.json"]
for p in paths:
    try:
        json.load(open(p))
        print(f"OK: {p}")
    except Exception as e:
        print(f"ERROR: {p} -> {e}")
        sys.exit(1)
PY
```

## 5) Replace Variables

Open `/tmp/aaa_plan_resolved.json` and replace:
- `{{TARGET_ORG}}`
- `{{PROJECT_SLUG}}`
- `{{AAA_VERSION}}`

Fail-fast check:

```bash
grep -n "{{" /tmp/aaa_plan_resolved.json && echo "ERROR: unresolved variables" && exit 1 || true
```

## 6) Validate + Run

```bash
aaa init validate-plan --plan /tmp/aaa_plan_resolved.json --schema /tmp/aaa_plan_schema.json --jsonl

# Dry-run first

aaa init --plan /tmp/aaa_plan_resolved.json --dry-run --jsonl

# Execute

aaa init --plan /tmp/aaa_plan_resolved.json --mode pr --jsonl
```

## Notes
- Replace `{{AAA_VERSION}}` with a released tag (e.g., `v0.2.0`).
- Use gh auth setup-git before any private repo access.
