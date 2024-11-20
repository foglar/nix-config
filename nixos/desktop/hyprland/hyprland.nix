{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    hyprland.enable =
      lib.mkEnableOption "enable Hyprland module";
  };

  imports = [
    ./packages.nix
    ./waybar.nix
    ./rofi.nix
    ./wlogout.nix
  ];

  config = lib.mkIf config.hyprland.enable {
    waybar.enable = lib.mkDefault true;
    rofi.enable = lib.mkDefault true;
    wlogout.enable = lib.mkDefault true;

    xdg.portal.enable =  true;
    #xdg.portal.config = { commom;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

    services.network-manager-applet.enable = true;
    services.dunst.enable = true;

    home.packages = [
      pkgs.toybox
    ];

    stylix.targets = {
      dunst.enable = true;
      kde.enable = true;
      gtk.enable = true;

      waybar = {
        enableCenterBackColors = false;
        enableLeftBackColors = false;
        enableRightBackColors = false;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;

      #plugins = [
      #inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      #inputs.Hyprspace.packages.${pkgs.system}.Hyprspace
      #];

      settings = {
        monitor = [
          "eDP-1,1920x1080,0x0,1"
          ",preferred,auto,1,mirror,eDP-1"
        ];

        input = {
          "kb_layout" = "us, cz, ru";
          "follow_mouse" = "1";

          #"kb_options" = "caps:swapecase";
          #"kb_options" = "ctrl:nocaps";

          touchpad = {
            "natural_scroll" = "no";
          };

          "sensitivity" = "0";
          "force_no_accel" = "1";
          #"numlock_by_default" = "true";
        };

        gestures = {
          "workspace_swipe" = "true";
          "workspace_swipe_fingers" = "3";
        };

        dwindle = {
          "pseudotile" = "yes";
          "preserve_split" = "yes";
        };

        master = {
          "new_status" = "master";
        };

        misc = {
          "vrr" = "0";
          "disable_hyprland_logo" = "true";
          "disable_splash_rendering" = "true";
          "force_default_wallpaper" = "0";
        };

        xwayland = {
          "force_zero_scaling" = "true";
        };

        env = [
          "XDG_CURRENT_DESKTOP,Hyprland"
          "XDG_SESSION_TYPE,wayland"
          "XDG_SESSION_DESKTOP,Hyprland"
          "QT_QPA_PLATFORM,wayland;xcb"
          "QT_QPA_PLATFORMTHEME,qt6ct"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_AUTO_SCREEN_SCALE_FACTOR,1"
          "MOZ_ENABLE_WAYLAND,1"
          "GDK_SCALE,1"
          "LIBVA_DRIVER_NAME,nvidia"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia"
          "__GL_VRR_ALLOWED,1"
          "WLR_DRM_NO_ATOMIC,1"
        ];

        exec-once = [
          "discord --start-minimized"
          "vesktop --start-minimized"
          "${pkgs.ferdium}/bin/ferdium --minimized"
          "${pkgs.plasma5Packages.kdeconnect-kde}/bin/kdeconnect-indicator"

          "systemctl --user start hyprpolkitagent"
          #"swww-daemon --format xrgb"
          #"swww ../../aurora_borealis.png"
          "hypridle"
          "waybar"
          "swayosd-server"

          "blueman-applet"
          "udiskie --no-automount --smart-tray"
          "nm-applet --indicator"
          "dunst"
          "wl-paste --type text --watch cliphist store # clipboard store text data"
          "wl-paste --type image --watch cliphist store # clipboard store image data"
          #"$scrPath/batterynotify.sh # battery notification"

          #"$scrPath/resetxdgportal.sh # reset XDPH for screenshare"
          #"dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # for XDPH"
          #"dbus-update-activation-environment --systemd --all # for XDPH"
          #"systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP # for XDPH"
        ];

        "$mod" = "SUPER";
        "$term" = "${pkgs.kitty}/bin/kitty";
        "$editor" = "${pkgs.vscode}/bin/code";
        "$file" = "dolphin";
        "$browser" = "${pkgs.librewolf}/bin/librewolf";

        animations = {
          "enabled" = "yes";
          "bezier" = [
            "wind, 0.05, 0.9, 0.1, 1.05"
            "winIn, 0.1, 1.1, 0.1, 1.1"
            "winOut, 0.3, -0.3, 0, 1"
            "liner, 1, 1, 1, 1"
          ];
          "animation" = [
            "windows, 1, 6, wind, slide"
            "windowsIn, 1, 6, winIn, slide"
            "windowsOut, 1, 5, winOut, slide"
            "windowsMove, 1, 5, wind, slide"
            "border, 1, 1, liner"
            "borderangle, 1, 30, liner, loop"
            "fade, 1, 10, default"
            "workspaces, 1, 5, wind"
          ];
        };

        bindr = [
          "ALTSHIFT, Shift_L, exec, keyboardswitch"
          "CAPS,Caps_Lock, exec, swayosd-client --caps-lock"
        ];

        #bindsr = [
        #];

        bindd = [
          "$mod SHIFT, P, Color Picker, exec, hyprpicker -a"
        ];

        bindl = [
          # Audio
          ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
          ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"

          # Media
          "Alt, P, exec, playerctl play-pause"
          "Alt, I, exec, playerctl next"
          "Alt, O, exec, playerctl previous"
        ];

        bindel = [
          ",XF86AudioLowerVolume, exec, swayosd-client --output-volume -5"
          ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume 5"
          # Brightness
          ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
          ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
        ];

        binde = [
          # Resize windows
          "$mod+Shift, Right, resizeactive, 30 0"
          "$mod+Shift, Left, resizeactive, -30 0"
          "$mod+Shift, Up, resizeactive, 0 -30"
          "$mod+Shift, Down, resizeactive, 0 30"
        ];

        bindm = [
          # Move/Resize focused window
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod, Z, movewindow"
          "$mod, X, resizewindow"
        ];

        bind = [
          "$mod, Q, exec, dontkillsteam"
          "$mod, Delete, exit"
          "$mod, W, togglefloating"
          "$mod, G, togglegroup"
          "Alt, Return, fullscreen"
          "$mod, Escape, exec, hyprlock"
          #"$mod+Shift,F, exec, windowpin.sh"
          "$mod, Backspace, exec, wlogout -b 2"
          "$Ctrl+Alt, W, exec, killall waybar || waybar" # toggle waybar

          "$mod, T, exec, $term"
          "$mod, F, exec, $browser"
          "$mod, E, exec, $file"
          "$mod, C, exec, $editor"
          "Ctrl+Shift, Escape, exec, btop"

          # Rofi
          "$mod, A, exec, pkill -x rofi || rofi -show drun"
          #"$mod, A, exec, pkill -x rofi || rofilaunch.sh d"
          #"$mod, Tab, exec, pkill -x rofi || rofilaunch.sh w"
          #"$mod+Shift, E, exec, pkill -x rofi || rofilaunch.sh f"

          # Grouped Windows
          "$mod CTRL, H, changegroupactive, b"
          "$mod CTRL, L, changegroupactive, f"

          # Screenshot
          "$mod, P, exec, screenshot s"
          "$mod+Ctrl, P, exec, screenshot sf"
          "$mod+Alt, P, exec, screenshot m"
          ", Print, exec, screenshot p" # All monitors screenshot capture

          # Custom scripts
          "$mod, V, exec, pkill -x rofi || scliphist c"

          # Move/Change window focus
          "$mod, H, movefocus, l"
          "$mod, L, movefocus, r"
          "$mod, K, movefocus, u"
          "$mod, J, movefocus, d"
          "Alt, Tab, movefocus, d"

          "$mod Shift, H, movewindow, l"
          "$mod Shift, L, movewindow, r"
          "$mod Shift, K, movewindow, u"
          "$mod Shift, J, movewindow, d"

          "$mod, 1, workspace, 1"
          "$mod, 2, workspace, 2"
          "$mod, 3, workspace, 3"
          "$mod, 4, workspace, 4"
          "$mod, 5, workspace, 5"
          "$mod, 6, workspace, 6"
          "$mod, 7, workspace, 7"
          "$mod, 8, workspace, 8"
          "$mod, 9, workspace, 9"
          "$mod, 0, workspace, 10"

          "$mod+Ctrl, Right, workspace, r+1"
          "$mod+Ctrl, Left, workspace, r-1"

          "$mod+Ctrl, Down, workspace, empty"

          # Move focused window to a relative workspace
          "$mod+Shift, 1, movetoworkspace, 1"
          "$mod+Shift, 2, movetoworkspace, 2"
          "$mod+Shift, 3, movetoworkspace, 3"
          "$mod+Shift, 4, movetoworkspace, 4"
          "$mod+Shift, 5, movetoworkspace, 5"
          "$mod+Shift, 6, movetoworkspace, 6"
          "$mod+Shift, 7, movetoworkspace, 7"
          "$mod+Shift, 8, movetoworkspace, 8"
          "$mod+Shift, 9, movetoworkspace, 9"
          "$mod+Shift, 0, movetoworkspace, 10"

          # Move focused window to a relative workspace silently
          "$mod+Alt, 1, movetoworkspacesilent, 1"
          "$mod+Alt, 2, movetoworkspacesilent, 2"
          "$mod+Alt, 3, movetoworkspacesilent, 3"
          "$mod+Alt, 4, movetoworkspacesilent, 4"
          "$mod+Alt, 5, movetoworkspacesilent, 5"
          "$mod+Alt, 6, movetoworkspacesilent, 6"
          "$mod+Alt, 7, movetoworkspacesilent, 7"
          "$mod+Alt, 8, movetoworkspacesilent, 8"
          "$mod+Alt, 9, movetoworkspacesilent, 9"
          "$mod+Alt, 0, movetoworkspacesilent, 10"

          # Move focused window to a relative workspace
          "$mod+Ctrl+Alt, Right, movetoworkspace, r+1"
          "$mod+Ctrl+Alt, Left, movetoworkspace, r-1"

          # Move active window around current workspace with $mod + SHIFT + CTRL

          # Scroll through existing workspaces
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"

          # Move/Switch to special workspace
          "$mod+Alt, S, movetoworkspacesilent, special"
          "$mod, S, togglespecialworkspace"

          "$mod, U, togglesplit"
        ];

        windowrulev2 = [
          "opacity 0.90 0.90,class:^(firefox)$"
          "opacity 0.90 0.90,class:^(Brave-browser)$"
          "opacity 0.80 0.80,class:^(code-oss)$"
          "opacity 0.80 0.80,class:^(Code)$"
          "opacity 0.80 0.80,class:^(code-url-handler)$"
          "opacity 0.80 0.80,class:^(code-insiders-url-handler)$"
          "opacity 0.80 0.80,class:^(kitty)$"
          "opacity 0.80 0.80,class:^(org.kde.dolphin)$"
          "opacity 0.80 0.80,class:^(org.kde.ark)$"
          "opacity 0.80 0.80,class:^(nwg-look)$"
          "opacity 0.80 0.80,class:^(qt5ct)$"
          "opacity 0.80 0.80,class:^(qt6ct)$"
          "opacity 0.80 0.80,class:^(kvantummanager)$"
          "opacity 0.80 0.70,class:^(org.pulseaudio.pavucontrol)$"
          "opacity 0.80 0.70,class:^(blueman-manager)$"
          "opacity 0.80 0.70,class:^(nm-applet)$"
          "opacity 0.80 0.70,class:^(nm-connection-editor)$"
          "opacity 0.80 0.70,class:^(org.kde.polkit-kde-authentication-agent-1)$"
          "opacity 0.80 0.70,class:^(polkit-gnome-authentication-agent-1)$"
          "opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.gtk)$"
          "opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.hyprland)$"
          "opacity 0.70 0.70,class:^([Ss]team)$"
          "opacity 0.70 0.70,class:^(steamwebhelper)$"
          "opacity 0.70 0.70,class:^([Ss]potify)$"
          "opacity 0.70 0.70,initialTitle:^(Spotify Free)$"
          "opacity 0.70 0.70,initialTitle:^(Spotify Premium)$"
          "opacity 0.90 0.90,class:^(com.github.rafostar.Clapper)$"
          "opacity 0.80 0.80,class:^(com.github.tchx84.Flatseal)$"
          "opacity 0.80 0.80,class:^(hu.kramo.Cartridges)$"
          "opacity 0.80 0.80,class:^(com.obsproject.Studio)$"
          "opacity 0.80 0.80,class:^(gnome-boxes)$"
          "opacity 0.80 0.80,class:^(vesktop)$"
          "opacity 0.80 0.80,class:^(discord)$"
          "opacity 0.80 0.80,class:^(WebCord)$"
          "opacity 0.80 0.80,class:^(ArmCord)$"
          "opacity 0.80 0.80,class:^(app.drey.Warp)$"
          "opacity 0.80 0.80,class:^(net.davidotek.pupgui2)$"
          "opacity 0.80 0.80,class:^(yad)$"
          "opacity 0.80 0.80,class:^(Signal)$"
          "opacity 0.80 0.80,class:^(io.github.alainm23.planify)$"
          "opacity 0.80 0.80,class:^(io.gitlab.theevilskeleton.Upscaler)$"
          "opacity 0.80 0.80,class:^(com.github.unrud.VideoDownloader)$"
          "opacity 0.80 0.80,class:^(io.gitlab.adhami3310.Impression)$"
          "opacity 0.80 0.80,class:^(io.missioncenter.MissionCenter)$"
          "opacity 0.80 0.80,class:^(io.github.flattool.Warehouse)$"
          "float,class:^(org.kde.dolphin)$,title:^(Progress Dialog — Dolphin)$"
          "float,class:^(org.kde.dolphin)$,title:^(Copying — Dolphin)$"
          "float,title:^(About Mozilla Firefox)$"
          "float,class:^(firefox)$,title:^(Picture-in-Picture)$"
          "float,class:^(firefox)$,title:^(Library)$"
          "float,class:^(kitty)$,title:^(top)$"
          "float,class:^(kitty)$,title:^(btop)$"
          "float,class:^(kitty)$,title:^(htop)$"
          "float,class:^(vlc)$"
          "float,class:^(kvantummanager)$"
          "float,class:^(qt5ct)$"
          "float,class:^(qt6ct)$"
          "float,class:^(nwg-look)$"
          "float,class:^(org.kde.ark)$"
          "float,class:^(org.pulseaudio.pavucontrol)$"
          "float,class:^(blueman-manager)$"
          "float,class:^(nm-applet)$"
          "float,class:^(nm-connection-editor)$"
          "float,class:^(org.kde.polkit-kde-authentication-agent-1)$"
          "float,class:^(Signal)$"
          "float,class:^(com.github.rafostar.Clapper)$"
          "float,class:^(app.drey.Warp)$"
          "float,class:^(net.davidotek.pupgui2)$"
          "float,class:^(yad)$"
          "float,class:^(eog)$"
          "float,class:^(io.github.alainm23.planify)$"
          "float,class:^(io.gitlab.theevilskeleton.Upscaler)$"
          "float,class:^(com.github.unrud.VideoDownloader)$"
          "float,class:^(io.gitlab.adhami3310.Impression)$"
          "float,class:^(io.missioncenter.MissionCenter)$"
          "float,title:^(stellarium)$"
          "float,class:^(localsend_app)$"
          "float,class:^(1Password)$"
          "stayfocused,class:^(1Password)$"
          "float,title:^(Open Folder)$"
          "float,class:^(org.wireshark.Wireshark)$"
          "float,class:^(spotube)$"
          "float,class:^(harmonymusic)$"
          "opacity 0.70 0.60,class:^(harmonymusic)$"
          "float,title:^(systemupdate)$"
          "size 800 450,title:^(systemupdate)$"
          "workspace special,title:^(systemupdate)$"
          "float,class:^(Spotify)$"
          "size 960 600,class:^(Spotify)$"
          "workspace special,title:^(Spotify)$"
          "float,class:^(post_processing_gui.py)$"
          "float,title:^(Picture-in-Picture)$"
          "pin,title:^(Picture-in-Picture)$"
          "move 1280 680,title:^(Picture-in-Picture)$"
          "float,title:^(KDE Connect)$"
          "opacity 0.80 0.70,title:^(KDE Connect)$"
          "float,title:^(Welcome to CLion)$"
          "float,title:^(Welcome to JetBrains Rider)$"
          "opacity 0.90 0.70,class:^(jetbrains-rider)$"
          "move 1460 330,title:^(JetBrains Toolbox)$"
          "opacity 0.80 0.70,title:^(JetBrains Toolbox)$"
          "opacity 0.70 0.60,class:^(org.wireshark.Wireshark)$"
          "opacity 0.70 0.60,class:^(install4j-burp-StartBurp)$"
          "opacity 0.70 0.60,class:^(GitKraken)$"
          "opacity 0.75 0.65,class:^(Arduino IDE)$"
          "opacity 0.70 0.60,class:^(virt-manager)$"
          "float,class:^(org.raspberrypi.rpi-imager)$"
          "opacity 0.80 0.70,title:^(Cobra Monitor)$"
          "opacity 0.80 0.70,class:^(chat-simplex-desktop-MainKt)$"
        ];

        layerrule = [
          "blur,rofi"
          "ignorezero,rofi"
          "blur,notifications"
          "ignorezero,notifications"
          "blur,swaync-notification-window"
          "ignorezero,swaync-notification-window"
          "blur,swaync-control-center"
          "ignorezero,swaync-control-center"
          "blur,logout_dialog"
        ];
      };
    };
  };
}
