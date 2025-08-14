{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:nix-darwin/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, ... }:
    let
      configuration = { pkgs, ... }: {
        # Packages
        environment.systemPackages = [
          pkgs.git
          pkgs.gh
          pkgs.ripgrep
          pkgs.fzf
          pkgs.bat
          pkgs.fastfetch
          pkgs.starship
          pkgs.tmux
          pkgs.vim
          pkgs.neovim
          pkgs.chezmoi
          pkgs.btop
          pkgs.yazi
          pkgs.openvpn
          pkgs.silicon
          pkgs.prettierd
          pkgs.docker
          pkgs.lazydocker
          pkgs.pnpm
          pkgs.fnm
          pkgs.go
          pkgs.opencode
          pkgs.localsend
          pkgs.yabai
          pkgs.skhd
        ];

        homebrew.enable = true;

        homebrew.casks = [
          "google-chrome"
          "ghostty"
          "obs"
          "bruno"
          "discord"
          "spotify"
          "zen"
          "whatsapp"
          "steam"
          "sol"
          "libreoffice"
          "qflipper"
        ];

        environment.variables =
          {
            EDITOR = "nvim";
          };

        # Necessary for using flakes on this system
        nix.settings.experimental-features = [ "nix-command" "flakes" ];

        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Backwards compatibility
        system.stateVersion = 6;

        # Platform
        nixpkgs.hostPlatform = "aarch64-darwin";

        # Touch ID on sudo
        security.pam.services.sudo_local.touchIdAuth = true;
        security.pam.services.sudo_local.reattach = true;

        # Theme
        system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
        system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;
        system.defaults.NSGlobalDomain.AppleICUForce24HourTime = true;

        # Typing
        system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticInlinePredictionEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;
        system.defaults.NSGlobalDomain.NSAutomaticSpellingCorrectionEnabled = false;

        # iCloud
        system.defaults.NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;

        # Control Center
        system.defaults.controlcenter.BatteryShowPercentage = true;
        system.defaults.controlcenter.Bluetooth = true;
        system.defaults.controlcenter.NowPlaying = true;

        # Dock
        system.defaults.dock.enable-spring-load-actions-on-all-items = false;
        system.defaults.dock.autohide = true;
        system.defaults.dock.minimize-to-application = true;
        system.defaults.dock.mineffect = "scale";
        system.defaults.dock.show-recents = false;
        system.defaults.dock.tilesize = 48;
        system.defaults.dock.persistent-apps = [
          {
            app = "/Applications/Ghostty.app/";
          }
          {
            app = "/Applications/Zen.app/";
          }
          {
            app = "/Applications/WhatsApp.app/";
          }
          {
            app = "/Applications/Spotify.app/";
          }
        ];

        # Finder
        system.defaults.NSGlobalDomain.AppleShowAllExtensions = true;
        system.defaults.NSGlobalDomain.AppleShowAllFiles = true;
        system.defaults.finder.CreateDesktop = false;
        system.defaults.finder.FXEnableExtensionChangeWarning = false;
        system.defaults.finder.FXPreferredViewStyle = "Nlsv";
        system.defaults.finder.NewWindowTarget = "Home";
        system.defaults.finder.QuitMenuItem = true;
        system.defaults.finder.ShowExternalHardDrivesOnDesktop = false;
        system.defaults.finder.ShowPathbar = true;

        # Login
        system.primaryUser = "camescasse";
        system.defaults.loginwindow.GuestEnabled = false;

        # Screen capture
        system.defaults.screencapture.include-date = false;
        system.defaults.screencapture.location = "~/Pictures/screenshots/";
        system.defaults.screencapture.target = "clipboard";

        # Keyboard & trackpad mappings
        system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
        system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;
        system.defaults.NSGlobalDomain.KeyRepeat = 2;
        system.keyboard.enableKeyMapping = true;
        system.keyboard.remapCapsLockToEscape = true;

        # Power management
        power.sleep.computer = 30;
        power.sleep.display = 15;

        # Services
        services.yabai.enable = true;
        services.yabai.enableScriptingAddition = true; # requires running "sudo yabai --load-sa" after darwin-rebuild switch
        services.skhd.enable = true;

        # Miscellaneous
        system.defaults.NSGlobalDomain.NSDisableAutomaticTermination = true;
        system.defaults.NSGlobalDomain.NSNavPanelExpandedStateForSaveMode = true;
        system.defaults.SoftwareUpdate.AutomaticallyInstallMacOSUpdates = false;
        system.defaults.WindowManager.AutoHide = true;

        # Possible changes
        # system.defaults.NSGlobalDomain.AppleEnableMouseSwipeNavigateWithScrolls = false;
        # system.defaults.NSGlobalDomain.AppleEnableSwipeNavigateWithScrolls = false;
        # system.defaults.hitoolbox.AppleFnUsageType = "Do Nothing";
      };
    in
    {
      # $ darwin-rebuild build --flake .#amanda
      darwinConfigurations."amanda" = darwin.lib.darwinSystem {
        modules = [
          configuration
        ];
      };
    };
}
