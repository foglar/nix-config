{
  config,
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
          #enhancer-for-youtube
          ublock-origin
          simple-translate
          duckduckgo-privacy-essentials
          return-youtube-dislikes
          user-agent-string-switcher
        ];
      };
    };
  };
}
