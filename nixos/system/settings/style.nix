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
      #base16Scheme = "${pkgs-stable.base16-schemes}/share/themes/${userSettings.theme}.yaml"; # List all possible themes: $ nix build nixpkgs#base16-schemes && ls result/share/themes
      base16Scheme = {
        base00 = "000000"; # background
        base01 = "300505"; # additional background
        base02 = "804040"; # selected text, highlights
        base03 = "a06000"; # unselected border
        base04 = "f03030"; # discord name texts
        base05 = "f00000"; # text
        base06 = "b00505"; # main names in discord?
        base07 = "f06060";
        base08 = "f07070";
        base09 = "f08080";
        base0A = "f09090";
        base0B = "c00000"; # title text
        base0C = "c00090"; # links and main image things
        base0D = "a03030"; # select border / special text
        base0E = "f0d0d0";
        base0F = "f0e0e0";
      };

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
