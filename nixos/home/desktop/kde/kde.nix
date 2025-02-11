{
  lib,
  config,
  ...
}: {
  options = {
    desktop.kde.enable = lib.mkEnableOption "enable KDE module";
  };

  config =
    lib.mkIf config.desktop.kde.enable {
    };
}
