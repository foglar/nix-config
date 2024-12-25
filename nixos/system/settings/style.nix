{
  lib,
  config,
  pkgs,
  pkgs-stable,
  userSettings,
  ...
}: {
  options = {
    sys.style.enable = lib.mkEnableOption "Enable the Stylix theme manager.";
  };

  config = lib.mkIf config.sys.style.enable {
    stylix = {
      enable = true;
      image = ../../../config/backgrounds/${userSettings.background};
      base16Scheme = "${pkgs-stable.base16-schemes}/share/themes/${userSettings.theme}.yaml"; # List all possible themes: $ nix build nixpkgs#base16-schemes && ls result/share/themes
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

        serif = {
          package = pkgs.nerd-fonts.monaspace;
          name = "Monaspace Xenon";
        };

        sansSerif = {
          package = pkgs.nerd-fonts.monaspace;
          name = "Monaspace Argon";
        };

        monospace = {
          package = pkgs.nerd-fonts.monaspace;
          name = "Monaspace Neon";
        };

        emoji = {
          package = pkgs-stable.noto-fonts-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
