{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    waybar.enable = lib.mkEnableOption "enable Waybar module";
  };

  config = lib.mkIf config.waybar.enable {
    home.packages = [
      pkgs.waybar
    ];

    programs.waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "bottom";
          position = "top";
          height = 31;
          exclusive = true;
          passthrough = false;
          gtk-layer-shell = true;
          reload_style_on_change = true;
          output = [
            "eDP-1"
          ];
          modules-left = ["custom/padd" "custom/l_end" "cpu" "memory" "custom/r_end" "custom/l_end" "idle_inhibitor" "clock" "custom/r_end" "" "custom/padd"];
          modules-center = ["custom/padd" "" "custom/l_end" "hyprland/workspaces" "hyprland/window" "custom/r_end" "custom/padd"];
          modules-right = ["custom/padd" "custom/l_end" "backlight" "network" "bluetooth" "pulseaudio" "pulseaudio#microphone" "custom/r_end" "custom/l_end" "tray" "battery" "custom/r_end" "custom/l_end" "custom/cliphist" "custom/power" "custom/r_end" "custom/padd"];

          "hyprland/workspaces" = {
            disable-scroll = true;
            #rotate = 1;
            all-outputs = true;
            active-only = false;
            on-click = "activate";
            on-scroll-up = "hyprctl dispatch workspace -1";
            on-scroll-down = "hyprctl dispatch workspace +1";
            persistent-workspaces = {};
          };

          "hyprland/window" = {
            format = "   {}";
            #rotate = ${r_deg};
            separate-outputs = true;
            rewrite = {
              #"${USER}@${set_sysname}:(.*)" = "$1 ";
              "(.*) — Mozilla Firefox" = "$1 󰈹";
              "(.*)Mozilla Firefox" = "Firefox 󰈹";
              "(.*) - Visual Studio Code" = "$1 󰨞";
              "(.*)Visual Studio Code" = "Code 󰨞";
              "(.*) — Dolphin" = "$1 󰉋";
              "(.*)Spotify" = "Spotify 󰓇";
              "(.*)Steam" = "Steam 󰓓";
            };
            max-length = 50;
          };

          "cpu" = {
            interval = 10;
            format = "󰍛 {usage}%";
            #rotate = ${r_deg};
            format-alt = "{icon0}{icon1}{icon2}{icon3}";
            format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          };

          "memory" = {
            states = {
              "c" = 90; # critical
              "h" = 60; # high
              "m" = 30; # medium
            };
            interval = 30;
            format = "󰾆  {used}GB";
            #rotate = ${r_deg};
            format-m = "󰾅  {used}GB";
            format-h = "󰓅  {used}GB";
            format-c = "  {used}GB";
            format-alt = "󰾆  {percentage}%";
            max-length = 10;
            tooltip = true;
            tooltip-format = "󰾆  {percentage}%\n  {used:0.1f}GB/{total:0.1f}GB";
          };

          "bluetooth" = {
            format = "";
            #rotate": ${r_deg},
            format-disabled = "";
            format-connected = " {num_connections}";
            format-connected-battery = "{icon} {num_connections}";
            # "format-connected-battery" = "{icon} {device_alias}-{device_battery_percentage}%";
            format-icons = ["󰥇" "󰤾" "󰤿" "󰥀" "󰥁" "󰥂" "󰥃" "󰥄" "󰥅" "󰥆" "󰥈"];
            #"format-device-preference": [ "device1", "device2" ], // preference list deciding the displayed device If this config option is not defined or none of the devices in the list are connected, it will fall back to showing the last connected device.
            tooltip-format = "{controller_alias}\n{num_connections} connected";
            tooltip-format-connected = "{controller_alias}\n{num_connections} connected\n\n{device_enumerate}";
            tooltip-format-enumerate-connected = "{device_alias}";
            tooltip-format-enumerate-connected-battery = "{device_alias}\t{icon} {device_battery_percentage}%";
          };

          "tray" = {
            icon-size = 18;
            rotate = 0;
            spacing = 5;
          };

          "idle_inhibitor" = {
            format = "{icon}";
            rotate = 0;
            format-icons = {
              activated = "󰥔";
              deactivated = "";
            };
          };

          "clock" = {
            format = "{:%H:%M}";
            rotate = 0;
            format-alt = "{:%R 󰃭 %d·%m·%y}";
            tooltip-format = "<span>{calendar}</span>";
            calendar = {
              mode = "month";
              mode-mon-col = 3;
              on-scroll = 1;
              on-click-right = "mode";
              format = {
                months = "<span color='#ffead3'><b>{}</b></span>";
                weekdays = "<span color='#ffcc66'><b>{}</b></span>";
                today = "<span color='#ff6699'><b>{}</b></span>";
              };
            };
            actions = {
              on-click-right = "mode";
              on-click-forward = "tz_up";
              on-click-backward = "tz_down";
              on-scroll-up = "shift_up";
              on-scroll-down = "shift_down";
            };
          };

          "battery" = {
            states = {
              good = 95;
              warning = 30;
              critical = 20;
            };
            format = "{icon} {capacity}%";
            rotate = 0;
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-alt = "{time} {icon}";
            format-icons = [
              "󰂎"
              "󰁺"
              "󰁻"
              "󰁼"
              "󰁽"
              "󰁾"
              "󰁿"
              "󰂀"
              "󰂁"
              "󰂂"
              "󰁹"
            ];
          };

          "backlight" = {
            device = "intel_backlight";
            rotate = 0;
            format = "{icon} {percent}%";
            format-icons = ["" "" "" "" "" "" "" "" ""];
            on-scroll-up = "${pkgs.swayosd}/bin/swayosd-client --brightness raise";
            on-scroll-down = "${pkgs.swayosd}/bin/swayosd-client --brightness lower";
            min-length = 6;
          };

          "network" = {
            tooltip = true;
            format-wifi = " ";
            rotate = 0;
            format-ethernet = "󰈀 ";
            tooltip-format = "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
            format-linked = "󰈀 {ifname} (No IP)";
            format-disconnected = "󰖪 ";
            tooltip-format-disconnected = "Disconnected";
            format-alt = "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
            interval = 2;
          };

          "pulseaudio" = {
            format = "{icon}  {volume}";
            rotate = 0;
            format-muted = "婢";
            on-click = "pavucontrol -t 3";
            on-click-middle = "swayosd-client --output-volume mute-toggle";
            on-scroll-up = "swayosd-client --output-volume 5";
            on-scroll-down = "swayosd-client --output-volume -5";
            tooltip-format = "{icon} {desc} // {volume}%";
            scroll-step = 5;
            format-icons = {
              headphone = " ";
              hands-free = " ";
              headset = " ";
              phone = " ";
              portable = " ";
              car = " ";
              default = ["" "" ""];
            };
          };

          "pulseaudio#microphone" = {
            format = "{format_source}";
            rotate = 0;
            format-source = "";
            format-source-muted = "";
            on-click = "pavucontrol -t 4";
            on-click-middle = "swayosd-client --input-volume mute-toggle";
            on-scroll-up = "swayosd-client --input-volume 5";
            on-scroll-down = "swayosd-client --input-volume -5";
            tooltip-format = "{format_source} {source_desc} // {source_volume}%";
            scroll-step = 5;
          };

          "custom/cliphist" = {
            format = "{}";
            rotate = 0;
            exec = "echo ; echo 󰅇 clipboard history";
            on-click = "sleep 0.1 && cliphist.sh c";
            on-click-right = "sleep 0.1 && cliphist.sh d";
            on-click-middle = "sleep 0.1 && cliphist.sh w";
            interval = 86400; # once every day;
            tooltip = true;
          };

          "custom/power" = {
            format = " {}";
            rotate = 0;
            exec = "echo ; echo  logout";
            on-click = "wlogout -b 2";
            on-click-right = "wlogout -b 2";
            interval = 86400; # once every day
            tooltip = true;
          };

          "custom/l_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/r_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/sl_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/sr_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/rl_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/rr_end" = {
            format = " ";
            interval = "once";
            tooltip = false;
          };

          "custom/padd" = {
            format = "  ";
            interval = "once";
            tooltip = false;
          };
        };
      };

      style = ''
        @define-color bar-bg rgba(0, 0, 0, 0);
        @define-color main-bg #11111b;
        @define-color main-fg #cdd6f4;
        @define-color wb-act-bg #a6adc8;
        @define-color wb-act-fg #313244;
        @define-color wb-hvr-bg #f5c2e7;
        @define-color wb-hvr-fg #313;
        * {
          border: none;
          border-radius: 0px;
          font-family: "JetBrainsMono Nerd Font";
          font-weight: bold;
          font-size: 10px;
          min-height: 10px;
          }

        window#waybar {
        	background: @bar-bg;
        }

        tooltip {
        	background: @main-bg;
        	color: @main-fg;
        	border-radius: 7px;
        	border-width: 0px;
        	}

        #workspaces button {
        	box-shadow: none;
        	text-shadow: none;
        	padding: 0px;
        	border-radius: 9px;
        	margin-top: 3px;
        	margin-bottom: 3px;
        	margin-left: 0px;
        	padding-left: 3px;
        	padding-right: 3px;
        	margin-right: 0px;
        	color: @main-fg;
        	animation: ws_normal 20s ease-in-out 1;
        	}

        #workspaces button.active {
        	background: @wb-act-bg;
        	color: @wb-act-fg;
        	margin-left: 3px;
        	padding-left: 12px;
        	padding-right: 12px;
        	margin-right: 3px;
        	animation: ws_active 20s ease-in-out 1;
        	transition: all 0.4s cubic-bezier(.55,-0.68,.48,1.682);
        	}

        #workspaces button:hover {
        	background: @wb-hvr-bg;
        	color: @wb-hvr-fg;
        	animation: ws_hover 20s ease-in-out 1;
        	transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
        	}
        #taskbar button {
        	box-shadow: none;
        	  text-shadow: none;
        	padding: 0px;
        	border-radius: 9px;
        	margin-top: 3px;
        	margin-bottom: 3px;
        	margin-left: 0px;
        	padding-left: 3px;
        	padding-right: 3px;
        	margin-right: 0px;
        	color: @wb-color;
        	animation: tb_normal 20s ease-in-out 1;
        	}
        #taskbar button.active {
        	background: @wb-act-bg;
        	color: @wb-act-color;
        	margin-left: 3px;
        	padding-left: 12px;
        	padding-right: 12px;
        	margin-right: 3px;
        	animation: tb_active 20s ease-in-out 1;
        	transition: all 0.4s cubic-bezier(.55,-0.68,.48,1.682);
        	}
        #taskbar button:hover {
        	background: @wb-hvr-bg;
        	color: @wb-hvr-color;
        	animation: tb_hover 20s ease-in-out 1;
        	transition: all 0.3s cubic-bezier(.55,-0.68,.48,1.682);
        	}
        #tray menu * {
        	min-height: 16px;
        	}
        #tray menu separator {
        	min-height: 10px;
        	}
        #backlight,
        #battery,
        #bluetooth,
        #custom-cliphist,
        #clock,
        #custom-cpuinfo,
        #cpu,
        #custom-gpuinfo,
        #idle_inhibitor,
        #custom-keybindhint,
        #language,
        #memory,
        #mpris,
        #network,
        #custom-notifications,
        #custom-power,
        #pulseaudio,
        #custom-spotify,
        #taskbar,
        #custom-theme,
        #tray,
        #custom-updates,
        #custom-wallchange,
        #custom-wbar,
        #window,
        #workspaces,
        #custom-l_end,
        #custom-r_end,
        #custom-sl_end,
        #custom-sr_end,
        #custom-rl_end,
        #custom-rr_end {
        	color: @main-fg;
        	background: @main-bg;
        	opacity: 1;
        	margin: 4px 0px 4px 0px;
        	padding-left: 4px;
        	padding-right: 4px;
        	}
        #workspaces,
        #taskbar {
        	padding: 0px;
        	}
        #custom-r_end {
        	border-radius: 0px 21px 21px 0px;
        	margin-right: 9px;
        	padding-right: 3px;
        	}
        #custom-l_end {
        	border-radius: 21px 0px 0px 21px;
        	margin-left: 9px;
        	padding-left: 3px;
        	}

        #custom-sr_end {
        	border-radius: 0px;
        	margin-right: 9px;
        	padding-right: 3px;
        	}
        #custom-sl_end {
        	border-radius: 0px;
        	margin-left: 9px;
        	padding-left: 3px;
        	}
        #custom-rr_end {
        	border-radius: 0px 7px 7px 0px;
        	margin-right: 9px;
        	padding-right: 3px;
        	}
        #custom-rl_end {
        	border-radius: 7px 0px 0px 7px;
        	margin-left: 9px;
        	padding-left: 3px;
        }
      '';
    };
  };
}
