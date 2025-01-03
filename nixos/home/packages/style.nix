{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    style.enable = lib.mkEnableOption "style";
  };

  config = lib.mkIf config.style.enable {
    stylix.iconTheme = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
    };

    stylix.targets = {
      bat.enable = lib.mkDefault true;
      btop.enable = lib.mkDefault true;
      fzf.enable = lib.mkDefault true;

      tmux.enable =
        if config.program.tmux.enable
        then lib.mkDefault true
        else lib.mkDefault false;
      dunst.enable =
        if config.desktop.hyprland.enable
        then lib.mkDefault true
        else lib.mkDefault false;

      kde.enable = true;
      gtk.enable = true;

      waybar = {
        enable = true;
        enableCenterBackColors = false;
        enableLeftBackColors = false;
        enableRightBackColors = false;
      };
    };
  };
}
