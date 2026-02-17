# Contributing

Thanks for contributing to `gitdropbox`.

## Development Setup
1. Fork and clone the repository.
2. Ensure Git and Bash are available.
3. Create a working branch:
   - `git checkout -b your-branch-name`

## Local Checks
Run these before opening a pull request:

```bash
bash -n gitdropbox
shellcheck gitdropbox tests/smoke.sh
bash tests/smoke.sh
```

If `shellcheck` is not installed locally, CI will still run it.

## Coding Guidelines
- Keep the script POSIX-aware where practical, but Bash-first and explicit.
- Preserve strict mode in scripts: `set -euo pipefail`.
- Prefer defensive checks and actionable error messages.
- Keep docs in sync when adding/changing CLI options.
- Use LF line endings (`.gitattributes` enforces this in Git).

## Pull Requests
1. Describe the problem and why your change is needed.
2. Keep changes focused and minimal.
3. Include test updates when behavior changes.
4. Update `README.md` and `CHANGELOG.md` when user-facing behavior changes.

## Release Process
Maintainers should follow `RELEASE_CHECKLIST.md` before publishing.
