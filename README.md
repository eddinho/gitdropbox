# gitdropbox

The script creates a new git project in `~/"new project"` and initializes a git repo on your Dropbox folder (`~/Dropbox/Git/"new project"`).

## Installation
```bash
mkdir ~/dev

cd ~/dev

git clone https://github.com/eddinho/gitdropbox.git

sudo cp ~/dev/gitdropbox/gitdropbox /usr/local/bin/

sudo chmod +x /usr/local/bin/gitdropbox
```

## Usage
```bash
gitdropbox newProject
