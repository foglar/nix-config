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
          "width" = 34;
          "height" = 18;
          "padding" = {
            "top" = 1;
          };
        };
        "modules" = [
          "break"
          {
            "type" = "title";
            "format" = "{#1}╭───────────── EVA 02 - {#}{user-name-colored}";
          }
          {
            "type" = "custom";
            "format" = "{#1}│ {#}System Information";
          }
          {
            "type" = "os";
            "key" = "{#separator}│  {#keys}󰍹 OS";
          }
          {
            "type" = "kernel";
            "key" = "{#separator}│  {#keys}󰒋 Kernel";
          }
          {
            "type" = "uptime";
            "key" = "{#separator}│  {#keys}󰅐 Uptime";
          }
          {
            "type" = "packages";
            "key" = "{#separator}│  {#keys}󰏖 Packages";
            "format" = "{all}";
          }
          {
            "type" = "custom";
            "format" = "{#1}│";
          }
          {
            "type" = "custom";
            "format" = "{#1}│ {#}Desktop Environment";
          }
          {
            "type" = "de";
            "key" = "{#separator}│  {#keys}󰧨 DE";
          }
          {
            "type" = "wm";
            "key" = "{#separator}│  {#keys}󱂬 WM";
          }
          {
            "type" = "wmtheme";
            "key" = "{#separator}│  {#keys}󰉼 Theme";
          }
          {
            "type" = "display";
            "key" = "{#separator}│  {#keys}󰹑 Resolution";
          }
          {
            "type" = "shell";
            "key" = "{#separator}│  {#keys}󰞷 Shell";
          }
          {
            "type" = "terminalfont";
            "key" = "{#separator}│  {#keys}󰛖 Font";
          }
          {
            "type" = "custom";
            "format" = "{#1}│";
          }
          {
            "type" = "custom";
            "format" = "{#1}│ {#}Hardware Information";
          }
          {
            "type" = "cpu";
            "key" = "{#separator}│  {#keys}󰻠 CPU";
          }
          {
            "type" = "gpu";
            "key" = "{#separator}│  {#keys}󰢮 GPU";
          }
          {
            "type" = "memory";
            "key" = "{#separator}│  {#keys}󰍛 Memory";
          }
          {
            "type" = "disk";
            "key" = "{#separator}│  {#keys}󰋊 Disk (/)";
            "folders" = "/";
          }
          {
            "type" = "custom";
            "format" = "{#1}│";
          }
          {
            "type" = "custom";
            "format" = "{#1}╰───────────────────────────────╯";
          }
          #"separator"
          #"os"
          #"host"
          #"kernel"
          #"uptime"
          #"packages"
          #"shell"
          #"de"
          #"wm"
          #"icons"
          #"font"
          #"cursor"
          #"terminalfont"
          #"cpu"
          #"gpu"
          #"disk"
          #"break"
        ];
      };
    };
  };
}
