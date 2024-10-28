{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    #font.name = "JetBrainsMono Nerd Font";
    #themeFile = "tokyo_night_night";
    #themeFile = "Catppuccin-Mocha";
    settings = {
      font_size = 11.5;
      confirm_os_window_close = 0;
      hide_window_decorations = 0;
      enable_audio_bell = false;
      window_padding_width = 25;
    };
  };

  home.packages = with pkgs; [
    hyprlock
    hyprpicker
    hypridle

    rofi
    waybar
    swww

    kitty
    kitty-themes
    kitty-img

    pavucontrol
    hyprshade
    swappy
    grimblast
    dunst
    udiskie
    wl-clipboard
    cliphist
    swayosd

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

    #(writeShellScriptBin "keyboardswitch")
    #(writeShellScriptBin "windowpin")
    #(writeShellScriptBin "logoutlaunch")
    #(writeShellScriptBin "sysmonlaunch")
    #(writeShellScriptBin "rofilaunch" '''')
  ];
}
