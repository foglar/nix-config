{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  options = {
    sys.desktop.plasma.enable = lib.mkEnableOption "Plasma Desktop";
    sys.desktop.gnome.enable = lib.mkEnableOption "GNOME Desktop";
    sys.desktop.hyprland.enable = lib.mkEnableOption "Hyprland Desktop";
  };

  config = lib.mkMerge [
    (lib.mkIf config.sys.desktop.plasma.enable {
      services.desktopManager.plasma6.enable = true;

      environment.plasma6.excludePackages = with pkgs.kdePackages; [
        ark
        plasma-browser-integration
        konsole
        oxygen
        gwenview
        okular
        elisa
        kate
        krdp
        khelpcenter
      ];
    })

    (lib.mkIf config.sys.desktop.gnome.enable {
      services.xserver.desktopManager.gnome.enable = true;

      environment.gnome.excludePackages = with pkgs; [
        gnome-tour
        gnome-connections
        epiphany # web browser
        geary # email reader. Up to 24.05. Starting from 24.11 the package name is just geary.
        #evince # document viewer
        gnome-weather
        gnome-contacts
        gnome-maps
        gnome-logs
        gnome-music
        gnome-system-monitor
        gnome-text-editor
        yelp
        totem
        snapshot
        seahorse
      ];
    })

    (lib.mkIf config.sys.desktop.hyprland.enable {
      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs.hyprland.packages."${pkgs.system}".hyprland;
        portalPackage = pkgs.xdg-desktop-portal-hyprland;
      };
    })
  ];
}
