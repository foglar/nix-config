{
  lib,
  pkgs,
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
    home.packages = with pkgs; [
      librewolf
      vesktop
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
    ];
  };
}
