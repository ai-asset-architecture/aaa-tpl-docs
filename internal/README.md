# AAA Internal Documentation

🔒 **For AAA Core Developers Only**

This directory contains internal working artifacts for the AAA core development team.

## 📁 Directory Structure

### `development/`
Core development documentation
- `milestones/completion-reports/` - Detailed milestone completion reports (Detail mode)
- `audits/` - Governance audit results (nightly, GitHub org)
- `plans/` - Active implementation plans
- `debug/` - Post-mortem analysis and debugging
- `architecture/` - Detailed technical architecture

### `operations/`
Operations and deployment documentation
- `runbooks/` - Operational runbooks
- `deployment/` - Deployment guides
- `monitoring/` - Monitoring and observability

## 📌 Quick Links for AI Developers

- **Latest Completion Report**: [development/milestones/completion-reports/LATEST.md](development/milestones/completion-reports/LATEST.md) *(Coming Soon)*
- **Latest Nightly Audit**: [development/audits/nightly/LATEST.md](development/audits/nightly/LATEST.md) *(Coming Soon)*
- **Latest GitHub Audit**: [development/audits/github/LATEST.md](development/audits/github/LATEST.md) *(Coming Soon)*
- **Machine-readable manifest**: [index.json](index.json)

## 🔄 Symlink Policy

**CRITICAL**: All `audits/` and `completion-reports/` subdirectories **MUST** maintain a `LATEST.md` symlink.

```bash
# Update LATEST symlink when adding new reports
ln -sf $(ls -t *.md | grep -v LATEST | head -1) LATEST.md
```

## 🔄 Auto-Archive Policy

Files older than **30 days** in `development/audits/` are automatically moved to `development/audits/archive/`.

---

**Status**: 🚧 Under Construction (Phase 1)  
**Last Updated**: 2026-01-27
