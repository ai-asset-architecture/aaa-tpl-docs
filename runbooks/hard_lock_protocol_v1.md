# AAA Governance: 4-Step Hard-Lock Protocol (Runbook v1.0)

## Overview
This runbook defines the mandatory enforcement protocol to prevent "hallucinated compliance" and ensure every AI action is grounded in verified documentation and evidence.

## Protocol Steps

### Step 1: Preflight (The Context Check)
- **Action**: Read the root `.ai-context.md` at the very start of EVERY turn.
- **Goal**: Reload the AI Constitution and high-priority constraints.
- **Check**: Is the "Hard-Lock Protocol" present in the context?

### Step 2: Mandatory Load (The Core Context)
- **Action**: Explicitly read `AI_COMMAND_CENTER.md` and `PROJECT_PLAYBOOK.md`.
- **Goal**: Ensure the role-specific philosophies and multi-repo architectures are current in the AI's active memory.
- **Constraint**: No execution without these two files loaded.

### Step 3: Evidence Mode (The Citation Lock)
- **Action**: For EVERY output, modification, or decision, cite the source line/document that authorizes it.
- **Format**: `(Citation: filename.md#L<line_number>)`
- **Goal**: Eliminate hallucinations and ensure adherence to the `implementation_plan.md`.

### Step 4: Fail-Closed (The Integrity Lock)
- **Action**: If any of the above steps fail, or if a required document is missing/corrupted, **STOP IMMEDIATELY**.
- **Requirement**: List the missing data/gaps and notify the Commander. Do not proceed with "best guesses."

## Usage
- Trigger: Automatic for all `aaa-` related tasks.
- Audit: Every evidence bundle must show the "Preflight" and "Load" steps in its command history/logs.
