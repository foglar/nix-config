{
  lib,
  config,
  userSettings,
  ...
}: {
  imports = [
    ./settings/audio.nix
    ./settings/desktops.nix
    ./settings/fonts.nix
    ./settings/locales.nix
    ./settings/network.nix
    ./settings/nvidia.nix
    ./settings/printing.nix
    ./settings/loginManager.nix
    ./settings/style.nix
    ./settings/default-applications.nix

    ./settings/user.nix
  ];

  sys = {
    audio.enable = lib.mkDefault true;
    desktop = {
      plasma.enable =
        if userSettings.plasma == true
        then lib.mkDefault true
        else lib.mkDefault false;
      gnome.enable =
        if userSettings.gnome == true
        then lib.mkDefault true
        else lib.mkDefault false;
      hyprland.enable =
        if userSettings.hyprland == true
        then lib.mkDefault true
        else lib.mkDefault false;
    };
    fonts.packages = lib.mkDefault true;
    locales.enable = lib.mkDefault true;
    network.enable = lib.mkDefault true;
    bluetooth = {
      enable = lib.mkDefault true;
      blueman.enable = lib.mkDefault true;
    };
    nvidia.enable = lib.mkDefault false;

    nvidiaRTX.enable =
      if config.sys.nvidia.enable == true
      then lib.mkDefault true
      else lib.mkDefault false;
    nvidiaRTX.disable =
      if config.sys.nvidia.enable == true
      then lib.mkDefault false
      else lib.mkDefault true;

    printing.enable = lib.mkDefault true;
    login = {
      sddm.enable = lib.mkDefault true;
      gdm.enable = lib.mkDefault false;
    };
    style.enable = lib.mkDefault true;
    default-applications.enable = lib.mkDefault true;
  };
}
