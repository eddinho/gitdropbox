#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

fail() {
    printf 'Test failed: %s\n' "$*" >&2
    exit 1
}

assert_exists() {
    local path="$1"
    [[ -e "$path" ]] || fail "Expected path to exist: $path"
}

assert_eq() {
    local got="$1"
    local expected="$2"
    [[ "$got" == "$expected" ]] || fail "Expected '$expected', got '$got'"
}

SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
ROOT_DIR=$(cd "$SCRIPT_DIR/.." && pwd -P)

TMP_ROOT=$(mktemp -d)
trap 'rm -rf "$TMP_ROOT"' EXIT

DEV_DIR="$TMP_ROOT/dev"
DROPBOX_DIR="$TMP_ROOT/dropbox"
PROJECT="demo-project"

export GIT_AUTHOR_NAME="gitdropbox-test"
export GIT_AUTHOR_EMAIL="gitdropbox-test@example.com"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

"$ROOT_DIR/gitdropbox" \
    --dev-dir "$DEV_DIR" \
    --dropbox-dir "$DROPBOX_DIR" \
    --name "$PROJECT"

PROJECT_DIR="$DEV_DIR/$PROJECT"
BARE_REPO="$DROPBOX_DIR/$PROJECT.git"

assert_exists "$PROJECT_DIR/.git"
assert_exists "$PROJECT_DIR/README.md"
assert_exists "$BARE_REPO/HEAD"

CURRENT_BRANCH=$(git -C "$PROJECT_DIR" symbolic-ref --short HEAD)
assert_eq "$CURRENT_BRANCH" "main"

REMOTE_URL=$(git -C "$PROJECT_DIR" remote get-url origin)
REMOTE_PATH="${REMOTE_URL#file://}"
assert_exists "$REMOTE_PATH"
[[ "$(git -C "$REMOTE_PATH" rev-parse --is-bare-repository 2>/dev/null || true)" == "true" ]] || fail "Remote is not a bare repository: $REMOTE_URL"

git -C "$PROJECT_DIR" ls-remote origin refs/heads/main >/dev/null 2>&1 || fail "Expected remote main branch to exist"

# Rerun on an existing project should be safe and idempotent with --force.
"$ROOT_DIR/gitdropbox" \
    --dev-dir "$DEV_DIR" \
    --dropbox-dir "$DROPBOX_DIR" \
    --name "$PROJECT" \
    --force \
    --no-commit

PROJECT_NO_COMMIT="demo-no-commit"
"$ROOT_DIR/gitdropbox" \
    --dev-dir "$DEV_DIR" \
    --dropbox-dir "$DROPBOX_DIR" \
    --name "$PROJECT_NO_COMMIT" \
    --no-commit

PROJECT_NO_COMMIT_DIR="$DEV_DIR/$PROJECT_NO_COMMIT"
assert_exists "$PROJECT_NO_COMMIT_DIR/.git"
if git -C "$PROJECT_NO_COMMIT_DIR" rev-parse --verify HEAD >/dev/null 2>&1; then
    fail "--no-commit should not create a commit"
fi

printf 'All smoke tests passed.\n'
