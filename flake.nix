{
  description = "My highly sofisticated and complicated flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
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
      username = "foglar";
      hostname = "laptop";

      shell = "bash"; # bash, zsh
      terminal = "kitty";

      theme = "catppuccin-mocha";
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
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs pkgs-stable userSettings;
        };

        modules = [
          ./zenith/configuration.nix

          inputs.stylix.nixosModules.stylix
          inputs.nix-ld.nixosModules.nix-ld
        ];
      };
      leanix = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs system pkgs pkgs-stable userSettings;
        };

        modules = [
          ./leanix/configuration.nix
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
  };
}
