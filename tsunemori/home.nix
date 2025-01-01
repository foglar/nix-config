{...}: {
  home.stateVersion = "24.05";

  imports = [
    ../nixos/home/packages/droid-packages.nix
  ];

  programs.home-manager.enable = true;
}
