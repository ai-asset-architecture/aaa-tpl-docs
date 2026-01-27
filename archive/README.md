# AAA Archive

📦 **Historical Documents (Automated Archive)**

This directory contains historical documents that are automatically archived after **30 days** of inactivity.

## 📅 Archive Structure

Documents are organized by year-month:

```
archive/
├── 2026-01/
│   ├── audits/          ← Audit reports from January 2026
│   └── reports/         ← Other reports from January 2026
├── 2025-12/
│   └── ...
└── ...
```

## 🔍 Finding Archived Documents

### By Date
Navigate to the corresponding `YYYY-MM/` folder to find documents from that period.

### By Type
Within each month folder:
- `audits/` - Nightly and GitHub audit reports
- `reports/` - Milestone completion reports and other reports
- `plans/` - Completed or obsolete implementation plans

## 📌 Quick Reference

- **Latest Active Documents**: See [`internal/`](../internal/)
- **Recent Audits**: Use `internal/development/audits/.../LATEST.md` symlinks
- **Search Archive**: `find archive/ -name "*keyword*.md"`

## ⚙️ Automation

Archive is managed by `scripts/auto-archive.sh` (runs nightly via GitHub Actions).

---

**Status**: 🚧 Under Construction (Phase 1)  
**Last Updated**: 2026-01-27
