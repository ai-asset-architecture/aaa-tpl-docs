# Repo-Type Governance Evals + Prompt Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Add repo_type-consistent governance checks and a repo_type decision prompt using `.aaa/metadata.json` as the local anchor.

**Architecture:** `aaa-tools` writes `.aaa/metadata.json` during apply-templates. `aaa-evals` reads it to gate agent-only checks and validates manifest coverage. A new prompt enforces repo_type reading for agents.

**Tech Stack:** Python (aaa-tools, aaa-evals), JSON, Markdown

---

### Task 1: Write `.aaa/metadata.json` anchor in `aaa-tools`

**Files:**
- Modify: `aaa-tools/aaa/init_commands.py`
- Test: `aaa-tools/tests/test_repo_metadata_anchor.py`

**Step 1: Write the failing test**

```python
# aaa-tools/tests/test_repo_metadata_anchor.py
import json
from pathlib import Path
from aaa import init_commands


def test_write_repo_metadata_creates_file(tmp_path):
    repo_root = tmp_path / "repo"
    repo_root.mkdir()
    init_commands.write_repo_metadata(repo_root, "docs", "plan.v0.7.json")

    metadata = repo_root / ".aaa" / "metadata.json"
    assert metadata.exists()
    payload = json.loads(metadata.read_text(encoding="utf-8"))
    assert payload["repo_type"] == "docs"
    assert payload["plan_ref"] == "plan.v0.7.json"
```

**Step 2: Run test to verify it fails**

Run: `python3 -m unittest tests.test_repo_metadata_anchor -v`
Expected: FAIL (import error or missing function).

**Step 3: Write minimal implementation**

```python
# aaa-tools/aaa/init_commands.py
from pathlib import Path
import json

def write_repo_metadata(repo_root: Path, repo_type: str, plan_ref: str) -> None:
    anchor_dir = repo_root / ".aaa"
    anchor_dir.mkdir(parents=True, exist_ok=True)
    payload = {
        "repo_type": repo_type,
        "plan_ref": plan_ref,
    }
    (anchor_dir / "metadata.json").write_text(
        json.dumps(payload, ensure_ascii=True, indent=2) + "\n",
        encoding="utf-8",
    )
```

Add call inside `apply_templates` after template copy and before git add:

```python
repo_type = _repo_type_from_plan(repo)
plan_ref = from_plan.name
write_repo_metadata(target_dir, repo_type, plan_ref)
```

**Step 4: Run test to verify it passes**

Run: `python3 -m unittest tests.test_repo_metadata_anchor -v`
Expected: PASS.

**Step 5: Commit**

```bash
git add aaa/init_commands.py tests/test_repo_metadata_anchor.py
git commit -m "feat: write repo metadata anchor"
```

---

### Task 2: Implement `repo_type_consistency` check in `aaa-evals`

**Files:**
- Create: `aaa-evals/runner/checks/check_repo_type_consistency.py`
- Modify: `aaa-evals/runner/run_repo_checks.py`
- Test: `aaa-evals/runner/tests/test_repo_type_consistency.py`

**Step 1: Write the failing test**

```python
# aaa-evals/runner/tests/test_repo_type_consistency.py
import json
from pathlib import Path
from runner.checks.check_repo_type_consistency import check_repo_type_consistency


def test_repo_type_consistency_pass(tmp_path):
    repo = tmp_path / "repo"
    (repo / ".aaa").mkdir(parents=True)
    (repo / ".aaa" / "metadata.json").write_text(
        json.dumps({"repo_type": "docs", "plan_ref": "plan.v0.7.json"}),
        encoding="utf-8",
    )

    result = check_repo_type_consistency({"repo_root": str(repo), "expected_repo_type": "docs"})
    assert result["pass"] is True


def test_repo_type_consistency_missing(tmp_path):
    repo = tmp_path / "repo"
    repo.mkdir()
    result = check_repo_type_consistency({"repo_root": str(repo), "expected_repo_type": "docs"})
    assert result["pass"] is False
```

**Step 2: Run test to verify it fails**

Run: `python3 -m unittest runner.tests.test_repo_type_consistency -v`
Expected: FAIL (module missing).

**Step 3: Write minimal implementation**

```python
# aaa-evals/runner/checks/check_repo_type_consistency.py
import json
from pathlib import Path
from typing import Any


def check_repo_type_consistency(config: dict[str, Any]) -> dict[str, Any]:
    repo_root = Path(config.get("repo_root", "."))
    expected = (config.get("expected_repo_type") or "").strip()
    metadata = repo_root / ".aaa" / "metadata.json"
    if not metadata.exists():
        return {"pass": False, "details": [".aaa/metadata.json missing"]}
    try:
        payload = json.loads(metadata.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return {"pass": False, "details": [".aaa/metadata.json invalid JSON"]}
    repo_type = str(payload.get("repo_type", "")).strip()
    if not repo_type:
        return {"pass": False, "details": ["repo_type missing"]}
    if expected and repo_type != expected:
        return {"pass": False, "details": [f"repo_type mismatch: {repo_type} != {expected}"]}
    return {"pass": True, "details": []}
```

**Step 4: Wire into `run_repo_checks.py`**

- Import the new check.
- Add `repo_type_consistency` to `choices`.
- In the dispatcher, call with config:

```python
config = {
    "repo_root": args.repo,
    "expected_repo_type": args.repo_type,
}
```

