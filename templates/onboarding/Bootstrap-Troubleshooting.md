# Bootstrap Troubleshooting (AAA)

## 403 Forbidden
- Check org member permissions for repo creation.
- If blocked, ask an owner to enable "Repository creation" or pre-create repos.

## 404 / Downloaded HTML Instead of JSON
- Private raw URLs return 404 for `curl`.
- Use `gh api -H "Accept: application/vnd.github.v3.raw"` to download plan/schema.
- Re-run the JSON sanity check.

## pip install Authentication Failed
- Run `gh auth setup-git` to attach git to gh credentials.
- Re-run `gh auth status` and try again.

## CI Not Running
- Check org Actions policy (allowed actions, workflows enabled).
- Ensure workflows pin `aaa-actions@<tag>`.

## Plan Validation Fails
- Run `aaa init validate-plan`.
- Fix missing required checks or placeholders (`{{...}}`).
