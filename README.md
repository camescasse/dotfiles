dotfiles repository to track config files for the following tools:

- .gitconfig globals
- .bashrc current shell
- btop
- desktopbg
- fastfetch
- kitty
- neovim
- spicetify
- yazi
- starship
- chezmoi

managed using [chezmoi](https://www.chezmoi.io). to load config on a new machine, install chezmoi and run:

```bash
chezmoi init https://github.com/camescasse/dotfiles.git

chezmoi update -v
```
