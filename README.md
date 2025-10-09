# camescasse/dotfiles

dotfiles repository

## Install guide - MacOS

nix-darwin

```zsh
curl -fsSL https://install.determinate.systems/nix | sh -s -- install

sudo scutil --set ComputerName <hostname>
sudo scutil --set LocalHostName <hostname>
sudo scutil --set HostName <hostname>

```

homebrew

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

manually create `~/.config/nix-darwin/flake.nix` and copy contents from flake.nix in the repo, then run:

```zsh
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.config/nix-darwin
```

chezmoi dotfiles

```zsh
chezmoi init https://github.com/camescasse/dotfiles.git

chezmoi update -v
```

for updates run:

```zsh
sudo darwin-rebuild switch --flake ~/.config/nix-darwin
```

# Apps

tmux

launch, then Ctrl+A > Shift+I

nvim

launch, install Lazy and Mason deps
