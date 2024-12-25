{
  lib,
  config,
  ...
}: {
  options = {
    desktop.hyprland.hyprlock.enable = lib.mkEnableOption "Enable hyprlock";
  };

  config = lib.mkIf config.desktop.hyprland.hyprlock.enable {
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

        label = {
          monitor = "";
          text = "$TIME $LAYOUT[!, cz, ru]";
          color = "$text";
          font_size = 40;
          #font_family = "Monaspace Xenon";

          position = "0, 80";
          halign = "center";
          valign = "center";
        };
      };
    };
  };
}
