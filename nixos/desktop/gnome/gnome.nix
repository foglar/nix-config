{
  lib,
  config,
  pkgs,
  ...
}: {
  options = {
    desktop.gnome.enable =
      lib.mkEnableOption "enable GNOME configuration";
  };

  config = lib.mkIf config.desktop.gnome.enable {

    home.packages = with pkgs.gnomeExtensions; [
      blur-my-shell
      gsconnect
      appindicator
      privacy-settings-menu
      
    ];

    dconf = {
      enable = true;
      settings."org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          gsconnect.extensionUuid
          appindicator.extensionUuid
          privacy-settings-menu.extensionUuid
        ];
      };
    };
  };
}
