{
  inputs,
  pkgs,
  ...
}:
{
  services.desktopManager.plasma6.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  
  #environment.gnome.excludePackages = with pkgs; [
  #  gnome-tour
  #  gnome-connections
  #  epiphany # web browser
  #  geary # email reader. Up to 24.05. Starting from 24.11 the package name is just geary.
  #  #evince # document viewer
  #  gnome-weather
  #  gnome-contacts
  #  gnome-maps
  #  gnome-logs
  #  gnome-music
  #  gnome-system-monitor
  #  gnome-text-editor
  #  yelp
  #  totem
  #  snapshot
  #  seahorse
  #];

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

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
}