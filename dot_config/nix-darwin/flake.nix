{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Use a dash-free alias in outputs to avoid any parsing weirdness.
    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };

    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, darwin, nix-homebrew, homebrew-core, homebrew-cask, ... }:
    let
      configuration = { pkgs, ... }: {
        # Packages
        environment.systemPackages = [
          pkgs.vim
          pkgs.git
          # pkgs.unzip
          # pkgs.unrar
          pkgs.neovim
          pkgs.chezmoi
          pkgs.fastfetch
          # pkgs.bruno
          # pkgs.discord
          pkgs.docker
          pkgs.fzf
          pkgs.ripgrep
          pkgs.bat
          # pkgs.obs-studio
          pkgs.openvpn
          # pkgs.spotify
          pkgs.silicon
          pkgs.prettierd
          pkgs.starship
          pkgs.tmux
          # pkgs.usbimager
          pkgs.yazi
          pkgs.btop
          pkgs.gh
          # pkgs.chromium
          pkgs.lazydocker
          pkgs.localsend
          pkgs.pnpm
          pkgs.go
          pkgs.fnm
          pkgs.opencode
        ];

        # nix-homebrew module config — NOTE the semicolon after the block.
        nix-homebrew = {
          enable = true;
          enableRosetta = true;
          user = "camescasse";
          taps = {
            "homebrew/homebrew-core" = homebrew-core;
            "homebrew/homebrew-cask" = homebrew-cask;
          };
          mutableTaps = false;
        };

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Backwards compatibility.
        system.stateVersion = 6;

        # Platform
        nixpkgs.hostPlatform = "aarch64-darwin";

        # QoL
        security.pam.services.sudo_local.touchIdAuth = true;
      };
    in {
      # $ darwin-rebuild build --flake .#amanda
      darwinConfigurations."amanda" = darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
    }
}
