{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    wlogout.enable = lib.mkEnableOption "enable wlogout module";
  };

  config = lib.mkIf config.wlogout.enable {
    programs.wlogout = {
      enable = true;
      layout = [
        {
          "label" = "lock";
          "action" = "swaylock";
          "text" = "Lock";
          "keybind" = "l";
        }

        {
          "label" = "logout";
          "action" = "hyprctl dispatch exit 0";
          "text" = "Logout";
          "keybind" = "e";
        }

        {
          "label" = "shutdown";
          "action" = "systemctl poweroff";
          "text" = "Shutdown";
          "keybind" = "s";
        }

        {
          "label" = "reboot";
          "action" = "systemctl reboot";
          "text" = "Reboot";
          "keybind" = "r";
        }
      ];
    };

    home.packages = [
      pkgs.wlogout
    ];
  };
}
