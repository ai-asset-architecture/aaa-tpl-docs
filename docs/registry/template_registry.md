# Template Registry

`template_registry.json` is the source of truth for reusable templates.

## Fields
- `version`: schema version
- `generated_at`: ISO-8601 timestamp
- `templates`: map of template ids to metadata

## Template Entry
- `title`: human-readable name
- `summary`: short description
- `source_repo`: repo that owns the template
- `paths`: file paths to the template assets
- `status`: active/planned

## Registry Location
- `ai-asset-architecture-registry/template_registry.json`

