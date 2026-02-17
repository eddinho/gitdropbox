# gitdropbox

Create a local project and a bare git repository in Dropbox, then push to it.

## Features
- Safe defaults with validation and clear errors
- Configurable folders and branch name
- Creates README.md if missing
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
```

### Windows (Git Bash)
```bash
git clone https://github.com/eddinho/gitdropbox.git
mkdir -p ~/bin
cp gitdropbox/gitdropbox ~/bin/
chmod +x ~/bin/gitdropbox
echo 'export PATH="$HOME/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
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
  -n, --name NAME          Project name (prompts if missing)
  -d, --dev-dir PATH       Local projects folder (default: ~/dev)
  -D, --dropbox-dir PATH   Dropbox git folder (default: ~/Dropbox/Git)
  -b, --branch NAME        Branch name (default: main)
  -r, --remote NAME        Remote name (default: origin)
  -f, --force              Allow existing non-empty project folder
      --no-readme          Do not create README.md if missing
      --no-commit          Do not commit or push changes
```

### Examples
```bash
gitdropbox my-project
gitdropbox -d ~/work -D ~/Dropbox/Git -b main my-project
gitdropbox --no-commit my-project
```

## Configuration
You can set defaults via git config:
```bash
git config --global gitdropbox.devdir ~/dev
git config --global gitdropbox.dropboxdir ~/Dropbox/Git
git config --global gitdropbox.branch main
git config --global gitdropbox.remote origin
```

## Troubleshooting
- If the project folder exists and is not empty, use `--force` or pick a new name.
- If the Dropbox bare repo already exists, the script will reuse it.
- On Windows, ensure the script uses LF line endings.

## License
MIT
