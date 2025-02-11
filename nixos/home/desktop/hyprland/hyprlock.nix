{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    desktop.hyprland.hyprlock.enable = lib.mkEnableOption "Enable hyprlock";
  };

  config = lib.mkIf config.desktop.hyprland.hyprlock.enable {
    home.packages = with pkgs; [
      (writeShellScriptBin "battery-hyprlock"
        ''
          # Get the current battery percentage
          battery_percentage=$(${pkgs.toybox}/bin/cat /sys/class/power_supply/BAT1/capacity)

          # Get the battery status (Charging or Discharging)
          battery_status=$(${pkgs.toybox}/bin/cat /sys/class/power_supply/BAT1/status)

          # Define the battery icons for each 10% segment
          battery_icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")

          # Define the charging icon
          charging_icon="󰂄"

          # Calculate the index for the icon array
          # Ensure the index is within bounds (0 to 9) for battery percentages 0 to 100
          icon_index=$((battery_percentage / 10))

          # If the battery is 100%, use the last icon (index 9)
          if [ "$battery_percentage" -eq 100 ]; then
              icon_index=9
          fi

          # Get the corresponding icon
          battery_icon=''${battery_icons[$icon_index]}

          # Check if the battery is charging
          if [ "$battery_status" = "Charging" ]; then
              battery_icon="$charging_icon"
          fi

          # Output the battery percentage and icon
          echo "$battery_percentage% $battery_icon"
        '')

      (writeShellScriptBin "playerctl-hyprlock"
        ''
          if [ $# -eq 0 ]; then
          	echo "Usage: $0 --title | --artist | --album | --source | --source-symbol"
          	exit 1
          fi

          # Function to get metadata using playerctl
          get_metadata() {
          	key=$1
          	playerctl metadata --player=%any,chromium,firefox --format "{{ $key }}" 2>/dev/null
          }

          # Check for arguments

          # Function to determine the source and return an icon and text
          get_source_info_symbol() {
          	trackid=$(get_metadata "mpris:trackid")
          	if [[ "$trackid" == *"firefox"* ]]; then
          		echo -e "󰈹"
          	elif [[ "$trackid" == *"spotify"* ]]; then
          		echo -e ""
          	elif [[ "$trackid" == *"chromium"* ]]; then
          		echo -e ""
          	else
          		echo ""
          	fi
          }

          get_source_info() {
          	trackid=$(get_metadata "mpris:trackid")
          	if [[ "$trackid" == *"firefox"* ]]; then
          		echo -e "Firefox"
          	elif [[ "$trackid" == *"spotify"* ]]; then
          		echo -e "Spotify"
          	elif [[ "$trackid" == *"chromium"* ]]; then
          		echo -e "Chrome"
          	else
          		echo ""
          	fi
          }

          # Function to truncate text with ellipsis if necessary
          truncate_with_ellipsis() {
          	text=$1
          	max_length=$2
          	if [ ''${#text} -gt $max_length ]; then
          		echo "''${text:0:$((max_length - 3))}..."
          	else
          		echo "$text"
          	fi
          }

          # Parse the argument
          case "$1" in
          --title)
          	title=$(get_metadata "xesam:title")
          	if [ -z "$title" ]; then
          		echo ""
          	else
          		truncate_with_ellipsis "$title" 28 # Limit the output to 50 characters
          	fi
          	;;
          --artist)
          	artist=$(get_metadata "xesam:artist")
          	if [ -z "$artist" ]; then
          		echo ""
          	else
          		truncate_with_ellipsis "$artist" 28 # Limit the output to 50 characters
          	fi
          	;;
          --status-symbol)
          	status=$(playerctl status 2>/dev/null)
          	if [[ $status == "Playing" ]]; then
          		echo "󰎆"
          	elif [[ $status == "Paused" ]]; then
          		echo "󰏥"
          	else
          		echo ""
          	fi
          	;;
          --status)
          	status=$(playerctl status 2>/dev/null)
          	if [[ $status == "Playing" ]]; then
          		echo "Playing Now"
          	elif [[ $status == "Paused" ]]; then
          		echo "Paused"
          	else
          		echo ""
          	fi
          	;;
          --album)
          	album=$(playerctl metadata --player=%any,chromium,firefox --format "{{ xesam:album }}" 2>/dev/null)
          	if [[ -n $album ]]; then
          		echo "$album"
          	else
          		status=$(playerctl status 2>/dev/null)
          		if [[ -n $status ]]; then
          			echo "Not album"
          		else
          			truncate_with_ellipsis "$album" 28 # Limit the output to 50 characters
          		fi
          	fi
          	;;
          --source-symbol)
          	get_source_info_symbol
          	;;
          --source)
          	get_source_info
          	;;
          *)
          	echo "Invalid option: $1"
          	echo "Usage: $0 --title | --artist | --album | --source | --source-symbol"
          	exit 1
          	;;
          esac'')
    ];

    programs.hyprlock = {
      enable = true;

      settings = {
        general = {
          disable_loading_bar = true;
          hide_cursor = true;
        };

        background = {
          monitor = "";
          # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
          blur_passes = 0; # 0 disables blurring
          blur_size = 3;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        };

        image = {
          monitor = "";
          #path = ~/.face.icon
          size = 100;
          border_color = "$accent";

          position = "0, 75";
          halign = "center";
          valign = "center";
        };

        input-field = {
          monitor = "";
          size = "200, 50";
          outline_thickness = 0;
          dots_size = 0.33; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.15; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = false;
          dots_rounding = -1; # -1 default circle, -2 follow input-field rounding
          #outer_color = "$accent";
          #inner_color = "$surface0";
          #font_color = "$text";
          fade_on_empty = true;
          fade_timeout = 1000; # Milliseconds before fade_on_empty is triggered.
          #placeholder_text =  '\'<span foreground="##cad3f5">Password...</span>'\';
          hide_input = false;
          rounding = -1; # -1 means complete rounding (circle/oval)
          #check_color = "$accent";
          #fail_color = "$red"; # if authentication failed, changes outer_color and fail message color
          fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>"; # can be set to empty
          fail_transition = 300; # transition time in ms between normal outer_color and fail_color
          #capslock_color = "$yellow";
          numlock_color = -1;
          bothlock_color = -1; # when both locks are active. -1 means don't change outer color (same for above)
          invert_numlock = false; # change color if numlock is off
          swap_font_color = false; # see below

          position = "0, -20";
          halign = "center";
          valign = "center";
        };

        label = [
          {
            monitor = "";
            text = "$TIME";
            color = "$text";
            font_size = 40;
            #font_family = "Monaspace Xenon";

            position = "0, 80";
            halign = "center";
            valign = "center";
          }
          # Battery percentage
          {
            monitor = "";
            text = "cmd[update:1000] echo $(battery-hyprlock)";

            color = "$accent";
            font_size = 12;

            position = "-37, 29";
            halign = "right";
            valign = "bottom";
            zindex = 5;
          }
          {
            monitor = "";
            text = "$LAYOUT[en, cz, ru]  ‎"; # This is blank space to show full emoji

            color = "$accent";
            font_size = 12;

            position = "-127, 29";
            halign = "right";
            valign = "bottom";
            zindex = 5;
          }
          {
            # PLAYER TITLE
            monitor = "";
            text = "cmd[update:1000] echo $(playerctl-hyprlock --title)";

            color = "$fg0";
            font_size = 14;
            font_family = "$font-text";

            position = "37, 49";
            halign = "left";
            valign = "bottom";
            zindex = 5;
          }

          # PLAYER ARTIST
          {
            monitor = "";
            text = "cmd[update:1000] echo $(playerctl-hyprlock --artist)";

            color = "$fg0";
            font_size = 11;
            font_family = "$font-text";

            position = "37, 29";
            halign = "left";
            valign = "bottom";
            zindex = 5;
          }

          # PLAYER STATUS SYMBOL
          {
            monitor = "";
            text = "cmd[update:1000] echo (playerctl-hyprlock --status-symbol)";

            color = "$fg0";
            font_size = 16;
            font_family = "$font-symbol";

            position = "700, -370";
            halign = "left";
            valign = "center";
            zindex = 5;
          }

          # PLAYER ALBUM
          #{
          #  monitor = "";
          #  text = "cmd[update:1000] echo $(playerctl-hyprlock --album)";
          #
          #  color = "$fg0";
          #  font_size = 11;
          #  font_family = "$font-text0";
          #
          #  position = "0, -445";
          #  halign = "center";
          #  valign = "center";
          #  zindex = 5;
          #}

          # PLAYER STATUS
          #{
          #  monitor = "";
          #  text = "cmd[update:1000] echo $(playerctl-hyprlock --status)";
          #
          #  color = "$fg0";
          #  font_size = 10;
          #  font_family = "$font-text";
          #
          #  position = "720, -370";
          #  halign = "left";
          #  valign = "center";
          #  zindex = 5;
          #}

          # PLAYER SOURCE SYMBOL
          #{
          #  monitor = "";
          #  text = "cmd[update:1000] echo $(playerctl-hyprlock --source-symbol)";
          #
          #  color = "rgba(255, 255, 255, 0.6)";
          #  font_size = 16;
          #  font_family = "$font-symbol";
          #
          #  position = "-720, -370";
          #  halign = "right";
          #  valign = "center";
          #  zindex = 5;
          #}

          # PLAYER SOURCE
          #{
          #  monitor = "";
          #  text = "cmd[update:1000] echo $(playerctl-hyprlock --source)";
          #
          #  color = "rgba(255, 255, 255, 0.6)";
          #  font_size = 10;
          #  font_family = "$font-text";
          #
          #  position = "-740, -370";
          #  halign = "right";
          #  valign = "center";
          #  zindex = 5;
          #}
        ];

        shape = [
          #{
          #  monitor = "";
          #  size = "90, 40";
          #
          #  shadow_passes = "$text-shadow-pass";
          #  shadow_boost = "$text-shadow-boost";
          #
          #  color = "${config.lib.stylix.color.}";
          #  rounding = "";
          #  border_size = "";
          #  border_color = "";
          #
          #  position = "-20, 20";
          #  halign = "right";
          #  valign = "bottom";
          #  zindex = 1;
          #}
        ];
      };
    };
  };
}
