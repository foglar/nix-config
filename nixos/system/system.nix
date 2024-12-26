{
  lib,
  config,
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
      plasma.enable = lib.mkDefault true;
      gnome.enable = lib.mkDefault false;
      hyprland.enable = lib.mkDefault true;
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
      else false;
    nvidiaRTX.disable =
      if config.sys.nvidia.enable == true
      then lib.mkDefault false
      else true;

    printing.enable = lib.mkDefault true;
    login = {
      sddm.enable = lib.mkDefault true;
      gdm.enable = lib.mkDefault false;
    };
    style.enable = lib.mkDefault true;
    default-applications.enable = lib.mkDefault true;
  };
}
