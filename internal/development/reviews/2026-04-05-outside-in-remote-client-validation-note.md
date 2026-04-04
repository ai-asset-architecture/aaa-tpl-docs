# AAA Outside-In Validation Note

- date: 2026-04-05
- mode: remote client outside-in validation
- workspace_root: `/tmp/aaa-remote-validate-AbxZrC`
- disposable_boundary: `/tmp only; not canonical evidence storage`

## Step-by-step log

1. Read mandatory entry docs:
   - `aaa-tpl-docs/AI_COMMAND_CENTER.md`
   - `aaa-tpl-docs/PROJECT_PLAYBOOK.md`
2. Verified local preconditions:
   - `gh auth status` => authenticated
   - `git --version` => available
   - `python3 --version` => available
   - `aaa --version` => `aaa-tools 2.0.0`
3. Observed official bootstrap path from runbook:
   - `aaa init --plan aaa-tools/runbooks/init/plan.v0.1.json --mode pr`
4. Observed current CLI reality:
   - package-related capabilities are exposed under `aaa governance ...` validators
   - there is no public `aaa package ...` command family
5. Created disposable plan at `/tmp/aaa-remote-validate-AbxZrC/plan.topology.json` with three presets:
   - `dedicated`
   - `repo_local`
   - `hybrid`
6. Ran `aaa init validate-plan` against the shared topology plan.
7. Ran `aaa init --plan ... --preset <mode> --dry-run --jsonl --log-dir ...` for each preset.
8. Added two targeted negative plans:
   - `plan.dedicated-missing.json`
   - `plan.hybrid-missing.json`
9. Ran `aaa init validate-plan` against both negative plans.
10. Attempted package selection via CLI:
   - `python -m aaa.cli package select --level lite`

## Observed outputs

### Package selection behavior
- `aaa package` is **not** a supported public CLI command.
- Actual output:
  - `No such command 'package'. Did you mean 'pack'?`
- Current external reality:
  - package line exists as governance/runtime validators
  - but not yet as a client-facing init/package command family

### Dedicated .github behavior
- Dedicated preset with `.github` repo included:
  - `aaa init validate-plan` => pass
  - `aaa init --dry-run` => pass and would check/apply/open PR for `.github`
- Dedicated preset without `.github`:
  - `aaa init validate-plan` => fail
  - error: `missing required repo: .github`

### repo_local behavior
- `repo_local` preset **passes** without dedicated `.github` repo.
- Dry-run report shows only repo-local repos would be checked/applied.
- This confirms dedicated `.github` is no longer a universal hard prerequisite inside topology-aware init plan resolution.

### hybrid behavior
- `hybrid` preset with dedicated `.github` repo included:
  - dry-run passes
- `hybrid` plan **without** dedicated `.github` repo:
  - `aaa init validate-plan` still passes
- Current implication:
  - hybrid is accepted structurally
  - but `aaa init validate-plan` does **not** require dual-sided evidence at this entrypoint
  - dual-sided evidence law appears to exist downstream in topology governance/runtime validators, not in the init plan gate itself

### Dry-run execution behavior
- `aaa init --dry-run` produces a report under the supplied `--log-dir` when the directory already exists.
- If `--log-dir` does not exist, `aaa init --dry-run` crashes when writing `aaa-init-report.json`.
- This is a real external blocker for sandbox validation and automation.

## Topology assumption summary

- `dedicated_repo`
  - still requires `.github` as a declared repo in the init plan
- `repo_local`
  - can pass without dedicated `.github`
- `hybrid`
  - currently behaves as a permissive structural mode in init validation
  - does not enforce dual-sided evidence at the init entry itself
- Overall current truth:
  - docs/playbook intent is hybrid-friendly
  - init/runtime has partial topology awareness
  - but package/runtime/topology enforcement is not fully unified at the external bootstrap entry

## Blockers

1. No public `aaa package ...` command family.
   - Remote client cannot explicitly perform package selection through a stable user-facing CLI.
2. `aaa init --dry-run --log-dir <missing-dir>` crashes instead of creating the directory or failing cleanly.
3. `aaa init validate-plan` does not enforce hybrid dual-sided evidence.
   - Hybrid can pass as a structure-only plan.
4. CLI help usability is weak from the outside.
   - `python -m aaa.cli --help` did not behave like a reliable quick discovery surface during this validation.
5. Official bootstrap runbook remains GitHub/PR/CI-oriented.
   - For a disposable local-only client sandbox, there is no clearly documented local-only bootstrap profile.

## Ambiguity points

1. Is package selection supposed to be:
   - a future public CLI family, or
   - permanently a governance validator/runtime-only concept?
2. Should hybrid require dedicated `.github` presence plus repo-local signals at init gate time,
   or only at later topology-aware prerequisite/status stages?
3. Is `aaa init` intended to support local-only sandbox bootstrap,
   or only org-backed GitHub bootstrap with dry-run as a diagnostic aid?

## What evidence should be preserved outside /tmp

If this validation is escalated into canonical follow-up evidence, preserve these artifacts outside `/tmp`:
- `plan.topology.json`
- `plan.dedicated-missing.json`
- `plan.hybrid-missing.json`
- `validate-dedicated.jsonl`
- `validate-repo_local.jsonl`
- `validate-hybrid.jsonl`
- `validate-dedicated-missing.jsonl`
- `validate-hybrid-missing.jsonl`
- `init-dedicated-rerun.jsonl`
- `init-repo_local-rerun.jsonl`
- `init-hybrid-rerun.jsonl`
- `log-dedicated/aaa-init-report.json`
- `log-repo_local/aaa-init-report.json`
- `log-hybrid/aaa-init-report.json`
- `package-select.txt`

## Suggested follow-up tests

1. Add a public `aaa package` command family and rerun the same outside-in validation.
2. Add explicit hybrid dual-sided evidence checks into either:
   - `aaa init validate-plan`, or
   - a documented prerequisite gate that is part of the supported bootstrap path.
3. Fix `--log-dir` creation behavior and rerun dry-run from a completely empty `/tmp` root.
4. Define and test a local-only bootstrap mode that does not assume GitHub PR/branch-protection side effects.
5. Validate whether repo-local materialization actually writes `.github/**` into target repos once non-dry-run local bootstrap exists.
