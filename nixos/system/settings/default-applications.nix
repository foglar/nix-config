{
  lib,
  pkgs,
  config,
  userSettings,
  ...
}: {
  options = {
    sys.default-applications.enable = lib.mkEnableOption "Enable default applications";
    xdg.da.browser = lib.mkOption {
      type = lib.types.str;
      default = "firefox";
      description = "Default browser";
    };
  };

  config = lib.mkIf config.sys.default-applications.enable {
    environment.sessionVariables = {
      DEFAULT_BROWSER = "${pkgs."${userSettings.browser}"}/bin/${userSettings.browser}";
      TERMINAL = "${pkgs."${userSettings.terminal}"}/bin/${userSettings.terminal}";
      EDITOR = "${pkgs."${userSettings.editor}"}/bin/${userSettings.editor}";
    };

    # Default applications configuration
    xdg.mime.enable = true;

    xdg.da.browser =
      if userSettings.browser == "qutebrowser"
      then "org.qutebrowser.qutebrowser"
      else
        (
          if userSettings.browser == "librewolf"
          then "librewolf"
          else "firefox"
        );

    xdg.mime.defaultApplications = {
      "text/html" = "${config.xdg.da.browser}.desktop";
      "x-scheme-handler/http" = "${config.xdg.da.browser}.desktop";
      "x-scheme-handler/https" = "${config.xdg.da.browser}.desktop";
      "x-scheme-handler/about" = "${config.xdg.da.browser}.desktop";
      "x-scheme-handler/unknown" = "${config.xdg.da.browser}.desktop";
      "text/plain" = "${userSettings.editor}.desktop";
      "application/pdf" = "org.gnome.Evince.desktop";
      "image/svg+xml" = "org.gnome.Loupe.desktop";
      "image/jpeg" = "org.gnome.Loupe.desktop";
      "image/png" = "org.gnome.Loupe.desktop";
    };

    programs.zsh.enable =
      if userSettings.shell == "zsh"
      then lib.mkDefault true
      else lib.mkDefault false;
    users.defaultUserShell =
      if userSettings.shell == "zsh"
      then pkgs.zsh
      else pkgs.bash;
  };
}
