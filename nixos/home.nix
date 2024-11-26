{...}: {
  home.username = "foglar";
  home.homeDirectory = "/home/foglar";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  imports = [
    ./packages/packages.nix
    ./desktop/desktops.nix
  ];

  desktop.hyprland.enable = true;
  programming.enable = true;
  games.enable = true;

  gtk.enable = true;


  home.file = {
    ".config/hypr/hyprlock.conf".source = ../config/hyprlock.conf;
    ".config/hypr/mocha.conf".source = ../config/mocha.conf;
    ".config/hypr/hypridle.conf".source = ../config/hypridle.conf;
    ".config/dolphinrc".source = ../config/dolphinrc;
    ".prettierrc".text = ''
      {
        "tabWidth": 4,
        "useTabs": true
      }
    '';
  };
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
