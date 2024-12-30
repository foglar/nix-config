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

    nvidia = {
      enable = lib.mkDefault false;
      mode = lib.mkDefault "none";
      optimus = {
        offload =
          if config.sys.nvidia.mode == "offload"
          then true
          else false;
        sync =
          if config.sys.nvidia.mode == "sync"
          then true
          else false;
        reverse =
          if config.sys.nvidia.mode == "reverse"
          then true
          else false;
      };
      disable =
        if config.sys.nvidia.mode == "disable"
        then true
        else false;
    };

    printing.enable = lib.mkDefault true;
    login = {
      sddm.enable = lib.mkDefault true;
      gdm.enable = lib.mkDefault false;
    };
    style.enable = lib.mkDefault true;
    default-applications.enable = lib.mkDefault true;
  };
}
