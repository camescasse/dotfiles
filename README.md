# camescasse/dotfiles

dotfiles repository

## Install guide - Arch Linux

after a base install with `base base-devel linux linux-firmware linux-headers`

### pacman

```sh
pacman -S --needed \
  amd-ucode efibootmgr dkms nvidia reflector zram-generator smartmontools \
  zsh less man-db nano wget tree unrar unzip 7zip \
  networkmanager network-manager-applet iwd wireless_tools bluez-utils openvpn \
  pipewire pipewire-alsa pipewire-jack pipewire-pulse gst-plugin-pipewire \
  wireplumber libpulse v4l2loopback-dkms v4l2loopback-utils \
  hyprland hyprpaper hyprpolkitagent sddm waybar wofi mako \
  xdg-desktop-portal-hyprland xdg-utils xorg-xinit \
  qt5-wayland qt6-multimedia-ffmpeg qt6-virtualkeyboard wl-clipboard swappy \
  git github-cli chezmoi neovim vim tmux \
  starship fastfetch btop yazi bat fd fzf ripgrep silicon prettierd \
  fnm pnpm go docker lazydocker \
  ghostty nautilus mpv inkscape yt-dlp \
  steam discord obs-studio libreoffice-still spotify-launcher \
  gnome-themes-extra accountsservice ttf-hack noto-fonts-cjk noto-fonts-emoji \
  jdk17-openjdk java-runtime-common android-tools
```

### paru (AUR)

install paru first: https://github.com/Morganamilo/paru

```sh
paru -S --needed \
  zen-browser-bin google-chrome localsend-bin bruno-bin opencode-bin \
  hyprshot clipse hyprlauncher pwvucontrol blueberry \
  networkmanager-dmenu-git qflipper usbimager \
  android-sdk-cmdline-tools-latest android-studio
```

### chezmoi dotfiles

```sh
chezmoi init https://github.com/camescasse/dotfiles.git
chezmoi apply -v
```

### post-install

```sh
# set zsh as default shell
chsh -s /usr/bin/zsh

# enable services
sudo systemctl enable --now sddm NetworkManager bluetooth docker

# tmux - launch, then Ctrl+A > Shift+I to install plugins
# nvim - launch, let Lazy and Mason install deps
```

---

## Install guide - macOS

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

manually create `~/.config/nix-darwin/flake.nix` and copy contents from flake.nix
in the repo, then run:

```zsh
sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.config/nix-darwin
```

chezmoi dotfiles

```zsh
chezmoi init https://github.com/camescasse/dotfiles.git
chezmoi apply -v
```

for updates run:

```zsh
sudo darwin-rebuild switch --flake ~/.config/nix-darwin
```

### post-install

```
tmux  - launch, then Ctrl+A > Shift+I
nvim  - launch, let Lazy and Mason install deps
```
