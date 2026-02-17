# gitdropbox

`gitdropbox` is a Bash CLI that creates a local project and a matching bare Git repository in Dropbox, then connects and pushes your initial branch.

## Why Use It
- Start a new project and Dropbox-backed remote in one command.
- Keep data local and simple (no extra service required).
- Avoid common setup mistakes with strict validation and safer defaults.

## Features
- Strict Bash mode (`set -euo pipefail`) with actionable errors
- Configurable dev folder, Dropbox folder, branch, and remote name
- CLI flags + `git config` defaults + environment variable overrides
- Bare-repository integrity checks before use
- Safe remote handling (`--update-remote` required to repoint existing remotes)
- Linux, macOS, and Git Bash (Windows) support

## Requirements
- Git available on `PATH`
- Bash shell (`bash` / Git Bash on Windows)

## Quick Start
```bash
gitdropbox my-project
```

This will:
1. Create `~/dev/my-project` (by default)
2. Create `~/Dropbox/Git/my-project.git` (bare repo)
3. Initialize local Git, add `origin`, commit, and push

## Installation

### Linux / macOS
```bash
git clone https://github.com/eddinho/gitdropbox.git
sudo cp gitdropbox/gitdropbox /usr/local/bin/
sudo chmod +x /usr/local/bin/gitdropbox
gitdropbox --version
```

### Windows (Git Bash)
```bash
git clone https://github.com/eddinho/gitdropbox.git
mkdir -p ~/bin
cp gitdropbox/gitdropbox ~/bin/
chmod +x ~/bin/gitdropbox
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
gitdropbox --version
```

## Usage
```bash
gitdropbox [OPTIONS] <project-name>
```

### Options
| Option | Description |
| --- | --- |
| `-h, --help` | Show help |
| `-V, --version` | Show version |
| `-n, --name NAME` | Project name (prompts if missing) |
| `-d, --dev-dir PATH` | Local projects folder (default: `~/dev`) |
| `-D, --dropbox-dir PATH` | Dropbox Git folder (default: `~/Dropbox/Git`) |
| `-b, --branch NAME` | Branch name (default: `main`) |
| `-r, --remote NAME` | Remote name (default: `origin`) |
| `-m, --message TEXT` | Commit message (default: `Initial commit`) |
| `-f, --force` | Allow existing non-empty project folder |
| `--update-remote` | Update remote URL if it points elsewhere |
| `--no-color` | Disable colored output |
| `--no-readme` | Skip creating `README.md` |
| `--no-commit` | Skip commit and push |

### Examples
```bash
gitdropbox my-project
gitdropbox -d ~/work -D ~/Dropbox/Git -b main my-project
gitdropbox --name=my-project --message="Bootstrap repo"
gitdropbox --no-commit my-project
gitdropbox --update-remote my-project
```

## Configuration
Set defaults with Git config:
```bash
git config --global gitdropbox.devdir ~/dev
git config --global gitdropbox.dropboxdir ~/Dropbox/Git
git config --global gitdropbox.branch main
git config --global gitdropbox.remote origin
```

Override via environment variables:
```bash
export GITDROPBOX_DEV_DIR=~/dev
export GITDROPBOX_DROPBOX_DIR=~/Dropbox/Git
export GITDROPBOX_BRANCH=main
export GITDROPBOX_REMOTE=origin
```

Precedence is: CLI options > environment variables > Git config > built-in defaults.

## Development
```bash
bash -n gitdropbox
shellcheck gitdropbox tests/smoke.sh
bash tests/smoke.sh
```

## Troubleshooting
- Existing non-empty project directory:
  Use `--force` or choose another name.
- Existing Dropbox path is not a bare repository:
  Move or rename the path, then rerun.
- Commit fails due missing identity:
  - `git config --global user.name "Your Name"`
  - `git config --global user.email "you@example.com"`
- Windows line endings:
  Keep LF line endings (enforced via `.gitattributes`).

## Contributing
See `doc/CONTRIBUTING.md`.

## Release Process
See `doc/RELEASE_CHECKLIST.md`.

## License
MIT