Add CLI arg:

```python
parser.add_argument("--repo-type", default="")
```

**Step 5: Run test to verify it passes**

Run: `python3 -m unittest runner.tests.test_repo_type_consistency -v`
Expected: PASS.

**Step 6: Commit**

```bash
git add runner/checks/check_repo_type_consistency.py runner/run_repo_checks.py runner/tests/test_repo_type_consistency.py
git commit -m "feat: add repo_type consistency check"
```

---

### Task 3: Implement `checks_manifest_alignment` check in `aaa-evals`

**Files:**
- Create: `aaa-evals/runner/checks/check_checks_manifest_alignment.py`
- Modify: `aaa-evals/runner/run_repo_checks.py`
- Test: `aaa-evals/runner/tests/test_checks_manifest_alignment.py`

**Step 1: Write the failing test**

```python
# aaa-evals/runner/tests/test_checks_manifest_alignment.py
import json
from pathlib import Path
from runner.checks.check_checks_manifest_alignment import check_checks_manifest_alignment


def test_checks_manifest_alignment_pass(tmp_path):
    manifest = tmp_path / "checks.manifest.json"
    manifest.write_text(json.dumps({
        "checks": [
            {"id": "lint", "name": "Lint", "applies_to": ["all"]},
            {"id": "agent", "name": "Agent safety check", "applies_to": ["agent"]},
        ]
    }), encoding="utf-8")

    result = check_checks_manifest_alignment({"manifest_path": str(manifest)})
    assert result["pass"] is True
```

**Step 2: Run test to verify it fails**

Run: `python3 -m unittest runner.tests.test_checks_manifest_alignment -v`
Expected: FAIL (module missing).

**Step 3: Write minimal implementation**

```python
# aaa-evals/runner/checks/check_checks_manifest_alignment.py
import json
from pathlib import Path
from typing import Any

REQUIRED_TYPES = {"all", "docs", "service", "frontend", "agent", "genai-service"}


def check_checks_manifest_alignment(config: dict[str, Any]) -> dict[str, Any]:
    manifest_path = Path(config.get("manifest_path", ""))
    if not manifest_path.exists():
        return {"pass": False, "details": ["checks.manifest.json missing"]}
    try:
        payload = json.loads(manifest_path.read_text(encoding="utf-8"))
    except json.JSONDecodeError:
        return {"pass": False, "details": ["checks.manifest.json invalid JSON"]}

    missing_fields = []
    seen_types: set[str] = set()
    for item in payload.get("checks", []):
        if not all(key in item for key in ("id", "name", "applies_to")):
            missing_fields.append("missing fields in manifest item")
            continue
        applies = set(item.get("applies_to", []))
        seen_types.update(applies)

    missing_types = sorted(REQUIRED_TYPES - seen_types)
    details = []
    if missing_fields:
        details.extend(missing_fields)
    if missing_types:
        details.append(f"missing applies_to types: {', '.join(missing_types)}")
    return {"pass": not details, "details": details}
```

**Step 4: Wire into `run_repo_checks.py`**

- Add `checks_manifest_alignment` to choices.
- Dispatch config:

```python
config = {"manifest_path": args.manifest_path}
```

Add CLI arg:

```python
parser.add_argument("--manifest-path", default="")
```

**Step 5: Run test to verify it passes**

Run: `python3 -m unittest runner.tests.test_checks_manifest_alignment -v`
Expected: PASS.

**Step 6: Commit**

```bash
git add runner/checks/check_checks_manifest_alignment.py runner/run_repo_checks.py runner/tests/test_checks_manifest_alignment.py
git commit -m "feat: add checks manifest alignment check"
```

---

### Task 4: Add repo_type decision prompt

**Files:**
- Create: `aaa-prompts/prompts/governance/repo_type_decision.md`

**Step 1: Write prompt file**

```markdown
# Repo Type Decision (Governance)

## Instruction
1. Read `.aaa/metadata.json` from repo root.
2. If the file is missing or `repo_type` is empty, respond with `BLOCK` and ask to add it.
3. Return `repo_type` and do not guess.

## Output
- repo_type: <docs|service|frontend|agent|genai-service>
- status: <ok|block>
- reason: <if block>
```

**Step 2: Commit**

```bash
git add prompts/governance/repo_type_decision.md
git commit -m "feat: add repo type decision prompt"
```

---

### Task 5: Wire checks into governance suite

**Files:**
- Modify: `aaa-tools/aaa/init_commands.py` (repo-checks checks list)

**Step 1: Update checks list**

```python
checks = ["readme", "workflow", "skills", "prompt", "repo_type_consistency", "checks_manifest_alignment"]
```

Pass extra args to runner when invoking the new checks:
- `--repo-type` should be derived from plan (`repo_type` field).
- `--manifest-path` should default to `../aaa-actions/checks.manifest.json` if exists.

**Step 2: Commit**

```bash
git add aaa/init_commands.py
git commit -m "feat: add v0.7 governance checks"
```

---

### Task 6: Verification

**Run:**
- `python3 -m unittest tests.test_repo_metadata_anchor -v` (aaa-tools)
- `python3 -m unittest runner.tests.test_repo_type_consistency -v` (aaa-evals)
- `python3 -m unittest runner.tests.test_checks_manifest_alignment -v` (aaa-evals)

Expected: PASS.

