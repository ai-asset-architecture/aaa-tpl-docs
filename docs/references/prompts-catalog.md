---
title: AAA Prompts Catalog
summary_zh: 'AAA Prompts 完整索引與使用指南'
summary_en: 'Complete AAA Prompts catalog with usage guide'
version: '1.0'
created: '2026-01-28'
---

# AAA Prompts Catalog

> **Purpose**: Complete index of all AAA LLM prompts  
> **Location**: `aaa-prompts/prompts/`  
> **Total**: 5 categories, 6+ prompt files

---

## What are Prompts?

**Prompts** are structured LLM instructions for:
- ✅ **Onboarding**: Member bootstrap and review
- ✅ **QA**: Test coverage Strategy
- ✅ **Governance**: Review processes
- ✅ **CLI**: Command execution guides

---

## Prompt Categories

### 📝 Onboarding (4 prompts)

| Prompt | Path | Purpose | Format |
|--------|------|---------|--------|
| Onboarding Review | `onboarding/onboarding_review_prompt.md` | Review onboarding docs | Markdown |
| Bootstrap Guide | `onboarding/member_bootstrap.md` | New member setup | Markdown |
| Command Guide | `onboarding/onboarding_commands.md` | Onboarding CLI commands | Markdown |
| Review Schema | `onboarding/review_prompts.json` | Structured review format | JSON |

### 🧪 QA (1 prompt)

| Prompt | Path | Purpose | Format |
|--------|------|---------|--------|
| Evidence-Based Validation Guide | `qa/evidence_based_validation_guide_v1.0.json` | When to use evidence-based vs structured tests | JSON |

**Created**: 2026-01-28  
**Key Features**:
- Appropriate scenarios for evidence-based validation
- Minimum evidence requirements
- Adjusted 1+2+1 rule formula
- Real examples from v0.9 & v1.0
- QA engineer checklist

### 🏛️ Governance (1 prompt)

| Prompt | Path | Purpose | Format |
|--------|------|---------|--------|
| Governance Review | `governance/governance_review_prompt.md` | Review governance changes | Markdown |
| Triple-Summary Protocol | `governance/triple_summary_protocol.md` | Communication logic for alignment | Markdown |

### 💻 CLI (3 prompts)

| Prompt | Path | Purpose | Format |
|--------|------|---------|--------|
| Init Commands | `cli/init_commands.md` | `aaa init` usage | Markdown |
| Audit Commands | `cli/audit_commands.md` | `aaa audit` usage | Markdown |
| Check Commands | `cli/check_commands.md` | `aaa check` usage | Markdown |

### 📖 Example (1 prompt)

| Prompt | Path | Purpose | Format |
|--------|------|---------|--------|
| Example Prompt | `example/example_prompt.json` | Prompt template example | JSON |

---

## Prompt Structure (JSON)

```json
{
  "name": "prompt_name",
  "version": "1.0",
  "created": "YYYY-MM-DD",
  "purpose": "What this prompt guides",
  "guidance": {
    "when_to_use": [...],
    "how_to_use": {...},
    "examples": {...}
  }
}
```

---

## Usage Examples

### Using QA Prompt
```python
import json

with open('prompts/qa/evidence_based_validation_guide_v1.0.json') as f:
    guide = json.load(f)
    
# Check if feature qualifies for evidence-based validation
if feature_type in guide['guidance']['when_to_use_evidence_based_validation']['appropriate_scenarios']:
    # Use evidence-based approach
    ...
```

### Using Onboarding Prompt
```bash
# Read onboarding commands
cat aaa-prompts/prompts/onboarding/onboarding_commands.md

# Follow step-by-step
```

---

## Creating Custom Prompts

1. **Choose format**:
   - **JSON**: Structured guidance (preferred for programmatic use)
   - **Markdown**: Human-readable instructions

2. **Follow schema**:
   - Include purpose, version, created date
   - Clear guidance sections
   - Examples when applicable

3. **Place in category directory**:
   - `onboarding/`, `qa/`, `governance/`, `cli/`, etc.

4. **Update this catalog**

---

## Prompt vs Template

| Aspect | Prompts | Templates |
|--------|---------|-----------|
| **Purpose** | Guide LLM/human actions | Document structure |
| **Audience** | AI agents + humans | Humans |
| **Format** | JSON/Markdown instructions | Markdown documents |
| **Usage** | Read → Execute | Copy → Fill |

---

## Total Count

- **Categories**: 5
- **Total Prompts**: 6+
- **Formats**: JSON (2), Markdown (4+)

---

| 1.0 | 2026-01-28 | Initial catalog creation |
| 1.1 | 2026-01-28 | Added v1.1 Protocols (Triple-Summary) |

---

**Last Updated**: 2026-01-28  
**Version**: 1.1
