{
  lib,
  pkgs,
  config,
  userSettings,
  ...
}: {
  options = {
    default-applications.enable = lib.mkEnableOption "Enable default applications";
  };

  config = lib.mkIf config.default-applications.enable {
    environment.sessionVariables = {
      DEFAULT_BROWSER = "${pkgs."${userSettings.browser}"}/bin/${userSettings.browser}";
      TERMINAL = "${pkgs."${userSettings.terminal}"}/bin/${userSettings.terminal}";
      EDITOR = "${pkgs."${userSettings.editor}"}/bin/${userSettings.editor}";
    };

    # Default applications configuration
    xdg.mime.enable = true;
    xdg.mime.defaultApplications = {
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
      "text/plain" = "nvim.desktop";
      "application/pdf" = "evince";
    };
  };
}
