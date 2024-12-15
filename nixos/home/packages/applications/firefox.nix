{
  config,
  lib,
  inputs,
  ...
}: {
  options = {
    program.firefox.enable = lib.mkEnableOption "enable Firefox module";
  };

  config = lib.mkIf config.program.firefox.enable {
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
