{
  lib,
  config,
  pkgs-stable,
  ...
}: {
  options = {
    sys.style.enable = lib.mkEnableOption "Enable the Stylix theme manager.";
  };

  config = lib.mkIf config.sys.style.enable {
    stylix = {
      enable = true;
      image = ../../../config/backgrounds/aurora_borealis.png;
      base16Scheme = "${pkgs-stable.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      #base16Scheme = "${pkgs.base16-schemes}/share/themes/onedark.yaml";
      #base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      polarity = "dark";
      autoEnable = true;

      # Set the cursor theme.
      cursor = {
        package = pkgs-stable.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      fonts = {
        sizes = {
          desktop = 8;
          applications = 10;
          popups = 10;
          terminal = 12;
        };

        monospace = {
          name = "JetBrainsMono Nerd Font";
          package = (pkgs-stable.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
        };
      };
    };
  };
}
