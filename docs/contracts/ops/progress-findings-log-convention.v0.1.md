# Progress / Findings Log Convention v0.1

- status: `active`
- scope:
  - `progress.md`
  - `progress_archive.md`
  - `findings.md`
  - `findings_archive.md`
- owner: `operations log governance`
- sorting_law: `timestamp_taipei` descending
- entry_header_format: `## Log Entry: <RFC3339+08:00> | <title>`
- archive_trigger_count: `25`
- retained_active_count: `15`
- active_window: `latest 15 entries kept in main file after archive rotation`
- archive_policy: `older entries move to *_archive.md and stay in descending order`

## Purpose

This convention fixes the shared writing schema for long-running operations logs so that both humans and AI tooling can read, sort, diff, and archive them consistently.

## File Roles

- `progress.md`
  - current active progress window
- `progress_archive.md`
  - older progress history that has rotated out of the active window
- `findings.md`
  - current active findings window
- `findings_archive.md`
  - older findings history that has rotated out of the active window

## Required Schema

Each main/archive file must start with a short metadata header that includes:

- `schema_version`
- `sort_key`
- `archive_trigger_count`
- `retained_active_count`
- `active_window`
- `archive_path`
- `entry_header_format`
- `append_law`
- `log_template`
- `convention_ref`

Each log entry must use this header shape:

```md
## Log Entry: 2026-03-22T12:13:11+08:00 | short title
```

The timestamp must be a real observed Taipei timestamp in RFC3339 format. Placeholder timestamps and guessed timestamps are forbidden.

## Append Law

- New entries must always be inserted at the top of the main file.
- Mid-file insertion is forbidden.
- Tail append is forbidden.
- Descending order by `timestamp_taipei` is mandatory.

## Archive Rotation Law

- New entries are written to the top of the main file first.
- If the main file `entry_count >= 25` after the new write, archive rotation must run immediately.
- After rotation, the main file must keep only the latest `15` entries.
- Older entries must be moved into the matching archive file.
- Archive files must keep the same schema and the same descending order.
- Historical body text should be preserved as-is whenever practical.
- After rotation, only minimal cross-reference notes may be added; history should not be substantively rewritten.

## Validation Expectations

At minimum, a valid update should confirm:

- the newest entry is at the top of the main file
- the main file either stays below `25` entries or has already been rotated back to `15`
- the archive file exists and contains older entries
- both files still sort correctly in descending timestamp order
- both files point back to this convention file via `convention_ref`
