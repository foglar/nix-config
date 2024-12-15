{lib, ...}:
{
  imports = [
    ./hyprland/hyprland.nix
    ./kde/kde.nix
    ./gnome/gnome.nix
  ];

  desktop = {
    gnome.enable = lib.mkDefault false;
    kde.enable = lib.mkDefault false;
    hyprland.enable = lib.mkDefault true;
  };
}