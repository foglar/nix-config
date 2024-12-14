{
  lib,
  config,
  pkgs-stable,
  ...
}: {
  options = {
    desktop.gnome.enable =
      lib.mkEnableOption "enable GNOME configuration";
  };

  config = lib.mkIf config.desktop.gnome.enable {
    dconf = {
      enable = true;
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs-stable.gnomeExtensions; [
          blur-my-shell.extensionUuid
          gsconnect.extensionUuid
        ];
      };
    };
  };
}
