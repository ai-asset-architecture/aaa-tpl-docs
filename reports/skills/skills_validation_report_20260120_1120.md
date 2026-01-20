# Skills 驗證報告 (2026-01-20 11:20)

## 檢查項目
- `skill_structure_v2`
- `tests/smoke.sh`

## 結果
- skill_structure_v2: PASS
- smoke tests: PASS

## 指令
```bash
python3 aaa-evals/runner/run_repo_checks.py --check skill_structure_v2 --repo aaa-tools --skills-root skills
python3 - <<'PY'
from pathlib import Path
root = Path('aaa-tools/skills/common')
failed = []
for skill in root.iterdir():
    if not (skill.is_dir() and skill.name.startswith('aaa-')):
        continue
    smoke = skill / 'tests' / 'smoke.sh'
    if not smoke.exists():
        failed.append(skill.name)
        continue
    import subprocess
    result = subprocess.run([str(smoke)], capture_output=True, text=True)
    if result.returncode != 0:
        failed.append(f"{skill.name}: {result.stdout.strip()} {result.stderr.strip()}")
print('PASS' if not failed else 'FAIL')
for item in failed:
    print(item)
PY
```
