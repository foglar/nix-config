{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    program.kitty.enable = lib.mkEnableOption "Enable kitty terminal emulator";
  };

  config = lib.mkIf config.program.kitty.enable {
    programs.kitty = {
      enable = true;
      font.name = lib.mkDefault "JetBrainsMono Nerd Font";
      #themeFile = "tokyo_night_night";
      #themeFile = "Catppuccin-Mocha";
      settings = {
        font_size = 11.5;
        confirm_os_window_close = 0;
        hide_window_decorations = 0;
        enable_audio_bell = false;
        window_padding_width = 25;
      };

      home.packages = with pkgs; [
        kitty
        kitty-img
        kitty-themes
      ];
    };
  };
}
