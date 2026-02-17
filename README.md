# gitdropbox

Create a local project folder and matching bare Git repository in Dropbox, then push your initial branch.

## Features
- Strict Bash mode (`set -euo pipefail`) and clear error messages
- Configurable dev/dropbox paths, branch, and remote name
- Supports CLI flags, `git config` defaults, and environment variable overrides
- Validates branch names, remote names, and existing bare repo integrity
- Safe remote behavior: refuses mismatched remotes unless `--update-remote` is set
- Works on Linux, macOS, and Git Bash on Windows

## Prerequisites
- Git installed and available on PATH
- Bash shell (Git Bash on Windows)

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
gitdropbox my-project
```

### Options
```bash
gitdropbox [OPTIONS] <project-name>

Options:
  -h, --help               Show help
  -V, --version            Show version
  -n, --name NAME          Project name (prompts if missing)
  -d, --dev-dir PATH       Local projects folder (default: ~/dev)
  -D, --dropbox-dir PATH   Dropbox git folder (default: ~/Dropbox/Git)
  -b, --branch NAME        Branch name (default: main)
  -r, --remote NAME        Remote name (default: origin)
  -m, --message TEXT       Commit message (default: "Initial commit")
  -f, --force              Allow existing non-empty project folder
      --update-remote      Update remote URL if it points elsewhere
      --no-color           Disable colored output
      --no-readme          Do not create README.md if missing
      --no-commit          Do not commit or push changes
```

### Examples
```bash
gitdropbox my-project
gitdropbox -d ~/work -D ~/Dropbox/Git -b main my-project
gitdropbox --no-commit my-project
gitdropbox --name=my-project --message="Bootstrap repo"
gitdropbox --update-remote my-project
```

## Configuration
You can set defaults via git config:
```bash
git config --global gitdropbox.devdir ~/dev
git config --global gitdropbox.dropboxdir ~/Dropbox/Git
git config --global gitdropbox.branch main
git config --global gitdropbox.remote origin
```

Environment variable overrides:
```bash
export GITDROPBOX_DEV_DIR=~/dev
export GITDROPBOX_DROPBOX_DIR=~/Dropbox/Git
export GITDROPBOX_BRANCH=main
export GITDROPBOX_REMOTE=origin
```

## Development
```bash
shellcheck gitdropbox
bash tests/smoke.sh
```

## Troubleshooting
- If the project folder exists and is not empty, use `--force` or pick a new name.
- If the Dropbox path exists but is not a bare Git repo, the script will stop with an error.
- If commit fails, set identity first:
  - `git config --global user.name "Your Name"`
  - `git config --global user.email "you@example.com"`
- On Windows, ensure the script uses LF line endings.

## Contributing
See `CONTRIBUTING.md`.

## Releases
See `RELEASE_CHECKLIST.md`.

## License
MIT
