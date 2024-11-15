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
        #tor-browser
        openrocket
        spotify
        spotube
        inkscape
      ])
      ++ (with pkgs-stable; [
        loupe
        simple-scan
        vesktop
      ]);
  };
}
