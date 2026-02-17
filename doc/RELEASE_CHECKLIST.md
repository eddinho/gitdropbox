# Release Checklist

Use this checklist before publishing a new version of `gitdropbox`.

## 1. Scope And Version
- [ ] Confirm release scope is frozen and reviewed.
- [ ] Update `VERSION` in `gitdropbox`.
- [ ] Update `doc/CHANGELOG.md` with release date and key changes.

## 2. Quality Gates
- [ ] Run syntax check:
  - `bash -n gitdropbox`
- [ ] Run lint checks:
  - `shellcheck gitdropbox tests/smoke.sh`
- [ ] Run smoke tests:
  - `bash tests/smoke.sh`
- [ ] Manually verify CLI output:
  - `./gitdropbox --help`
  - `./gitdropbox --version`

## 3. Docs And Metadata
- [ ] Ensure `README.md` options and examples match script behavior.
- [ ] Confirm `LICENSE` is present and correct.
- [ ] Ensure `.gitattributes` and `.editorconfig` are up to date.

## 4. Git And Tag
- [ ] Confirm clean working tree:
  - `git status --short`
- [ ] Commit release changes.
- [ ] Create annotated tag:
  - `git tag -a vX.Y.Z -m "vX.Y.Z"`
- [ ] Push branch and tag:
  - `git push origin <branch>`
  - `git push origin vX.Y.Z`

## 5. Publish
- [ ] Create GitHub Release from tag `vX.Y.Z`.
- [ ] Copy highlights from `doc/CHANGELOG.md` into release notes.
- [ ] Verify CI passed on tag/branch.

## 6. Post-Release
- [ ] Quick install test from fresh clone on Linux/macOS.
- [ ] Quick install test from fresh clone on Git Bash (Windows).
- [ ] Open follow-up issues for deferred improvements.
