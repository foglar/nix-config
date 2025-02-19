{
  pkgs,
  pkgs-stable,
  ...
}: {
  # Keyboard image for keyboard switch layout
  home.file = {
    ".local/share/icons/kogami/keyboard.svg".source = ../../../../config/icons/keyboard.svg;
  };

  #services.mpd = {
  #  enable = true;
  #  musicDirectory = /home/shinya/Music;
  #};

  home.packages =
    (with pkgs; [
      hypridle
      hyprpolkitagent

      libnotify
      swayosd
      playerctl

      wl-clipboard
      cliphist
      bc

      #swww

      (writeShellScriptBin "dontkillsteam" ''
        if [[ $(hyprctl activewindow -j | ${pkgs.jq}/bin/jq -r ".class") == "Steam" ]]; then
          xdotool windowunmap $(xdotool getactivewindow)
        else
          hyprctl dispatch killactive ""
        fi
      '')

      (writeShellScriptBin "screenshot" ''
        restore_shader() {
         if [ -n "$shader" ]; then
         	${pkgs.hyprshade}/bin/hyprshade on "$shader"
         fi
        }

        # Saves the current shader and turns it off
        save_shader() {
        	shader=$(${pkgs.hyprshade}/bin/hyprshade current)
        	${pkgs.hyprshade}/bin/hyprshade off
        	trap restore_shader EXIT
        }

        save_shader

        save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')
        temp_screenshot="/tmp/screenshot.png"

        case $1 in
        p) # print all outputs
        	${pkgs.grimblast}/bin/grimblast copysave screen $temp_screenshot && restore_shader && ${pkgs.swappy}/bin/swappy -f $temp_screenshot ;;
        s) # drag to manually snip an area / click on a window to print it
        	${pkgs.grimblast}/bin/grimblast copysave area $temp_screenshot && restore_shader && ${pkgs.swappy}/bin/swappy -f $temp_screenshot ;;
        sf) # frozen screen, drag to manually snip an area / click on a window to print it
          ${pkgs.grimblast}/bin/grimblast --freeze copysave area $temp_screenshot && restore_shader && ${pkgs.swappy}/bin/swappy -f $temp_screenshot ;;
        m) # print focused monitor
        	${pkgs.grimblast}/bin/grimblast copysave output $temp_screenshot && restore_shader && ${pkgs.swappy}/bin/swappy -f $temp_screenshot ;;
        *) # invalid option
        	print_error ;;
        esac

        rm "$temp_screenshot"
      '')

      (writeShellScriptBin "keyboardswitch" ''
        hyprctl switchxkblayout all next
        layMain=$(hyprctl -j devices | ${pkgs.jq}/bin/jq '.keyboards' | ${pkgs.jq}/bin/jq '.[] | select (.main == true)' | awk -F '"' '{if ($2=="active_keymap") print $4}')
        ${libnotify}/bin/notify-send -a "t1" -r 91190 -t 800 -e "$layMain" -i ~/.local/share/icons/kogami/keyboard.svg
      '')

      (writeShellScriptBin "background-switch-random" ''
        directory=$HOME/Pictures/backgrounds/
        monitor=$(hyprctl monitors | grep Monitor | awk '{print $2}')

        if [ -d "$directory" ]; then
            # Use find to include .jpg, .png, and .jpeg files
            random_background=$(find "$directory" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

            hyprctl hyprpaper unload all
            hyprctl hyprpaper preload "$random_background"
            hyprctl hyprpaper wallpaper "$monitor, $random_background"
        fi

      '')

      (writeShellScriptBin "battery-notify" ''
        # Configuration variables (with default values)
        dock="''${BATTERY_NOTIFY_DOCK:-true}"
        batterynotify_conf="$HYDE_STATE_HOME/staterc"
        battery_critical_threshold="''${BATTERY_NOTIFY_THRESHOLD_CRITICAL:-5}"
        battery_low_threshold="''${BATTERY_NOTIFY_THRESHOLD_LOW:-20}"
        timer="''${BATTERY_NOTIFY_TIMER:-120}"
        interval="''${BATTERY_NOTIFY_INTERVAL:-5}"
        execute_critical="''${BATTERY_NOTIFY_EXECUTE_CRITICAL:-systemctl suspend}"
        execute_low="''${BATTERY_NOTIFY_EXECUTE_LOW:-}"
        verbose=false
        state_file="/tmp/battery_notify_state"

        # Display configuration info
        config_info() {
            cat <<EOF
        Modify $batterynotify_conf to set options.

        STATUS      THRESHOLD
        Critical    $battery_critical_threshold  then '$execute_critical'
        Low         $battery_low_threshold       then '$execute_low'

        Notifications at: 80%, 90%, 100% (charging only).
        EOF
        }

        # Check if system is a laptop
        is_laptop() {
            if ! grep -q "Battery" /sys/class/power_supply/BAT*/type 2>/dev/null; then
                echo "No battery detected. Exiting."
                exit 0
            fi
        }

        # Display verbose information
        fn_verbose() {
            if $verbose; then
                echo "============================================="
                echo "Battery Status: $battery_status"
                echo "Battery Percentage: $battery_percentage"
                echo "============================================="
            fi
        }

        # Handle battery notifications
        notify_user() {
            local urgency=$1
            local title=$2
            local message=$3
            notify-send -a "HyDE Power" -t 5000 -u "$urgency" "$title" "$message"
        }

        # Get battery status and percentage
        get_battery_info() {
            local total_percentage=0 battery_count=0
            for battery in /sys/class/power_supply/BAT*; do
                battery_status=$(<"$battery/status")
                battery_percentage=$(<"$battery/capacity")
                total_percentage=$((total_percentage + battery_percentage))
                battery_count=$((battery_count + 1))
            done
            battery_percentage=$((total_percentage / battery_count))
        }

        # Manage notifications for charging thresholds
        manage_charging_notifications() {
            local thresholds=(80 90 100)
            for threshold in "''${thresholds[@]}"; do
                if [[ "$battery_percentage" -ge "$threshold" && "$battery_status" == "Charging" ]]; then
                    if ! grep -q "$threshold" "$state_file" 2>/dev/null; then
                        notify_user "NORMAL" "Battery Charging" "Battery has reached $threshold%. Consider unplugging the charger."
                        echo "$threshold" >> "$state_file"
                    fi
                fi
            done
        }

        # Reset state when discharging
        reset_state_if_discharging() {
            if [[ "$battery_status" == "Discharging" ]]; then
                > "$state_file"
            fi
        }

        # Monitor battery status changes
        monitor_battery() {
            while :; do
                get_battery_info
                reset_state_if_discharging
                manage_charging_notifications
                sleep $interval
            done
        }

        # Main function
        main() {
            is_laptop
            config_info
            if $verbose; then
                echo "Verbose Mode is ON."
            fi
            monitor_battery
        }

        # Parse script arguments
        case "$1" in
            -i|--info)
                config_info
                exit 0
                ;;
            -v|--verbose)
                verbose=true
                ;;
            -h|--help|*)
                cat <<HELP
        Usage: $0 [options]

        [-i|--info]    Display configuration information
        [-v|--verbose] Enable verbose mode
        [-h|--help]    Show this help message
        HELP
                exit 0
                ;;
        esac

        main
      '')

      #(writeShellScriptBin "windowpin")
    ])
    ++ (with pkgs-stable; [
      pavucontrol
      nautilus
    ]);
}
