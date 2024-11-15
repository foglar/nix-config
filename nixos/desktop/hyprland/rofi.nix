{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    rofi.enable = lib.mkEnableOption "enable Rofi module";
  };

  config = lib.mkIf config.rofi.enable {
    home.packages = [
      pkgs.rofi
    ];

    programs.rofi = {
      enable = true;
      cycle = true;
      location = "center";
      pass = {};
      font = lib.mkDefault "JetBrainsMono NF 14";
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
      #  "*" = {
      #    main-bg = mkLiteral "#11111be6";
      #    main-fg = mkLiteral "#cdd6f4ff";
      #    main-br = mkLiteral "#cba6f7ff";
      #    main-ex = mkLiteral "#f5e0dcff";
      #    select-bg = mkLiteral "#b4befeff";
      #    select-fg = mkLiteral "#11111bff";
      #    separatorcolor = mkLiteral "transparent";
      #    border-color = mkLiteral "transparent";
      #  };
      #
        "configuration" = {
          modi = "drun,filebrowser,window,run";
          show-icons = true;
          display-drun = " ";
          display-run = " ";
          display-filebrowser = " ";
          display-window = " ";
          drun-display-format = "{name}";
          window-format = "{w}{t}";
          font = "JetBrainsMono Nerd Font 10";
          icon-theme = "Tela-circle-dracula";
        };
      
        # Main window settings
        "window" = {
          height = mkLiteral "35em";
          width = mkLiteral "56em";
          transparency = "real";
          fullscreen = false;
          enabled = true;
          cursor = "default";
          spacing = mkLiteral "0em";
          padding = mkLiteral "0em";
          #border-color = mkLiteral "@main-br"; # replace with actual color hex if needed
          #background-color = mkLiteral "@main-bg";
        };
      
        # Mainbox settings
        "mainbox" = {
          enabled = true;
          spacing = mkLiteral "0em";
          padding = mkLiteral "0em";
          orientation = mkLiteral "vertical";
          children = ["inputbar" "listbox"];
          background-color = mkLiteral "transparent";
          background-image = mkLiteral "url(\"~/dotfiles/nixos/aurora_borealis.png\", height)";
        };
      
        # Input bar settings
        "inputbar" = {
          enabled = true;
          spacing = mkLiteral "0em";
          padding = mkLiteral "5em";
          children = ["entry"];
          background-color = mkLiteral "transparent";
          background-image = mkLiteral "url(\"~/dotfiles/nixos/aurora_borealis.png\", width)";
        };
      
        # Entry field settings
        "entry" = {
          border-radius = mkLiteral "2em";
          enabled = true;
          spacing = mkLiteral "1em";
          padding = mkLiteral "1em";
          #text-color = mkLiteral "@main-fg";
          #background-color = mkLiteral "@main-bg";
        };
      
        # Listbox settings
        "listbox" = {
          padding = mkLiteral "0em";
          spacing = mkLiteral "0em";
          orientation = mkLiteral "horizontal";
          children = ["listview" "mode-switcher"];
          #background-color = mkLiteral "@main-bg";
        };
      
        # List view settings
        "listview" = {
          padding = mkLiteral "1.5em";
          spacing = mkLiteral "0.5em";
          enabled = true;
          columns = 2;
          lines = 3;
          cycle = true;
          dynamic = true;
          scrollbar = false;
          layout = "vertical";
          reverse = false;
          fixed-height = true;
          fixed-columns = true;
          cursor = "default";
          background-color = mkLiteral "transparent";
          #text-color = mkLiteral "@main-fg";
        };
      
        # Mode switcher settings
        "mode-switcher" = {
          orientation = mkLiteral "vertical";
          width = mkLiteral "6.6em";
          enabled = true;
          padding = mkLiteral "1.5em";
          spacing = mkLiteral "1.5em";
          background-color = mkLiteral "transparent";
        };
      
        # Button settings
        "button" = {
          cursor = "pointer";
          border-radius = mkLiteral "2em";
          #background-color = mkLiteral "@main-bg";
          #text-color = mkLiteral "@main-fg";
        };
        "button selected" = {
          #background-color = mkLiteral "@main-fg";
          #text-color = mkLiteral "@main-bg";
        };
      
        # Element settings
        "element" = {
          enabled = true;
          spacing = mkLiteral "0em";
          padding = mkLiteral "0.5em";
          cursor = "pointer";
          background-color = mkLiteral "transparent";
          #text-color = mkLiteral "@main-fg";
        };
        "element selected.normal" = {
          #background-color = mkLiteral "@select-bg";
          #text-color = mkLiteral "@select-fg";
        };
      
        # Icon element settings
        "element-icon" = {
          size = mkLiteral "3em";
          cursor = "inherit";
          #background-color = mkLiteral "transparent";
          #text-color = mkLiteral "inherit";
        };
      
        # Text element settings
        "element-text" = {
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.0";
          cursor = "inherit";
          #background-color = mkLiteral "transparent";
          #text-color = mkLiteral "inherit";
        };
      
        # Error message settings
        "error-message" = {
          #text-color = mkLiteral "@main-fg";
          #background-color = mkLiteral "@main-bg";
          text-transform = mkLiteral "capitalize";
          children = ["textbox"];
        };
      
        # Textbox settings
        "textbox" = {
          #text-color = mkLiteral "inherit";
          #background-color = mkLiteral "inherit";
          vertical-align = mkLiteral "0.5";
          horizontal-align = mkLiteral "0.5";
        };
      };
    };  
  };
}
