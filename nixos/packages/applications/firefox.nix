{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  options = {
    firefox.enable = lib.mkEnableOption "enable Firefox module";
  };

  config = lib.mkIf config.firefox.enable {
    programs.firefox = {
      enable = true;
      profiles.default = {
        extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
          ublock-origin
        ];
      };
    };
  };
}
