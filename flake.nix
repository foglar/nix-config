{
  description = "My highly sofisticated and complicated flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";

    nix-ld.url = "github:Mic92/nix-ld";
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };

    #hyprland-plugins = {
    #  url = "github:hyprwm/hyprland-plugins";
    #  inputs.hyprland.follows = "hyprland";
    #};

    #Hyprspace = {
    #  url = "github:KZDKM/Hyprspace";
    #  # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
    #  inputs.hyprland.follows = "hyprland";
    #};

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

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
    username = "foglar";
    hostname = "laptop";

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
          inherit inputs system pkgs pkgs-stable username hostname;
        };

        modules = [
          ./nixos/configuration.nix
          inputs.stylix.nixosModules.stylix
          inputs.nix-ld.nixosModules.nix-ld
        ];
      };
    };
  };
}
