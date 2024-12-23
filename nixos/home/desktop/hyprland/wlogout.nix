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
      style = 
      let
        fntSize = "40";
        BtnCol = config.lib.stylix.colors.base01;
        active_rad = "40";
        y_hvr = "5";
        x_hvr = "5";
        button_rad = "20";
        y_mgn = "5";
        x_mgn = "5";
      in ''
        @define-color bar-bg rgba(0, 0, 0, 0);

        @define-color main-bg #11111b;
        @define-color main-fg #cdd6f4;

        @define-color wb-act-bg #a6adc8;
        @define-color wb-act-fg #313244;

        @define-color wb-hvr-bg #f5c2e7;
        @define-color wb-hvr-fg #313244;
        * {
            background-image: none;
            font-size: ${fntSize}px;
        }

        window {
            background-color: transparent;
        }

        button {
            color: #${BtnCol};
            background-color: @main-bg;
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
            background-color: @wb-act-bg;
            background-size: 20%;
        }

        button:hover {
            background-color: @wb-hvr-bg;
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
            border-radius: ${button_rad}px 0px 0px 0px;
            margin : ${y_mgn}px 0px 0px ${x_mgn}px;
        }

        #logout {
            border-radius: 0px 0px 0px ${button_rad}px;
            margin : 0px 0px ${y_mgn}px ${x_mgn}px;
        }

        #shutdown {
            border-radius: 0px ${button_rad}px 0px 0px;
            margin : ${y_mgn}px ${x_mgn}px 0px 0px;
        }

        #reboot {
            border-radius: 0px 0px ${button_rad}px 0px;
            margin : 0px ${x_mgn}px ${y_mgn}px 0px;
        }
      '';
    };

    home.packages = [
      pkgs.wlogout
    ];
  };
}
