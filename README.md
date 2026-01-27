# aaa-tpl-docs

## Purpose / Scope
Template repo for documentation-centric projects. Provides a standard docs skeleton aligned with aaa governance.

## Ownership / CODEOWNERS
Owned by the docs maintainers. See `CODEOWNERS` (to be added).

## Versioning / Release
Templates are versioned by git tags. Consumers should fork or use a specific tag when generating new repos.

## How to Consume / Use
Use this repo as a template to initialize a docs repo, then customize content for your org/project.

## Contribution / Promotion Rules
Template changes must preserve required files and be released with a tag.

## Docs SSOT Rules
This repo is the single source of truth for project documentation. Do not duplicate docs in code repos.

## Required Files
- `AI_COMMAND_CENTER.md` (ACC)
- `PROJECT_PLAYBOOK.md` (PP)
- `prd/` (PRD files)
- `adr/` (ADR files)

## Onboarding Templates
- `templates/onboarding/Member-Start-Checklist.md`
- `templates/onboarding/Bootstrap-Troubleshooting.md`

## Review Templates
- `templates/Skill-Review-Checklist.md`

## Contribution Docs
- `docs/asset-contribution-sop.md`

## Reports Index
- `reports/skills/skills_v0.2_upgrade_report_20260120_0309.md`

## Milestones vs Reports
- `milestones/` - architecture definition milestones (specs completed, system definition).
- `internal/development/milestones/completion-reports/` - implementation/verification reports (changes + validation results).

## .ai-context.md usage
Include `.ai-context.md` at the repo root to enforce agent behavior and required knowledge loading.

---

## 📁 Repository Structure (Updated 2026-01-27)

This repository is organized into the following directories:

### 🌐 [`public/`](public/)
**For External Users** - Documentation for those who want to use AAA.
- Quick start guides & MCP server connection
- Step-by-step tutorials
- Architecture overview
- **Future**: Will be extracted as standalone `aaa-docs` (PUBLIC repo)

### 🔒 [`internal/`](internal/)
**For AAA Core Team Only** - Internal development documentation.
- `development/` - Milestones, audits, plans, debug logs
- `operations/` - Runbooks, deployment, monitoring
- **Future**: Will remain in this repo when it becomes PRIVATE

### 📊 [`milestones/`](milestones/)
**High-Level Overview** - Architecture definitions & roadmap (Project facade).

### 📦 [`archive/`](archive/)
**Historical Documents** - Auto-archived documents (> 30 days old).

### 📄 [`templates/`](templates/)
**Template Files** - Reusable templates for AAA-adopting projects.

---

**Note**: This repo is undergoing structure reorganization (Phase 1 complete as of 2026-01-27). Legacy directories (`docs/`, `reports/`, `arch/`) will be migrated in Phase 2-4.

**Dual-Repo Strategy**: This repo is being prepared for future separation:
- `public/` → `aaa-docs` (PUBLIC repo, external entry point)
- Rest of repo (including `internal/`) → becomes PRIVATE
