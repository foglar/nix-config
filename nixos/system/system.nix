{lib, ...}: {
  imports = [
    ./sys/audio.nix
    ./sys/desktops.nix
    ./sys/fonts.nix
    ./sys/locales.nix
    ./sys/network.nix
    ./sys/nvidia.nix
    ./sys/printing.nix
    ./sys/sddm.nix
    ./sys/style.nix
  ];

  sys.audio.enable = lib.mkDefault true;
  sys.desktop.plasma.enable = lib.mkDefault true;
  sys.desktop.gnome.enable = lib.mkDefault false;
  sys.desktop.hyprland.enable = lib.mkDefault true;
  sys.fonts.packages = lib.mkDefault true;
  sys.locales.enable = lib.mkDefault true;
  sys.network.enable = lib.mkDefault true;
  sys.bluetooth.enable = lib.mkDefault true;
  sys.nvidia.enable = lib.mkDefault true;
  sys.printing.enable = lib.mkDefault true;
  sys.sddm.enable = lib.mkDefault true;
  sys.style.enable = lib.mkDefault true;

}
