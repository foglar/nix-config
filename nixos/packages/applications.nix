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
        qbittorrent
        vlc
        openrocket
        spotify
        spotube
        inkscape
        gnome-disk-utility
      ])
      ++ (with pkgs-stable; [
        loupe
        simple-scan
        vesktop
        evince
      ]);
  };
}
