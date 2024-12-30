{
  lib,
  config,
  pkgs,
  userSettings,
  ...
}: {
  options = {
    desktop.hyprland.wlogout.enable = lib.mkEnableOption "enable wlogout module";
  };

  config = lib.mkIf config.desktop.hyprland.wlogout.enable {
    home.file = {
      ".config/wlogout/icons/lock.png".source = ./icons/lock_white.png;
      ".config/wlogout/icons/logout.png".source = ./icons/logout_white.png;
      ".config/wlogout/icons/shutdown.png".source = ./icons/shutdown_white.png;
      ".config/wlogout/icons/reboot.png".source = ./icons/reboot_white.png;
    };

    programs.wlogout = {
      enable = true;
      layout = [
        {
          "label" = "lock";
          "action" = "hyprlock";
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
      style = let
        fntSize = "40";
        BtnCol = config.lib.stylix.colors.base01;
        Main-bg = config.lib.stylix.colors.base02;
        Wb-act-bg = config.lib.stylix.colors.base05; # base05 is light blue color
        Wb-hvr-bg = config.lib.stylix.colors.base07; # base07 is blue color

        active_rad = "40";
        y_hvr = "5";
        x_hvr = "5";
        button_rad = "20";
        y_mgn = "5";
        x_mgn = "5";
      in ''
        * {
            background-image: none;
            font-size: ${fntSize}px;
        }

        window {
            background-color: transparent;
        }

        button {
            color: #${BtnCol};
            background-color: #${Main-bg};
            outline-style: none;
            border: none;
            border-width: 0px;
            background-repeat: no-repeat;
            background-position: center;
            background-size: 10%;
            border-radius: 0px;
            box-shadow: none;
            text-shadow: none;
            animation: gradient_f 20s ease-in infinite;
        }

        button:focus {
            background-color: #${Wb-act-bg};
            background-size: 20%;
        }

        button:hover {
            background-color: #${Wb-hvr-bg};
            background-size: 25%;
            border-radius: ${active_rad}px;
            animation: gradient_f 20s ease-in infinite;
            transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
        }

        button:hover#lock {
            border-radius: ${active_rad}px ${active_rad}px 0px ${active_rad}px;
            margin : ${y_hvr}px 0px 0px ${x_hvr}px;
        }

        button:hover#logout {
            border-radius: ${active_rad}px 0px ${active_rad}px ${active_rad}px;
            margin : 0px 0px ${y_hvr}px ${x_hvr}px;
        }

        button:hover#shutdown {
            border-radius: ${active_rad}px ${active_rad}px ${active_rad}px 0px;
            margin : ${y_hvr}px ${x_hvr}px 0px 0px;
        }

        button:hover#reboot {
            border-radius: 0px ${active_rad}px ${active_rad}px ${active_rad}px;
            margin : 0px ${x_hvr}px ${y_hvr}px 0px;
        }

        #lock {
            background-image: image(url("/home/${userSettings.username}/.config/wlogout/icons/lock.png"), url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
            border-radius: ${button_rad}px 0px 0px 0px;
            margin : ${y_mgn}px 0px 0px ${x_mgn}px;
        }

        #logout {
            background-image: image(url("/home/${userSettings.username}/.config/wlogout/icons/logout.png"), url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
            border-radius: 0px 0px 0px ${button_rad}px;
            margin : 0px 0px ${y_mgn}px ${x_mgn}px;
        }

        #shutdown {
            background-image: image(url("/home/${userSettings.username}/.config/wlogout/icons/shutdown.png"), url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
            border-radius: 0px ${button_rad}px 0px 0px;
            margin : ${y_mgn}px ${x_mgn}px 0px 0px;
        }

        #reboot {
            background-image: image(url("/home/${userSettings.username}/.config/wlogout/icons/reboot.png"), url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
            border-radius: 0px 0px ${button_rad}px 0px;
            margin : 0px ${x_mgn}px ${y_mgn}px 0px;
        }
      '';
    };
  };
}
