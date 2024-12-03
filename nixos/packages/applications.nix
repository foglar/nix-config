{
  lib,
  pkgs,
  pkgs-stable,
  config,
  ...
}: {
  options = {
    applications.enable = lib.mkEnableOption "enable Graphical applications";
  };

  imports = [
    ./applications/firefox.nix
  ];

  config = lib.mkIf config.applications.enable {
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
