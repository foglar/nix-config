{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    desktop.hyprland.rofi.clipboard.enable = lib.mkEnableOption "rofi-clipboard";
  };

  config = lib.mkIf config.desktop.hyprland.rofi.clipboard.enable {
    home.file = {
      ".config/rofi/cliboard.rasi".text = let
        main-bg = config.lib.stylix.colors.base01;
        main-fg = config.lib.stylix.colors.base02;
        main-br = config.lib.stylix.colors.base05;
        main-ex = config.lib.stylix.colors.base09;
        select-bg = config.lib.stylix.colors.base05; # Selected background color    
        select-fg = config.lib.stylix.colors.base11; # Selected text color
        separatorcolor = "transparent";
        border-color = "transparent";
      in ''
              // Config //
        configuration {
            modi:                        "drun";
            show-icons:                  false;
        }

        * {
           main-bg : #${main-bg};
           main-fg : #${main-fg};
           main-br : #${main-br};
           main-ex : #${main-ex};
           select-bg : #${select-bg};
           select-fg : #${select-fg};
           separatorcolor : ${separatorcolor};
           border-color : ${border-color};
         }

        // Main //
        window {
            width:                       23em;
            height:                      30em;
            transparency:                "real";
            fullscreen:                  false;
            enabled:                     true;
            cursor:                      "default";
            spacing:                     0em;
            padding:                     0em;
            border-color:                @main-br;
            background-color:            @main-bg;
        }
        mainbox {
            enabled:                     true;
            spacing:                     0em;
            padding:                     0.5em;
            orientation:                 vertical;
            children:                    [ "wallbox" , "listbox" ];
            background-color:            transparent;
        }
        wallbox {
            spacing:                     0em;
            padding:                     0em;
            expand:                      false;
            orientation:                 horizontal;
            background-color:            transparent;
            background-image:            url("~/.dotfiles/config/backgrounds/aurora_borealis.png", width);
            children:                    [ "wallframe" , "inputbar" ];
        }
        wallframe {
            width:                       5em;
            spacing:                     0em;
            padding:                     0em;
            expand:                      false;
            background-color:            @main-bg;
            background-image:            url("~/.dotfiles/config/backgrounds/aurora_borealis.png", height);
        }


        // Inputs //
        inputbar {
            enabled:                     true;
            padding:                     0em;
            children:                    [ "entry" ];
            background-color:            @main-bg;
            expand:                      true;
        }
        entry {
            enabled:                     true;
            padding:                     1.8em;
            text-color:                  @main-fg;
            background-color:            transparent;
        }


        // Lists //
        listbox {
            spacing:                     0em;
            padding:                     0em;
            orientation:                 vertical;
            children:                    [ "dummy" , "listview" , "dummy" ];
            background-color:            transparent;
        }
        listview {
            enabled:                     true;
            padding:                     0.5em;
            columns:                     1;
            lines:                       11;
            cycle:                       true;
            fixed-height:                true;
            fixed-columns:               false;
            expand:                      false;
            cursor:                      "default";
            background-color:            transparent;
            text-color:                  @main-fg;
        }
        dummy {
            spacing:                     0em;
            padding:                     0em;
            background-color:            transparent;
        }


        // Elements //
        element {
            enabled:                     true;
            padding:                     0.5em;
            cursor:                      pointer;
            background-color:            transparent;
            text-color:                  @main-fg;
        }
        element selected.normal {
            background-color:            @select-bg;
            text-color:                  @select-fg;
        }
        element-text {
            vertical-align:              0.0;
            horizontal-align:            0.0;
            cursor:                      inherit;
            background-color:            transparent;
            text-color:                  inherit;
        }
      '';
    };

    home.packages = with pkgs; [
      wl-clipboard
      cliphist
      (writeShellScriptBin "clipboard" ''
        export confDir="''${XDG_CONFIG_HOME:-$HOME/.config}"
        roconf="''${confDir}/rofi/cliboard.rasi"
        favoritesFile="''${HOME}/.cliphist_favorites"

        if printenv HYPRLAND_INSTANCE_SIGNATURE &> /dev/null; then
            export hypr_border="$(hyprctl -j getoption decoration:rounding | jq '.int')"
            export hypr_width="$(hyprctl -j getoption general:border_size | jq '.int')"
        fi

        # Set rofi scaling
        [[ "''${rofiScale}" =~ ^[0-9]+$ ]] || rofiScale=10
        r_scale="configuration {font: \"JetBrainsMono Nerd Font ''${rofiScale}\";}"
        wind_border=$((hypr_border * 3 / 2))
        elem_border=$([ $hypr_border -eq 0 ] && echo "5" || echo $hypr_border)

        # Evaluate spawn position
        readarray -t curPos < <(hyprctl cursorpos -j | jq -r '.x,.y')
        readarray -t monRes < <(hyprctl -j monitors | jq '.[] | select(.focused==true) | .width,.height,.scale,.x,.y')
        readarray -t offRes < <(hyprctl -j monitors | jq -r '.[] | select(.focused==true).reserved | map(tostring) | join("\n")')
        monRes[2]="$(echo "''${monRes[2]}" | sed "s/\.//")"
        monRes[0]="$(( ''${monRes[0]} * 100 / ''${monRes[2]} ))"
        monRes[1]="$(( ''${monRes[1]} * 100 / ''${monRes[2]} ))"
        curPos[0]="$(( ''${curPos[0]} - ''${monRes[3]} ))"
        curPos[1]="$(( ''${curPos[1]} - ''${monRes[4]} ))"

        if [ "''${curPos[0]}" -ge "$((monRes[0] / 2))" ] ; then
            x_pos="east"
            x_off="-$((monRes[0] - curPos[0] - offRes[2]))"
        else
            x_pos="west"
            x_off="$((curPos[0] - offRes[0]))"
        fi

        if [ "''${curPos[1]}" -ge "$((monRes[1] / 2))" ] ; then
            y_pos="south"
            y_off="-$((monRes[1] - curPos[1] - offRes[3]))"
        else
            y_pos="north"
            y_off="$((curPos[1] - offRes[1]))"
        fi

        r_override="window{location:''${x_pos} ''${y_pos};anchor:''${x_pos} ''${y_pos};x-offset:''${x_off}px;y-offset:''${y_off}px;border:''${hypr_width}px;border-radius:''${wind_border}px;} wallbox{border-radius:''${elem_border}px;} element{border-radius:''${elem_border}px;}"

        # Show main menu if no arguments are passed
        if [ $# -eq 0 ]; then
            main_action=$(echo -e "History\nDelete\nView Favorites\nManage Favorites\nClear History" | rofi -dmenu -theme-str "entry { placeholder: \"Choose action\";}" -theme-str "''${r_scale}" -theme-str "''${r_override}" -config "''${roconf}")
        else
            main_action="History"
        fi

        case "''${main_action}" in
        "History")
            selected_item=$(cliphist list | rofi -dmenu -theme-str "entry { placeholder: \"History...\";}" -theme-str "''${r_scale}" -theme-str "''${r_override}" -config "''${roconf}")
            if [ -n "$selected_item" ]; then
                echo "$selected_item" | cliphist decode | wl-copy
                notify-send "Copied to clipboard."
            fi
            ;;
        "Delete")
            selected_item=$(cliphist list | rofi -dmenu -theme-str "entry { placeholder: \"Delete...\";}" -theme-str "''${r_scale}" -theme-str "''${r_override}" -config "''${roconf}")
            if [ -n "$selected_item" ]; then
                echo "$selected_item" | cliphist delete
                notify-send "Deleted."
            fi
            ;;
        "View Favorites")
            if [ -f "$favoritesFile" ] && [ -s "$favoritesFile" ]; then
                mapfile -t favorites < "$favoritesFile"
                decoded_lines=()
                for favorite in "''${favorites[@]}"; do
                    decoded_favorite=$(echo "$favorite" | base64 --decode)
                    single_line_favorite=$(echo "$decoded_favorite" | tr '\n' ' ')
                    decoded_lines+=("$single_line_favorite")
                done
                selected_favorite=$(printf "%s\n" "''${decoded_lines[@]}" | rofi -dmenu -theme-str "entry { placeholder: \"View Favorites\";}" -theme-str "''${r_scale}" -theme-str "''${r_override}" -config "''${roconf}")
                if [ -n "$selected_favorite" ]; then
                    index=$(printf "%s\n" "''${decoded_lines[@]}" | grep -nxF "$selected_favorite" | cut -d: -f1)
                    if [ -n "$index" ]; then
                        selected_encoded_favorite="''${favorites[$((index - 1))]}"
                        echo "$selected_encoded_favorite" | base64 --decode | wl-copy
                        notify-send "Copied to clipboard."
                    else
                        notify-send "Error: Selected favorite not found."
                    fi
                fi
            else
                notify-send "No favorites."
            fi
            ;;
        "Manage Favorites")
            manage_action=$(echo -e "Add to Favorites\nDelete from Favorites\nClear All Favorites" | rofi -dmenu -theme-str "entry { placeholder: \"Manage Favorites\";}" -theme-str "''${r_scale}" -theme-str "''${r_override}" -config "''${roconf}")

            case "''${manage_action}" in
            "Add to Favorites")
                item=$(cliphist list | rofi -dmenu -theme-str "entry { placeholder: \"Add to Favorites...\";}" -theme-str "''${r_scale}" -theme-str "''${r_override}" -config "''${roconf}")
                if [ -n "$item" ]; then
                    full_item=$(echo "$item" | cliphist decode)
                    encoded_item=$(echo "$full_item" | base64 -w 0)
                    if grep -Fxq "$encoded_item" "$favoritesFile"; then
                        notify-send "Item is already in favorites."
                    else
                        echo "$encoded_item" >> "$favoritesFile"
                        notify-send "Added in favorites."
                    fi
                fi
                ;;
            "Delete from Favorites")
                if [ -f "$favoritesFile" ] && [ -s "$favoritesFile" ]; then
                    mapfile -t favorites < "$favoritesFile"
                    decoded_lines=()
                    for favorite in "''${favorites[@]}"; do
                        decoded_favorite=$(echo "$favorite" | base64 --decode)
                        single_line_favorite=$(echo "$decoded_favorite" | tr '\n' ' ')
                        decoded_lines+=("$single_line_favorite")
                    done
                    selected_favorite=$(printf "%s\n" "''${decoded_lines[@]}" | rofi -dmenu -theme-str "entry { placeholder: \"Remove from Favorites...\";}" -theme-str "''${r_scale}" -theme-str "''${r_override}" -config "''${roconf}")
                    if [ -n "$selected_favorite" ]; then
                        index=$(printf "%s\n" "''${decoded_lines[@]}" | grep -nxF "$selected_favorite" | cut -d: -f1)
                        if [ -n "$index" ]; then
                            selected_encoded_favorite="''${favorites[$((index - 1))]}"
                            if [ "$(wc -l < "$favoritesFile")" -eq 1 ]; then
                                > "$favoritesFile"
                            else
                                grep -vF -x "$selected_encoded_favorite" "$favoritesFile" > "''${favoritesFile}.tmp" && mv "''${favoritesFile}.tmp" "$favoritesFile"
                            fi
                            notify-send "Item removed from favorites."
                        else
                            notify-send "Error: Selected favorite not found."
                        fi
                    fi
                else
                    notify-send "No favorites to remove."
                fi
                ;;
            "Clear All Favorites")
                if [ -f "$favoritesFile" ] && [ -s "$favoritesFile" ]; then
                    confirm=$(echo -e "Yes\nNo" | rofi -dmenu -theme-str "entry { placeholder: \"Clear All Favorites?\";}" -theme-str "''${r_scale}" -theme-str "''${r_override}" -config "''${roconf}")
                    if [ "$confirm" = "Yes" ]; then
                        > "$favoritesFile"
                        notify-send "All favorites have been deleted."
                    fi
                else
                    notify-send "No favorites to delete."
                fi
                ;;
            *)
                echo "Invalid action"
                exit 1
                ;;
            esac
            ;;
        "Clear History")
            if [ "$(echo -e "Yes\nNo" | rofi -dmenu -theme-str "entry { placeholder: \"Clear Clipboard History?\";}" -theme-str "''${r_scale}" -theme-str "''${r_override}" -config "''${roconf}")" == "Yes" ] ; then
                cliphist wipe
                notify-send "Clipboard history cleared."
            fi
            ;;
        *)
            echo "Invalid action"
            exit 1
            ;;
        esac
      '')
    ];
  };
}
