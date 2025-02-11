{
  lib,
  config,
  ...
}: {
  options = {
    program.fastfetch.enable = lib.mkEnableOption "fastfetch";
  };

  config = lib.mkIf config.program.fastfetch.enable {
    home.file = {
      ".config/fastfetch/logo.png".source = ../../../../config/logo.png;
    };

    programs.fastfetch = {
      enable = true;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        "logo" = {
          "source" = "/home/shinya/.config/fastfetch/logo.png";
          "width" = 30;
          "height" = 18;
        };
        "modules" = [
          "break"
          "title"
          "separator"
          "os"
          "host"
          "kernel"
          "uptime"
          "packages"
          "shell"
          "de"
          "wm"
          "icons"
          "font"
          "cursor"
          "terminalfont"
          "cpu"
          "gpu"
          "disk"
        ];
      };
    };
  };
}
