{
  lib,
  config,
  ...
}: {
  options = {
    sys.bootloader.systemd-boot.enable = lib.mkEnableOption "Enable systemd-boot as the bootloader";
    sys.bootloader.plymouth.enable = lib.mkEnableOption "Enable Plymouth as the bootloader animation";
  };

  config = lib.mkMerge [
    (lib.mkIf config.sys.bootloader.systemd-boot.enable {
      boot.loader.systemd-boot.enable = true;
    })
    (lib.mkIf config.sys.bootloader.plymouth.enable {
      boot.plymouth = {
        enable = true;
      };
    })
  ];
}
