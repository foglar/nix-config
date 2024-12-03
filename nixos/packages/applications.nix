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
