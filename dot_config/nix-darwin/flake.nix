{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

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

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, homebrew-core, homebrew-cask }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile.
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
        nix.settings.experimental-features = "nix-command flakes";

        # Enable alternative shell support in nix-darwin.
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 6;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Quality of life
        security.pam.services.sudo_local.touchIdAuth = true;
      };
    in {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#amanda
      darwinConfigurations."amanda" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
    }
}
