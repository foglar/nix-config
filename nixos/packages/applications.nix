{
  lib,
  pkgs,
  pkgs-stable,
  config,
  ...
}: {
  options = {
    group.applications.enable = lib.mkEnableOption "Enable graphical applications";
  };

  config = lib.mkIf config.group.applications.enable {
    home.packages =
      (with pkgs; [
        librewolf
        ferdium

        stellarium
        libreoffice
        localsend
        plasma5Packages.kdeconnect-kde
        vlc
        openrocket
        spotify
        spotube
        inkscape
        gnome-disk-utility
        qbittorrent

        (writeShellScriptBin "nvidia-offload" ''
          export __NV_PRIME_RENDER_OFFLOAD=1
          export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
          export __GLX_VENDOR_LIBRARY_NAME=nvidia
          export __VK_LAYER_NV_optimus=NVIDIA_only
          exec "$@"
        '')
      ])
      ++ (with pkgs-stable; [
        loupe
        simple-scan
        vesktop
        gnome.gnome-font-viewer
        evince
      ]);
  };
}
