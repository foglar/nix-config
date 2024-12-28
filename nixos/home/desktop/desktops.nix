{
  lib,
  userSettings,
  ...
}: {
  imports = [
    ./hyprland/hyprland.nix
    ./kde/kde.nix
    ./gnome/gnome.nix
  ];

  desktop = {
    gnome.enable =
      if userSettings.gnome
      then lib.mkDefault true
      else lib.mkDefault false;
    kde.enable =
      if userSettings.plasma
      then lib.mkDefault true
      else lib.mkDefault false;
    hyprland.enable =
      if userSettings.hyprland
      then lib.mkDefault true
      else lib.mkDefault false;
  };
}
