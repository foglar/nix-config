{pkgs, pkgs-stable, ...}: {
  home.packages = (with pkgs; [
      hyprlock
      hyprpicker
      hypridle
      hyprpolkitagent

      dunst
      libnotify
      swayosd

      #swww
      playerctl

      hyprshade
      swappy
      grimblast

      udiskie

      wl-clipboard
      cliphist
    
    (writeShellScriptBin "dontkillsteam" ''
      if [[ $(hyprctl activewindow -j | jq -r ".class") == "Steam" ]]; then
        xdotool windowunmap $(xdotool getactivewindow)
      else
        hyprctl dispatch killactive ""
      fi
    '')

    (writeShellScriptBin "screenshot" ''
      restore_shader() {
       if [ -n "$shader" ]; then
       	hyprshade on "$shader"
       fi
      }

      # Saves the current shader and turns it off
      save_shader() {
      	shader=$(hyprshade current)
      	hyprshade off
      	trap restore_shader EXIT
      }

      save_shader

      save_file=$(date +'%y%m%d_%Hh%Mm%Ss_screenshot.png')
      temp_screenshot="/tmp/screenshot.png"

      case $1 in
      p) # print all outputs
      	grimblast copysave screen $temp_screenshot && restore_shader && swappy -f $temp_screenshot ;;
      s) # drag to manually snip an area / click on a window to print it
      	grimblast copysave area $temp_screenshot && restore_shader && swappy -f $temp_screenshot ;;
      sf) # frozen screen, drag to manually snip an area / click on a window to print it
      	grimblast --freeze copysave area $temp_screenshot && restore_shader && swappy -f $temp_screenshot ;;
      m) # print focused monitor
      	grimblast copysave output $temp_screenshot && restore_shader && swappy -f $temp_screenshot ;;
      *) # invalid option
      	print_error ;;
      esac

      rm "$temp_screenshot"
    '')

    (writeShellScriptBin "keyboardswitch" ''
      hyprctl switchxkblayout all next
      layMain=$(hyprctl -j devices | jq '.keyboards' | jq '.[] | select (.main == true)' | awk -F '"' '{if ($2=="active_keymap") print $4}')
      ${libnotify}/bin/notify-send -a "t1" -r 91190 -t 800 "$layMain" -i ~/dotfiles/config/keyboard.svg
    '')

    #(writeShellScriptBin "windowpin")
    #(writeShellScriptBin "logoutlaunch")
    #(writeShellScriptBin "sysmonlaunch")
    #(writeShellScriptBin "rofilaunch" '''')
  ]) ++ (with pkgs-stable; [
    pavucontrol
    gnome.nautilus
  ]);
}
