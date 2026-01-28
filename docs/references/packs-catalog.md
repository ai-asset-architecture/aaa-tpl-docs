---
title: AAA Packs Catalog
summary_zh: 'AAA Packs 完整索引與使用指南'
summary_en: 'Complete AAA Packs catalog with usage guide'
version: '1.0'
created: '2026-01-28'
---

# AAA Packs Catalog

> **Purpose**: Complete index of all AAA asset packs  
> **System**: Pack-based asset distribution (v0.8)  
> **Registry**: `ai-asset-architecture-registry/registry_index.json`  
> **Total**: 1 seed pack (v1.0)

---

## What are Packs?

**Packs** are distributable asset bundles containing:
- ✅ **Evals**: Reusable evaluation checks
- ✅ **Templates**: Document structures  
- ✅ **Prompts**: LLM instructions
- ✅ **Schemas**: Validation specifications
- ✅ **Manifest**: Pack metadata

**Key Features**:
- Versioned (`pack@1.0.0`)
- Installable via `aaa pack install`
- Dynamically loadable by `aaa-evals`

---

## Available Packs

### agent-safety@1.0.0 (Seed Pack)

**Purpose**: Agent safety evaluation suite  
**Created**: v0.8  
**Registry**: `ai-asset-architecture-registry`

**Contents**:
- Security checks (path traversal, unauthorized actions)
- Safety evals for AI agents
- Agent action validation

**Installation**:
```bash
aaa pack install agent-safety@1.0.0
```

**Usage**:
```bash
# Load pack in evals
python runner/run_evalswith_pack.py \
  --pack agent-safety@1.0.0 \
  --repo /path/to/repo
```

---

## Pack Structure

```
pack-name/
├── pack.manifest.json    # Pack metadata
├── evals/                # Evaluation cases
│   ├── check_*.py
│   └── *.jsonl
├── templates/            # Optional
├── prompts/              # Optional
└── schemas/              # Optional
```

### pack.manifest.json
```json
{
  "name": "pack-name",
  "version": "1.0.0",
  "description": "Pack purpose",
  "author": "org-name",
  "dependencies": [],
  "contents": {
    "evals": ["check_name"],
    "templates": [],
    "prompts": []
  }
}
```

---

## Pack Commands

### List Available Packs
```bash
aaa pack list
```

### Install Pack
```bash
aaa pack install <pack-name>@<version>
```

### Show Pack Info
```bash
aaa pack show <pack-name>@<version>
```

### Build Custom Pack
```bash
aaa pack build --manifest ./pack.manifest.json
```

---

## Creating Custom Packs

### 1. Create Pack Structure
```bash
mkdir my-pack
cd my-pack
```

### 2. Create Manifest
```json
{
  "name": "my-pack",
  "version": "1.0.0",
  "description": "My custom pack",
  "contents": {
    "evals": ["my_check"]
  }
}
```

### 3. Add Assets
```bash
mkdir evals
# Add check runners, cases, etc.
```

### 4. Build Pack
```bash
aaa pack build --manifest ./pack.manifest.json
```

### 5. Publish to Registry
```bash
# Add to ai-asset-architecture-registry/registry_index.json
```

---

## Registry Structure

**Location**: `ai-asset-architecture-registry/registry_index.json`

```json
{
  "packs": [
    {
      "name": "agent-safety",
      "versions": ["1.0.0"],
      "latest": "1.0.0",
      "source": "https://github.com/ai-asset-architecture/aaa-evals"
    }
  ]
}
```

---

## Planned Packs (v1.1+)

| Pack | Target Version | Contents |
|------|----------------|----------|
| **ops-pack** | v1.2 | Org-level operation runbooks |
| **repo-pack** | v1.2 | Repository management runbooks |
| **security-pack** | v1.2 | Security checks & validations |
| **industry-fintech-pack** | v2.0 | Fintech compliance evals |
| **industry-healthcare-pack** | v2.0 | HIPAA compliance evals |

*See [AAA_roadmap.md § Known Limitations](../../milestones/AAA_roadmap.md#v10-known-limitations--deferred-features) for details*

---

## Pack vs Other Assets

| Aspect | Packs | Individual Assets |
|--------|-------|-------------------|
| **Distribution** | Bundled, versioned | Single file |
| **Installation** | `aaa pack install` | Manual copy |
| **Updates** | Version upgrade | Manual replace |
| **Dependencies** | Declared in manifest | Ad-hoc |
| **Discovery** | Registry lookup | File search |

---

## Total Count

- **Available Packs**: 1 (v1.0)
- **Planned Packs**: 5+ (v1.1-v2.0)
- **Pack System**: Production-ready (v0.8)

---

**Last Updated**: 2026-01-28  
**Version**: 1.0
