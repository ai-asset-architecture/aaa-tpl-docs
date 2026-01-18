# Skills QA Report (20260119_0049)

Workspace: /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE

Note: aaa init related skills may fail until CLI subcommands are implemented.

## aaa-governance-audit
Command: `AAA_WORKSPACE=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE EVALS_ROOT=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-evals DOCS_ROOT=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/skills/common/aaa-governance-audit/scripts/run.sh`
```
/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs/reports/governance_evals_report_20260119_0049.md
exit=0
```

## aaa-evals-governance-check
Command: `TARGET_PATH=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs CHECKS=readme,workflow EVALS_ROOT=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-evals /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/skills/common/aaa-evals-governance-check/scripts/run.sh`
```
{"check": "readme", "repo": "/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs", "pass": true, "details": []}
{"check": "workflow", "repo": "/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs", "pass": true, "details": []}
exit=0
```

## aaa-prompts-schema-validate
Command: `PROMPTS_ROOT=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-prompts EVALS_ROOT=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-evals /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/skills/common/aaa-prompts-schema-validate/scripts/run.sh`
```
{"check": "prompt", "repo": "/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-prompts", "pass": true, "details": []}
exit=0
```

## aaa-workflow-tag-audit
Command: `TARGET_PATH=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs EVALS_ROOT=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-evals /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/skills/common/aaa-workflow-tag-audit/scripts/run.sh`
```
{"check": "workflow", "repo": "/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-docs", "pass": true, "details": []}
exit=0
```

## aaa-docs-link-audit
Command: `TARGET_PATH=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tpl-service DOCS_PATTERN='<org>-docs' /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/skills/common/aaa-docs-link-audit/scripts/run.sh`
```
3:Project documentation lives in `<org>-docs`.
exit=0
```

## aaa-init-validate-plan
Command: `PLAN_PATH=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/runbooks/init/plan.v0.1.json SCHEMA_PATH=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/specs/plan.schema.json /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/skills/common/aaa-init-validate-plan/scripts/run.sh`
```
/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/skills/common/aaa-init-validate-plan/scripts/run.sh: line 13: aaa: command not found
exit=127
```

## aaa-branch-protection-audit
Command: `ORG=ai-asset-architecture PLAN_PATH=/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/runbooks/init/plan.v0.1.json /Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/skills/common/aaa-branch-protection-audit/scripts/run.sh`
```
/Users/imac/Documents/Code/AI-Lotto/AAA_WORKSPACE/aaa-tools/skills/common/aaa-branch-protection-audit/scripts/run.sh: line 18: aaa: command not found
exit=127
```

