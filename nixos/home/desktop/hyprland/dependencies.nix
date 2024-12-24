{
  pkgs,
  pkgs-stable,
  ...
}: {
  home.packages =
    (with pkgs; [
      hypridle
      hyprpolkitagent

      libnotify
      swayosd
      playerctl

      wl-clipboard
      cliphist

      #dunst
      #swww
      #hyprshade

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
        ${libnotify}/bin/notify-send -a "t1" -r 91190 -t 800 "$layMain" -i ~/dotfiles/config/icons/keyboard.svg
      '')

      (writeShellScriptBin "background-switch-random" ''
        directory=$HOME/dotfiles/config/backgrounds/
        monitor=$(hyprctl monitors | grep Monitor | awk '{print $2}')

        if [ -d "$directory" ]; then
            # Use find to include .jpg, .png, and .jpeg files
            random_background=$(find "$directory" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)

            hyprctl hyprpaper unload all
            hyprctl hyprpaper preload "$random_background"
            hyprctl hyprpaper wallpaper "$monitor, $random_background"
        fi

      '')

      #(writeShellScriptBin "windowpin")
    ])
    ++ (with pkgs-stable; [
      pavucontrol
      nautilus
    ]);
}
