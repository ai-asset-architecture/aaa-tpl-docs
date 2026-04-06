# Run Evidence: v2.1.42 Intermediate Bundle Generation Baseline

- **version**: v2.1.42
- **step**: Step2
- **evidence_type**: remote_execution
- **computed_at_taipei**: 2026-04-06T07:58:00+08:00

## Remote Evidence

```
run_ref: gh-actions:ai-asset-architecture/aaa-tools@v2-1-42-intermediate-bundle-generation-baseline.yml#24013340136
```

## Required Fields (operate_maintain_guide.md §Step2)

| Field | Value |
|-------|-------|
| `run_ref` | `gh-actions:ai-asset-architecture/aaa-tools@v2-1-42-intermediate-bundle-generation-baseline.yml#24013340136` |
| `computed_at_taipei` | `2026-04-06T07:58:00+08:00` |
| `inputs_digest` | `sha256:python-3.11.15-aaa-tools@9d71e35` |
| `source_paths` | `aaa-tools/aaa/intermediate_bundle_generation_baseline.py` |
| `source_paths` | `aaa-tools/tests/test_intermediate_bundle_generation_baseline.py` |
| `source_paths` | `aaa-tools/.github/workflows/v2-1-42-intermediate-bundle-generation-baseline.yml` |
| `evidence_path` | `aaa-tpl-docs/internal/development/evidence/v2.1.42/intermediate-bundle-generation-baseline/run-evidence.md` |

## Execution Summary

| Job | Steps | Result |
|-----|-------|--------|
| test-intermediate-bundle-generation-baseline | Set up job, Checkout, Python 3.11, Install deps, Run pytest (33 tests), Smoke run, Upload artifacts, Teardown | ✅ PASS in 18s |

## Test Results

- **Total tests**: 33
- **Passed**: 33
- **Failed**: 0
- **Test classes**: `TestBuildGenerationReport` (9), `TestGeneratePrerequisiteBundle` (7), `TestGenerateMaterializationMappingBundle` (5), `TestValidateBundle` (12)
- **Fixture tests**: pass fixture → validates PASS, fail fixture → validates FAIL ✅

## Smoke Validation

All three topologies smoke-checked:
- `generate_prerequisite_bundle(dedicated_repo)` → `command_emitted` ✅
- `generate_prerequisite_bundle(repo_local)` → `command_emitted` ✅
- `generate_prerequisite_bundle(hybrid)` → `command_emitted` ✅
- `generate_materialization_mapping_bundle(*)` → `back_write_allowed=false` ✅
- `validate_bundle(pass_payload)` → verdict=`pass` ✅

## Compliance

- ✅ run_ref format: `gh-actions:` (remote-only, no local/file/shell)
- ✅ No glob in source_paths
- ✅ Completion claim backed by this remote evidence
- ✅ supported_path_fully_automated=false (not overstated)
- ✅ full_orchestration_provided=false (contract boundary respected)
