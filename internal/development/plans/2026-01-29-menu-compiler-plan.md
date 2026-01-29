<template id="plan">
# Implementation Plan: v1.6 Menu Compiler

## Goal Description
Implement "The Menu Compiler" to transform `AAA_MENU.md` (Human Interface) into `registry_index.v2.json` (Machine Protocol). This establishes the Markdown menu as the Single Source of Truth (SSOT).

## User Review Required
> [!IMPORTANT]
> **Source format dependence**: The compiler relies on specific Markdown structures (Tables for Archetypes, Checkbox Lists for Packs). Changes to `AAA_MENU.md` formatting may break the compiler.

## Proposed Changes
### [aaa-tools]
#### [NEW] aaa/compiler/menu_v2.py
- **Purpose**: Core parsing logic for Markdown -> JSON.
- **Components**:
    - `compile_menu(source, output)`: Main driver.
    - `_parse_archetypes_table(content)`: Extracts Archetype definitions.
    - `_parse_packs_list(content)`: Extracts Pack capabilities.

#### [NEW] aaa/cmd/registry_commands.py
- **Purpose**: CLI interface.
- **Command**: `aaa registry compile --source <path>`

#### [MODIFY] aaa/cli.py
- **Change**: Register `registry` command group.

## Triple-Summary Protocol (v1.6)
### 1. Strategic Plan (戰略計畫摘要)
Execute "Visual Interface -> Machine Protocol" strategy. Create a compiler that allows the "Physical Menu" (Markdown) to drive the "Digital Registry" (JSON), enforcing the "Input/Output Co-location" architectural principle.

### 2. Schema Evolution (結構演進摘要)
- **Input**: Markdown (Standard GFM Tables & Lists).
- **Output**: `registry_index.v2.json` (Compliant with Schema 2.0).
- **Transformation**: Maps Markdown columns to JSON fields (`Archetype` -> `object_types`, `Includes Packs` -> `inherited_packs`).

### 3. Component Architecture (組件架構摘要)
- **Parser**: Regex-based Markdown parser in `menu_v2.py`.
- **Generator**: JSON serialization logic reusing existing schema constraints.
- **CLI**: Standard Typer command in `registry_commands.py` invoking the Parser.

## Verification Plan
### Automated Tests
- `pytest tests/compiler/test_menu_v2.py`: Verify parsing of sample Markdown content.

### Manual Verification
1. Run `aaa registry compile --source ai-asset-architecture-registry/AAA_MENU.md`
2. Verify `ai-asset-architecture-registry/registry_index.v2.json` is updated.
3. Diff the generated JSON with expected structure.
</template>
