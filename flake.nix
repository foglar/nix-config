{
  description = "My highly sofisticated and complicated flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-stable,
    ...
  } @ inputs: let
    userSettings = {
      username = "shinya"; # konsta or shinya (else defaulting to shinya or none)
      hostname = "kogami"; # kogami or ginoza

      shell = "zsh"; # bash, zsh, none
      terminal = "kitty"; # kitty, alacritty, gnome-terminal
      browser = "librewolf"; # firefox, librewolf, qutebrowser
      editor = "neovim"; # neovim, vscode

      # List all themes: $ nix build nixpkgs#base16-schemes && ls result/share/themes
      theme = "catppuccin-mocha"; #tokyo-night-dark, one-dark
      background = "aurora_borealis.png";
    };

    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };

    pkgs-stable = import nixpkgs-stable {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      kogami = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs system pkgs pkgs-stable userSettings;
        };

        modules = [
          ./kogami/configuration.nix

          inputs.stylix.nixosModules.stylix
          inputs.nix-ld.nixosModules.nix-ld
          inputs.sops-nix.nixosModules.sops
          inputs.auto-cpufreq.nixosModules.default
        ];
      };
      ginoza = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs system pkgs pkgs-stable userSettings;
        };

        modules = [
          ./ginoza/configuration.nix
          inputs.stylix.nixosModules.stylix
          inputs.sops-nix.nixosModules.sops
        ];
      };
    };
  };
}
